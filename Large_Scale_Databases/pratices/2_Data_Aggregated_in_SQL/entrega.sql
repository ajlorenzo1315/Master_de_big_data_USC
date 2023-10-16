-- ARRAY
-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", 
-- ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de peliculas de penelope cruz
select orden, (persona).nombre, personaje
from peliculasarray, unnest (reparto) with ordinality r(persona, personaje, orden)
where (persona).nombre = 'Penélope Cruz'
order by orden 
-- anadimos la fecha de emision  por defecto el orden es ascendente
select orden, (persona).nombre, personaje, titulo , fecha_emision
from peliculasarray, unnest (reparto) with ordinality r(persona, personaje, orden)
where (persona).nombre = 'Penélope Cruz'
order by fecha_emision 

-- E2.- Obtén un listado de los 10 directores que han generado más beneficios en sus películas. Para cada director obtén el número de películas 
-- dirigidas, y el beneficio total.

-- Primero  tenemos que obtener todos los directores

select (persona).nombre,trabajo,titulo
from peliculasarray, unnest (personal) per(persona, departamento, trabajo)
where trabajo = 'Director'
-- ahora agrupamos por la id de la persona asi tenemos todas las pelicualas por director 

select (persona).id
from peliculasarray, unnest (personal) per(persona, departamento, trabajo)
where trabajo = 'Director'
group by (persona).id

-- ahora obtenermos los beneficion y el numero de peliculas , ordenando por el beneficio total

select (persona).id,(persona).nombre, count(distinct p.id) as numero_peliculas_dirigidas, sum(p.ingresos-p.presupuesto) as beneficios_totales
from peliculasarray as p, unnest (personal) per(persona, departamento, trabajo)
where trabajo = 'Director'
group by (persona).id, (persona).nombre
order by beneficios_totales  desc 

--- XML

-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de 

select orden,
	   xmlserialize(content (xpath('/miembroreparto/text()', x))[1] as text) as nombre,
 	   xmlserialize(content (xpath('/miembroreparto/@personaje', x))[1] as text) as personaje,
       pel.titulo , pel.fecha_emision
from peliculasxml pel, unnest(xpath('/reparto/miembroreparto', reparto)) with ordinality as t(x, orden)
where xmlserialize(content (xpath('/miembroreparto/text()', x))[1] as text) = 'Penélope Cruz' 
order by fecha_emision


-- E2.- Obtén un listado de los 10 directores que han generado más beneficios en sus películas. Para cada director obtén el número de películas 
-- dirigidas, y el beneficio total.
-- seguimos una logica similar al caso de  array

select xmlserialize(content (xpath('/trabajador/text()', x))[1] as text) as nombre,
       count(distinct pel.id) as numero_peliculas_dirigidas,
       sum(pel.ingresos-pel.presupuesto) as beneficios_totales
from peliculasxml pel, unnest(xpath('/personal/trabajador', personal)) as t(x)
where xmlserialize(content (xpath('/trabajador/@trabajo', x))[1] as text) = 'Director' 
group by nombre
order by beneficios_totales desc 

-- agupamos por la id y el nombre por si hay nombres repetidos que no sean  el mismo director

select xmlserialize(content (xpath('/trabajador/@id', x))[1] as text) as id,
       xmlserialize(content (xpath('/trabajador/text()', x))[1] as text) as nombre,
       count(distinct pel.id) as numero_peliculas_dirigidas,
       sum(pel.ingresos-pel.presupuesto) as beneficios_totales
from peliculasxml pel, unnest(xpath('/personal/trabajador', personal)) as t(x)
where xmlserialize(content (xpath('/trabajador/@trabajo', x))[1] as text) = 'Director' 
group by xmlserialize(content (xpath('/trabajador/@id', x))[1] as text) ,nombre
order by beneficios_totales desc 


-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de 


select orden, (a->'persona')->>'nombre' as nombre, a->>'personaje' as personaje, titulo , fecha_emision
from peliculasjson pel, jsonb_array_elements(reparto) with ordinality as reparto(a,orden)
where (a->'persona')->>'nombre' = 'Penélope Cruz' 
order by fecha_emision


-- E2.- Obtén un listado de los 10 directores que han generado más beneficios en sus películas. Para cada director obtén el número de películas 
-- dirigidas, y el beneficio total.
-- seguimos una logica similar al caso de  array


select (a->'persona')->>'nombre' as nombre,
       count(distinct pel.id) as numero_peliculas_dirigidas,
       sum(pel.ingresos-pel.presupuesto) as beneficios_totales
from peliculasjson pel, jsonb_array_elements(personal) as per(a)
where a->>'trabajo'  = 'Director'  
group by nombre
order by beneficios_totales desc


select (a->'persona')->>'id' as id,
       (a->'persona')->>'nombre' as nombre,
       count(distinct pel.id) as numero_peliculas_dirigidas,
       sum(pel.ingresos-pel.presupuesto) as beneficios_totales
from peliculasjson pel, jsonb_array_elements(personal) as per(a)
where a->>'trabajo'  = 'Director'  
group by  (a->'persona')->>'id',nombre
order by beneficios_totales desc

-- metodo relacional

-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de 

select per.nombre, pr.personaje, pel.titulo  ,pel.fecha_emision 
from peliculas pel , personas per ,pelicula_reparto pr 
where  pel.id = pr.pelicula  and pr.persona= per.id  and 
	per.nombre ='Penélope Cruz'
order by  pel.fecha_emision

-- E2.- Obtén un listado de los 10 directores que han generado más beneficios en sus películas. Para cada director obtén el número de películas 
-- dirigidas, y el beneficio total.

select per.id as id, per.nombre as nombre,count(distinct pel.id) as numero_peliculas_dirigidas,
       sum(pel.ingresos-pel.presupuesto) as beneficios_totales
from peliculas pel , personas per ,pelicula_personal pp  
where  pel.id = pp.pelicula  and pp.persona= per.id  and 
	pp.trabajo  ='Director'
group by per.id ,nombre
order by beneficios_totales desc