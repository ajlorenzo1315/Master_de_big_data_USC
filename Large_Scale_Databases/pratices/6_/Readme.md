cypher-shell
neo4jusername: neo4j
password: **********
Connected to Neo4j using Bolt protocol version 4.2 at neo4j://localhost:7687 as user neo4j.
Type :help for a list of available commands or :exit to exit the shell.
Note that Cypher queries must end with a semicolon.
neo4j@neo4j> CREATE (:Movie { title:"The Matrix",released:1997 });
0 rows available after 313 ms, consumed after another 0 ms
Added 1 nodes, Set 2 properties, Added 1 labels
neo4j@neo4j> CREATE (p:Person { name:"Keanu Reeves", born:1964 })
             CREATE (p:Person {name:"Halle Berry"})
             RETURN p;
Variable `p` already declared (line 3, column 9 (offset: 62))
"CREATE (p:Person {name:"Halle Berry"})"                                                                                                                                                                                                                            
         ^                                                                                                                                                                                                                                                          
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

1 row available after 149 ms, consumed after another 23 ms
Added 3 nodes, Created 2 relationships, Set 7 properties, Added 3 labels
neo4j@neo4j> 
neo4j@neo4j> 
neo4j@neo4j> match (p:Person { name:"Keanu Reeves"})
             match (m:Movie { title:"The Matrix"})
             create (p)-[r:ACTED_IN { roles: ['Neo']}]->(m);
0 rows available after 496 ms, consumed after another 0 ms
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person { name:"Tom Hanks" })
             CREATE (m:Movie { title:"Cloud Atlas",released:2012 })
             CREATE (p)-[r:ACTED_IN { roles: ['Dr. Henry Goose', 'Hotel Manager', 'Isaac Sachs', 
                                              'Dermot Hoggins', 'Cavendish', 'Look-a-Like Actor','Zachry']}]->(m)
             RETURN p,r,m;
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| p                                         | r                                                                                                                                      | m                                               |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

1 row available after 132 ms, consumed after another 8 ms
Added 1 nodes, Created 1 relationships, Set 3 properties, Added 1 labels
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person {name:"Halle Berry"})
             MATCH (m:Movie { title:"Cloud Atlas"})
             CREATE (p)-[r:ACTED_IN {roles:['Native Woman' , 'Jocasta Ayrs', 'Luisa Rey', 
                                            'Indian Party Guest', 'Ovid', 'Meronym']}]->(m)
             
----------------------


cypher-shell
neo4jusername: neo4j
password: **********
Connected to Neo4j using Bolt protocol version 4.2 at neo4j://localhost:7687 as user neo4j.
Type :help for a list of available commands or :exit to exit the shell.
Note that Cypher queries must end with a semicolon.
neo4j@neo4j> CREATE (:Movie { title:"The Matrix",released:1997 });
0 rows available after 313 ms, consumed after another 0 ms
Added 1 nodes, Set 2 properties, Added 1 labels
neo4j@neo4j> CREATE (p:Person { name:"Keanu Reeves", born:1964 })
             CREATE (p:Person {name:"Halle Berry"})
             RETURN p;
Variable `p` already declared (line 3, column 9 (offset: 62))
"CREATE (p:Person {name:"Halle Berry"})"                                                                                                                                                                                                                                      
         ^                                                                                                                                                                                                                                                                    
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

1 row available after 149 ms, consumed after another 23 ms
Added 3 nodes, Created 2 relationships, Set 7 properties, Added 3 labels
neo4j@neo4j> 
neo4j@neo4j> 
neo4j@neo4j> match (p:Person { name:"Keanu Reeves"})
             match (m:Movie { title:"The Matrix"})
             create (p)-[r:ACTED_IN { roles: ['Neo']}]->(m);
0 rows available after 496 ms, consumed after another 0 ms
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person { name:"Tom Hanks" })
             CREATE (m:Movie { title:"Cloud Atlas",released:2012 })
             CREATE (p)-[r:ACTED_IN { roles: ['Dr. Henry Goose', 'Hotel Manager', 'Isaac Sachs', 
                                              'Dermot Hoggins', 'Cavendish', 'Look-a-Like Actor','Zachry']}]->(m)
             RETURN p,r,m;
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| p                                         | r                                                                                                                                      | m                                               |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

1 row available after 132 ms, consumed after another 8 ms
Added 1 nodes, Created 1 relationships, Set 3 properties, Added 1 labels
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person {name:"Halle Berry"})
             MATCH (m:Movie { title:"Cloud Atlas"})
             CREATE (p)-[r:ACTED_IN {roles:['Native Woman' , 'Jocasta Ayrs', 'Luisa Rey', 
                                            'Indian Party Guest', 'Ovid', 'Meronym']}]->(m)
             
             
             
Interrupted (Note that Cypher queries must end with a semicolon. Type :exit to exit the shell.)                                                                                                                                                                               
neo4j@neo4j> match (:Person {name:"Tom Hanks"}) -[r:ACTED_IN]-> (m:Movie)
             return m.title, r.roles;
+------------------------------------------------------------------------------------------------------------------------------------+
| m.title        | r.roles                                                                                                           |
+------------------------------------------------------------------------------------------------------------------------------------+
| "Cloud Atlas"  | ["Dr. Henry Goose", "Hotel Manager", "Isaac Sachs", "Dermot Hoggins", "Cavendish", "Look-a-Like Actor", "Zachry"] |
| "Forrest Gump" | ["Forrest"]                                                                                                       |
+------------------------------------------------------------------------------------------------------------------------------------+

2 rows available after 158 ms, consumed after another 10 ms
neo4j@neo4j> MERGE (m:Movie { title:"Cloud Atlas" })
             ON CREATE SET m.released = 2012
             RETURN m;
+-------------------------------------------------+
| m                                               |
+-------------------------------------------------+
| (:Movie {title: "Cloud Atlas", released: 2012}) |
+-------------------------------------------------+

1 row available after 96 ms, consumed after another 4 ms
neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             SET m.released = 2013
             RETURN m;
+-------------------------------------------------+
| m                                               |
+-------------------------------------------------+
| (:Movie {title: "Cloud Atlas", released: 2013}) |
+-------------------------------------------------+

1 row available after 56 ms, consumed after another 7 ms
Set 1 properties
neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             REMOVE m.released
             RETURN m;
+---------------------------------+
| m                               |
+---------------------------------+
| (:Movie {title: "Cloud Atlas"}) |
+---------------------------------+

1 row available after 64 ms, consumed after another 3 ms
Set 1 properties
neo4j@neo4j> 
neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             DELETE m;
Cannot delete node<4>, because it still has relationships. To delete this node, you must first delete its relationships.
neo4j@neo4j> 
neo4j@neo4j> MATCH (m:Movie { title:"Cloud Atlas" })
             DETACH DELETE m;
0 rows available after 45 ms, consumed after another 0 ms
Deleted 1 nodes, Deleted 1 relationships
neo4j@neo4j> 
neo4j@neo4j> MATCH (p:Person { name:"Tom Hanks" })
             CREATE (m:Movie { title:"Cloud Atlas",released:2012 })
             CREATE (p)-[r:ACTED_IN { roles: ['Zachry']}]->(m)
             RETURN p,r,m;
+-------------------------------------------------------------------------------------------------------------------------------+
| p                                         | r                               | m                                               |
+-------------------------------------------------------------------------------------------------------------------------------+
| (:Person {name: "Tom Hanks", born: 1956}) | [:ACTED_IN {roles: ["Zachry"]}] | (:Movie {title: "Cloud Atlas", released: 2012}) |
+-------------------------------------------------------------------------------------------------------------------------------+

1 row available after 42 ms, consumed after another 4 ms
Added 1 nodes, Created 1 relationships, Set 3 properties, Added 1 labels
neo4j@neo4j> 
neo4j@neo4j> 
neo4j@neo4j> MATCH (m:Movie)
             WHERE m.title = "Forrest Gump"
             RETURN m;
+--------------------------------------------------+
| m                                                |
+--------------------------------------------------+
| (:Movie {title: "Forrest Gump", released: 1994}) |
+--------------------------------------------------+

1 row available after 44 ms, consumed after another 1 ms
