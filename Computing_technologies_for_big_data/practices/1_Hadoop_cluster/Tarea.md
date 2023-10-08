
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

4. Como usuario hdadmin, añade al fichero hdfs-site.xml las siguentes propiedades

    dfs.namenode.backup.address: Dirección y puerto del nodo de backup. Dale el valor backupnode:50100
    dfs.namenode.backup.http-address:  Dirección y puerto del servicio web del nodo de backup. Dale el valor backupnode:50105

5. Inicia el servidor de backup ejecutando:

    
  $ hdfs namenode -backup

6. Analiza el directorio de backup para ver lo que se ha creado. Compáralo con el directorio con los metadatos del NameNode
7. Mira en los mensajes del servicio de backup información que indique que se ha realizado un checkpoint

Nota: Una vez obtenidos los datos para la memoria, puedes parar el servicio de backup. Si quieres poder reiniciarlo de forma facil, sal del Docker, guárdalo como una imagen e inícialo haciendo:

docker container run -d --name backupnode --network=hadoop-cluster --hostname backupnode --cpus=1 --memory=3072m --expose 50100 -p 50105:50105 backupnode-image \
su hdadmin -c "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 /opt/bd/hadoop/bin/hdfs namenode -backup"

Y para comprobar que se está ejecutando correctamente el servicio de backup, haz:


    docker container logs backupnode

