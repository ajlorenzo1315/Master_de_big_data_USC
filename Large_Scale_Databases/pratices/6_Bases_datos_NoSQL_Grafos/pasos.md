mkdir neo4j
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update

sudo add-apt-repository universe
sudo apt-get install neo4j=1:4.2.2

sudo chown neo4j:adm apoc-4.2.0.1-all.jar

 	

sudo systemctl start neo4j

sudo systemctl status neo4j

cypher-shell

username: neo4j
password: greibd2021


show default database;

neo4j@neo4j> CREATE (:Movie { title:"The Matrix",released:1997 });
0 rows available after 441 ms, consumed after another 0 ms
Added 1 nodes, Set 2 properties, Added 1 labels



CREATE (p:Person {name:"Halle Berry"})
                          RETURN p;
+---------------------------------+
| p                               |
+---------------------------------+
| (:Person {name: "Halle Berry"}) |
+---------------------------------+

1 row available after 127 ms, consumed after another 5 ms
Added 1 nodes, Set 1 properties, Added 1 labels

 CREATE (p:Person { name:"Keanu Reeves", born:1964 })
                RETURN p;
+----------------------------------------------+
| p                                            |
+----------------------------------------------+
| (:Person {name: "Keanu Reeves", born: 1964}) |
+----------------------------------------------+

1 row available after 92 ms, consumed after another 10 ms
Added 1 nodes, Set 2 properties, Added 1 labels
neo4j@neo4j> 


neo4j@neo4j> CREATE (a:Person { name:"Tom Hanks", born:1956 })
                     -[r:ACTED_IN { roles: ["Forrest"]}]->
                     (m:Movie { title:"Forrest Gump",released:1994 })
             CREATE (d:Person { name:"Robert Zemeckis", born:1951 })-[:DIRECTED]->(m)
             RETURN a,d,r,m;
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| a                                         | d                                               | r                                | m                                                |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956}) | (:Person {name: "Robert Zemeckis", born: 1951}) | [:ACTED_IN {roles: ["Forrest"]}] | (:Movie {title: "Forrest Gump", released: 1994}) |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

1 row available after 262 ms, consumed after another 36 ms
Added 3 nodes, Created 2 relationships, Set 7 properties, Added 3 labels



neo4j@neo4j> MATCH (p:Person { name:"Tom Hanks" })
             CREATE (m:Movie { title:"Cloud Atlas",released:2012 })
             CREATE (p)-[r:ACTED_IN { roles: ['Dr. Henry Goose', 'Hotel Manager', 'Isaac Sachs', 
                                              'Dermot Hoggins', 'Cavendish', 'Look-a-Like Actor','Zachry']}]->(m)
             RETURN p,r,m;
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| p                                         | r                                                                                                                                      | m                                               |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

2 rows available after 174 ms, consumed after another 10 ms
Added 2 nodes, Created 2 relationships, Set 6 properties, Added 2 labels
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person {name:"Halle Berry"})
             MATCH (m:Movie { title:"Cloud Atlas"})
             CREATE (p)-[r:ACTED_IN {roles:['Native Woman' , 'Jocasta Ayrs', 'Luisa Rey', 
                                            'Indian Party Guest', 'Ovid', 'Meronym']}]->(m)
             ;
0 rows available after 94 ms, consumed after another 0 ms
Created 3 relationships, Set 3 properties


neo4j@neo4j> match (:Person {name:"Tom Hanks"}) -[r:ACTED_IN]-> (m:Movie)
             return m.title, r.roles;
+------------------------------------------------------------------------------------------------------------------------------------+
| m.title        | r.roles                                                                                                           |
+------------------------------------------------------------------------------------------------------------------------------------+
| "Cloud Atlas"  | ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"] |
| "Cloud Atlas"  | ["Zachry"]                                                                                                        |
| "Forrest Gump" | ["Forrest"]                                                                                                       |
| "Cloud Atlas"  | ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"] |
| "Forrest Gump" | ["Forrest"]                                                                                                       |
+------------------------------------------------------------------------------------------------------------------------------------+

5 rows available after 342 ms, consumed after another 24 ms


neo4j@neo4j> MERGE (m:Movie { title:"Cloud Atlas" })
             ON CREATE SET m.released = 2012
             RETURN m;
+-------------------------------------------------+
| m                                               |
+-------------------------------------------------+
| (:Movie {title: "Cloud Atlas", released: 2012}) |
| (:Movie {title: "Cloud Atlas", released: 2012}) |
| (:Movie {title: "Cloud Atlas", released: 2012}) |
+-------------------------------------------------+

3 rows available after 240 ms, consumed after another 11 ms


neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             SET m.released = 2013
             RETURN m;
+-------------------------------------------------+
| m                                               |
+-------------------------------------------------+
| (:Movie {title: "Cloud Atlas", released: 2013}) |
| (:Movie {title: "Cloud Atlas", released: 2013}) |
| (:Movie {title: "Cloud Atlas", released: 2013}) |
+-------------------------------------------------+

3 rows available after 71 ms, consumed after another 8 ms
Set 3 properties



neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             DELETE m;
Cannot delete node<5>, because it still has relationships. To delete this node, you must first delete its relationships.
neo4j@neo4j> 
neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             DETACH DELETE m;
0 rows available after 124 ms, consumed after another 0 ms
Deleted 3 nodes, Deleted 6 relationships
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person { name:"Tom Hanks" })
             CREATE (m:Movie { title:"Cloud Atlas",released:2012 })
             CREATE (p)-[r:ACTED_IN { roles: ['Zachry']}]->(m)
             RETURN p,r,m;
+-------------------------------------------------------------------------------------------------------------------------------+
| p                                         | r                               | m                                               |
+-------------------------------------------------------------------------------------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
+-------------------------------------------------------------------------------------------------------------------------------+

2 rows available after 79 ms, consumed after another 11 ms
Added 2 nodes, Created 2 relationships, Set 6 properties, Added 2 labels

neo4j@neo4j> MATCH (m:Movie)
             WHERE m.title = "Forrest Gump"
             RETURN m;
+--------------------------------------------------+
| m                                                |
+--------------------------------------------------+
| (:Movie {title: "Forrest Gump", released: 1994}) |
| (:Movie {title: "Forrest Gump", released: 1994}) |
+--------------------------------------------------+

2 rows available after 82 ms, consumed after another 5 ms



Ojo con como funciona esta clausula. En la siguiente consulta la misma persona no puede ser p1 y p2 en la misma fila del resultado.

MATCH (p1:Person)-[:ACTED_IN]->(m:Movie{title:"Cloud Atlas"})<-[:ACTED_IN]-(p2:Person)
RETURN p1, p2


neo4j@neo4j> MATCH (p1:Person)-[:ACTED_IN]->(m:Movie{title:"Cloud Atlas"})<-[:ACTED_IN]-(p2:Person)
             RETURN p1, p2
             ;
+---------+
| p1 | p2 |
+---------+
+---------+

0 rows available after 238 ms, consumed after another 9 ms




También se pueden filtrar por la etiqueta en la cláusula WHERE.

MATCH (n)
WHERE n:Person OR n:Movie
return n;

neo4j@neo4j> MATCH (n)
             WHERE n:Person OR n:Movie
             return n;
+--------------------------------------------------+
| n                                                |
+--------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956})        |
| (:Person {name: "Robert Zemeckis", born: 1951})  |
| (:Person {name: "Halle Berry"})                  |
| (:Person {name: "Keanu Reeves", born: 1964})     |
| (:Person {name: "Tom Hanks", born: 1956})        |
| (:Person {name: "Robert Zemeckis", born: 1951})  |
| (:Movie {title: "The Matrix", released: 1997})   |
| (:Movie {title: "Forrest Gump", released: 1994}) |
| (:Movie {title: "The Matrix", released: 1997})   |
| (:Movie {title: "Forrest Gump", released: 1994}) |
| (:Movie {title: "Cloud Atlas", released: 2012})  |
| (:Movie {title: "Cloud Atlas", released: 2012})  |
+--------------------------------------------------+

12 rows available after 123 ms, consumed after another 17 ms

psql -h localhost -p 5432 -U alumnogreibd -W -d bdge


copy (select id, titulo, presupuesto, fecha_emision, ingresos, duracionf) rrom peliculas 
order by presupuesto desc, id 
limit 20)
to '/home/alumnogreibd/public/peliculas.csv'
with csv header


eliminamos toodo

neo4j@neo4j> match(n) with n limit 10000 detach delete n;
0 rows available after 98 ms, consumed after another 0 ms
Deleted 12 nodes, Deleted 8 relationships
neo4j@neo4j> 

Para asegurarnos de que los datos se importan correctamente, y que después van a poder accederse de forma ágil, podemos definir algunas restricciones e índices.

CREATE CONSTRAINT idPelicula ON (p:Pelicula) ASSERT p.id IS UNIQUE;
CREATE CONSTRAINT idPersona ON (p:Persona) ASSERT p.id IS UNIQUE;
CREATE INDEX FOR (p:Pelicula) ON (p.titulo);
CREATE INDEX FOR (p:Persona) ON (p.nombre); 

neo4j@neo4j> CREATE CONSTRAINT idPelicula ON (p:Pelicula) ASSERT p.id IS UNIQUE;
There already exists an index (:Pelicula {id}). A constraint cannot be created until the index has been dropped.
neo4j@neo4j> CREATE CONSTRAINT idPersona ON (p:Persona) ASSERT p.id IS UNIQUE;
There already exists an index (:Persona {id}). A constraint cannot be created until the index has been dropped.
neo4j@neo4j> CREATE INDEX FOR (p:Pelicula) ON (p.titulo);
An equivalent index already exists, 'Index( id=2, name='index_7aab3471', type='GENERAL BTREE', schema=(:Pelicula {titulo}), indexProvider='native-btree-1.0' )'.
neo4j@neo4j> CREATE INDEX FOR (p:Persona) ON (p.nombre); 
An equivalent index already exists, 'Index( id=1, name='index_55d193f8', type='GENERAL BTREE', schema=(:Persona {nombre}), indexProvider='native-btree-1.0' )'.


Para poder importar los datos, debemos moverlos al directorio de importación /var/lib/neo4j/import. Generamos ahora un nodo para cada película que hemos exportado en el archivo "peliculas.csv".   



cp /home/alumnogreibd/public/peliculas.csv /var/lib/neo4j/import
sudo cp /home/alumnogreibd/public/peliculas.csv /var/lib/neo4j/import
sudo cp /home/alumnogreibd/public/reparto.csv /var/lib/neo4j/import
sudo cp /home/alumnogreibd/public/personal.csv /var/lib/neo4j/import


LOAD CSV WITH HEADERS FROM "file:///peliculas.csv" AS csvPelicula
CREATE (p:Pelicula {id: toInteger(csvPelicula.id),
                    titulo: csvPelicula.titulo,
		   presupuesto: csveplicula.presupuesto,
		   fechaEmision: date(csvPelicula.fecha_emision),
		   ingresos: toInteger(csvPelicula.ingresos),
		   duracion: toInteger(csvPelicula.duracion)});


LOAD CSV WITH HEADERS FROM "file:/peliculas.csv" AS csvPelicula

LOAD CSV WITH HEADERS FROM "file:/peliculas.csv" AS csvPelicula
CREATE (p:Pelicula {id: toInteger(csvPelicula.id),
                    titulo: csvPelicula.titulo,
		   presupuesto: csveplicula.presupuesto,
		   fechaEmision: date(csvPelicula.fecha_emision),
		   ingresos: toInteger(csvPelicula.ingresos),
		   duracion: toInteger(csvPelicula.duracion)});


/var/lib/neo4j/conf/neo4j.conf.

LOAD CSV WITH HEADERS FROM "file:///peliculas.csv" AS csvPelicula
             RETURN csvPelicula.titulo, csvPelicula.año
             LIMIT 10



LOAD CSV WITH HEADERS FROM "file:///peliculas.csv" AS csvPelicula
CREATE (p:Pelicula {id: toInteger(csvPelicula.id),
                    titulo: csvPelicula.titulo,
		   presupuesto: csvPelicula.presupuesto,
		   fechaEmision: date(csvPelicula.fecha_emision),
		   ingresos: toInteger(csvPelicula.ingresos),
		   duracion: toInteger(csvPelicula.duracion)});



hora vamos a importar los datos de los créditos de cada película, empezando por el personal que ha trabajado en la película. Antes de proceder a importar los datos, comprobamos que las condiciones que vamos a colocar funciona con una consulta.

LOAD CSV WITH HEADERS FROM "file:///personal.csv" AS csvPersonal
MATCH (pe:Pelicula {id:toInteger(csvPersonal.id_pelicula)})
return pe.titulo, csvPersonal.nombre, csvPersonal.trabajo;

USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///personal.csv" AS csvPersonal
MATCH (pe:Pelicula {id:toInteger(csvPersonal.id_pelicula)})
MERGE (p:Persona {id:toInteger(csvPersonal.id_persona)})
ON CREATE SET p.nombre = csvPersonal.nombre
CREATE (p)-[:TRABAJO_EN {trabajo:csvPersonal.trabajo}]->(pe);

Comprobamos ahora con  una consulta que los datos están importados. Recupera para cada película cuyo título empiece por "Pirat", su id, su título, el número de personas que han trabajado en la película, y un mapeao con la lista de nombres y trabajos de las personas involucradas.

match (persona)-[t:TRABAJO_EN]->(pelicula)
WHERE pelicula.titulo =~ "Pirat.+" 
return pelicula.id, pelicula.titulo,
       count(*) as numPersonas, 
       collect({nombre:persona.nombre,trabajo:t.trabajo}) as personal;

Para terminar, importamos los datos del reparto de la película, es decir, de las personas que actuaron en la película y de los personajes que interpretaron.

USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///reparto.csv" AS csvReparto
MATCH (pe:Pelicula {id:toInteger(csvReparto.id_pelicula)})
MERGE (p:Persona {id:toInteger(csvReparto.id_persona)})
ON CREATE SET p.nombre = csvReparto.nombre
CREATE (p)-[:ACTUO_EN {personaje:csvReparto.personaje}]->(pe);


Comprobamos que los datos están cargados con una consulta simple.

match (p:Persona)-[r:ACTUO_EN]->(pe)
             WHERE r.personaje =~ ".*Jack.*"
             return p.nombre, r.personaje, pe.titulo, pe.fechaEmision;
+-----------------------------------------------------------------------------------------------------------+
| p.nombre       | r.personaje            | pe.titulo                                     | pe.fechaEmision |
+-----------------------------------------------------------------------------------------------------------+
| "Johnny Depp"  | "Captain Jack Sparrow" | "Pirates of the Caribbean: On Stranger Tides" | 2011-05-14      |
| "Johnny Depp"  | "Captain Jack Sparrow" | "Pirates of the Caribbean: At World's End"    | 2007-05-19      |
| "Hugh Maguire" | "Jack O'Dwyer"         | "Batman v Superman: Dawn of Justice"          | 2016-03-23      |
+-----------------------------------------------------------------------------------------------------------+


Empezamos generando los datos de las películas.

with "jdbc:postgresql:xine?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select id, titulo, presupuesto, fecha_emision, ingresos, duracion
from peliculas order by presupuesto desc, id limit 1000") yield row
CREATE (p:Pelicula {id:row.id,
                    titulo:row.titulo,
		   presupuesto: row.presupuesto,
		   fechaEmision:row.fecha_emision,
		   ingresos:row.ingresos,
		   duracion:row.duracion});

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
             CALL apoc.load.jdbc(url, 
             "select id, titulo, presupuesto, fecha_emision, ingresos, duracion
             from peliculas order by presupuesto desc, id limit 1000") yield row
             CREATE (p:Pelicula {id:row.id,
                                 titulo:row.titulo,
                presupuesto: row.presupuesto,
                fechaEmision:row.fecha_emision,
                ingresos:row.ingresos,
                duracion:row.duracion});
Failed to invoke procedure `apoc.load.jdbc`: Caused by: org.postgresql.util.PSQLException: FATAL: no existe la base de datos «xine»


neo4j@neo4j> with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
                          CALL apoc.load.jdbc(url, 
                          "select id, titulo, presupuesto, fecha_emision, ingresos, duracion
                          from peliculas order by presupuesto desc, id limit 1000") yield row
                          CREATE (p:Pelicula {id:row.id,
                                              titulo:row.titulo,
                             presupuesto: row.presupuesto,
                             fechaEmision:row.fecha_emision,
                             ingresos:row.ingresos,
                             duracion:row.duracion});
0 rows available after 523 ms, consumed after another 0 ms
Added 1000 nodes, Set 6000 properties, Added 1000 labels


Ahora generamos los nodos de las personas. 

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select distinct id, first_value(nombre) over (partition by id order by nombre) as nombre
from (select per.id as id, per.nombre as nombre
	  from pelicula_personal as pp, personas as per
	  where pp.persona = per.id and pp.pelicula in (select id from peliculas order by presupuesto desc, id limit 1000)
	  union all
	  select per.id as id, per.nombre as nombre
	  from pelicula_reparto as pr, personas as per
	  where pr.persona = per.id and pr.pelicula in (select id from peliculas order by presupuesto desc, id limit 1000)) as t") yield row
CREATE (p:Persona {id:row.id,
                   nombre:row.nombre});

0 rows available after 3055 ms, consumed after another 0 ms
Added 45578 nodes, Set 91156 properties, Added 45578 labels

Para acelerar la inserción de las relaciones, añadimos primero índices sobre las Peliculas y Personas, para que su búsqueda en cada inserción se realice más rápido. Vamos a añadir también índices sobre el nombre de la persona y sobre el Título de la película para acelerar consultas sobre estos campos.

neo4j@neo4j> CREATE INDEX FOR (a:Persona) ON (a.id);
An equivalent index already exists, 'Index( id=4, name='index_48db0f70', type='GENERAL BTREE', schema=(:Persona {id}), indexProvider='native-btree-1.0' )'.
neo4j@neo4j> CREATE INDEX FOR (a:Pelicula) ON (a.id);
An equivalent index already exists, 'Index( id=5, name='index_17d89829', type='GENERAL BTREE', schema=(:Pelicula {id}), indexProvider='native-btree-1.0' )'.
neo4j@neo4j> CREATE INDEX FOR (a:Persona) ON (a.nombre);
An equivalent index already exists, 'Index( id=1, name='index_55d193f8', type='GENERAL BTREE', schema=(:Persona {nombre}), indexProvider='native-btree-1.0' )'.
neo4j@neo4j> CREATE INDEX FOR (a:Pelicula) ON (a.titulo);
An equivalent index already exists, 'Index( id=2, name='index_7aab3471', type='GENERAL BTREE', schema=(:Pelicula {titulo}), indexProvider='native-btree-1.0' )'.


 Ahora ya podemos proceder a insertar las relaciones que definen que persona ha actuado en que película.

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select per.id as persona, pr.personaje as personaje, pr.pelicula
from pelicula_reparto as pr, personas as per
where pr.persona = per.id and pr.pelicula in (select id from peliculas order by presupuesto desc, id limit 1000)") yield row
MATCH (pelicula:Pelicula {id:row.pelicula})
MATCH (persona:Persona {id:row.persona})
CREATE (persona)-[r:ACTUO_EN {personaje:row.personaje}]->(pelicula);

0 rows available after 3975 ms, consumed after another 0 ms
Created 39933 relationships, Set 39933 propertiess


Finalmente procedemos a insertar las relaciones que definen que persona ha trabajado en que película.

with "jdbc:postgresql:bdge?user=alumnogreibd&password=greibd2021" as url
CALL apoc.load.jdbc(url, 
"select per.id as persona, pp.trabajo as trabajo, pp.pelicula
from pelicula_personal as pp, personas as per
where pp.persona = per.id and pp.pelicula in (select id from peliculas order by presupuesto desc, id limit 1000)") yield row
MATCH (pelicula:Pelicula {id:row.pelicula})
MATCH (persona:Persona {id:row.persona})
CREATE (persona)-[r:TRABAJO_EN {trabajo:row.trabajo}]->(pelicula);

0 rows available after 3504 ms, consumed after another 0 ms
Created 66350 relationships, Set 66350 properties

Obtener el número de personas que han colaborado de forma directa con "Penélope Cruz", es decir, que han actuado o trabajado en la misma película.

neo4j@neo4j> match (penelope:Persona{nombre: "Penélope Cruz"})-->()<--(p)
             return count(distinct p.id);
+----------------------+
| count(distinct p.id) |
+----------------------+
| 340                  |
+----------------------+

1 row available after 113 ms, consumed after another 50 ms

Obtener el número de personas que han actuado con  alguna persona con la que haya actuado "Penélope Cruz" (relaciones de segundo nivel de tipo ACTUO_EN)

match (penelope:Persona{nombre: "Penélope Cruz"})-[:ACTUO_EN*..4]-(p:Persona)
return count(distinct p.id);

+----------------------+
| count(distinct p.id) |
+----------------------+
| 10095                |
+----------------------+

1 row available after 138 ms, consumed after another 359 ms


 Obtener el número de personas que ha colaborado con alguna persona con la que haya colaborado "Penélope Cruz" (relaciones de segundo nivel de cualquier tipo).

match (penelope:Persona{nombre: "Penélope Cruz"})-[*..4]-(p:Persona)
             return count(distinct p.id);
+----------------------+
| count(distinct p.id) |
+----------------------+
| 35398                |
+----------------------+

1 row available after 115 ms, consumed after another 1455 ms


Obtener el camino más corto entre "Kevin Bacon" y "Penélope Cruz" a través de relaciones tipo ACTUO_EN. Obtén el camino más corto usando cualquier tipo de relación también.

MATCH (k:Persona {nombre: 'Kevin Bacon'} ),
      (a:Persona {nombre: 'Penélope Cruz'}),
      p = shortestPath((k)-[:ACTUO_EN*]-(a))
RETURN length(p), p;

MATCH (k:Persona {nombre: 'Kevin Bacon'} ),
      (a:Persona {nombre: 'Penélope Cruz'}),
      p = shortestPath((k)-[*]-(a))
RETURN length(p), p;
