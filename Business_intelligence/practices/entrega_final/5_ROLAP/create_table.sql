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


-- Create staging table vamos a usar como una pasarela para rellenar Country
CREATE TEMP TABLE staging_countries (
"Country Name" text,
"Country Code" text,
PRIMARY KEY ("Country Name") );


--Populate the fact table (this staging table contains the population but could also be used 
-- as input to country dimension earlier)
CREATE TABLE staging_population (
"Country Name" TEXT,
"Country Code" TEXT,
year INTEGER, population BIGINT );


-- ejercio 2

CREATE TABLE Fact_labor_force(
country_id INT REFERENCES
Dim_Country(country_id),
time_id INT REFERENCES
Dim_Time(time_id),
labor_force BIGINT,
PRIMARY KEY (country_id, time_id) );

-- the fact table (this staging table contains the labor_force but could also be used 
-- as input to country dimension earlier)
CREATE TABLE staging_labor_force (
"Country Name" TEXT,
"Country Code" TEXT,
year INTEGER, labor_force BIGINT );


