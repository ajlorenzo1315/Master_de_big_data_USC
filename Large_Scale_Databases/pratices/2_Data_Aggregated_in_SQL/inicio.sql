create type coleccion as (
	id int4,
	nombre text
); 

create type genero as (
	id int4,
	nombre text
);


CREATE type idioma as (
	id text,
	nombre text
);

CREATE type pais as (
	id text,
	nombre text
);

	

CREATE type productora as (
	id int4,
	nombre text
);

CREATE type persona as (
	id int4,
	nombre text
);

CREATE type miembro_reparto as (
	persona persona,
	personaje text
);

CREATE type miembro_personal as (
	persona persona,
	departamento text,
	trabajo text
);



----------------- creamos la tabla de peliculas array
CREATE TABLE peliculasarray (
	id int4 NOT NULL,
	titulo text,
	coleccion coleccion,
	para_adultos bool,
	presupuesto int4,
	idioma_original idioma,
	titulo_original text,
	sinopsis text,
	popularidad float8,
	fecha_emision date,
	ingresos int8,
	duracion float8,
	lema text,
	generos genero ARRAY,
	idiomas_hablados idioma ARRAY,
	paises pais ARRAY,
	personal miembro_personal ARRAY,
	reparto miembro_reparto ARRAY,
	productoras productora ARRAY,
	CONSTRAINT peliculasarry_pkey PRIMARY KEY (id)
);

insert into peliculasarray
select pels.id as id,
       pels.titulo as titulo,
       case
          when c.id is null then null
          else cast((c.id,c.nombre) as coleccion) 
       end as coleccion,
       pels.para_adultos as para_adultos,
       pels.presupuesto as presupuesto,
       case 
          when i1.id is null then null
          else cast((i1.id, i1.nombre) as idioma) 
       end as idioma_original,
       pels.titulo_original as titulo_original,
       pels.sinopsis as sinopsis,
       pels.popularidad as popularidad,
       pels.fecha_emision as fecha_emision,
       pels.ingresos as ingresos,
       pels.duracion as duracion,
       pels.lema as lema,
       ARRAY(select cast((g.id, g.nombre) as genero)
        from public.pelicula_genero pg, public.generos g
        where pels.id =pg.pelicula  and pg.genero = g.id) as generos,
       ARRAY(select cast((i2.id, i2.nombre) as idioma)
        from public.pelicula_idioma_hablado pih, public.idiomas i2
        where pels.id=pih.pelicula and pih.idioma=i2.id) as idiomas_hablados,
       ARRAY(select cast((pa.id, pa.nombre) as pais)
        from public.pelicula_pais ppais, public.paises pa
        where pels.id =ppais.pelicula and ppais.pais =pa.id) as paises,
       ARRAY(select cast((cast((per1.id,per1.nombre) as persona), pper.departamento, pper.trabajo) as miembro_personal)
       from public.pelicula_personal pper, public.personas per1
       where pels.id = pper.pelicula and pper.persona = per1.id) as personal,
       ARRAY(select cast((cast((per2.id,per2.nombre) as persona), prep.personaje) as miembro_reparto)
       from public.pelicula_reparto prep, public.personas per2
       where pels.id =prep.pelicula and prep.persona = per2.id
       order by prep.orden) as reparto,
       ARRAY(select cast((prods.id, prods.nombre) as productora)
        from public.pelicula_productora pprod, public.productoras prods
        where pels.id = pprod.pelicula and pprod.productora = prods.id) as productoras 
from public.peliculas pels left join public.colecciones c on pels.coleccion = c.id
     left join public.idiomas i1 on pels.idioma_original=i1.id



---------------- creamos la tabla de peliculas xml
--- genrar un documento con sql
CREATE TABLE docxml (
titulo varchar(500) not null primary key,
doc xml
);

insert into docxml values ('ejemploHTML.xml', xmlparse(DOCUMENT
'<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--Este es un comentario y no sera tomado en cuenta por el navegador
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
<title>Titulo de la pagina</title>
</head>
<body>
<p>Primer documento XHTML, es decir un, Hola mundo</p>
<p>En este segundo párrafo voy a incluír un <b>texto en
negrita</b></p>
En este texto libre coloco un <b>salto de linea</b> <br/>
para continuar con algunos <b>caracteres especiales</b>. En concreto:
<br/>
El caracter &amp; se usa para escribir los caracteres especiales.<br/>
Este mismo caracter especial se escribiría &amp;amp.<br/>
Tampoco se pueden usar los <b>signos mayor y menor</b> &lt;(&amp;lt) y
&gt;(&amp;gt);<br/>
Si quieres introducir <b>espacios en blanco</b> &nbsp; &nbsp; tienes
que usar &amp;nbsp
</body>
</html>'));

select xmlserialize(DOCUMENT doc as text)
from docxml
where titulo like '%HTML%';


------------ 2.2.1 Generación de contenido XML a partir de datos relacionales

create table peliculasxml as
select pels.id as id,
       pels.titulo as titulo,
       case
          when c.id is null then null
          else xmlelement(name coleccion, xmlattributes(c.id as id), c.nombre) 
       end as coleccion,
       pels.para_adultos as para_adultos,
       pels.presupuesto as presupuesto,
       case 
          when i1.id is null then null
          else xmlelement(name idioma, xmlattributes(i1.id as id), i1.nombre)
       end as idioma_original,
       pels.titulo_original as titulo_original,
       pels.sinopsis as sinopsis,
       pels.popularidad as popularidad,
       pels.fecha_emision as fecha_emision,
       pels.ingresos as ingresos,
       pels.duracion as duracion,
       pels.lema as lema,
       xmlelement(
       	name generos, 
       	(select xmlagg(xmlelement(name genero, xmlattributes(g.id as id), g.nombre))
       	from public.pelicula_genero pg, public.generos g
        where pels.id =pg.pelicula  and pg.genero = g.id)
       ) as generos,       
       xmlelement(
       	name idiomas, 
       	(select xmlagg(xmlelement(name idioma, xmlattributes(i2.id as id), i2.nombre))  
        from public.pelicula_idioma_hablado pih, public.idiomas i2
        where pels.id=pih.pelicula and pih.idioma=i2.id)
       ) as idiomas_hablados,
       xmlelement(
       	name paises, 
       	(select xmlagg(xmlelement(name pais, xmlattributes(pa.id as id), pa.nombre))  
        from public.pelicula_pais ppais, public.paises pa
        where pels.id =ppais.pelicula and ppais.pais =pa.id)
       ) as paises,
       xmlelement(
       	name personal, 
       	(select xmlagg(xmlelement(name trabajador, xmlattributes(per1.id as id, pper.departamento as departamento, pper.trabajo as trabajo), per1.nombre))  
        from public.pelicula_personal pper, public.personas per1
       	where pels.id = pper.pelicula and pper.persona = per1.id)
       ) as personal,
       xmlelement(
       	name reparto, 
       	(select xmlagg(xmlelement(name miembroreparto, xmlattributes(per2.id as id, prep.personaje as personaje), per2.nombre) order by prep.orden)  
        from public.pelicula_reparto prep, public.personas per2
      	 where pels.id =prep.pelicula and prep.persona = per2.id
       	)
       ) as reparto,
       xmlelement(
       	name productoras, 
       	(select xmlagg(xmlelement(name productora, xmlattributes(prods.id as id), prods.nombre))  
        from public.pelicula_productora pprod, public.productoras prods
        where pels.id = pprod.pelicula and pprod.productora = prods.id)
       ) as productoras    
from public.peliculas pels left join public.colecciones c on pels.coleccion = c.id
     left join public.idiomas i1 on pels.idioma_original=i1.id


------------------ JSON

create table peliculasjson as
select pels.id as id,
       pels.titulo as titulo,
       case
          when c.id is null then null
          else jsonb_build_object('id',c.id, 'nombre',c.nombre) 
       end as coleccion,
       pels.para_adultos as para_adultos,
       pels.presupuesto as presupuesto,
       case 
          when i1.id is null then null
          else jsonb_build_object('id',i1.id, 'nombre',i1.nombre)
       end as idioma_original,
       pels.titulo_original as titulo_original,
       pels.sinopsis as sinopsis,
       pels.popularidad as popularidad,
       pels.fecha_emision as fecha_emision,
       pels.ingresos as ingresos,
       pels.duracion as duracion,
       pels.lema as lema,
       (select jsonb_agg(jsonb_build_object('id',g.id, 'nombre',g.nombre))
       	from public.pelicula_genero pg, public.generos g
        where pels.id =pg.pelicula  and pg.genero = g.id) as generos,
       (select jsonb_agg(jsonb_build_object('id',i2.id, 'nombre',i2.nombre))
        from public.pelicula_idioma_hablado pih, public.idiomas i2
        where pels.id=pih.pelicula and pih.idioma=i2.id) as idiomas_hablados,       
        (select jsonb_agg(jsonb_build_object('id',pa.id, 'nombre',pa.nombre)) 
        from public.pelicula_pais ppais, public.paises pa
        where pels.id =ppais.pelicula and ppais.pais =pa.id) as paises,
        (select jsonb_agg(jsonb_build_object('persona',jsonb_build_object('id',per1.id, 'nombre', per1.nombre), 'departamento',pper.departamento, 'trabajo', pper.trabajo)) 
        from public.pelicula_personal pper, public.personas per1
       	where pels.id = pper.pelicula and pper.persona = per1.id) as personal,
       	(select jsonb_agg(jsonb_build_object('persona',jsonb_build_object('id',per2.id, 'nombre', per2.nombre), 'personaje',prep.personaje) order by prep.orden) 
        from public.pelicula_reparto prep, public.personas per2
      	 where pels.id =prep.pelicula and prep.persona = per2.id) as reparto,
        (select jsonb_agg(jsonb_build_object('id',prods.id, 'nombre',prods.nombre)) 
        from public.pelicula_productora pprod, public.productoras prods
        where pels.id = pprod.pelicula and pprod.productora = prods.id) as productoras
from public.peliculas pels left join public.colecciones c on pels.coleccion = c.id
     left join public.idiomas i1 on pels.idioma_original=i1.id