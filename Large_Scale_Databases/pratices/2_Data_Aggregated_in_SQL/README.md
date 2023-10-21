### 2.- Datos Agregados en SQL

**NOTA**
Después de crear una nueva base de datos en PostgreSQL llamada "bdge" ejecutar el siguiente comando para crear todas las tablas.
Esta tabla esta en el github en [PeliculasSchema.sql](../material/PeliculasSchema.sql) en la maquina virtual esta en /home/alumnogreibd/BDGE/datos/
Lo que va ejecutar el cliente psql es el usuario alumnogreibd en bdge y ejecuta todo el comando de home/alumnogreibd/BDGE/datos/PeliculasSchema.sql en la base de datos (para ello hay que crear la base de datos) para crear todas las tablas.
```bash
    psql -U alumnogreibd -d bdge -f /home/alumnogreibd/BDGE/datos/PeliculasSchema.sql
```
Las sentencias DML de inserción de datos de cada una de las tablas se encuentra en archivos .sql en la misma carpeta ./BDGE/datos. Ejecutar los siguientes comandos para importar todos los datos.
```bash
    psql -U alumnogreibd -d bdge -c "\copy colecciones from /home/alumnogreibd/BDGE/datos/colecciones.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy generos from /home/alumnogreibd/BDGE/datos/generos.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy idiomas from /home/alumnogreibd/BDGE/datos/idiomas.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy paises from /home/alumnogreibd/BDGE/datos/paises.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy personas from /home/alumnogreibd/BDGE/datos/personas.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy productoras from /home/alumnogreibd/BDGE/datos/productoras.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy peliculas from /home/alumnogreibd/BDGE/datos/peliculas.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy pelicula_genero from /home/alumnogreibd/BDGE/datos/pelicula_genero.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy pelicula_idioma_hablado from /home/alumnogreibd/BDGE/datos/pelicula_idioma_hablado.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy pelicula_pais from /home/alumnogreibd/BDGE/datos/pelicula_pais.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy pelicula_personal from /home/alumnogreibd/BDGE/datos/pelicula_personal.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy pelicula_productora from /home/alumnogreibd/BDGE/datos/pelicula_productora.csv csv"
    psql -U alumnogreibd -d bdge -c "\copy pelicula_reparto from /home/alumnogreibd/BDGE/datos/pelicula_reparto.csv csv"
```

En esta práctica veremos como gestionar datos agregados con el lenguaje SQL utilizando tres representaciones distintas, primero usando las estructuras proporcionadas por el modelo objeto-relacional y después usando representaciones jerárquicas en XML y JSON.
2.1- Bases de datos objeto-relacionales (tipos compuestos y arrays)

En esta parte de la práctica nos centraremos en el uso de tipos compuestos y arrays en PostgreSQL para gestionar tablas con estructura compleja. Para mantener nuestra base de datos ordenada, vamos a crear un  nuevo esquema "agregados" dentro de nuestra base de datos "bdge".
2.1.1 Tipos de dato compuestos

En la siguiente página web de la documentación de PostgreSQL hay información sobre los tipos compuestos:

https://www.postgresql.org/docs/13/rowtypes.html 

El sistema de tipos de postgreSQL tiene constructores de tipo ROW, para tipos compuestos, y ARRAY para colecciones. Un campo del resultado de una consulta puede tener un tipo de dato ROW, es decir, un tipo de dato que contiene varias columnas anidadas. Un campo de tipo ARRAY, puede tener también como tipo de dato de cada uno de sus elementos un tipo ROW. Sin embargo, al contrario de lo que ocurren en el estándar de SQL, no se pueden crear directamente estructuras de tabla que tengan columnas de estos tipos ROW si no se crea previamente el tipo con una instrucción CREATE TYPE. En el siguiente trozo de código podemos ver la sintaxis para la creación de literales de tipo ROW.

```sql
select 45 as id, (24, 'Hola') as elemento_compuesto
```
    

Nota en este caso no se hace falta el fron  ya que en postgreSQL  si ejecutamos genera una unica fila simeple genera tabla en la segunda coluna 
hay el constructor row de es uan fila que sta dentro de un elemento , cada campo no tiene nombre este tipo de dato fila ya lo tenia el SQL pero sin campo se podia en algunas selec para usar el selec in y se pude construir los parentesis construyen , y se pude devolver.


La siguiente consulta genera una tabla con un tipo de dato ROW sin nombre, pero al intentar crear la tabla que almacene ese resultado el sistema genera un error.
```sql
select pels.id, pels.titulo, 
    case 
      when pels.coleccion is null then null -- si la colencion es nulo ahí lo quetenos una tablas en el campo colención tiene una fila dentro
      -- eso pudo devolverlo  pero deberias poder leerlo
      else (c.id, c.nombre)
    end  as coleccion
from public.peliculas pels left join public.colecciones c  on  pels.coleccion =c.id 
order by pels.presupuesto desc
limit 10;

-- cuando se intenta crear una tabla con ese resultado , si se ejecuta eso se debira tener un error 
-- nos dice que la columna colección tiene seudo tipo  el record el aray .. no podemos crear una
-- con cualquier nuemro de campos por que SQL es fuertemente tipado no puede almacenar registrosa 
-- estilo c 
create table peliculas10 as
select pels.id, pels.titulo, 
    case 
      when pels.coleccion is null then null
      else (c.id, c.nombre)
    end  as coleccion
from public.peliculas pels left join public.colecciones c  on  pels.coleccion =c.id 
order by pels.presupuesto desc
limit 10

```
ERROR
```sql
SQL Error [42P16]: ERROR: la columna «coleccion» tiene pseudotipo record
Error position:
```

Para poder crear nuestra tabla de películas, creamos primero todos los tipos de dato compuestos necesarios.
```sql
-- posmos crear nuestro tipos antes lo cual al igual que c++ le estamos dando categoria 
-- Para ver los tipos en el public se pude ver tipos de datos se va poder crear una tabla en la
-- que es alguno de estos tipo se crean los demas 

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

-- Ahora hay que hacerle un cast el tipo de dato de las tablas para que tenga  conocimiento el valor dentro que tipo es 
-- no hemos incluido en el mienbro de reparto no hemos incluido un orden pero ahora no lo hemos hecho dado que 
-- que las coleciones en el estandar se soportan con un constructor array () el multi seq (este no tiene orden) en postgress vamos a soportar
-- con un orden que seran los indicis del array es decir que no almacenamos el orden ya que el propio array contiene información del
-- orden


Es importante observar la decisión de no incluir el campo "orden" en el tipo "miembro_reparto". Esto se debe a que, al soportar las colecciones con tipos de dato ARRAY, estos ya tienen un orden definido para sus elementos, con lo que este campo ya no será necesario.   


2.1.2 Tipos de dato ARRAY

En el manual de PostgreSQL hay información sobre el tipo array y sus funciones y operadores:

https://www.postgresql.org/docs/13/arrays.html

https://www.postgresql.org/docs/13/functions-array.html

Los arrays pueden tener cualquier número de dimensiones y se soportan dos formas de sintaxis. La forma con la palabra clave ARRAY es la usada por el estándar SQL, pero solo se puede usar con arrays unidimensionales. En esta práctica nos centraremos en el uso de arrays unidimensionales. En el siguiente trozo de código tenemos ejemplos de sintaxis de literales de tipo array, tanto usando la palabra clave ARRAY como usando directamente la sintaxis no estándar de PostgreSQL. Hay ejemplos de arrays de dimensiones 1 y 2. La segunda instrucción falla porque un array solo puede tener un tipo de dato para sus elementos, y la segunda falla porque un array no pude tener distintos tamaños de columnas en sus filas (debe de ser una matriz).


-- como un string {12, 334, 233}  esto de aqui lo que va intentar apartir del string pasar a arry enteros
select cast('{12, 334, 233}' as  integer array), array['hola', 'mundo']

-- crear un array con dos cadenas de caracteres
-- para array entre llaves anotación es con las llaves el estandar tiene los corchetes
-- en los dos casos se construye un array 
select array[12, 12,'hola'] -- cadenas de caracters 
-- los pudeo expecificar con cadena de caracteres tambien puedo hacerlo con array 
-- postgress solo tiene array de una dimensión 
-- si se intenta de mezcla numeros con caractenes no se pude ya que es fuertementae tipado


-- esto es una matriz no permite crearlo ya que hay una fila de 2 columnas
-- tiene que tener el mismo numero de elemnetos que  una matriz coincide

select array[array[12,6], array[12,12,23]] --mal 
select array[array[45,31,45], array[46,13,89]] -- bien



Con la siguiente instrucción DDL creamos la tabla necesaria para almacenar nuestras películas.

```sql
-- se crea una tabla de pelicuals la colección es de tipo coclencio  abajo estan los generos
-- con un  array de tipo generos por lo cual estoy colocando una tabla dentro de una celda
-- de una tabla 
-- en persolnal esta hilado dos veces ya que tiene dentro id y su nombre
-- es un arry si que hay primer elemento el primer mienbro del repar to  es el 1
-- en el de reparto tambien va ha 
-- en una unica tabla tengo todo anidadado en una unica tabla que tenia en el 
-- modelo relacional cudado por ya hay una tabla pelicualas
-- por lo que hay que crear un nuevo esquema (si se creo ya los tipos eliminar tipos)
-- crear un nuevo esquema que se llame agregados arriba se elige agregados 
-- y dentro de este se crean los tipos 
-- dentro de agregados hay que ver la tabla y los tipos de datos si eee se sigue 
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
	CONSTRAINT peliculas_pkey PRIMARY KEY (id)
);
```
Vamos ahora a construir las filas de esta nueva tabla, a partir de las tablas de nuestro modelo relacional.
-- se va a insertar los datos es una expresion bastante larga tiene una inserción de peliculas con coleciones y nada mas 
cada pelicula su colección y no se que 
-- saca el titulo 
insert into peliculas
select pels.id as id,
       pels.titulo as titulo,
       case
          when c.id is null then null
          else cast((c.id,c.nombre) as coleccion) 
       end as coleccion,
       pels.para_adultos as para_adultos,
       pels.presupuesto as presupuesto,
       -- saca el titulo  si no  nolo estan en la misma filat
       case 
          when i1.id is null then null
          else cast((i1.id, i1.nombre) as idioma) 
       end as idioma_original,
       -- datos de la pelicual
       pels.titulo_original as titulo_original,
       pels.sinopsis as sinopsis,
       pels.popularidad as popularidad,
       pels.fecha_emision as fecha_emision,
       pels.ingresos as ingresos,
       pels.duracion as duracion,
       pels.lema as lema,
       -- en la selec estomos ejecutando una tabla seleciona una tabla genero 
       -- para generar todos los generos y optine el id y el nombre 
       -- y esta haciendo un cast de tio genero y luego se lo pasa al array
       -- construyensdo un array de generos si queremos que tenga un orden 
       -- especifico hay que indicarselo ya que el array tiene orden pero se guarda
       -- de cualquier manera 
       ARRAY(select cast((g.id, g.nombre) as genero)
        from public.pelicula_genero pg, public.generos g
        where pels.id =pg.pelicula  and pg.genero = g.id) as generos,
       ARRAY(select cast((i2.id, i2.nombre) as idioma)
        from public.pelicula_idioma_hablado pih, public.idiomas i2
        where pels.id=pih.pelicula and pih.idioma=i2.id) as idiomas_hablados,
       ARRAY(select cast((pa.id, pa.nombre) as pais)
        from public.pelicula_pais ppais, public.paises pa
        where pels.id =ppais.pelicula and ppais.pais =pa.id) as paises,
        -- en este caso creamos un array de mienbros personasl vamos a hacer join traer todo y colocarlo en la tabla de peliculas 
        -- esto va a tardar pero en algun momento temrina tiene que recorrer toda la base de datos 
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

2.1.3 Consulta con tipos compuestos y arrays

Para acceder a los campos de un tipo compuesto usamos la notación ".". Es necesario tener en cuenta que esta misma notación se utiliza para acceder a los campos de una tabla, con lo que puede generar errores de sintaxis inesperados.

1.- Obtener todas las películas de las colecciones que contenga la palabra "Wars". Muestra el título de la película y el nombre de la colección. Ordena el resultado por el nombre de la colección

-- ahora solo tengo una tabla no tengo que hacer join  si me salen muchas filas esto es mas facil 
-- hay que desanidar cosas el atributo coleción tiene una tupla para acceder al nombre tengo que colocar parentesis
-- para no confundirlo con una columna  si no se ponen se cre que es un alias de la tala por lo que 
-- lo que le dices es un avez que aceedas a coleción luego extraes nombrer luego puedo ordenar 
-- acceder a un campo de un elemneto compuesto con el punto  importante el parentesis
-- Si que le estoy dando mas información una pelicula todo junto  si yo quiero 
-- recuperar todos los datos de una pelicula esto deberia ir mejor 
-- los mienbros estan cerca de otro mienbor de reparto (en el relacional)
-- en el anidado tienes para cada pelicula toda la informcaión 
select titulo, (coleccion).nombre as coleccion
from peliculas
where (coleccion).nombre like '%Wars%'
order by (coleccion).nombre

Fijarse en la necesidad de usar paréntesis para asegurarse que accedemos primero a la columna de la tabla y después a un campo dentro de esa columna. Si no usamos los paréntesis el sistema cree que estamos intentando acceder al campo nombre de una tabla "coleccion" que no hemos puesto en la cláusula "from". Ahora, como todos nuestros datos están agregados en una única tabla, ya no es necesario realizar la operación de JOIN para acceder a los datos de la colección de la película.

2.- Para cada película de la colección "Star Wars Collection" obtener su título, el nombre y trabajo del primer miembro del personal, y los datos de los cinco primeros miembros del reparto. Ordena el resultado por fecha de emisión.

-- en este caso como no tengo ningun orden no se cual es el primero luefgo 1:5 es del 1 al 5  si no exite pone null 
-- El cliente piensa que esta anidadado el reparto arriba que denota que eso es un array tiene la persona que lo remarca como un personal complejo para 
-- si lo recuperais entan todos 
select titulo, (personal[1]).persona.nombre as nombre_personal, (personal[1]).trabajo as trabajo_personal,
       reparto[1:5] as reparto
from peliculas
where (coleccion).nombre = 'Star Wars Collection'
order by fecha_emision 

si le das a la flecha a la derecha te los despliega  esta anidado como se hace el cliente soporte para una almacenar una estructura
lo que no se va tener que hacer es construir objetos apartir si arriba tenies json se recupera directp



El editor solo nos permite ver el primer elemento del array. Podemos transformarlo a tipo "text" para verlos todos.

3.- Obtener un listado de los miembros del personal de la película "The Empire Strikes Back". Ordena el resultado por departamento y trabajo.
-- yo en la tabla peliculas no puedo selecionar tal pero quiero sacar una fila por cada mienbro del personal pero ya no tengo dos tablas
-- para eso se usa unnest desanida un array como una tabla que se le pone per como alias con 3 columnas lo que saca una fila por 
cada elemento de de personal ahora estoy sacando datos de una sola fila y saco nombres aunque teneis los datos anidados podeis desempaquetarlos
-- la correspondencia entre la pelicula ya sabe que va adesanidar los miembros de la pelicual con su pelicula
-- con esta operación ya podeis tranforma tablas el resto de SQL 

Anidado array
desanidad unnest

podemos construir el resultado con el nivel de anidado que queramos 




select (persona).nombre, departamento, trabajo
from peliculas, unnest(personal) per(persona, departamento, trabajo)
where titulo = 'The Empire Strikes Back'
order by departamento, trabajo

4.- Obtener un listado del reparto de la película "The Empire Strikes Back", ordenado por el orden en el que aparecen en el array.

-- with ordinality  tiene encuenta el orden del arry y lo almacena en la columna orden por lo que se generan con los 
-- indices del array por lo que nos permite saber el orden que perdimos al anidarlo sin arry 
-- permitiendonos almacenar el orden siempre va haber un orden pero si no lo utilizas da igual
-- pero ahora tienen un modelos con tablas y array 
-- se complica estaba en el gestor ya  pero con la parte relacional 

select orden, (persona).nombre, personaje
from peliculas, unnest (reparto) with ordinality r(persona, personaje, orden)
where titulo = 'The Empire Strikes Back'
order by orden


2.2 Gestión de documentos XML con SQL

-- es lo mismo pero con XML

PostgreSQL proporciona un tipo de datos y un conjunto de funciones, similares a las que define el estándar de SQL, para la gestión de documentos XML. Estas funciones permiten tanto la generación de contenido XML a partir de datos relacionales como el acceso a partes de un documento XML.

Las funciones "xmlparse" y "xmlserialize" permiten el parseo de un documento XML para generar un elemento del tipo de datos "xml" y la obtención del texto de un elemento del tipo de datos "xml".

-- se crea una tabla nativo de possgrees podemos insertar el texto del titulo y luego tenmos 
-- una pagina web 
-- ahí abajo se pude ver , no solo eso se puede consultar el xml se pueden obtener todos los textos que estan en negrita
-- justo debajo se ve un ejemplo como se semi extructurados 
-- con tags con miembros que no tienen estructura

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

2.2.1 Generación de contenido XML a partir de datos relacionales

Para crear contenido XML a partir de datos relacionales podemos usar las funciones "xmlelement"(crea un elmento, posiblemente con atributos), "xmlforest" (crea varios elementos a partir de varias expresiones), "xmlagg" (agrega varios elementos), "xmlconcat" (concatena varios trozos de xml). 

-- en vez utilizar datos de postgressSQL usa documentos XML 
-- son documentos en los que tenemos tag y se van anidado en datos 
-- dentro tiene  y su contenido un nombre
-- se va crear la tabla pelicuals xml 
-- ahora los campos anidados van a ser documentos XML no tiene esquema no hay que crear el tipo
-- en el caso anterior en XML no hace crear type al insertarlo en tipo XML si unos de mis 
-- no hay esquema en esa parte eso 

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
       -- voy a TENER UN ELEMENTO GENEROS QUE SE VA CERRAR Y DENTRO TENGO UNA CONSULTA QUE VA A 
       GENERAR UN ELEMENTO GENERO Y DENTRO TENGO UN ELEMENTO GENERO QUE LO TIENE COMO CONTENIDO 
       EN ELE QUE HABRA UN ID Y EL NOMBRE DEL GENERO XML (CON TAG DE MANERA GERARQUICA)
       -- XLMELEMENT SE PASA UN NOMBRE COMO PRIMER PARAMETRO Y ATRIBUTOS DE MANERA OPCINAL Y LUEGO PONGO EL CONTENIDO
       -- UNA CONSULTA QUE VA A SACAR VARIAS FILAS DESPUES DE UNA FUNCIÓN AGGE SE INCLUYE COMO CONTENIDO TENGO FUNCIONES QUE
       ME PERMITEN CONSTRUIR ELEMENTOS XML 
       -- DE ESTA FORMA SE CONSTRUYE TODO , LA TABLA DE PELICUALS TIENE EN FORMATO XML
       -- LA CONSULTA ARRIBA SE TIENE  NO SE QUE DIGO  XPATH ES UN  TIENE RUTAS 
       -- QUE NAVERGA POR LOS ELEMENTOS 
       -- SERIALICE TRANFORMA EL XML A TEXTO LO TRANFORMA A TEXTO 
       -- SI FUERA UN NUMERO SOLO TENGO TEXTO
       -- COMO PUEDO HACER UNA CONSULTA COMO HACIA EN POSSTGRESS PUEDO ACCEDER AL XML 
       
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

Los agregados que antes almacenábamos con arrays de valores de tipos compuestos, ahora se almacenan en elementos xml con estructura compleja.
2.2.2 Consulta de xml con xpath

-- para poder hacer consultas hay que hacer consultas que permitan , xpath es una función que va tomar un una expresión 
-- se lo aplica a la columna personal los elementos de la ruta personal trabajador por eso hay que hacer el unnest ya que 
va a ser un arry cadauno  va tener un trabahjador del personal la coleción construye un elemento con un nombres
esto lo que hace es construir un nombre  un ide de un nombre 

-- el elemto contenzi tiene ide y como tengo xml pudeo tenerlo anidado


5.- Obtener un listado de los miembros del personal de la película "The Empire Strikes Back". Ordena el resultado por departamento y trabajo.

select xmlserialize(content (xpath('/trabajador/text()', x))[1] as text) as nombre,
 	   xmlserialize(content (xpath('/trabajador/@departamento', x))[1] as text) as departamento,
 	   xmlserialize(content (xpath('/trabajador/@trabajo', x))[1] as text) as trabajo
from peliculasxml pel, unnest(xpath('/personal/trabajador', personal)) as t(x)
where titulo = 'The Empire Strikes Back' 
order by departamento, trabajo


6.- Obtener un listado del reparto de la película "The Empire Strikes Back", ordenado por el orden en el que aparecen en el xml.
-- saco un array xml el primero es el primero el 2 es el segundo tiene orden como los array

select orden,
	   xmlserialize(content (xpath('/miembroreparto/text()', x))[1] as text) as nombre,
 	   xmlserialize(content (xpath('/miembroreparto/@personaje', x))[1] as text) as personaje
from peliculasxml pel, unnest(xpath('/reparto/miembroreparto', reparto)) with ordinality as t(x, orden)
where titulo = 'The Empire Strikes Back' 
order by orden

2.3 Gestión de documentos JSON con SQL

-- json es muy parecido a xml solo que es json hay dos tipo 
-- json b es binario deberia ser mas compacto tampoco almacena el texto va almacenarlo mas compacto
-- json b lo envias añ cliente podeis desenpaqutarlo y json va a ocupar mas
-- si vale la pena mas pasarlo a binario o no 

En las siguientes páginas del manual de PostgreSQL hay información sobre los tipos de datos, funciones y operadores proporcionados para gestionar documentos JSON dentro de las tablas con SQL.

https://www.postgresql.org/docs/13/datatype-json.html

https://www.postgresql.org/docs/13/functions-json.html

Al igual que ocurre con XML, PostgreSQL proporciona un tipo de datos "json" y con conjunto de funciones y operadores que permiten tanto generar documentos JSON a partir de datos relacionales como consultar partes de un documento JSON. Además del tipo "json", también se proporciona un tipo más eficiente "jsonb", que almacena los documentos en formato binario y evita el tener que parsear el texto cada vez que hay que procesarlo y un tipo de datos "jsonpath" para poder hacer consultas que extraen parte de los documentos json (como el xpath de XML). Por falta de tiempo no veremos aquí en detalle toda esta funcionalidad, solo lo suficiente para tener una idea inicial de la funcionalidad proporcionada.
2.3.1 Generación de documentos JSON a partir de datos relacionales

-- jason teien pares claver valor crea un objeto json que introduce dentro de no se qu e
-- ademas de tenner objetos tambien tiener arrais se pude usar '' para generar jason 
-- abajo se tiene par ael personal 

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

2.3.2 Consulta de datos JSON con SQL

-- mismas consultas con las 3 opciones en este caso para desenpaqutar par desenpaqutar un array cada elemento a es un json 
-- a flecha persona de ese elemento json despues del elemento json de este - simbolo -> accede  al objeto perosna el secundo que tien-> > lo
trandfornma a tipo texto por queremos que tse un texto (el mobe) ahñi se pude probar cual va mas rapido hay un tiempo de respuesta para la consulta
7.- Obtener un listado de los miembros del personal de la película "The Empire Strikes Back". Ordena el resultado por departamento y trabajo.

select (a->'persona')->>'nombre' as nombre, a->>'departamento' as departamento, a->>'trabajo' as trabajo
from peliculasjson pel, jsonb_array_elements(personal) as per(a)
where titulo = 'The Empire Strikes Back' 
order by departamento, trabajo

8.- Obtener un listado del reparto de la película "The Empire Strikes Back", ordenado por el orden en el que aparecen en el xml.

select orden, (a->'persona')->>'nombre' as nombre, a->>'personaje' as personaje
from peliculasjson pel, jsonb_array_elements(reparto) with ordinality as reparto(a,orden)
where titulo = 'The Empire Strikes Back' 
order by orden

-- lo que se pedie que se resuelva estos ejercición 3 consultas para E1 y 3 consultas E2 uno por cada coso supongo 
-- como penelope cruz esta en reparto hay que desanidarlo y quedarnos con la de penelope cruz
-- en la segunda 

-- algo interesante es hacer lo mismo en el relacional (supongo que subira nota ) el nombre de una persona concreta 
-- esta un 
-- pero en anidado esta almacenado repetido y almacenado en un orden que si es el mismo que quiero consultar todo va bien
-- pero si quiero ver con una persona voy a tener que desanidar todo hay que fijarse en las consulta y que tipo 
-- de consulta y si encaja luego en el modelo relacional

-- lo que deberian ocurrir en las consultas el agregado las mas rapido en lo contrario y el relñacional mas o menos en el el medio 
-- pero tiene mucho que ver con el no SQL 

-- importante para generar el modelo es saber que consultas tengo que hacer 

-- una base de datos json para almacenar documentos no estaba en el SQl 
Ejercicios

Resuelve cada una de las siguientes consultas utilizando las tres tablas (peliculas, peliculasxml y peliculasjson). Entrega el código SQL generado para cada consulta en un único archivo de texto a través del campus virtual.

E1.- Obtén un listado de películas en las que haya actuado "Penélope Cruz", ordena el listado en orden ascendente por fecha de emisión.

E2.- Obtén un listado de los 10 directores que han generado más beneficios en sus películas. Para cada director obtén el número de películas dirigidas, y el beneficio total.






