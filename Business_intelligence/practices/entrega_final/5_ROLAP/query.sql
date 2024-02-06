--ejercio 2


select  dc."Country Code", dt.year,
    flf.labor_force as labor_force,
    fp.population as population
from fact_labor_force flf ,  dim_Time dt , dim_Country dc ,fact_population fp
    
where flf.time_id = dt.time_id and  flf.country_id = dc.country_id and
    fp.time_id = dt.time_id and  fp.country_id = dc.country_id
order by dc."Country Code", dt.year;