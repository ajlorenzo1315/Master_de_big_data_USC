
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

