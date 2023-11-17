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
FROM '/home/alumnogreibd/IN/practicas/practica_5//population.csv' DELIMITER ',' CSV HEADER;


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
