-- 1.- Obtener todas las películas de las colecciones que contenga la palabra "Wars". 
-- Muestra el título de la película y el nombre de la colección. Ordena el resultado por el nombre de la colección

select titulo, (coleccion).nombre as coleccion
from peliculas
where (coleccion).nombre like '%Wars%'
order by (coleccion).nombre

-- Fijarse en la necesidad de usar paréntesis para asegurarse que accedemos primero a la columna de la tabla y 
-- después a un campo dentro de esa columna. Si no usamos los paréntesis el sistema cree que estamos intentando 
-- acceder al campo nombre de una tabla "coleccion" que no hemos puesto en la cláusula "from". Ahora, como todos 
-- nuestros datos están agregados en una única tabla, ya no es necesario realizar la operación de JOIN para acceder 
-- a los datos de la colección de la película.


-- 2.- Para cada película de la colección "Star Wars Collection" obtener su título, el nombre y trabajo del primer miembro del personal,
-- y los datos de los cinco primeros miembros del reparto. Ordena el resultado por fecha de emisión.

select titulo, (personal[1]).persona.nombre as nombre_personal, (personal[1]).trabajo as trabajo_personal,
       reparto[1:5] as reparto
from peliculasarray
where (coleccion).nombre = 'Star Wars Collection'
order by fecha_emision 

-- El editor solo nos permite ver el primer elemento del array. Podemos transformarlo a tipo "text" para verlos todos.

-- 3.- Obtener un listado de los miembros del personal de la película "The Empire Strikes Back". Ordena el resultado por departamento y trabajo.

select (persona).nombre, departamento, trabajo
from peliculasarray, unnest(personal) per(persona, departamento, trabajo)
where titulo = 'The Empire Strikes Back'
order by departamento, trabajo


-- 4.- Obtener un listado del reparto de la película "The Empire Strikes Back", ordenado por el orden en el que aparecen en el array.

select orden, (persona).nombre, personaje
from peliculasarray, unnest (reparto) with ordinality r(persona, personaje, orden)
where titulo = 'The Empire Strikes Back'
order by orden 

-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de 
select orden, (persona).nombre, personaje
from peliculasarray, unnest (reparto) with ordinality r(persona, personaje, orden)
where (persona).nombre = 'Penélope Cruz'
order by orden 

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

-- xml

-- 5.- Obtener un listado de los miembros del personal de la película "The Empire Strikes Back". Ordena el resultado por departamento y trabajo.

select xmlserialize(content (xpath('/trabajador/text()', x))[1] as text) as nombre,
 	   xmlserialize(content (xpath('/trabajador/@departamento', x))[1] as text) as departamento,
 	   xmlserialize(content (xpath('/trabajador/@trabajo', x))[1] as text) as trabajo
from peliculasxml pel, unnest(xpath('/personal/trabajador', personal)) as t(x)
where titulo = 'The Empire Strikes Back' 
order by departamento, trabajo

-- 6.- Obtener un listado del reparto de la película "The Empire Strikes Back", ordenado por el orden en el que aparecen en el xml.

select orden,
	   xmlserialize(content (xpath('/miembroreparto/text()', x))[1] as text) as nombre,
 	   xmlserialize(content (xpath('/miembroreparto/@personaje', x))[1] as text) as personaje
from peliculasxml pel, unnest(xpath('/reparto/miembroreparto', reparto)) with ordinality as t(x, orden)
where titulo = 'The Empire Strikes Back' 
order by orden

-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de 

select orden,
	   xmlserialize(content (xpath('/miembroreparto/text()', x))[1] as text) as nombre,
 	   xmlserialize(content (xpath('/miembroreparto/@personaje', x))[1] as text) as personaje
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

-- json

-- 7.- Obtener un listado de los miembros del personal de la película "The Empire Strikes Back". Ordena el resultado por departamento y trabajo.

select (a->'persona')->>'nombre' as nombre, a->>'departamento' as departamento, a->>'trabajo' as trabajo
from peliculasjson pel, jsonb_array_elements(personal) as per(a)
where titulo = 'The Empire Strikes Back' 
order by departamento, trabajo

-- 8.- Obtener un listado del reparto de la película "The Empire Strikes Back", ordenado por el orden en el que aparecen en el xml.

select orden, (a->'persona')->>'nombre' as nombre, a->>'personaje' as personaje
from peliculasjson pel, jsonb_array_elements(reparto) with ordinality as reparto(a,orden)
where titulo = 'The Empire Strikes Back' 
order by orden

-- E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.
-- obtenemos la tabla de 


select orden, (a->'persona')->>'nombre' as nombre, a->>'personaje' as personaje
from peliculasjson pel, jsonb_array_elements(reparto) with ordinality as reparto(a,orden)
where nombre = 'The Empire Strikes Back' 
order by orden


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
