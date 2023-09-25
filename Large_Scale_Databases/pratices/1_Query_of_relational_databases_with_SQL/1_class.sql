-- Obtener los datos de las películas con idioma original Español y con unos ingresos superiores a 15 millones.
select *
from peliculas
where idioma_original ='es' and ingresos > 15000000


-- Obtener el título, sinopsis y lema de las películas que tengan la palabra "Pirate" en su título. Ordena el resultado de forma descendente por p.presupuesto
select titulo, sinopsis, lema 
-- en el from colocamos las tablas de las que queremos obtener la informción
from peliculas
-- where filtra todas las peliculas con el titulo que tenga Pirate
where titulo like '%Pirate%'
order by p.presupuesto desc



--Muestra los títulos de las 10 películas con mayor p.presupuesto con una duración inferior a 60.
-- descendiente en order es ta por defecto 

select titulo
from peliculas
where duracion < 60
-- si no usas el order pued hacer compactaciones , puede que genere distintos order puesto que sacara 
-- el mas como para hacer duplicados hay que ordenar si haces un join puede se por la clave comun
-- eso con usuarios puede problemas cuando no usan el order by  tarda mas 
order by p.presupuesto desc 
limit 10 -- saca las primeras 10 lineas offset dice que le saltes limit dices 10  para ir paginando 
-- offset 10 limit 10 luego offset 20 limit 10 pagina de 10 en 10

-- Para las películas en las que actuó "Penélope Cruz", 
-- muestra el título original de la película y el personaje que interpretó. 
-- Ordena las películas por popularidad de forma descendente

select pel.titulo_original, pr.personaje 
from peliculas pel, pelicula_reparto pr , personas per
where pel.id = pr.pelicula 
  and pr.persona = per.id 
  and per.nombre = 'Penélope Cruz'
order by pel.popularidad  desc

-- ejercicio

-- Obtén un listado de las películas dirigidas por "Steven Spielberg" (el trabajo es "Director"). 
-- Para cada película muestra su título, p.presupuesto e ingresos. Ordena el listado por popularidad de forma descendente.

select pel.titulo_original , p.presupuesto , ingresos
from peliculas pel, pelicula_personal pp , personas per
where pel.id = pp.pelicula 
and pp.persona = per.id 
and per.nombre = 'Steven Spielberg'
and pp.trabajo = 'Director'
order by pel.popularidad  desc

-- Obtén el máximo, mínimo y media del p.presupuesto e ingresos de las películas producidas en España. 
-- Muestra la media del p.presupuesto sin decimales.
-- en esl select puedo operar en orizontal y se crean nuevas columnas que se ejecutan para cada fila para optener el valor atomico esos
-- tipo de valores que son de agregado cast transforma tipos ejemplo  cast(avg(presupuesto) as integer) pasa a enterosç
-- tambien puedo hacer calculos en vertical y para hacerlo tengo que hacer en agregado 


select max(presupuesto) as maximo_presupuesto, 
    min(presupuesto) as minimo_presupuesto,
    cast(avg(presupuesto) as integer) as media_presupuesto,
    max(ingresos) as maximo_ingresos, 
    min(ingresos) as minimo_ingresos,
    cast(avg(ingresos) as integer) as media_ingresos
from peliculas pel, pelicula_pais pp
where pel.id =pp.pelicula 
and pp.pais ='ES'

-- ejercio

-- 7
-- Para las películas de la colección "Star Wars Collection", obtener el mínimo, máximo y media del beneficio obtenido 
-- (ingresos - p.presupuesto y los coeficientes de correlación entre p.presupuesto e ingresos), 
-- entre la popularidad y el p.presupuesto e ingresos, y entre la fecha de emisión y el p.presupuesto, ingresos y popularidad. 
-- Nota: Ver como poder aplicar la correlación a una fecha, transformándola a un número.

-- Para realizar estas consultas en SQL, primero debes tener una base de datos que contenga 
-- información sobre las películas de la colección "Star Wars Collection". 
-- Supongamos que tienes una tabla llamada "peliculas" con las siguientes columnas: 
-- "id", "titulo", "presupuesto", "ingresos", "popularidad" y "fecha_emision". Aquí te muestro cómo podrías realizar estas consultas:

-- Obtener el mínimo, máximo y media del beneficio obtenido (ingresos - p.presupuesto) para las películas de la colección "Star Wars Collection":



SELECT 
    MIN(ingresos - p.presupuesto) AS min_beneficio,
    MAX(ingresos - p.presupuesto) AS max_beneficio,
    AVG(ingresos - p.presupuesto) AS media_beneficio
FROM peliculas
WHERE titulo LIKE 'Star Wars Collection%';

--  Calcular el coeficiente de correlación entre p.presupuesto e ingresos:



SELECT
    CORR(presupuesto, ingresos) AS correlacion_presupuesto_ingresos
FROM peliculas
WHERE titulo LIKE 'Star Wars Collection%';

--  Calcular el coeficiente de correlación entre popularidad y p.presupuesto:



SELECT
    CORR(popularidad, p.presupuesto) AS correlacion_popularidad_presupuesto
FROM peliculas
WHERE titulo LIKE 'Star Wars Collection%';

--  Calcular el coeficiente de correlación entre popularidad e ingresos:


SELECT
    CORR(popularidad, ingresos) AS correlacion_popularidad_ingresos
FROM peliculas
WHERE titulo LIKE 'Star Wars Collection%';

-- Para aplicar la correlación a la fecha de emisión, primero debes transformar la fecha en un número,
-- por ejemplo, utilizando la función UNIX_TIMESTAMP si estás trabajando con MySQL:

SELECT
    CORR(EXTRACT(YEAR FROM fecha_emision), p.presupuesto) AS correlacion_fecha_presupuesto,
    CORR(EXTRACT(YEAR FROM fecha_emision), ingresos) AS correlacion_fecha_ingresos,
    CORR(EXTRACT(YEAR FROM fecha_emision), popularidad) AS correlacion_fecha_popularidad
FROM peliculas
WHERE titulo LIKE 'Star Wars Collection%';

-- Recuerda que la sintaxis puede variar dependiendo del sistema de gestión de bases de datos que 
-- estés utilizando, pero estos ejemplos están escritos en SQL estándar. Asegúrate de ajustarlos según tu entorno específico.


-- fin 

SELECT 
    MIN(ingresos - p.presupuesto) AS min_beneficio,
    MAX(ingresos - p.presupuesto) AS max_beneficio,
    AVG(ingresos - p.presupuesto) AS media_beneficio,
    CORR(presupuesto, ingresos) AS correlacion_presupuesto_ingresos,
    CORR(popularidad, p.presupuesto) AS correlacion_popularidad_presupuesto,
    CORR(popularidad, ingresos) AS correlacion_popularidad_ingresos
    CORR(UNIX_TIMESTAMP(fecha_emision), p.presupuesto) AS correlacion_fecha_presupuesto,
    CORR(UNIX_TIMESTAMP(fecha_emision), ingresos) AS correlacion_fecha_ingresos,
    CORR(UNIX_TIMESTAMP(fecha_emision), popularidad) AS correlacion_fecha_popularidad


SELECT  EXTRACT(YEAR FROM p.fecha_emision),DATE_PART('epoch', p.fecha_emision)::numeric ,c.nombre ,p.titulo
FROM peliculas p , colecciones c 
WHERE p.coleccion = c.id and c.nombre like 'Star Wars Collection';


SELECT 
      MIN(p.ingresos - p.presupuesto) AS min_beneficio,
      MAX(p.ingresos - p.presupuesto) AS max_beneficio,
      AVG(p.ingresos - p.presupuesto) AS media_beneficio,
      CORR(p.presupuesto, p.ingresos) AS correlacion_presupuesto_ingresos,
      CORR(p.popularidad, p.presupuesto) AS correlacion_popularidad_presupuesto,
      CORR(p.popularidad, p.ingresos) AS correlacion_popularidad_ingresos,
      CORR(EXTRACT(YEAR FROM p.fecha_emision), p.presupuesto) AS correlacion_ano_presupuesto,
      CORR(EXTRACT(YEAR FROM p.fecha_emision), p.ingresos) AS correlacion_ano_ingresos,
      CORR(EXTRACT(YEAR FROM p.fecha_emision), p.popularidad) AS correlacion_ano_popularidad,
      CORR(DATE_PART('epoch', p.fecha_emision)::NUMERIC, p.presupuesto) AS correlacion_fecha_presupuesto,
      CORR(DATE_PART('epoch', p.fecha_emision)::NUMERIC, p.ingresos) AS correlacion_fecha_presupuesto,
      CORR(DATE_PART('epoch', p.fecha_emision)::NUMERIC, p.popularidad) AS correlacion_fecha_presupuesto
FROM peliculas p , colecciones c 
WHERE p.coleccion = c.id and c.nombre like '%Star Wars Collection%';

-- Obtén un informe en el que se muestre para cada película de la colección "Star Wars Collection" 
-- el número de personas que han trabajado en cada departamento.

select p.titulo, pp.departamento, count(distinct pp.persona) as personas
from peliculas p, colecciones c, pelicula_personal pp 
where p.coleccion = c.id 
 and p.id =pp.pelicula 
 and c.nombre = 'Star Wars Collection'
group by p.titulo, pp.departamento
order by p.titulo, pp.departamento 


-- ejercio

-- Para las diez productoras que más películas tengan, muestra el nombre de la productora, 
-- el número de películas, el número distinto de idiomas originales de las películas, a suma de presupuesto, 
-- la suma de ingresos, el beneficio (resta de ingresos - presupuesto) y la primera y última fecha de emisión.


select p.titulo, pro.nombre, count(distinct p.peliculas) as idioma
from peliculas p , productoras pro, pelicula_productora pp
where pro.id = pp.productora 
 and p.id =pp.pelicula 

order by count(distinct pro.nombre) desc


select p.titulo, pro.nombre, count(distinct pp.pelicula) as idioma
from peliculas p , productoras pro, pelicula_productora pp
where pro.id = pp.productora 
 and p.id = pp.pelicula 

-- aqui estoy agrupando por nombre de pelicula y por promotora lo cual solo toma si hay peliculas repetidas
group by p.titulo,pro.nombre
order by count( pp.pelicula)  desc 


select pro.nombre, count( pp.pelicula) as num_peliculas
from peliculas p , productoras pro, pelicula_productora pp
where pro.id = pp.productora 
 and p.id = pp.pelicula 
-- aqui estoy agrupando  por promotora lo cual solo toma si hay peliculas repetidas
group by pro.nombre
order by count( pp.pelicula)  desc 

--Common Table Expression (CTE) - TopProductoras:

--Esta parte de la consulta se encarga de calcular las estadísticas para las 10 productoras con más películas. 
--Primero, creamos una CTE llamada TopProductoras. Una CTE es como una tabla temporal que podemos usar en la consulta principal. 
--Aquí está el código para esta parte:


WITH TopProductoras AS (
    SELECT
        pp.productora,
        COUNT(p.id) AS num_peliculas,
        COUNT(DISTINCT p.idioma_original) AS num_idiomas_distintos,
        SUM(p.presupuesto) AS suma_presupuesto,
        SUM(p.ingresos) AS suma_ingresos,
        SUM(p.ingresos - p.presupuesto) AS beneficio,
        MIN(p.fecha_emision) AS primera_fecha_emision,
        MAX(p.fecha_emision) AS ultima_fecha_emision
    FROM
        pelicula_productora pp
    JOIN
        peliculas p ON pp.pelicula = p.id
    GROUP BY
        pp.productora
    ORDER BY
        num_peliculas DESC
    LIMIT 10
)

-- Explicación de esta parte:
--
--    Creamos una CTE llamada TopProductoras para realizar cálculos en las productoras con más películas.
--    Utilizamos un SELECT para obtener los siguientes datos:
--        pp.productora: La ID de la productora.
--        COUNT(p.id) AS num_peliculas: El número de películas de esta productora.
--        COUNT(DISTINCT p.idioma_original) AS num_idiomas_distintos: El número de idiomas originales distintos de las películas de esta productora.
--        SUM(p.presupuesto) AS suma_presupuesto: La suma de presupuestos de todas las películas de esta productora.
--        SUM(p.ingresos) AS suma_ingresos: La suma de ingresos de todas las películas de esta productora.
--        SUM(p.ingresos - p.presupuesto) AS beneficio: El beneficio total (resta de ingresos y presupuestos) de todas las películas de esta productora.
--        MIN(p.fecha_emision) AS primera_fecha_emision: La fecha de emisión más temprana de las películas de esta productora.
--        MAX(p.fecha_emision) AS ultima_fecha_emision: La fecha de emisión más reciente de las películas de esta productora.
--    Utilizamos JOIN para combinar la tabla pelicula_productora (que relaciona películas y productoras) con la tabla peliculas para obtener información sobre las películas.
--    Agrupamos los resultados por pp.productora, es decir, estamos calculando estas estadísticas para cada productora.
--    Ordenamos los resultados por num_peliculas en orden descendente para encontrar las 10 productoras con más películas.
--    Limitamos el resultado a 10 filas con LIMIT 10.
--

-- Consulta Principal:

-- La segunda parte de la consulta utiliza la CTE TopProductoras para obtener 
--los nombres de las productoras correspondientes y mostrar la información completa. Aquí está el código para esta parte:

sql

SELECT
    pr.nombre AS nombre_productora,
    tp.num_peliculas,
    tp.num_idiomas_distintos,
    tp.suma_presupuesto,
    tp.suma_ingresos,
    tp.beneficio,
    tp.primera_fecha_emision,
    tp.ultima_fecha_emision
FROM
    TopProductoras tp
JOIN
    productoras pr ON tp.productora = pr.id
ORDER BY
    tp.num_peliculas DESC;

--Explicación de esta parte:
--
--    Usamos SELECT para seleccionar los siguientes datos de la CTE TopProductoras:
--        pr.nombre AS nombre_productora: El nombre de la productora, renombrado como nombre_productora.
--        tp.num_peliculas: El número de películas de esta productora.
--        tp.num_idiomas_distintos: El número de idiomas originales distintos de las películas de esta productora.
--        tp.suma_presupuesto: La suma de presupuestos de todas las películas de esta productora.
--        tp.suma_ingresos: La suma de ingresos de todas las películas de esta productora.
--        tp.beneficio: El beneficio total de todas las películas de esta productora.
--        tp.primera_fecha_emision: La fecha de emisión más temprana de las películas de esta productora.
--        tp.ultima_fecha_emision: La fecha de emisión más reciente de las películas de esta productora.
--    Utilizamos JOIN para unir la CTE TopProductoras con la tabla productoras para obtener los nombres de las productoras correspondientes.
--    Ordenamos los resultados por tp.num_peliculas en orden descendente para mostrar las productoras con más películas primero.


--- seguimos con el ejecicio 9


-- Para las diez productoras que más películas tengan, muestra el nombre de la productora, 
-- el número de películas, el número distinto de idiomas originales de las películas, a suma de presupuesto, 
-- la suma de ingresos, el beneficio (resta de ingresos - presupuesto) y la primera y última fecha de emisión.

-- tenemos cuantas peliculas ha producido cada promotora
select pro.nombre, count( pp.pelicula) as num_peliculas
from peliculas p , productoras pro, pelicula_productora pp
where pro.id = pp.productora 
 and p.id = pp.pelicula 
-- aqui estoy agrupando  por promotora lo cual solo toma si hay peliculas repetidas
group by pro.nombre
order by count( pp.pelicula)  desc 
-- ahora limitamos la tabla a la visualización a 10
limit 10


-- tenemos cuantas peliculas ha producido cada promotora y los idiomas distintos al original de las peliculas que no se repitan los
-- idiomas es decir que solo cuente una vez el español
select pro.nombre, count( pp.pelicula) as num_peliculas , count( distinct pih.idioma ) as num_peliculas
from peliculas p , productoras pro, pelicula_productora pp ,pelicula_idioma_hablado pih,idiomas i
where pro.id = pp.productora 
 and p.id = pp.pelicula 
 and pih.pelicula= p.id
 and pih.idioma= i.id
 and i.nombre != p.idioma_original
-- aqui estoy agrupando  por promotora lo cual solo toma si hay peliculas repetidas
group by pro.nombre
order by count( pp.pelicula)  desc 
-- ahora limitamos la tabla a la visualización a 10
limit 10


-- tenemos cuantas peliculas ha producido cada promotora y los idiomas distintos al original de las peliculas que no se repitan los
-- idiomas es decir que solo cuente una vez el español mas la suma de presupuseto ,ingresos y rentabilidad
select pro.nombre, count( pp.pelicula) as num_peliculas,  count( distinct pih.idioma ) as num_peliculas,
       sum(p.presupuesto) as sum_presupueste, sum(p.ingresos) as sum_ingresos, sum(p.ingresos-p.presupuesto) as sum_ingresos

from peliculas p , productoras pro, pelicula_productora pp ,pelicula_idioma_hablado pih,idiomas i
where pro.id = pp.productora 
 and p.id = pp.pelicula 
 and pih.pelicula= p.id
 and pih.idioma= i.id
 and i.nombre != p.idioma_original
-- aqui estoy agrupando  por promotora lo cual solo toma si hay peliculas repetidas
group by pro.nombre
order by count( pp.pelicula)  desc 
-- ahora limitamos la tabla a la visualización a 10
limit 10





-- tenemos cuantas peliculas ha producido cada promotora y los idiomas distintos al original de las peliculas que no se repitan los
-- idiomas es decir que solo cuente una vez el español mas la suma de presupuseto ,ingresos y rentabilidad
-- y  la primera y última fecha de emisión.
select pro.nombre, count( pp.pelicula) as num_peliculas,  count( distinct pih.idioma ) as num_peliculas,
       sum(p.presupuesto) as sum_presupueste, sum(p.ingresos) as sum_ingresos, sum(p.ingresos-p.presupuesto) as sum_ingresos,
       min(p.fecha_emision) as primera_fecha_de_emision, max(p.fecha_emision) ultima_fecha_de_emision
from peliculas p , productoras pro, pelicula_productora pp ,pelicula_idioma_hablado pih,idiomas i
where pro.id = pp.productora 
 and p.id = pp.pelicula 
 and pih.pelicula= p.id
 and pih.idioma= i.id
 and i.nombre != p.idioma_original
-- aqui estoy agrupando  por promotora lo cual solo toma si hay peliculas repetidas
group by pro.nombre
order by count( pp.pelicula)  desc 
-- ahora limitamos la tabla a la visualización a 10
limit 10

--fin  añadiendo tambien  la lista separada por comas de los códigos de los idiomas 
select pro.nombre, count( pp.pelicula) as num_peliculas,  count( distinct pih.idioma ) as num_idiomas,string_agg(distinct pih.idioma,',') as idiomas,
       sum(p.presupuesto) as sum_presupueste, sum(p.ingresos) as sum_ingresos, sum(p.ingresos-p.presupuesto) as sum_ingresos,
       min(p.fecha_emision) as primera_fecha_de_emision, max(p.fecha_emision) ultima_fecha_de_emision
       
from peliculas p , productoras pro, pelicula_productora pp ,pelicula_idioma_hablado pih,idiomas i
where pro.id = pp.productora 
 and p.id = pp.pelicula 
 and pih.pelicula= p.id
 and pih.idioma= i.id
 and i.nombre != p.idioma_original
-- aqui estoy agrupando  por promotora lo cual solo toma si hay peliculas repetidas
group by pro.nombre
order by count( pp.pelicula)  desc 
-- ahora limitamos la tabla a la visualización a 10
limit 10

-- Obtener la lista de directores cuyas películas hayan generado más de 1500 millones de ingresos. 
-- Para cada director, obtener el número de películas que ha dirigido, el total de ingresos y presupuesto, y el beneficio total. 
-- Mostrar también el número de idiomas originales y la lista separada por comas de los códigos de los idiomas (usar string_agg). 
-- Ordena el resultado en orden descendente por beneficio.

select per.nombre as director,
       count(pel.id) as peliculas,
       sum(ingresos) as ingresos,
       sum(presupuesto) as presupuesto,
       sum(ingresos-presupuesto) as beneficio,
       count(distinct idioma_original) as num_idiomas,
       string_agg(distinct idioma_original,',') as idiomas
from peliculas pel, pelicula_personal pp, personas per
where pel.id = pp.pelicula 
  and per.id = pp.persona 
  and pp.trabajo = 'Director'
group by per.id, per.nombre 
having sum(pel.ingresos) > 1500000000
order by beneficio desc


-- Ejercio 11
-- Para las películas producidas en España (ES), obtener las lista de actores/actrices que han participado en más de 15 películas distintas. 
-- Muestra el número de películas, la media de popularidad de las películas (con dos decimales) y ordena el resultado por este campo.

-- Ver otro tipo de expresiones más complejas con funciones de agregado incluyendo (https://www.postgresql.org/docs/12/sql-expressions.html):

--  Ordenación y filtrado durante el cálculo de agregados.
--  Funciones de ventana (window functions).

-- empezamos por obtener todas las peliculas de espana

select max(presupuesto) as maximo_presupuesto, 
    min(presupuesto) as minimo_presupuesto,
    cast(avg(presupuesto) as integer) as media_presupuesto,
    max(ingresos) as maximo_ingresos, 
    min(ingresos) as minimo_ingresos,
    cast(avg(ingresos) as integer) as media_ingresos
from peliculas pel, pelicula_pais pp ,
where pel.id =pp.pelicula 
and pp.pais ='ES'

-- ahora tengo las peliculas españolas  y los actores o actrices que perticiparon en ellas

select pel.titulo_original, p.nombre  , pp.pais
from peliculas pel, pelicula_pais pp , pelicula_reparto pr ,personas p 
where pel.id =pp.pelicula 
and pel.id = pr.pelicula 
and pr.persona = p.id 
and pp.pais ='ES'

-- ahora tenemos las peliculas agrupadas por el nombre del actor y luego ponemos la condición de que tenga mas de 15
select p.nombre, count(pel.id) as numero_de_peliculas 
from peliculas pel, pelicula_pais pp , pelicula_reparto pr ,personas p 
where pel.id =pp.pelicula 
and pel.id = pr.pelicula 
and pr.persona = p.id 
and pp.pais ='ES'
group by p.nombre 
having  COUNT(pel.id) > 15


-- la media de popularidad de las películas (con dos decimales) y ordena el resultado por este campo
select p.nombre, count(pel.id) as numero_de_peliculas,
	AVG(pel.popularidad) AS media_de_popularidad,round(CAST(AVG(pel.popularidad) as  numeric), 2) as M
	
from peliculas pel, pelicula_pais pp , pelicula_reparto pr ,personas p 
where pel.id =pp.pelicula 
and pel.id = pr.pelicula 
and pr.persona = p.id 
and pp.pais ='ES'
group by p.nombre 
having  COUNT(pel.id) > 15
order  by media_de_popularidad desc 
