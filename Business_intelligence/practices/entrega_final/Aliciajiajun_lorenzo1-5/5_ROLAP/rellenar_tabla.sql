COPY staging_countries("Country Name", "Country Code") 
FROM '/home/alumnogreibd/IN/practicas/practica_5/input.csv' WITH CSV
HEADER;

INSERT INTO Dim_Country ("Country Name", "Country Code") 
SELECT "Country Name", "Country Code" 
FROM staging_countries ON CONFLICT DO NOTHING;

INSERT INTO Dim_Time (year)
SELECT generate_series(1960, 2022) 
ON CONFLICT DO NOTHING;

COPY staging_population("Country Name", "Country Code", year, population) 
FROM '/home/alumnogreibd/IN/practicas/practica_5/population.csv' DELIMITER ',' CSV HEADER;


INSERT INTO Fact_population (country_id, time_id, population)
SELECT c.country_id, y.time_id, s.population
FROM staging_population s
JOIN Dim_country c ON c."Country Code" = s."Country Code"
JOIN Dim_time y ON y.year = s.year;

-- metodo de corrección uno 
SELECT c.country_id, y.time_id, s.population
FROM staging_population s
JOIN Dim_country c ON c."Country Code" =  CONCAT(' ',s."Country Code")
JOIN Dim_time y ON y.year = s.year;

--metodo de corrección dos

INSERT INTO Fact_population (country_id, time_id, population)
SELECT DISTINCT c.country_id, y.time_id, s.population
FROM staging_population s 
JOIN dim_country c ON c."Country Code" = CONCAT(' ',s."Country Code")
JOIN dim_time y ON y.year = s.year
WHERE NOT EXISTS (
    SELECT 1 FROM Fact_population fp
    WHERE fp.country_id = c.country_id AND fp.time_id = y.time_id
);

-- si no tiene el caracter extrano

INSERT INTO Fact_population (country_id, time_id, population)
SELECT DISTINCT c.country_id, y.time_id, s.population
FROM staging_population s 
JOIN dim_country c ON c."Country Code" =s."Country Code"
JOIN dim_time y ON y.year = s.year
WHERE NOT EXISTS (
    SELECT 1 FROM Fact_population fp
    WHERE fp.country_id = c.country_id AND fp.time_id = y.time_id
);



-- para sumar por continentes o regiones  para poder sumar por años por estos mismos


CREATE TEMPORARY TABLE temp_population (
    country_code VARCHAR(255),
    Region VARCHAR(255),
    country_name VARCHAR(255)
);

COPY temp_population(country_code, Region, country_name)
FROM '/home/alumnogreibd/IN/practicas/practica_5/paises_continentes.csv'
DELIMITER ',' CSV HEADER;

CREATE  TABLE continente (
    country_id SERIAL PRIMARY KEY,
	Continente_name TEXT UNIQUE);

INSERT INTO continente (Continente_name)
SELECT DISTINCT Region
FROM temp_population;

select  *
from continente

-- o

ALTER TABLE Dim_Country
ADD COLUMN region VARCHAR(255);

INSERT INTO Dim_Country (region)
SELECT DISTINCT Region
FROM temp_population tp, Dim_Country dc
WHERE dc."Country Code"=tp.country_code;

-- usar realmente

CREATE TEMPORARY TABLE temp_region(
    country_code VARCHAR(255),
    Region VARCHAR(255),
    country_name VARCHAR(255)
);


-- ejercicio 2


COPY staging_labor_force("Country Name", "Country Code", year, labor_force) 
FROM '/home/alumnogreibd/IN/practicas/practica_5/Labor_force_transformed.csv' DELIMITER ',' CSV HEADER;


INSERT INTO Fact_labor_force (country_id, time_id, population)
SELECT DISTINCT c.country_id, y.time_id, s.population
FROM staging_labor_force s 
JOIN dim_country c ON c."Country Code" = CONCAT(' ',s."Country Code")
JOIN dim_time y ON y.year = s.year
WHERE NOT EXISTS (
    SELECT 1 FROM Fact_population fp
    WHERE fp.country_id = c.country_id AND fp.time_id = y.time_id
);


-- ejercio 3

COPY temp_region(country_code, Region, country_name)
FROM '/home/alumnogreibd/IN/practicas/practica_5/paises_continentes.csv'
DELIMITER ',' CSV HEADER;

-- Primero, añade la columna 'region' si aún no existe
ALTER TABLE Dim_Country
ADD COLUMN region VARCHAR(255);

-- Luego, actualiza los registros existentes con los datos de la tabla temporal
UPDATE Dim_Country dc
SET region = tp.Region
FROM temp_region tp
WHERE dc."Country Code" = tp.country_code;

DELETE FROM Dim_Country
WHERE region IS NULL;


