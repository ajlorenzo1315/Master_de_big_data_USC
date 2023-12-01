
-- Ejercicio 1  : Metodo alternativo para insertar csv en PostgreSQL
CREATE OR REPLACE PROCEDURE importar_datos()
LANGUAGE plpgsql AS $$
BEGIN
    -- 
    COPY staging_population("Country Name", "Country Code", year, population) 
    FROM '/home/alumnogreibd/IN/practicas/practica_5//population.csv' DELIMITER ',' CSV HEADER;


    -- Insertar en Dim_Country
    INSERT INTO Dim_Country ("Country Name", "Country Code")
    SELECT "Country Name", "Country Code" 
    FROM staging_countries 
    ON CONFLICT DO NOTHING;

    -- Insertar en Dim_Time
    INSERT INTO Dim_Time (year)
    SELECT generate_series(1960, 2022) 
    ON CONFLICT DO NOTHING;

    -- Insertar en Fact_Population
    INSERT INTO Fact_population (country_id, time_id, population)
    SELECT c.country_id, y.time_id, s.population
    FROM staging_population s
    JOIN Dim_country c ON c."Country Code" = s."Country Code"
    JOIN Dim_time y ON y.year = s.year
    WHERE NOT EXISTS (
        SELECT 1 FROM Fact_population fp
        WHERE fp.country_id = c.country_id AND fp.time_id = y.time_id
    );
END;
$$;

-- Usar una Etl

--    Usar Python con Pandas y Psycopg2:
--      Utiliza Pandas para leer y transformar el archivo CSV.
--      Conecta a PostgreSQL usando Psycopg2.
--      Inserta los datos directamente desde el DataFrame de Pandas a PostgreSQL usando el método to_sql de Pandas.