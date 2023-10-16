## PASO 1

voy a crear una tabla de  llamda bgde2

**NOTA**
Después de crear una nueva base de datos en PostgreSQL llamada "bdge" ejecutar el siguiente comando para crear todas las tablas.
Esta tabla esta en el github en [PeliculasSchema.sql](../material/PeliculasSchema.sql) en la maquina virtual esta en /home/alumnogreibd/BDGE/datos/
Lo que va ejecutar el cliente psql es el usuario alumnogreibd en bdge y ejecuta todo el comando de home/alumnogreibd/BDGE/datos/PeliculasSchema.sql en la base de datos (para ello hay que crear la base de datos) para crear todas las tablas.
```bash
    psql -U alumnogreibd -d bdge2 -f /home/alumnogreibd/BDGE/datos/PeliculasSchema.sql
```
Las sentencias DML de inserción de datos de cada una de las tablas se encuentra en archivos .sql en la misma carpeta ./BDGE/datos. Ejecutar los siguientes comandos para importar todos los datos.
```bash
    psql -U alumnogreibd -d bdge2 -c "\copy colecciones from /home/alumnogreibd/BDGE/datos/colecciones.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy generos from /home/alumnogreibd/BDGE/datos/generos.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy idiomas from /home/alumnogreibd/BDGE/datos/idiomas.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy paises from /home/alumnogreibd/BDGE/datos/paises.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy personas from /home/alumnogreibd/BDGE/datos/personas.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy productoras from /home/alumnogreibd/BDGE/datos/productoras.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy peliculas from /home/alumnogreibd/BDGE/datos/peliculas.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy pelicula_genero from /home/alumnogreibd/BDGE/datos/pelicula_genero.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy pelicula_idioma_hablado from /home/alumnogreibd/BDGE/datos/pelicula_idioma_hablado.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy pelicula_pais from /home/alumnogreibd/BDGE/datos/pelicula_pais.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy pelicula_personal from /home/alumnogreibd/BDGE/datos/pelicula_personal.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy pelicula_productora from /home/alumnogreibd/BDGE/datos/pelicula_productora.csv csv"
    psql -U alumnogreibd -d bdge2 -c "\copy pelicula_reparto from /home/alumnogreibd/BDGE/datos/pelicula_reparto.csv csv"
```
creamos los tipos de clases

```sql
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
```

creamos una tabla
```sql
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

```

## CONSULTAS

select titulo, (coleccion).nombre as coleccion
from peliculasarray
where (coleccion).nombre like '%Wars%'
order by (coleccion).nombre
