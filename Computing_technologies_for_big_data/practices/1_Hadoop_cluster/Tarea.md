
### Tareas a realizar
####  Tarea 1: Añadir al cluster un servidor de Backup y un TimeLineServer

1. Servidor de Backup
El servidor de backup realiza una tarea doble:

    Mantiene una copia de seguridad permanentemente actualizada de los metadatos del NameNode
    Realiza tareas de Checkpoint sobre estos metadatos.

Más información sobre este servicio en [mas informcion Backup](https://hadoop.apache.org/docs/stable3/hadoop-project-dist/hadoop-hdfs/HdfsUserGuide.html#Backup_Node)

Importante: Antes de iniciar el servicio de backup inicia el cluster, ve al NameNode y obten una captura de pantalla el la que se vean los ficheros del directorio de metadatos del NameNode (dentro de current).

Para añadir el servidor de backup, tenéis que seguir los siguientes pasos (con el cluster funcionando):

1. Inicia un nuevo Docker a partir de la imagen hadoop-base de la siguiente forma:
 

      docker container run -ti --name backupnode --network=hadoop-cluster --hostname backupnode --cpus=1 --memory=3072m --expose 50100 -p 50105:50105 tfpena/hadoop-base /bin/bash

2. Crea un directorio donde se guardarán los backups. Haz que el propietario de ese directorio sea hdadmin y crea dentro del mismo la carpeta dfs/name

3. Como usuario hdadmin, añade al fichero core-site.xml las siguentes propiedades

    fs.defaultFS: Nombre del filesystem por defecto. Dale el valor hdfs://namenode:9000/.
    hadoop.tmp.dir: Indica el directorio donde se guardarán las copias de seguridad. Dale el valor del directorio que has creado (sin incluir dfs/name).

    <configuration>

    <!-- Nombre del filesystem por defecto -->
    <!-- Como queremos usar HDFS tenemos que indicarlo con hdfs:// y el servidor y puerto en el que corre el NameNode -->
    <property>
        
        <name>fs.defaultFS</name>
        <value>hdfs://namenode:9000/</value>
        <final>true</final>
    </property>

    <!-- Directorio para almacenamiento temporal (debe tener suficiente espacio) -->
    <property>
        <!-- Directorio para almacenamiento temporal (debe tener suficiente espacio) -->
        <name>hadoop.tmp.dir</name>
        <value>/var/data/hadoop/hdfs/backup</value>
        <final>true</final>
    </property>

    </configuration>

4. Como usuario hdadmin, añade al fichero hdfs-site.xml las siguentes propiedades

    dfs.namenode.backup.address: Dirección y puerto del nodo de backup. Dale el valor backupnode:50100
    dfs.namenode.backup.http-address:  Dirección y puerto del servicio web del nodo de backup. Dale el valor backupnode:50105

    <configuration>

    <!--  Propiedad para configurar la dirección y puerto del nodo de backup -->
    <property>
    <name>dfs.namenode.backup.address</name>
    <value>backupnode:50100</value>
    <final>true</final>
    </property>

    <!-- Dirección y puerto del interfaz web del NameNode -->
    <!-- Especifica la dirección y el puerto donde se puede 
    acceder a la interfaz web del NameNode. -->
    <property>
        <name>dfs.namenode.backup.http-address</name>
        <value>backupnode:50105</value>
        <final>true</final>
    </property>

    </configuration>



5. Inicia el servidor de backup ejecutando:

    
  $ hdfs namenode -backup

6. Analiza el directorio de backup para ver lo que se ha creado. Compáralo con el directorio con los metadatos del NameNode
7. Mira en los mensajes del servicio de backup información que indique que se ha realizado un checkpoint

Nota: Una vez obtenidos los datos para la memoria, puedes parar el servicio de backup. Si quieres poder reiniciarlo de forma facil, sal del Docker, guárdalo como una imagen e inícialo haciendo:

docker container run -d --name backupnode --network=hadoop-cluster --hostname backupnode --cpus=1 --memory=3072m --expose 50100 -p 50105:50105 backupnode-image \
su hdadmin -c "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 /opt/bd/hadoop/bin/hdfs namenode -backup"

Y para comprobar que se está ejecutando correctamente el servicio de backup, haz:


    docker container logs backupnode

    http://localhost:50105




2. TimeLineServer

El servidor de línea temporal de YARN mantiene un histórico y proporciona métricas de las aplicaciones ejecutadas mediante YARN (es similar a la funcionalidad del Job History Server porporcionado por MapReduce).
Proporciona tanto información genérica acerca de aplicaciones completadas (contenedores en los que se ejecutó la aplicación, intentos de ejecución, el nombre del usuario, de la cola, etc)  como información específica del framework concreto de la aplicación (por ejemplo, el framework MapReduce puede publicar información sobre el número de maps y reduces, u otros contadores). La información es accesible a través de un interfaz web o vía una API REST.
El Timeline Server se ejecuta como un demonio standalone que puede correr en un nodo del cluster o colocarse con el ResourceManager. Más información sobre el servicio en https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/TimelineServer.html.

Para añadir el TimeLineServer, tenéis que seguir los siguientes pasos (con el cluster funcionando):

# todo se ejecuta en su - hdadmin

1. Ve al NameNode/ResourceManager y detén el servicio ResourceManager

    su hdadmin -c "$HADOOP_HOME/bin/yarn resourcemanager -stop"


2. En este sistema, edita el fichero yarn-site.xml y añade las siguentes propiedades

    yarn.timeline-service.hostname: Nombre del equipo que ejecutará el demonio de línea de tiempo por defecto. Dale el valor timelineserver (llamaremos de esta forma al Docker que ejecutará el servicio).
    yarn.timeline-service.enabled: Indica que si el servicio de linea de tiempo está activo o no. Dale el valor true.
    yarn.system-metrics-publisher.enabled: Le indica al ResourceManager que publique las metricas de YARN en el timeline server. Dale el valor true.

    Añadir

    <!-- Configuración del hostname del servicio de línea de tiempo de YARN -->
    <property>
        <name>yarn.timeline-service.hostname</name> <!-- Nombre del parámetro -->
        <value>timelineserver</value> <!-- Valor del parámetro (en este caso, el nombre del servidor de línea de tiempo) -->
    </property>

    <!-- Habilitar el servicio de línea de tiempo de YARN -->
    <property>
        <name>yarn.timeline-service.enabled</name> <!-- Nombre del parámetro -->
        <value>true</value> <!-- Valor del parámetro (habilitar el servicio) -->
    </property>

    <!-- Habilitar el publicador de métricas del sistema de YARN -->
    <property>
        <name>yarn.system-metrics-publisher.enabled</name> <!-- Nombre del parámetro -->
        <value>true</value> <!-- Valor del parámetro (habilitar el publicador de métricas del sistema) -->
    </property>


3. Reinicia el servicio ResourceManager

    yarn --daemon start resourcemanager

3. Inicia un nuevo Docker a partir de la imagen hadoop-base de la siguiente forma:
 

    docker container run -ti --name timelineserver --network=hadoop-cluster --hostname timelineserver --cpus=1 --memory=3072m --expose 10200 -p 8188:8188 tfpena/hadoop-base /bin/bash


4. En este nuevo Docker, levanta el servicio timelineserver ejecutando: 

    yarn --daemon start timelineserver
    yarn jar $MAPRED_EXAMPLES/hadoop-mapreduce-examples-*.jar pi 16 1000

5. Vuelve al NameNode/ResourceManager y ejecuta una aplicación con yarn (la de el cálculo de pi o el wordcount).
6. Comprueba en el servidor web del TimeLineServer (http://localhost:8188) que se recoge la información de la ejecución


### Tarea 2: Retirar un DataNode/NodeManager

2.1. Creación de ficheros de nodos incluidos y excluidos

Aunque no es estrictamente necesario para añadir o retirar nodos del cluster, es conveniente tener una lista en la que podamos indicar los nodos que se pueden añadir o retirar del cluster. Para ello, haced lo siguiente en el NameNode (como usuario hdadmin):

    Para los demonios del NameNode y del ResourceManager.
        $ yarn --daemon stop resourcemanager
        $ hdfs --daemon stop namenode

    Para comprobar que se ha detenido 
        http://localhost:9870/
        http://localhost:8088/
    Crea cuatro ficheros: ${HADOOP_HOME}/etc/hadoop/dfs.include, ${HADOOP_HOME}/etc/hadoop/dfs.exclude, ${HADOOP_HOME}/etc/hadoop/yarn.include y ${HADOOP_HOME}/etc/hadoop/yarn.exclude (inicialmente vacíos).

        /docker/change_config.sh /docker/hadoop_ResourceManager/ $HADOOP_HOME/etc/hadoop/


    En los fichero dfs.include y yarn.include, poned los nombres de todos los DataNodes/NodeManagers que querramos que estén en el cluster (datanode1, datanode2, datanode3 y datanode4, un nombre por línea) . Deja los ficheros dfs.exclude y yarn.exclude vacíos.
    En el fichero de configuración hdfs-site.xml, añade dos propiedades:
        dfs.hosts: nombre de un fichero con lista de hosts que pueden actuar como DataNodes; si el fichero está vacío, cualquier nodo están permitido. Dale como valor el path completo al  fichero dfs.include, es decir /opt/bd/hadoop/etc/hadoop/dfs.include
        dfs.hosts.exclude:  nombre de un fichero con lista de hosts que no pueden actuar como DataNodes; si el fichero está vacío, ninguno está excluido. Dale como valor, el path completo al fichero dfs.exclude, es decir /opt/bd/hadoop/etc/hadoop/dfs.exclude
    En el fichero yarn-site.xml, añade dos propiedades:
        yarn.resourcemanager.nodes.include-path: nombre de un fichero con lista de hosts que pueden actuar como NodeManagers; si el fichero está vacío, cualquier nodo están permitido. Dale como valor, el path completo al fichero yarn.include, es decir /opt/bd/hadoop/etc/hadoop/yarn.include
        yarn.resourcemanager.nodes.exclude-path: nombre de un fichero con lista de hosts que no pueden actuar como NodeManagers; si el fichero está vacío, ninguno está excluido. Dale como valor, el path completo al fichero yarn.exclude, es decir /opt/bd/hadoop/etc/hadoop/yarn.exclude
    Reinicia los demonios del NameNode y del ResourceManager.
    Comprueba en los ficheros de log que se han incluido al HDFS y al YARN los nodos datanode{1,2,3,4}.


2.2. Retirar un datanode/nodemanager

En principio, el apagado de un DataNode/NodeManager puede hacerse directamente y no afecta al cluster. Sin embargo, si queremos hacer un apagado programado de un DataNode/nodeManager es preferible advertir al NameNode previamente. 

Sigue los siguiente pasos para eliminar, por ejemplo, el datanode4.

    Pon el nombre del nodo o nodos que queremos retirar en los fichero dfs.exclude y yarn.exclude y ejecutar
    /docker/change_config.sh /docker/include_node $HADOOP_HOME/etc/hadoop

    $ hdfs dfsadmin -refreshNodes
    $ yarn rmadmin -refreshNodes

    Comprueba que al cabo de un rato, usando el interfaz web y mediante los comandos los comandos hdfs dfsadmin -report y yarn node -list, que el/los nodo(s) excluido(s) aparece(n) que está(n) Decomissioned en HDFS y YARN

Ya podríamos parar los demonios en el nodo decomisionado y parar el contenedor asociado. Si no queremos volver a incluirlo en el cluster:

    Eliminar el/los nodo(s) de los ficheros include y exclude y ejecutar otra vez


    $ hdfs dfsadmin -refreshNodes
    $ yarn rmadmin -refreshNodes


Tarea 3: Añadir un nuevo DataNode/NodeManager

Vamos ahora a añadir dos nuevos DataNode/NodeManager al cluster:

    En el NameNode, añade los nombres de dos nuevos nodos (datanode5,datanode6) en los ficheros dfs.include y yarn.include.
    Actualiza el NameNode y el ResourceManager con el nuevo NodeManager ejecutando:


    $ hdfs dfsadmin -refreshNodes
    $ yarn rmadmin -refreshNodes

    Iniciar los dos nuevos contenedores para hacer de DataNodes/NodeManagers:


      docker container run -d --name datanode5 --network=hadoop-cluster --hostname datanode5 --cpus=1 --memory=3072m \
      --expose 8000-10000 --expose 50000-50200 datanode-image /inicio.sh
      docker container run -d --name datanode6 --network=hadoop-cluster --hostname datanode6 --cpus=1 --memory=3072m \
      --expose 8000-10000 --expose 50000-50200 datanode-image /inicio.sh

    Comprueba usando (en el NameNode como usuario hdadmin) los comandos hdfs dfsadmin -report y yarn node -list que los nuevos contenedores se han añadido al HDFS y al YARN. Puedes comprobarlo también el interfaz web del NameNode y de YARN.
    Anota cuánto espacio, en bytes y en bloques, tienen ocupados los dos nuevos DataNodes.
    num_bloques en mi caso 39*64 bytes declarados en 


    hdfs-site.xml: configuración del demonio NameNode (HDFS)

    <configuration>

     <property>
       <!-- Factor de replicacion de los bloques -->
        <name>dfs.replication</name>
        <value>3</value>
        <final>true</final>
      </property>

      <property>
       <!-- Tamano del bloque (por defecto 128m) -->
        <name>dfs.blocksize</name>
        <value>64m</value>
        <final>true</final>
      </property>

      <property>
        <!-- Lista (separada por comas) de directorios donde el namenode guarda los metadatos. -->
        <name>dfs.namenode.name.dir</name>
        <value>file:///var/data/hdfs/namenode</value>
        <final>true</final>
      </property>

      <property>
        <!-- Dirección y puerto del interfaz web del namenode -->
        <name>dfs.namenode.http-address</name>
        <value>namenode:9870</value>
        <final>true</final>
      </property>

     </configuration>



Los nuevos nodo inicialmente están vacíos (no tienen datos de HDFS), con lo que el cluster estará desbalanceado. Se puede forzar el balanceo ejecutando, en el NameNode:

     $ hdfs balancer -threshold 1

     NO rebalancea por tener muy pocos datos usandolo

Comprueba ahora cuánto espacio, en bytes y en bloques, tienen ocupados los dos nuevos DataNodes.

Para más información, ver https://hadoop.apache.org/docs/stable3/hadoop-project-dist/hadoop-hdfs/HDFSCommands.html#balancer


Tarea 4: Rack awareness

Para obtener el máximo rendimiento, es importante configurar Hadoop para para que conozca la topología de nuestra red. Por defecto, Hadoop considera que todos los DataNodes/NodeManagers son iguales y están situados en un único rack, que se identifica como /default-rack.

Para clusters multirack, debemos indicar a Hadoop en que rack está cada nodo, para mejorar la eficiencia y la fiabilidad.

En la imagen, se muestra una arquitectura típica en 2 niveles de un cluster Hadoop. Esta topología puede describirse en forma de árbol, como /switch1/rack1 y /switch1/rack2, o, simplificando /rack1 y /rack2. Para indicarle esta topología a Hadoop, es necesario utilizar un script que mapee los nombres de los nodos al rack en el que se encuentran.

En nuestro caso, vamos a suponer que tenemos 3 racks (rack1, rack2 y rack3) y que tenemos dos nodos en cada rack. Haced lo siguiente en el NameNode (como usuario hdadmin):

    Ejecuta el comando hdfs dfsadmin -printTopology para ver como es la topología actual. Apunta las IPs (sin los puertos) de los datanodos.
    Apaga el demonio NameNode

    hdfs --daemon stop namenode

    Crea un fichero $HADOOP_HOME/etc/hadoop/topology.data que tenga en cada linea la IP de uno de los DataNodes y el rack donde está, como en este ejemplo (cambiando las IPs por las tuyas)

    sacar ips 
    primera parte sin los dos puntos 
    Para mirar las ip $ hdfs dfsadmin -report

    IPdatanode1     /rack1
    IPdatanode2     /rack1
    IPdatanode3     /rack2
    IPdatanode5     /rack3
    IPdatanode6     /rack3

    172.21.0.3     /rack1
    172.21.0.4     /rack1
    172.21.0.5     /rack2
    172.21.0.9     /rack3
    172.21.0.10     /rack3

    Crea un script de bash $HADOOP_HOME/etc/hadoop/topology.script como el siguiente (fuente: https://cwiki.apache.org/confluence/display/HADOOP2/Topology+rack+awareness+scripts). Dar permisos de ejecución (chmod +x topology.script).


    #!/bin/bash

    HADOOP_CONF=$HADOOP_HOME/etc/hadoop 
    while [ $# -gt 0 ] ; do
      nodeArg=$1
      exec< ${HADOOP_CONF}/topology.data 
      result="" 
      while read line ; do
        ar=( $line ) 
        if [ "${ar[0]}" = "$nodeArg" ] ; then
          result="${ar[1]}"
        fi
      done 
      shift 
      if [ -z "$result" ] ; then
        echo -n "/default-rack "
      else
        echo -n "$result "
      fi
    done

    Define en el fichero core-site.xml la propiedad net.topology.script.file.name y darle como valor el path completo al script

    add 

    <property>
    <!-- Directorio para almacenamiento informacion sobre la topologia-->
    <name>net.topology.script.file.name</name>
    <value>$HADOOP_HOME/etc/hadoop/topology.script</value>
    <final>true</final>
    </property>

    /docker/change_config.sh /docker/hadoop_ResourceManager $HADOOP_HOME/etc/hadoop


    Inicia los demonios y comprueba que se han identificado los racks ejecutando hdfs dfsadmin -printTopology

    hdfs --daemon start namenode

    xa esta
    