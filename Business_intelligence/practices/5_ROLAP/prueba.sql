CREATE TABLE Dim_Country (
country_id SERIAL PRIMARY KEY,
"Country Name" TEXT UNIQUE,
"Country Code" TEXT UNIQUE );

CREATE TABLE Dim_Time (
time_id SERIAL PRIMARY KEY,
year INT UNIQUE );

CREATE TABLE Fact_Population (
country_id INT REFERENCES
Dim_Country(country_id),
time_id INT REFERENCES
Dim_Time(time_id),
population BIGINT,
PRIMARY KEY (country_id, time_id) );



--Populate the fact table (this staging table contains the population but could also be used 
-- as input to country dimension earlier)
CREATE TABLE staging_population (
"Country Name" TEXT,
"Country Code" TEXT,
year INTEGER, population BIGINT );

INSERT INTO Fact_population (country_id, time_id, population)
SELECT DISTINCT c.country_id, y.time_id, s.population
FROM staging_population s 
JOIN dim_country c ON c."Country Code" =s."Country Code"
JOIN dim_time y ON y.year = s.year
WHERE NOT EXISTS (
    SELECT 1 FROM Fact_population fp
    WHERE fp.country_id = c.country_id AND fp.time_id = y.time_id
);


select *
from staging_population

select *
from Fact_population


SELECT DISTINCT c.country_id, y.time_id, s.population
FROM staging_population s 
JOIN dim_country c ON c."Country Code" =s."Country Code"
JOIN dim_time y ON y.year = s.year


SELECT DISTINCT c.country_id, y.time_id, s.population
FROM staging_population s 
JOIN dim_country c ON c."Country Code" =s."Country Code"
JOIN dim_time y ON y.year = s.year

INSERT INTO Dim_Time (year)
SELECT generate_series(1960, 2022) 
ON CONFLICT DO NOTHING;
   
select  y.time_id
FROM staging_population s 
JOIN dim_time y ON y.year = s.year

select *
from dim_time dt 


select *
from  Fact_population