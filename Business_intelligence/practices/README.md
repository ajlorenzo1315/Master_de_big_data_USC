Usamos una maquina virtual con la siguiente configuración
Máquina virtual con software de cliente y servidor.

Usuario: alumnogreibd

Contraseña: greibd2021

Software Instalado:

    Sistema Operativo lubuntu 20.04.2 LTS
    Navegador Firefox
    OpenJDK 11.0.11
    PostgreSQL
    MySQL
    Cliente SQL DBeaver Community
    Citus Data para PostgreSQL
    MongoDB
    Cliente Compass para MongoDB
    Neo4J
    HBase 2.3.5 Standalone
    Pentaho 9.1
        Pentaho Server
        Pentaho Data Integration
        Schema Workbench
        Report Designer
        Saiku Analytics
    Apache NetBeans

Aumentar Tamaño del Disco:

    Aumentar el tamaño del disco en Virtual Box.
    Comprobar el tamaño del disco con el comando "df -h"
    Aumentar el tamaño de la partición: "sudo cfdisk". Opción de menú "Resize". Antes de salir guardar los cambio con "Write" (elegir "yes" para confirmar). 
    sudo resize2fs -p /dev/sda1
    Volvemos a comprobar el nuevo tamaño con "df -h"



Se trasmiten las clases por teams

La mayoria de los modulos se tienen que intalar por separados esto es una aplicación pero esta segunamente no es la mejor 


en la maquina virtual 
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
    
## 4 




----------


# Ponemos un todo al final
idea tener todas las entregas en ese moemnto

el trabajo es hacer un replica de este informe 

uno de trabajos de seguimientos tiene que ver con este

formar un grupo una recomendaciónes burcar dataset somos una productora contruir un conjunto de datos dtl xml 

primera entregr tiene que ver esas peliculas , los individuales lo que vamos viendo en clase  
lo que hicimos esto hay que hacer una creación de tablas e insertar  los datos trabajaremos y lo haremos aqui y luego tenemos el proyecto de asignatura  por las tablas  y unos datos cuando seas 
ultimi agruparos en grupo y empezar a hacer y la entre de individuales tiene que se muy script muy exustivo la idea es ver como se hace mas  ala otra persona la idea hacerlo mas o menos bien , los trabajos pequeños el caso de uso nuevo y el caso de usos dimensionales nuevo s