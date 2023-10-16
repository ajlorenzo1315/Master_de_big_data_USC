
-- E1.- Obtén un listado ordenado de forma descendente por beneficios (ingresos - presupuesto) de las películas en idioma italiano (it) del año 1960. 
-- Para cada película muestra su título, su título original, la fecha de emisión y su sinopsis.

-- Selecciona los campos que queremos mostrar en la consulta:
select pel.titulo, pel.titulo_original, 
       extract(year from pel.fecha_emision) as ano_de_emision, pel.fecha_emision,
       pel.idioma_original, pel.sinopsis,
       (pel.ingresos - pel.presupuesto) as beneficios
from peliculas pel
-- Filtra las películas en idioma italiano (it) del año 1960:
where pel.idioma_original = 'it' 
      and extract(year from pel.fecha_emision) = 1960
-- Ordena el resultado de forma descendente por beneficios:
order by beneficios desc;


-- E2.- Obtener el reparto de la película "Titanic" de 1997. Para cada miembro del reparto mostrar el orden, el nombre del actor/actriz y el personaje.
-- Mostrar el resultado ordenado por orden.
-- Selecciona los campos que queremos mostrar en la consulta:
--select pel.titulo,p.nombre as nombre_actor_actriz,pr.personaje ,pr.orden ,
select pel.titulo,p.nombre as nombre_actor_actriz,pr.personaje ,pr.orden ,
	   extract(year from  pel.fecha_emision) as ano_de_emision
from peliculas pel, pelicula_reparto pr ,personas p 
-- where  pel.titulo like '%Titanic%' and  esta opción es por si se quiere mirar 
-- todas las peliculas
-- que contengan la palabra titanin pero en este caso se pide que el nombre sea 
-- sea titaninic
-- Filtra las películas con el título 'Titanic' del año 1997:
where  pel.titulo = 'Titanic' and 
	extract(year from  pel.fecha_emision)=1997 and
	pel.id=pr.pelicula and 
	p.id =pr.persona 
-- Ordena el resultado por el orden del reparto:
order by pr.orden


-- E3.- Obtener un listado de países, en el que se muestre para cada país: 
-- i) El número de películas producidas, 

-- Muestra el título de películas junto con su país de origen.
select pel.titulo, pp.pais 
from peliculas pel, pelicula_pais pp , paises p 
where   pel.id=pp.pelicula and 
		pp.pais =p.id  
		
-- Cuenta el número de películas por país y las ordena de forma descendente.		
select pp.pais , count(  pel.id) as numero_de_peliculas
from peliculas pel, pelicula_pais pp , paises p 
where   pel.id=pp.pelicula and 
		pp.pais =p.id  
group  by  pp.pais
order  by  numero_de_peliculas desc 

-- Cuenta el número de películas únicas (evitando duplicados) por país y las ordena de forma descendente.
select pp.pais , count( distinct pel.id) as numero_de_peliculas
from peliculas pel, pelicula_pais pp , paises p 
where   pel.id=pp.pelicula and 
		pp.pais =p.id  
group  by  pp.pais
order  by  numero_de_peliculas desc 


-- ii) La cantidad de beneficios producida, 

select pp.pais , count( distinct pel.id) as numero_de_peliculas ,
		sum(pel.ingresos-pel.presupuesto) as beneficio
from peliculas pel, pelicula_pais pp , paises p 
where   pel.id=pp.pelicula and 
		pp.pais =p.id  
group  by  pp.pais
order  by  numero_de_peliculas desc 

-- iii) La media de popularidad de las películas (con dos cifras decimales).

select pp.pais , count( distinct pel.id) as numero_de_peliculas ,
		sum(pel.ingresos-pel.presupuesto) as beneficio,
		avg(pel.popularidad) as popularidad_media
from peliculas pel, pelicula_pais pp , paises p 
where   pel.id=pp.pelicula and 
		pp.pais =p.id  
group  by  pp.pais
order  by  numero_de_peliculas desc 


-- Ordena el listado de forma descendente por beneficios producidos.
select pp.pais , count( distinct pel.id) as numero_de_peliculas ,
		sum(pel.ingresos-pel.presupuesto) as beneficio,
		round(CAST ( avg(pel.popularidad) as DECIMAL ), 2) as popularidad_media,
		CAST ( avg(pel.popularidad) as DECIMAL ) as popularidad_media_decimal
from peliculas pel, pelicula_pais pp , paises p 
where  pel.id=pp.pelicula and 
	   pp.pais =p.id  
group  by  pp.pais
order  by  beneficio desc


-- E4.- Obtener un listado de personas que hayan dirigido y actuado en alguna película. 
-- Mostrar el número de películas dirigidas y las fechas de la primera y última. 
-- Mostrar también el número de películas en las que actuó, y la fecha de la primera y última. 
-- Ordena el resultado por el producto del número de películas dirigidas por el número de películas en la que actuó.


--select pel.titulo,p.nombre as nombre_actor_actriz,pr.personaje ,pr.orden ,
select pel.titulo,p.nombre as nombre, pp.trabajo,pr.personaje  ,pr.orden ,
	   extract(year from  pel.fecha_emision) as ano_de_emision
from peliculas pel, pelicula_reparto pr ,personas p , pelicula_personal pp 
-- where  pel.titulo like '%Titanic%' and 
where  pel.titulo = 'Titanic' and 
	extract(year from  pel.fecha_emision)=1997 and
	pel.id=pr.pelicula and 
	pp.trabajo = 'Director' and 
	pel.id=pp.pelicula and
	p.id =pr.persona 

order by pr.orden

-- primero generamos una tabla que mire los directores 
-- Y muestra el número de películas dirigidas y las fechas de la primera y última. 
select per.id  as id, 
	  per.nombre as nombre, 
	  count(distinct pel.id) as num_pelicualas_dirigidas,
	  min(pel.fecha_emision) as fecha_primera_pelicula_dirigida,
	  max(pel.fecha_emision) as fecha_ultima_pelicula_dirigida
from peliculas pel, pelicula_personal pp, personas per
where pel.id =pp.pelicula and pp.persona = per.id and pp.trabajo='Director'
group by per.id

-- Segundo generamos una tabla que mire los directores 
-- Y muestra también el número de películas en las que actuó, y la fecha de la primera y última. 
select per.id  as id, 
	  per.nombre as nombre, 
	  count(distinct pel.id) as num_pelicualas_interpretadas,
	  min(pel.fecha_emision) as fecha_primera_pelicula_interpretada,
	  max(pel.fecha_emision) as fecha_ultima_pelicula_interpretada
from peliculas pel, pelicula_reparto pr , personas per
where pel.id =pr.pelicula and pr.persona = per.id 
group by per.id

-- Por ultimo las tratamos como subconsultas para obtener los datos de los dos
-- y igualamos comprobamos que id estan en las dos tablas lo cual nos 
-- dira que persono actua y dirige

with directores as ( select per.id  as id, 
	  per.nombre as nombre, 
	  count(distinct pel.id) as num_pelicualas_dirigidas,
	  min(pel.fecha_emision) as fecha_primera_pelicula_dirigida,
	  max(pel.fecha_emision) as fecha_ultima_pelicula_dirigida
from peliculas pel, pelicula_personal pp, personas per
where pel.id =pp.pelicula and pp.persona = per.id and pp.trabajo='Director'
group by per.id ),
	actores as (select per.id  as id, 
	  per.nombre as nombre, 
	  count(distinct pel.id) as num_pelicualas_interpretadas,
	  min(pel.fecha_emision) as fecha_primera_pelicula_interpretada,
	  max(pel.fecha_emision) as fecha_ultima_pelicula_interpretada
from peliculas pel, pelicula_reparto pr , personas per
where pel.id =pr.pelicula and pr.persona = per.id 
group by per.id)


select d.id, d.nombre , d.num_pelicualas_dirigidas, d.fecha_primera_pelicula_dirigida, 
	  d.fecha_ultima_pelicula_dirigida, a.num_pelicualas_interpretadas,
	  a.fecha_primera_pelicula_interpretada, a.fecha_ultima_pelicula_interpretada,
	  d.num_pelicualas_dirigidas*a.num_pelicualas_interpretadas

from directores d , actores a
where d.id = a.id
-- Ordena el resultado por el producto del número de películas 
-- dirigidas por el número de películas en la que actuó.
-- en este caso lo oredena de maneras descendente para visualizar que 
-- personas han trabajado y dirigido en mas 
-- peliculas
order by  d.num_pelicualas_dirigidas *   a.num_pelicualas_interpretadas desc 


-- E5.- Para cada género, muestra la popularidad media de sus películas, la suma de beneficios, el beneficio por película medio,
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


-- ahora obtenemos los actores  que mas beneficios dan 
-- aqui lo que optnemos el es la suma de todos los beneficios
-- de todas las peliculas por cada actor en cada categoria
with  beneficios_actores_por_generoa as(
select g.id as id_gen, g.nombre as nombre_gen, p.nombre as nombre_per, p.id as id_per,
	 p.nombre, max(pr.orden) , sum(pel.ingresos-pel.presupuesto) as beneficio_generado
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_reparto pr ,personas p 
where pel.id = pg.pelicula and pg.genero = g.id and 
	  pel.id = pr.pelicula and pr.persona = p.id and pr.orden <6 
group by g.id,p.id 
order by beneficio_generado desc),
-- ahora obtenemos cual es el valor maximo benefecición de cada geneerodo
-- de los benefición de un actor 
max_beneficios_actores_por_genero as (
select
    id_gen,
    max(beneficio_generado) as max_beneficio_generado
from
    beneficios_actores_por_generoa
group by id_gen
)

-- ahora obtenemos el nombre del actor
select
  bapg.id_gen,
  bapg.nombre_gen,
  bapg.nombre_per,
  bapg.beneficio_generado
from
  beneficios_actores_por_generoa bapg, max_beneficios_actores_por_genero mbapg
where bapg.id_gen = mbapg.id_gen and bapg.beneficio_generado = mbapg.max_beneficio_generado

-- codigo para intentar comprobar que estamos haciendolo bien 

select g.id as id_gen, g.nombre as nombre_gen, p.nombre as nombre_per, p.id as id_per,
	 p.nombre, max(pr.orden) , sum(pel.ingresos-pel.presupuesto) as beneficio_generado
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_reparto pr ,personas p 
where pel.id = pg.pelicula and pg.genero = g.id and 
	  pel.id = pr.pelicula and pr.persona = p.id and pr.orden <6 and
	  g.nombre = 'Documentary'
group by g.id,p.id 
order by beneficio_generado desc



-- ahora hacemos lo mismo para los directores



--------- RESULTADO FINAL ------------------------------------------------------------

with  beneficios_director_por_genero as(
select g.id as id_gen, g.nombre as nombre_gen, p.nombre as nombre_per, p.id as id_per,
	 p.nombre , sum(pel.ingresos-pel.presupuesto) as beneficio_generado
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_personal pp  ,personas p 
where pel.id = pg.pelicula and pg.genero = g.id and 
	  pel.id = pp.pelicula and pp.persona = p.id and pp.trabajo = 'Director'
group by g.id,p.id 
order by beneficio_generado desc),
-- ahora obtenemos cual es el valor maximo benefecición de cada geneerodo
-- de los benefición de un actor 
max_beneficios_directores_por_genero as (
select
    id_gen,
    max(beneficio_generado) as max_beneficio_generado
from
    beneficios_director_por_genero
group by id_gen
),

beneficios_actores_por_generoa as(
select g.id as id_gen, g.nombre as nombre_gen, p.nombre as nombre_per, p.id as id_per,
	 p.nombre, max(pr.orden) , sum(pel.ingresos-pel.presupuesto) as beneficio_generado
from peliculas pel , pelicula_genero pg ,generos g ,pelicula_reparto pr ,personas p 
where pel.id = pg.pelicula and pg.genero = g.id and 
	  pel.id = pr.pelicula and pr.persona = p.id and pr.orden <6 
group by g.id,p.id 
order by beneficio_generado desc),
-- ahora obtenemos cual es el valor maximo benefecición de cada geneerodo
-- de los benefición de un actor 
max_beneficios_actores_por_genero as (
select
    id_gen,
    max(beneficio_generado) as max_beneficio_generado
from
    beneficios_actores_por_generoa
group by id_gen
),
max_director as (
-- director mejor 
select
  bdpg.id_gen,
  MAX(bdpg.nombre_per) as director,
  bdpg.beneficio_generado
from
  beneficios_director_por_genero bdpg, max_beneficios_directores_por_genero mbdpg
where bdpg.id_gen = mbdpg.id_gen and bdpg.beneficio_generado = mbdpg.max_beneficio_generado
group  by bdpg.id_gen,bdpg.beneficio_generado),
max_actor as (
-- ahora obtenemos el nombre del actor
select
  bapg.id_gen as id_gen  ,
  MAX(bapg.nombre_per) as actor,
  bapg.beneficio_generado
from
  beneficios_actores_por_generoa bapg, max_beneficios_actores_por_genero mbapg
where bapg.id_gen = mbapg.id_gen and bapg.beneficio_generado = mbapg.max_beneficio_generado
group  by bapg.id_gen,bapg.beneficio_generado),

max_actor_director as(
select
  ma.id_gen as id,
  g.nombre,
  ma.actor as nombre_actores_mayor_beneficio,
  ma.beneficio_generado as mayor_beneficio_actores,
  md.director  as nombre_directores_mayor_beneficio,
  md.beneficio_generado as mayor_beneficio_directores
  
from
  max_actor ma, max_director md ,generos g 
where ma.id_gen = md.id_gen and ma.id_gen=g.id),


-- la tabla solo para la peliculas que mas rentables

mayor_beneficio as (select g.id as id , g.nombre as nombre, max(pel.ingresos - pel.presupuesto ) as beneficio_maximo
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero  = g.id 
group  by g.id  )  ,

pelicula_mayo_beneficio as (
select pel.titulo as titulo , pg.genero as id , mb.beneficio_maximo as mayor_beneficio
from peliculas pel , pelicula_genero pg ,mayor_beneficio mb
where pel.id=pg.pelicula and pg.genero=mb.id  and pel.ingresos - pel.presupuesto = mb.beneficio_maximo
 	),

metricas_por_generos as (
	select g.id as id, count(pel.id) as num_pel , avg(pel.popularidad) as avg_popularidad ,sum (pel.ingresos-pel.presupuesto) as sum_beneficio,
	    avg(pel.ingresos - pel.presupuesto) as avg_beneficio
from peliculas pel , pelicula_genero pg ,generos g 
where pel.id=pg.pelicula and pg.genero  = g.id  
group  by g.id
)


select g.nombre , mpg.num_pel , mpg.avg_popularidad, mpg.sum_beneficio ,mpg.avg_beneficio,
	pmb.titulo as  nombre_pelicula_mayor_beneficio, pmb.mayor_beneficio as  mayor_beneficio_de_pelicula,
	mad.nombre_actores_mayor_beneficio, mad.mayor_beneficio_actores, mad.nombre_directores_mayor_beneficio, mad.mayor_beneficio_directores
from generos g ,pelicula_mayo_beneficio pmb , max_actor_director mad, metricas_por_generos mpg
where g.id=mpg.id and mad.id=g.id and pmb.id=g.id
order by  mpg.avg_popularidad desc 
