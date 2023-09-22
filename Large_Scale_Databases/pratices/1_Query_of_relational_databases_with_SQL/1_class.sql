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


-- Para las diez productoras que más películas tengan, muestra el nombre de la productora, 
-- el número de películas, el número distinto de idiomas originales de las películas, a suma de presupuesto, 
-- la suma de ingresos, el beneficio (resta de ingresos - presupuesto) y la primera y última fecha de emisión.


select p.titulo, pro.nombre, count(distinct p.peliculas) as idioma
from peliculas p , productoras pro, pelicula_productora pp
where pro.id = pp.productora 
 and p.id =pp.pelicula 

order by count(distinct pro.nombre) desc