En este ejercicio vamos a importar datos de la base de datos de películas y realizar algunas consultas sobre las mismas y sus créditos (personal y reparto). Antes de importar los nuevos datos, debemos asegurarnos de que la base de datos esté vacía. Para eso, borramos todos los nodos y relaciones.

```bash


neo4j@neo4j> match(n) with n limit 10000 detach delete n;

0 rows available after 1557 ms, consumed after another 0 ms
Deleted 10000 nodes, Deleted 109327 relationships

```


La consulta anterior elimina 10000 nodos, con sus relaciones respectivas con otros nodos. Repetimos esta sentencia hasta que no existan nodos en la base de datos. Borramos los nodos de 10000 en 10000 para evitar problemas de memoria de la máquina virtual de Java durante la operación.   

Importación de los datos de a través de JDBC

1. Importa los datos de las 2000 películas que más ingresos han generado, de cada película almacena su identificador, título, presupuesto, fecha de emisión, ingresos y duración. Crea índices por id y título.

```bash

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select id, titulo, presupuesto, fecha_emision, ingresos, duracion
from peliculas 
order by presupuesto desc, id 
limit 2000") yield row
CREATE (p:Pelicula {id:row.id,
                    titulo:row.titulo,
		   presupuesto: row.presupuesto,
		   fechaEmision:row.fecha_emision,
		   ingresos:row.ingresos,
		   duracion:row.duracion});

```

2. Importa los datos de las personas involucradas en las 2000 películas ya importadas. De cada persona importa su identificador y su nombre. Crea índices por id y nombre.

```bash

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select distinct id, first_value(nombre) over (partition by id order by nombre) as nombre
from (select per.id as id, per.nombre as nombre
	  from pelicula_personal as pp, personas as per
	  where pp.persona = per.id and pp.pelicula in (select id from peliculas order by presupuesto desc, id limit 2000)
	  union all
	  select per.id as id, per.nombre as nombre
	  from pelicula_reparto as pr, personas as per
	  where pr.persona = per.id and pr.pelicula in (select id from peliculas order by presupuesto desc, id limit 2000)) as t") yield row
CREATE (p:Persona {id:row.id,
                   nombre:row.nombre});

CREATE INDEX FOR (a:Persona) ON (a.id);
CREATE INDEX FOR (a:Pelicula) ON (a.id);
CREATE INDEX FOR (a:Persona) ON (a.nombre);
CREATE INDEX FOR (a:Pelicula) ON (a.titulo);
```

3. Importa ahora las relaciones que tienen que ver con el reparto de cada una de las películas antes importadas. Para cada relación, además de registrar la persona y película involucrada, almacena también el personaje interpretado y el orden de aparición en los créditos.

```bash

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select per.id as persona, pr.personaje as personaje, pr.pelicula , pr.orden as orden
from pelicula_reparto as pr, personas as per
where pr.persona = per.id and pr.pelicula in (select id from peliculas order by presupuesto desc, id limit 2000)") yield row
MATCH (pelicula:Pelicula {id:row.pelicula})
MATCH (persona:Persona {id:row.persona})
CREATE (persona)-[r:ACTUO_EN {personaje:row.personaje,orden:row.orden}]->(pelicula);

0 rows available after 3249 ms, consumed after another 0 ms
Created 95097 relationships, Set 190194 properties
```

4. Importa las relaciones que tienen que ver con el resto de personal involucrado en la película. Para cada relación, además de registrar la persona y película involucrada, almacena también el trabajo ('job') y el departamento ('department').

```bash

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select per.id as persona, pp.trabajo as trabajo, pp.pelicula,pp.departamento as departamento
from pelicula_personal as pp, personas as per
where pp.persona = per.id and pp.pelicula in (select id from peliculas order by presupuesto desc, id limit 2000)") yield row
MATCH (pelicula:Pelicula {id:row.pelicula})
MATCH (persona:Persona {id:row.persona})
CREATE (persona)-[r:TRABAJO_EN {trabajo:row.trabajo,departamento:row.departamento}]->(pelicula);

0 rows available after 2596 ms, consumed after another 0 ms
Created 150234 relationships, Set 300468 properties
```

Consultas

1. Crea una relación DIRIGE entre cada director y las películas que ha dirigido.

```bash
# creamos la relacion dirige
MATCH (persona:Persona)-[r:TRABAJO_EN {trabajo: "Director"}]->(pelicula:Pelicula)
CREATE (persona)-[d:DIRIGE]->(pelicula);

# Comprobamos que  este bien creada
MATCH (persona:Persona{nombre:"Steven Spielberg"})-[d:DIRIGE]->(p:Pelicula)
RETURN persona.nombre AS Director, collect(p.titulo) AS Peliculas
ORDER BY persona.nombre;
```

2. Obtén un listado del reparto de la película "Star Wars", ordenado por el atributo orden de la relación ACTUO_EN. Para cada miembro del reparto, muestra el nombre del personaje interpretado y el nombre del actor/actriz.

```bash
# comprobamos peliculoas que tenga el nombre eexactamente igual a Star Wars
MATCH (actor:Persona)-[r:ACTUO_EN]->(pelicula:Pelicula {titulo: "Star Wars"})
RETURN actor.nombre AS Actor, pelicula.titulo AS Pelicula;
# comprobamos los nombres que hay 
MATCH (pelicula:Pelicula)
RETURN  pelicula.titulo AS Pelicula
ORDER BY pelicula.titulo;
# como no hay uno exacto pasamos a mirar los que contengan el nombre
MATCH (pelicula:Pelicula)
WHERE pelicula.titulo CONTAINS "Star Wars"
RETURN  pelicula.titulo AS Pelicula
ORDER BY pelicula.titulo;
# haria ordenamos por titulo y orden 
MATCH (actor:Persona)-[r:ACTUO_EN]->(pelicula:Pelicula)
WHERE pelicula.titulo CONTAINS "Star Wars"
RETURN actor.nombre AS Actor,r.orden,pelicula.titulo AS Pelicula
ORDER BY Pelicula,r.orden;
```

3. Obtén la lista de las 10 películas que mayor beneficio hayan generado (ingresos - presupuesto).
```bash
MATCH (pelicula:Pelicula)
RETURN  pelicula.titulo AS Pelicula , pelicula.ingresos-pelicula.presupuesto AS Beneficios
ORDER BY pelicula.ingresos-pelicula.presupuesto desc
LIMIT 10;
```

4. Mostrar las películas en las que participó "Quentin Tarantino", como actor o como director. Para cada película, muestra su título, fecha de emisión, presupuesto e ingresos. Ordena el resultado por fecha de emisión. Muestra una propiedad "participacion" que indique si dirigió o si actuó.


```bash
MATCH (actor:Persona {nombre: 'Quentin Tarantino'})-[r:ACTUO_EN|DIRIGE]->(pelicula:Pelicula)
RETURN actor.nombre AS Actor, 
       pelicula.titulo AS Pelicula,
       CASE WHEN type(r) = 'ACTUO_EN' THEN 'Actuó' ELSE 'Dirigió' END AS Participacion,
       CASE WHEN type(r) = 'ACTUO_EN' THEN r.orden ELSE NULL END AS Orden
ORDER BY pelicula.titulo, Orden;
```

5. Para la pelicula "The Godfather", obtén para cada departamento, el número de personas involucradas y la lista de nombres y trabajos de cada persona.

```bash
MATCH (persona:Persona)-[r:TRABAJO_EN]->(pelicula:Pelicula)
WHERE pelicula.titulo CONTAINS "The Godfather"
WITH r.departamento AS Departamento, collect(distinct{id: persona.id , nombre: persona.nombre, trabajo: r.trabajo}) AS Personas, 
count(distinct persona.id) AS NumeroDePersonas
RETURN Departamento, NumeroDePersonas, Personas;
```


6. Para la película con más ingresos de entre las que trabajó "Steven Spielberg", obtener el título, el trabajo realizado por el, el presupuesto, los ingresos y el número de personas que actuaron y el número de personas que trabajaron (sin contar los miembros del reparto).

```bash
MATCH (persona:Persona {nombre: 'Steven Spielberg'})-[r:TRABAJO_EN|ACTUO_EN]->(pelicula:Pelicula)
WITH pelicula, CASE WHEN type(r) = 'ACTUO_EN' THEN 'Actuó' ELSE r.trabajo END AS trabajoSteven
MATCH (persona:Persona)-[r:TRABAJO_EN|ACTUO_EN]->(pelicula)
WHERE pelicula = pelicula
RETURN pelicula.titulo AS titulo, 
       trabajoSteven AS trabajoSteven, 
       pelicula.presupuesto AS presupuesto, 
       pelicula.ingresos AS ingresos, 
       COUNT(DISTINCT CASE WHEN type(r) = 'ACTUO_EN' THEN persona END) AS NumeroDeActores, 
       COUNT(DISTINCT CASE WHEN type(r) = 'TRABAJO_EN' THEN persona END) AS NumeroDePersonasTrabajaron
ORDER BY titulo;
```

7. Obtén los nombres de actores y actrices dirigidos por algún director que haya dirigido a "Marlon Brando". Ordena el resultado por el nombre.

```bash

MATCH (brando:Persona {nombre: 'Marlon Brando'})-[:ACTUO_EN]->(:Pelicula)<-[:DIRIGE]-(director:Persona)
WITH director.id as dirigido_por_id
MATCH (actor:Persona)-[:ACTUO_EN]->(pelicula:Pelicula)<-[:DIRIGE]-(director:Persona{id:dirigido_por_id})
RETURN DISTINCT actor.nombre AS NombreActor, pelicula.titulo
ORDER BY NombreActor;
```

8. Obtén una lista de películas que tengan más de un director. Para cada película obtén también una lista de los nombres de sus directores. Ordena el resultado por el número de directores.

```bash

MATCH (persona:Persona)-[d:DIRIGE]->(pelicula:Pelicula)
WITH collect(distinct{id: persona.id , nombre: persona.nombre}) AS Personas, 
count(distinct persona.id) AS NumeroDePersonas, pelicula.titulo as titulo
WHERE NumeroDePersonas>1
RETURN titulo, NumeroDePersonas, Personas
Order by NumeroDePersonas desc ;
```


9. Obtén las 10 personas que más roles han desempeñado en una película, incluyendo participaciones en reparto y personal. Para cada persona, mostrar su id, nombre, el título de la película, el número de roles que desempeño en la película y los nombres de los roles (usa el trabajo para la relación TRABAJO_EN y el texto 'reparto' para la relación ACTUO_EN). Si te sirve de ayuda, puedes usar la cláusula CALL para realizar una subconsulta.

```bash
MATCH (persona:Persona)-[r:TRABAJO_EN|ACTUO_EN]->(pelicula:Pelicula)
WITH persona, pelicula, CASE WHEN type(r) = 'ACTUO_EN' THEN r.personaje ELSE r.trabajo END AS role
WITH persona.id AS id, persona.nombre AS nombre, pelicula.titulo AS tituloPelicula, COLLECT(distinct role) AS roles
WITH id, nombre, tituloPelicula, roles, SIZE(roles) AS numeroDeRoles
ORDER BY numeroDeRoles DESC
LIMIT 10
RETURN nombre, tituloPelicula, numeroDeRoles, roles;
```



10. Obtén la lista de actores o actrices que, o han trabajado con "Quentin Tarantino", o han podido oír de primera mano como es actuar bajo su  mando (han actuado en alguna película en la que haya actuado también alguien que ha sido dirigido por el).

```bash

# si solo se considera direcctor
MATCH (tarantino:Persona {nombre: 'Quentin Tarantino'})-[r:DIRIGE|ACTUO_EN]->(pelicula:Pelicula)<-[p:ACTUO_EN]-(actorDirecto:Persona)
RETURN  collect(distinct{id: actorDirecto.id , nombre: actorDirecto.nombre, personaje: p.personaje}) AS ActoresDirectos, pelicula.titulo , 
CASE WHEN type(r) =  'ACTUO_EN' THEN r.personaje ELSE 'Director' END AS TrabajoQuentin ;

# si solo se considera todos los trabajos
MATCH (tarantino:Persona {nombre: 'Quentin Tarantino'})-[r:TRABAJO_EN|ACTUO_EN]->(pelicula:Pelicula)<-[p:ACTUO_EN]-(actorDirecto:Persona)
RETURN  collect(distinct{id: actorDirecto.id , nombre: actorDirecto.nombre, personaje: p.personaje}) AS ActoresDirectos, pelicula.titulo , 
CASE WHEN type(r) =  'ACTUO_EN' THEN r.personaje ELSE r.trabajo END AS TrabajoQuentin ;

```