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


--- seguimos con el ejercicio 9


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
-- NO ESTA BIEN YA QUE SE REPITE POR PELICULAS DEBIDO A LOS IDIOMAS YA QUE HAY COMBINATORIA DE 
-- IDIOMA Y PELICULA DE TAL MANERA QUE HABRIA QUE HACERLO DE OTRO MANERA

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


-- idioma_original tendias que colocar una tabla mas y eso varia un poco diferentes hay contar identificadores distintos 
-- ahora vas temer una por cada idioma en este cso hay que contar distintos  no hay sum distic
-- habria que hacer algo mas complejo ya que hay peliculas que se repiterian por peliculas 


-- Ejercicio 9 resuleto por el profesor 

-- dentro del mismo grupo una pelicula no puede aparecer menos veces grupo es una productora cada fila es
-- no es una pelicuala
select pr.nombre, count(*) as peliculas,
    count(distinct p.idioma_original) as idiomas,
    sum(p.presupuesto) as presupuesto
    sum(p.ingresos) as ingresos
    sum(p.ingresos-p.presupuesto) as beneficios
    min(p.fecha_emision) as pelicula
    max(p.fecha_emision) as ultima 
from productora pr, pelicula p , pelicula_productora pp

where pr.id==pp.productora
    and pp.pelicula = p.id

group by pr .id
-- si fuera por ingresos 
-- order by ingresos desc
-- si es por mas peliculas 
order by peliculas desc
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

--Ejercio 10
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
-- Aqui la combinacion de pelicala persona no hay mas de una pelicula igual para cada director 
-- lo que se hace en este caso es seria añadir columnas a pelicula_productora ya que esta 
-- hace que haya solo una combinación de director por cada pelicula a qui
from peliculas pel, pelicula_personal pp, personas per
where pel.id = pp.pelicula 
  and per.id = pp.persona 
  and pp.trabajo = 'Director'
group by per.id, per.nombre 
-- solo quiero aquelllos que cobran mas de 1500000000
having sum(pel.ingresos) > 1500000000
order by beneficio desc


-- Ejercio 11

-- 11. si tu quieres obtener los maximos ingresos de las peliculas si tu quieres sacar solo
-- uno tienes que decirle que una fila pertenezca o no al resultado es buleneada una fila pertenece
--  
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

--Ejercicio 11 solución del profesor
-- si usamos el codigo ES no cahe flat apaises si no hay que añadiri paises p2
from peliculas p, peliculas_pais pp ,pelicula_reparto pr ,--paises p2
     personas per,
     -- para obtener las metricas 
     avg(p.popularidad) as pop_media
where p.id = pp.pelicuala and p.id=pr.pelucula  -- hasta aqui tendriamos combinaciones
-- de peliculas y peliculas_pais por lo que pude estar repetido ya que un misma pelicula
-- podria estar en  mas de un pais por lo que hay que añadir 
    and pp.pais='ES' -- Es decir aqui se eliminana la repeticiones
    and pr.persona=per.id -- Aqui optenemos las los nombres que de los actores
    -- aqui tengo una fila por pelicula persona 
    -- por lo que ahora agrupo por persona para obtener
-- Si hace varios personajes puede llevar a un error por lo que 
-- si pongo distinct me aseguro de que sean distintas 
having count(distinct p.id) > 15

order  by pop_media desc 


-- 12. Para las 10 películas con más ingresos, 
-- muestra su título y el número de personas distintas del reparto, 
-- y los nombres separados por comas (ordenados por orden), 
-- el número de personas distintas del personal, y el número de departamentos y 
-- trabajos distintos de su personal. 
-- Muestra también la lista de sus directores (ordenados alfabéticamente)

select reparto.titulo, reparto.num_reparto, reparto.reparto,
       personal.num_personal, personal.departamentos, personal.trabajos, personal.directores
from
	(select pel.id as id, pel.titulo as titulo, pel.ingresos as ingresos,
	       count(distinct pr.persona) as num_reparto,
	       string_agg(per.nombre,' ,' order by pr.orden) as reparto
	from peliculas pel, pelicula_reparto pr, personas per
	where pel.id =pr.pelicula and pr.persona = per.id 
	group by pel.id, pel.titulo) as reparto,
	(select pel.id as id,
	       count(distinct pp.persona) as num_personal,
	       count(distinct pp.departamento) as departamentos,
	       count(distinct pp.trabajo) as trabajos,
	       string_agg(per.nombre, ' ,' order by per.nombre) filter (where pp.trabajo = 'Director') as directores
	from peliculas pel, pelicula_personal pp, personas per
	where pel.id=pp.pelicula  and pp.persona = per.id 
	group by pel.id) as personal
where reparto.id = personal.id
order by reparto.ingresos desc 
limit 10

--- comment profesor
select reparto.titulo, reparto.num_reparto, reparto.reparto,
       personal.num_personal, personal.departamentos, personal.trabajos, personal.directores
from
    -- lo hago para el reparto  agrupo  por peliculas  y loc concateno por orden 
    -- todos los datos de pelicula para el repato y me quedo como es la tabla
	(select pel.id as id, pel.titulo as titulo, pel.ingresos as ingresos,
	       count(distinct pr.persona) as num_reparto,
	       string_agg(per.nombre,' ,' order by pr.orden) as reparto
	from peliculas pel, pelicula_reparto pr, personas per
	where pel.id =pr.pelicula and pr.persona = per.id 
	group by pel.id, pel.titulo) as reparto,
    -- indico  que quiero de las persona per solo tengo los nombres de los directores 
    -- pero cuento todos los trabajadres
	(select pel.id as id,
	       count(distinct pp.persona) as num_personal,
	       count(distinct pp.departamento) as departamentos,
	       count(distinct pp.trabajo) as trabajos,
	       string_agg(per.nombre, ' ,' order by per.nombre) filter (where pp.trabajo = 'Director') as directores
	-- las colescos en el from las dos tablas y hago la condición 
    -- de join  en la que las igualo por id de pelicualas
    from peliculas pel, pelicula_personal pp, personas per
	where pel.id=pp.pelicula  and pp.persona = per.id 
	group by pel.id) as personal
where reparto.id = personal.id
order by reparto.ingresos desc 
limit 10

-- usar la clausa with pillar una consulta y darle un rombre en cada sitio que pone 
-- reparto pone el codigo luego intenta generar el arbol y la siguiente puede usar el siguiente
-- y el siguiente

-- lo hago para el reparto  agrupo  por peliculas  y loc concateno por orden 
-- todos los datos de pelicula para el repato y me quedo como es la tabla
with reparto as (select pel.id as id, pel.titulo as titulo, pel.ingresos as ingresos,
	       count(distinct pr.persona) as num_reparto,
	       string_agg(per.nombre,' ,' order by pr.orden) as reparto
	from peliculas pel, pelicula_reparto pr, personas per
	where pel.id =pr.pelicula and pr.persona = per.id 
	group by pel.id, pel.titulo) ,

    
-- indico  que quiero de las persona per solo tengo los nombres de los directores 
-- pero cuento todos los trabajadres
personal as (select pel.id as id,
	       count(distinct pp.persona) as num_personal,
	       count(distinct pp.departamento) as departamentos,
	       count(distinct pp.trabajo) as trabajos,
	       string_agg(per.nombre, ' ,' order by per.nombre) filter (where pp.trabajo = 'Director') as directores
	-- las colescos en el from las dos tablas y hago la condición 
    -- de join  en la que las igualo por id de pelicualas
    from peliculas pel, pelicula_personal pp, personas per
	where pel.id=pp.pelicula  and pp.persona = per.id 
	group by pel.id) 

select reparto.titulo, reparto.num_reparto, reparto.reparto,

       personal.num_personal, personal.departamentos, personal.trabajos, personal.directores
from reparto, personal

where reparto.id = personal.id
order by reparto.ingresos desc 
limit 10

-- otra manera es create view es como una tabla vitual y coge el codigo de la vista y 
-- permite reutilizar en 
-- muchas consultas tambien se puden crear funciones 
-- esas vistas tambien se dan para acceder a partes de tabla
-- para introducir un nivel de seguridad dejando ver ciertas partes de las tabalas

-- Ejercicio 13
-- Ese dato no solo se pude encontrar en esa fila
-- Obtener el titulo, fecha de emisión y sinopsis de la película más 
-- reciente con un beneficio superior a 1000 millones.

select titulo, fecha_emision, sinopsis
-- tengo peliculas

from peliculas pel
where (ingresos - presupuesto) > 1000000000
    -- cuando puedo colocar un where cuando solo devuelve una fila
    -- es decir que el select solo vale par agregasdos de tal manera
    -- que devuelva solo un valor  si me dan el maximo puedo ver pelicual
    -- Yo quiero las pelical ue cumple la condición y quito la condiciñon si 
    -- puede ser mas reciente pero no valer mas de 1000000000 por eso necito 
    -- pero no te van a salir los empates si usas order by in no es estandar 
    -- pero ahora si isarla o no usarla si yo cambio mis consultas cambia algo
    -- tienes problemas de los empates 
    -- con el selsct max salen los empates y si quiero que salga los empates
    -- la fecha de de emisión tambien es mayor o igual quitando la maxima
    -- la maxima tambien es no existe ninguna perlicula que sea mayor o igual
    -- select devuelve siempre la pelicula el mismo valor  la consulta de dentro si unasa
    -- el exit que recorre peliculas y otro bucle que recorre peliculas 
    -- where selec son las que mas cuestan en este caso en el select 
    -- es el mas aciago de todo 
  and fecha_emision = (select max(fecha_emision) 
                       from peliculas pel1 
                       where (ingresos - presupuesto) > 1000000000)


-- se puede hacer no muestra empates  la de arriba si  
from peliculas pel
where (ingresos - presupuesto) > 1000000000
order by fecha_emision desc
limit 1 


-- Ejercicio 14

-- Obtener el título original, presupuesto e ingresos de las 10 película producidas 
-- solo en España con más ingresos. 
-- Obtener también los directores y el reparto.


-- Seleccionamos el título original, presupuesto e ingresos de 
-- las películas desde la tabla peliculas.
SELECT
    p.titulo_original AS "Título Original",
    p.presupuesto AS "Presupuesto",
    p.ingresos AS "Ingresos",
    (
        -- Subconsulta para obtener los directores de la película actual.
        -- Es igual a 


        SELECT string_agg(DISTINCT nombre, ', ')
        FROM personas
        WHERE id IN (
            -- Subconsulta para obtener las personas que tienen el 
            -- trabajo 'Director' en la película actual.
            -- Es decir selecionamos miramos la id de peliculas y comprobamos si
            -- esa persona es director por lo que aqui estamos 
            -- creando solo una sub tabla de directores en la que escojemos 

            SELECT persona
            FROM pelicula_personal
            WHERE pelicula = p.id AND trabajo = 'Director'
        )
    ) AS "Directores",
    (
        -- Subconsulta para obtener el reparto de la película actual.
        SELECT string_agg(DISTINCT CONCAT(nombre, ' - ', personaje), ', ')
        FROM personas
        -- JOIN pelicula_reparto ON personas.id = pelicula_reparto.persona: 
        -- Esta parte del código realiza un INNER JOIN entre las tablas personas y
        -- pelicula_reparto. Esto se hace para vincular las personas con sus respectivos
        -- roles en la película a través de sus IDs. personas.id se compara con 
        -- pelicula_reparto.persona para asegurarse de que estamos uniendo la persona 
        -- correcta con su participación en la película.
        JOIN pelicula_reparto ON personas.id = pelicula_reparto.persona
        WHERE pelicula_reparto.pelicula = p.id
    ) AS "Reparto"
FROM
    peliculas p
WHERE
    -- Filtramos las películas que solo fueron producidas en España utilizando una subconsulta.
    p.id IN (
        SELECT pelicula
        FROM pelicula_pais
        WHERE pais = 'ES'
    )
ORDER BY
    -- Ordenamos los resultados por ingresos en orden descendente.
    p.ingresos DESC
LIMIT 10; -- Limitamos el resultado a las 10 películas con más ingresos.


-- Ejercicio 15
-- en las del from podia generar columnas de una forma y la otra forma eso para la supcon
-- sulta
-- EL junior quiero unirs de filas yo no se reultar
-- puedo gernerar filas de una manera 
-- En este caso no hay un or cada una de esas dos partes tienen consultas similiras

-- Ejercicio 16 consulta simples el tema es que las peliculas no salen como
-- puedo  saldra nulo el left join o right join
-- abajo se tiene un ejemplo de un join 
-- las 20 pelicuals



--- E5.- Para cada género, muestra la popularidad media de sus películas, la suma de beneficios, el beneficio por película medio,
-- el título de la película que generó más beneficios y el actor/actriz principal (entre los 5 primeros en orden) y 
-- el director que han generado más beneficios. Ordena el resultado por popularidad media de forma descendientes

--  Para cada género, muestra la popularidad media de sus películas, la suma de beneficios, el beneficio por película medio

select g.nombre as genero, count(pel.id) , avg(pel.popularidad) ,sum (pel.ingresos-pel.presupuesto),
	    avg(pel.ingresos - pel.presupuesto) as beneficios_medios
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero= g.id
group  by g.nombre 

-- el título de la película que generó más beneficios 
-- primero sabemos cual es el beneficio maximo por cada genero
select g.nombre as genero, max(pel.ingresos - pel.presupuesto ) as beneficio_maximo
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero = g.id 
group  by g.nombre 

select g.id as id , g.nombre as genero, max(pel.ingresos - pel.presupuesto ) as beneficio_maximo
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero  = g.id 
group  by g.id 
order by beneficio_maximo desc 

-- ahora obtenermos la pelicuala  con el mayor beneficio
with mayor_beneficio as (select g.id as id , g.nombre as nombre, max(pel.ingresos - pel.presupuesto ) as beneficio_maximo
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero  = g.id 
group  by g.id  ) 

select pel.titulo , mb.nombre , pel.id , pel.ingresos - pel.presupuesto as beneficio
from peliculas pel , pelicula_genero pg ,mayor_beneficio mb
where pel.id=pg.pelicula and pg.genero=mb.id  and pel.ingresos - pel.presupuesto = mb.beneficio_maximo
order  by beneficio desc 

with mayor_beneficio as (select g.id as id , g.nombre as nombre, max(pel.ingresos - pel.presupuesto ) as beneficio_maximo
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero  = g.id 
group  by g.id  ) 


select pel.titulo as titulo
from peliculas pel , pelicula_genero pg ,mayor_beneficio mb
where pel.id=pg.pelicula and pg.genero=mb.id  and pel.ingresos - pel.presupuesto = mb.beneficio_maximo


select 
   pel.titulo
  from 
   peliculas as pel, 
   generos as gen, 
   pelicula_genero as pg 
  where 
   pel.id = pg.pelicula
   and gen.id = pg.genero
   and (gen.id, (pel.ingresos - pel.presupuesto)) in (select 
 													   gen.id,
													   max(pel.ingresos - pel.presupuesto)
													  from 
													   peliculas as pel, 
													   generos as gen, 
													   pelicula_genero as pg 
													  where 
													   pel.id = pg.pelicula
													   and gen.id = pg.genero
													  group by gen.id)

-- ahora obtenermos la pelicuala  con el mayor beneficio
													  
with mayor_beneficio as (select g.id as id , g.nombre as nombre, max(pel.ingresos - pel.presupuesto ) as beneficio_maximo
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero  = g.id 
group  by g.id  )  ,
pelicula_mayo_beneficio as (
select pel.titulo as titulo , pg.genero as id
from peliculas pel , pelicula_genero pg ,mayor_beneficio mb
where pel.id=pg.pelicula and pg.genero=mb.id  and pel.ingresos - pel.presupuesto = mb.beneficio_maximo
 	)

select g.nombre as genero, count(pel.id) , avg(pel.popularidad) ,sum (pel.ingresos-pel.presupuesto),
	    avg(pel.ingresos - pel.presupuesto) as beneficios_medios , pmb.titulo
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_mayo_beneficio pmb
where pel.id=pg.pelicula and pg.genero  = g.id  and pmb.id = pg.genero 
group  by g.id , pmb.titulo
order  by beneficios_medios

select gen_outer.nombre as genero_nombre,
 cast(avg(pel_outer.popularidad) as decimal(4,2)) as popularidad_media,
 sum(pel_outer.ingresos - pel_outer.presupuesto) as beneficios_totales,
 cast(avg(pel_outer.ingresos - pel_outer.presupuesto) as decimal(20,2)) as beneficios_medios
 ,(select 
   pel.titulo
  from 
   peliculas as pel, 
   generos as gen, 
   pelicula_genero as pg 
  where 
   pel.id = pg.pelicula
   and gen.id = pg.genero
   and gen.id = gen_outer.id
   and (gen.id, (pel.ingresos - pel.presupuesto)) in (select 
 													   gen.id,
													   max(pel.ingresos - pel.presupuesto)
													  from 
													   peliculas as pel, 
													   generos as gen, 
													   pelicula_genero as pg 
													  where 
													   pel.id = pg.pelicula
													   and gen.id = pg.genero
													  group by gen.id)) as pelicula_max_beneficios
from 
 peliculas as pel_outer, 
 generos as gen_outer, 
 pelicula_genero as pg_outer 
where 
 pel_outer.id = pg_outer.pelicula
 and gen_outer.id = pg_outer.genero
group by gen_outer.id
order  by beneficios_medios




-- el actor/actriz principal (entre los 5 primeros en orden)
-- y el director que han generado más beneficios.
-- agrupamos la pelicuals por cada actor en el que se cumpla que el actor este
-- en el orden <5   max(pr.orden) con esto compruebo  que el solo se tienen peliculas en las que el actor 
-- o actriz esta entre los 5 personas siendo principal
-- tabla que da la suma de los beneficios por genero de cada actriz
select g.id as id_gen, g.nombre, p.nombre as nombre_per, p.id as id_per,
	 p.nombre, max(pr.orden) , sum(pel.ingresos-pel.presupuesto) as beneficio_generado
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_reparto pr ,personas p 
where pel.id = pg.pelicula and pg.genero = g.id and 
	  pel.id = pr.pelicula and pr.persona = p.id and pr.orden <6 
group by g.id,p.id 
order by beneficio_generado desc

-- el beneficio maximo de los actores para cada genero

with  beneficios_actores_por_generoa as(
select g.id as id_gen, g.nombre as nombre_gen, p.nombre as nombre_per, p.id as id_per,
	 p.nombre, max(pr.orden) , sum(pel.ingresos-pel.presupuesto) as beneficio_generado
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_reparto pr ,personas p 
where pel.id = pg.pelicula and pg.genero = g.id and 
	  pel.id = pr.pelicula and pr.persona = p.id and pr.orden <6 
group by g.id,p.id 
order by beneficio_generado desc)

select bapg.id_gen as id_gen, bapg.nombre_gen as nombre_gen , max(beneficio_generado) as max_beneficios_actores_por_generoa
from peliculas pel , pelicula_genero pg ,pelicula_reparto pr , beneficios_actores_por_generoa bapg
where pel.id = pg.pelicula and pg.genero = bapg.id_gen and 
	  pel.id = pr.pelicula and pr.persona = bapg.id_per
group  by bapg.id_gen,bapg.nombre_gen