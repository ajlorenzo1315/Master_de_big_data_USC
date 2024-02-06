WITH Population2000 AS (
    SELECT 
        c.country_id, 
        c."Country Name", 
        MAX(p.population) AS population_2000
    FROM Fact_Population p
    JOIN Dim_Country c ON p.country_id = c.country_id
    JOIN Dim_Time t ON p.time_id = t.time_id
    WHERE t.year = 2000
    GROUP BY c.country_id, c."Country Name"
),
PopulationRecent AS (
    SELECT 
        c.country_id, 
        MAX(t.year) AS recent_year,
        MAX(p.population) AS recent_population
    FROM Fact_Population p
    JOIN Dim_Country c ON p.country_id = c.country_id
    JOIN Dim_Time t ON p.time_id = t.time_id
    GROUP BY c.country_id
),
Growth AS (
    SELECT 
        p2000.country_id,
        p2000."Country Name",
        p2000.population_2000,
        precent.recent_year,
        precent.recent_population,
        ((precent.recent_population - p2000.population_2000) / p2000.population_2000::float) * 100 AS growth_percentage
    FROM Population2000 p2000
    JOIN PopulationRecent precent ON p2000.country_id = precent.country_id
)
SELECT 
    country_id,
    "Country Name",
    population_2000,
    recent_year,
    recent_population,
    growth_percentage
FROM Growth
ORDER BY growth_percentage DESC;
