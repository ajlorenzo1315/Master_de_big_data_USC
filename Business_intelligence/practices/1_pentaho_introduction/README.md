#### [Video tutorial]()
En la maquina virtual 
## 1 lanzamos el servidor pentaho

    ./pentaho/pentaho-server/start-pentaho.sh                                                                                                                                                                                                    
    ./pentaho/pentaho-server/start-pentaho.sh: 59: cd: can't cd to ./pentaho/pentaho-server                                                                                                                                                                             
    DEBUG: Using PENTAHO_JAVA_HOME                                                                                                                                                                                                                                      
    DEBUG: _PENTAHO_JAVA_HOME=/home/alumnogreibd/pentaho/jdk1.8.0_202                                                                                                                                                                                                   
    DEBUG: _PENTAHO_JAVA=/home/alumnogreibd/pentaho/jdk1.8.0_202/bin/java                                                                                                                                                                                               
    Using CATALINA_BASE:   /home/alumnogreibd/pentaho/pentaho-server/tomcat                                                                                                                                                                                             
    Using CATALINA_HOME:   /home/alumnogreibd/pentaho/pentaho-server/tomcat                                                                                                                                                                                             
    Using CATALINA_TMPDIR: /home/alumnogreibd/pentaho/pentaho-server/tomcat/temp                                                                                                                                                                                        
    Using JRE_HOME:        /usr                                                                                                                                                                                                                                         
    Using CLASSPATH:       /home/alumnogreibd/pentaho/pentaho-server/tomcat/bin/bootstrap.jar:/home/alumnogreibd/pentaho/pentaho-server/tomcat/bin/tomcat-juli.jar                                                                                                      
    Tomcat started.                                                                                                                                                  

## 2
    abrir dbeaver-cd
    crear una tabla vamos a tener viento maximo viento medio tiempo por mes año y vais

    dimension geografica pais/region temporal  ano/mes
    CREATE TABLE tormentas (
	ano int,
	mes int,
	pais varchar,
	region varchar,
	viento_max real,
	viento_medio real,
	tormentas int,
	primary key (ano, mes, pais, region)
    );

    luego cargamos los datos 
    copy tormentas from '/home/alumnogreibd/public/tormentas.csv' with csv;
    para visualizar los datos

    select * from tormentas
## 3 abrimos en el buscador 
    http://localhost:8080/pentaho/Login

    Usuario: alumnogreibd

    Contraseña: greibd2021
    
## 4  cargamos los datso en pentaho
    
#### generamos intormetas link con intormentas

<kbd>
  <a href="../images/praticese_1_1.png" target="_blank"><img src="../images/praticese_1_1.png" width="1000" height="600"></a>
</kbd>
    

#### generamos datos tormentas1 que viene de la tabala de de datos de tormentas.csv


<kbd>
  <a href="../images/praticese_1_2.png" target="_blank"><img src="../images/praticese_1_1.png" width="1000" height="600"></a>
</kbd>

Luego le damos a visualizar o a finish (si le damos a finish deberia dar un error)


# Ejercicio

Creamos una base de datos llamada IN

luego ejemcutamos 

  psql -U alumnogreibd -d bi -f /home/alumnogreibd/BDGE/datos/PeliculasSchema.sql

luego las copiamos las tablas a nuestra base de datos

psql -U alumnogreibd -d bi -c "\copy colecciones from /home/alumnogreibd/BDGE/datos/colecciones.csv csv"
psql -U alumnogreibd -d bi -c "\copy generos from /home/alumnogreibd/BDGE/datos/generos.csv csv"
psql -U alumnogreibd -d bi -c "\copy idiomas from /home/alumnogreibd/BDGE/datos/idiomas.csv csv"
psql -U alumnogreibd -d bi -c "\copy paises from /home/alumnogreibd/BDGE/datos/paises.csv csv"
psql -U alumnogreibd -d bi -c "\copy personas from /home/alumnogreibd/BDGE/datos/personas.csv csv"
psql -U alumnogreibd -d bi -c "\copy productoras from /home/alumnogreibd/BDGE/datos/productoras.csv csv"
psql -U alumnogreibd -d bi -c "\copy peliculas from /home/alumnogreibd/BDGE/datos/peliculas.csv csv"
psql -U alumnogreibd -d bi -c "\copy pelicula_genero from /home/alumnogreibd/BDGE/datos/pelicula_genero.csv csv"
psql -U alumnogreibd -d bi -c "\copy pelicula_idioma_hablado from /home/alumnogreibd/BDGE/datos/pelicula_idioma_hablado.csv csv"
psql -U alumnogreibd -d bi -c "\copy pelicula_pais from /home/alumnogreibd/BDGE/datos/pelicula_pais.csv csv"
psql -U alumnogreibd -d bi -c "\copy pelicula_personal from /home/alumnogreibd/BDGE/datos/pelicula_personal.csv csv"
psql -U alumnogreibd -d bi -c "\copy pelicula_productora from /home/alumnogreibd/BDGE/datos/pelicula_productora.csv csv"
psql -U alumnogreibd -d bi -c "\copy pelicula_reparto from /home/alumnogreibd/BDGE/datos/pelicula_reparto.csv csv"
