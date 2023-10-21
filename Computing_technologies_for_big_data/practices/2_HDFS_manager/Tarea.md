### Paso 1: Crear un archivo grande en el NameNode

```bash
#Como usuario luser, crea un archivo grande usando dd
dd if=/dev/urandom of=fichero_grande bs=1M count=350
```
Paso 2: Mover el archivo al HDFS

```bash
# Mueve el archivo al HDFS usando hdfs dfs -moveFromLocal
hdfs dfs -moveFromLocal fichero_grande /user/luser/
```

Paso 3: Acceder a la interfaz web del [NameNode](http://localhost:9870/explorer.html#/user/luser)

Paso 4: Buscar el fichero y obtener información sobre la división de bloques y las réplicas
En la interfaz web del NameNode, puedes buscar el archivo fichero_grande y obtener información sobre la división de bloques y las réplicas siguiendo estos pasos:

    Busca el archivo fichero_grande en la lista de archivos.
    Una vez que lo encuentres, selecciona el archivo y accede a su información.

Deberías poder ver cuántos bloques se han dividido y en qué DataNodes se encuentran sus réplicas.

Paso 5: Obtener la misma información usando hdfs fsck
Para obtener la misma información utilizando el comando hdfs fsck, puedes ejecutar el siguiente comando:

```bash
hdfs fsck /user/luser/fichero_grande -files -blocks -locations
```
Este comando te proporcionará información sobre la división de bloques y las ubicaciones de las réplicas del archivo fichero_grande.

Espero que esta guía te ayude a realizar esta tarea en tu clúster Hadoop. Asegúrate de tener los permisos adecuados y las configuraciones correctas en tu entorno para ejecutar estos comandos.

Accede al interfaz web del NameNode y busca el fichero. Responde a las siguientes preguntas:

- ¿En cuántos bloques se ha dividido el fichero?

    El  fichero de datos se dividió e 6 bloques 

- Para cada uno de estos bloques ¿en que DataNodes se encuentran sus réplicas?

/user/luser/fichero_grande 367001600 bytes, replicated: replication=3, 6 block(s):  OK
0. BP-1236072688-172.19.0.2-1697554321959:blk_1073741840_1016 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.3:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.7:9866,DS-3a40a112-5daf-4397-842b-f5b093b577cb,DISK]]

Block ID: 1073741840

Block Pool ID: BP-1236072688-172.19.0.2-1697554321959

Generation Stamp: 1016

Size: 67108864

Availability:

    datanode5
    datanode1
    datanode2

1. BP-1236072688-172.19.0.2-1697554321959:blk_1073741841_1017 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.3:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK]]

Block ID: 1073741841

Block Pool ID: BP-1236072688-172.19.0.2-1697554321959

Generation Stamp: 1017

Size: 67108864

Availability:

    datanode6
    datanode2
    datanode1

2. BP-1236072688-172.19.0.2-1697554321959:blk_1073741842_1018 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.3:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK]]

Block ID: 1073741841

Block Pool ID: BP-1236072688-172.19.0.2-1697554321959

Generation Stamp: 1017

Size: 67108864

Availability:

    datanode6
    datanode2
    datanode1

3. BP-1236072688-172.19.0.2-1697554321959:blk_1073741843_1019 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.3:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.7:9866,DS-3a40a112-5daf-4397-842b-f5b093b577cb,DISK]]

Block ID: 1073741843

Block Pool ID: BP-1236072688-172.19.0.2-1697554321959

Generation Stamp: 1019

Size: 67108864

Availability:

    datanode5
    datanode1
    datanode2

4. BP-1236072688-172.19.0.2-1697554321959:blk_1073741844_1020 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.3:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.7:9866,DS-3a40a112-5daf-4397-842b-f5b093b577cb,DISK]]

Block ID: 1073741844

Block Pool ID: BP-1236072688-172.19.0.2-1697554321959

Generation Stamp: 1020

Size: 67108864

Availability:

    datanode5
    datanode2
    datanode1

5. BP-1236072688-172.19.0.2-1697554321959:blk_1073741845_1021 len=31457280 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.5:9866,DS-5bc0f6e2-6c36-4474-97a6-43d54fed1154,DISK], DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], DatanodeInfoWithStorage[172.19.0.7:9866,DS-3a40a112-5daf-4397-842b-f5b093b577cb,DISK]]

Block ID: 1073741845

Block Pool ID: BP-1236072688-172.19.0.2-1697554321959

Generation Stamp: 1021

Size: 31457280

Availability:

    datanode6
    datanode5
    datanode3



4. Obtén la misma información usando el comando hdfs fsck con las opciones adecuadas (busca en la ayuda de hdfs fsck cuáles son esas opciones).
4. -files -blocks -locations


## Segunda parte: Probar el comando hdfs dfsadmin

En el NameNode, como usuario hdadmin, crea un directorio en HDFS y ponle una cuota de solo 4 ficheros. Comprueba cuántos ficheros puedes copiar a ese directorio. Explica a qué se debe este comportamiento.

Paso 1: Inicia sesión como el usuario hdfsadmin en el NameNode. Debes tener privilegios administrativos en el clúster Hadoop para poder utilizar el comando hdfs dfsadmin.

Paso 2: Crea un directorio en HDFS y establece una cuota de solo 4 ficheros. Puedes hacerlo con el siguiente comando:

```bash

hdfs dfs -mkdir /user/hdadmin/directorio_cuota
hdfs dfsadmin -setSpaceQuota 4 /user/hdadmin/directorio_cuota
# hdfs dfs -rm -r /user/hdfsadmin/directorio_cuota
# Establecer una cuota de 4 ficheros para el directorio
hdfs dfsadmin -setQuota 4 /user/hdadmin/directorio_cuota


```




En este ejemplo, hemos creado un directorio llamado directorio_cuota en el directorio del usuario hdfsadmin y le hemos asignado una cuota de 4 ficheros.

Paso 3: Intenta copiar ficheros en ese directorio para comprobar la cuota. Utiliza el siguiente comando:

bash

hdfs dfs -copyFromLocal fichero_grande /user/hdadmin/directorio_cuota/

indica que has superado la cuota de espacio en disco (DiskSpace quota) asignada al directorio /user/hdadmin/directorio_cuota.

Aquí está el significado de las partes del mensaje:

    copyFromLocal: Este es el comando que estás ejecutando, que intenta copiar un archivo local al sistema de archivos distribuido HDFS.

    The DiskSpace quota of /user/hdadmin/directorio_cuota is exceeded: Significa que has excedido la cuota de espacio en disco asignada al directorio /user/hdadmin/directorio_cuota. En otras palabras, el directorio tiene una cuota de espacio en disco de 4 bytes (4 B), pero ya se han consumido 192 megabytes (MB) de espacio en disco.

    quota = 4 B: Indica cuál es la cuota de espacio en disco que se ha establecido para el directorio. En este caso, es de solo 4 bytes.

    diskspace consumed = 201326592 B = 192 MB: Muestra cuánto espacio en disco se ha consumido en el directorio. En este caso, se han utilizado 201326592 bytes, que equivalen a 192 megabytes (MB).

indica que has superado la cuota del espacio de nombres (NameSpace quota) en el directorio /user/hdadmin/directorio_cuota.

Aquí está el significado de las partes del mensaje:

    copyFromLocal: Este es el comando que estás ejecutando, que intenta copiar un archivo local al sistema de archivos distribuido HDFS.

    The NameSpace quota (directories and files) of directory /user/hdadmin/directorio_cuota is exceeded: Significa que has superado la cuota del espacio de nombres (que incluye tanto directorios como ficheros) asignada al directorio /user/hdadmin/directorio_cuota. En otras palabras, has superado el límite de la cantidad total de directorios y ficheros que puedes tener en ese directorio.

    quota=4: Indica cuál es la cuota del espacio de nombres que se ha establecido para el directorio. En este caso, es de 4, lo que significa que puedes tener un máximo de 4 ficheros o directorios en ese directorio.

    file count=5: Muestra cuántos ficheros o directorios ya se han creado en el directorio /user/hdadmin/directorio_cuota. En este caso, ya se han creado 5, lo que supera la cuota establecida.


Repite el comando para copiar varios ficheros y observa qué sucede. Solo podrás copiar hasta 4 ficheros debido a la cuota establecida en el directorio.

Explicación: Este comportamiento se debe a que has configurado una cuota de espacio en el directorio directorio_cuota. La cuota de espacio limita el número de ficheros que puedes almacenar en el directorio en función de la cantidad de espacio disponible. En este caso, has limitado el directorio a un máximo de 4 ficheros, por lo que no podrás copiar más de 4 ficheros en ese directorio.

Es importante mencionar que las cuotas de espacio en HDFS permiten a los administradores de clúster controlar y limitar el uso de espacio en disco por usuario o directorio, lo que es útil para la gestión de recursos y la prevención de agotamiento de espacio en el clúster.

Tercera parte: Probar el comando hdfs fsck


Esta es una tarea bastante extensa y requerirá varios pasos y comandos para completarla. A continuación, te guiaré a través de cada parte de la tarea.

Parte 1: Chequeo de todo el HDFS y resolución de errores

    Para realizar un chequeo completo de todo el HDFS y verificar si hay errores, utiliza el comando hdfs fsck. Ejecuta el siguiente comando como usuario hdadmin:

bash

hdfs fsck /

Esto verificará todo el sistema de archivos HDFS y te mostrará información sobre bloques y archivos, incluidos los errores (si los hay). Si encuentras errores, generalmente tendrás que abordarlos caso por caso.

Parte 2: Detener DataNodes y comprobar la disponibilidad de bloques

    Para llevar a cabo la "Parte 2" de tu tarea, donde debes detener DataNodes y comprobar la disponibilidad de bloques en HDFS, sigue estos pasos:

Paso 1: Detener DataNodes

    Accede al servidor o máquina donde se ejecutan los DataNodes en tu clúster Hadoop. Puedes utilizar comandos como docker container stop o los comandos específicos de tu configuración para detener los DataNodes. Asegúrate de detener suficientes DataNodes para que queden solo 2 activos en racks diferentes.

Ejemplo (suponiendo que los DataNodes se ejecutan en contenedores Docker):

bash

docker container stop datanode1 datanode3 datanode5

docker container stop datanode1 datanode3 datanode5
datanode1
datanode3
datanode5


    Espera al menos 10 minutos para que el NameNode detecte que los DataNodes se han vuelto inactivos.

Paso 2: Comprobar la disponibilidad de bloques

    Para verificar cuántos DataNodes están actualmente activos y la disponibilidad de bloques, ejecuta el siguiente comando en el NameNode como usuario hdadmin:

bash

hdfs dfsadmin -report

Name: 172.19.0.4:9866 (datanode2.hadoop-cluster)
Hostname: datanode2
Rack: /rack1
Decommission Status : Normal
Configured Capacity: 263086084096 (245.02 GB)
DFS Used: 1485032458 (1.38 GB)
Non DFS Used: 118960042998 (110.79 GB)
DFS Remaining: 129202458624 (120.33 GB)
DFS Used%: 0.56%
DFS Remaining%: 49.11%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 0
Last contact: Tue Oct 17 17:12:51 CEST 2023
Last Block Report: Tue Oct 17 16:52:15 CEST 2023
Num of Blocks: 39


Name: 172.19.0.8:9866 (datanode6.hadoop-cluster)
Hostname: datanode6
Decommission Status : Normal
Configured Capacity: 263086084096 (245.02 GB)
DFS Used: 1484924968 (1.38 GB)
Non DFS Used: 118960150488 (110.79 GB)
DFS Remaining: 129202458624 (120.33 GB)
DFS Used%: 0.56%
DFS Remaining%: 49.11%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 0
Last contact: Tue Oct 17 17:12:51 CEST 2023
Last Block Report: Tue Oct 17 16:52:15 CEST 2023
Num of Blocks: 39


Este comando te mostrará un informe que incluirá información sobre los DataNodes activos y su capacidad.

    Para obtener información sobre la disponibilidad de bloques y réplicas, puedes utilizar el siguiente comando:

bash

hdfs fsck / -files -blocks -locations

Status: HEALTHY
 Number of data-nodes:	2
 Number of racks:		2
 Total dirs:			9
 Total symlinks:		0

Replicated Blocks:
 Total size:	1473244853 B
 Total files:	19
 Total blocks (validated):	39 (avg. block size 37775509 B)
 Minimally replicated blocks:	39 (100.0 %)
 Over-replicated blocks:	0 (0.0 %)
 Under-replicated blocks:	39 (100.0 %)
 Mis-replicated blocks:		0 (0.0 %)
 Default replication factor:	3
 Average block replication:	2.0
 Missing blocks:		0
 Corrupt blocks:		0
 Missing replicas:		39 (33.333332 %)
 Blocks queued for replication:	0

Erasure Coded Block Groups:
 Total size:	0 B
 Total files:	0
 Total block groups (validated):	0
 Minimally erasure-coded block groups:	0
 Over-erasure-coded block groups:	0
 Under-erasure-coded block groups:	0
 Unsatisfactory placement block groups:	0
 Average block group size:	0.0
 Missing block groups:		0
 Corrupt block groups:		0
 Missing internal blocks:	0
 Blocks queued for replication:	0
FSCK ended at Tue Oct 17 17:16:09 CEST 2023 in 6 milliseconds


The filesystem under path '/' is HEALTHY



Este comando mostrará información sobre los bloques y su ubicación en DataNodes. Verifica cuántos bloques hay en cada DataNode y si hay bloques under-replicated.

    Comprueba si solo quedan 2 DataNodes activos en racks diferentes. Asegúrate de que los DataNodes que detuviste estén reflejados en el informe de hdfs dfsadmin -report y que los bloques estén distribuidos entre los DataNodes activos.

Ten en cuenta que estos pasos son críticos y deben realizarse con precaución, ya que detener DataNodes puede afectar la disponibilidad de datos en el clúster. Asegúrate de entender la configuración de tu clúster y ten un plan de recuperación en caso de problemas.


    Detén de forma brusca algunos DataNodes como se describe en la tarea.

    Espera alrededor de 10 minutos para que HDFS detecte los DataNodes que están inactivos.

    Ejecuta el comando hdfs dfsadmin -report para verificar cuántos DataNodes están activos. Deberías ver que solo quedan 2 DataNodes.

    Puedes utilizar el siguiente comando para verificar la cantidad de bloques en cada DataNode:

bash

hdfs fsck / -files -blocks -locations

Esto te proporcionará información sobre la cantidad de bloques en cada DataNode.

Parte 3: Chequeo de bloques under-replicated y archivos corruptos

    Ejecuta nuevamente el comando hdfs fsck para verificar si hay bloques under-replicated o archivos corruptos:

bash

hdfs fsck / -files -blocks -locations

Mira la salida del comando para encontrar la cantidad de bloques under-replicated. En caso de bloques perdidos, utiliza el siguiente comando para encontrar los archivos correspondientes:

bash

hdfs fsck / -files -blocks -locations -racks -replicaDetails

Esto proporcionará información detallada sobre los bloques y su ubicación.

Parte 4: Chequeo de disponibilidad de bloques del fichero fichero_grande

    Utiliza el comando hdfs fsck para verificar la disponibilidad de bloques del fichero fichero_grande y obtener información sobre las réplicas y su ubicación:

bash

hdfs fsck /user/hdadmin/directorio_cuota/fichero_grande -files -blocks -locations

hdfs fsck /user/hdadmin/directorio_cuota/fichero_grande -files -blocks -locations

FileSystem is inaccessible due to:
java.io.FileNotFoundException: File does not exist: /user/hdadmin/directorio_cuota/fichero_grande
DFSck exiting.


Status: HEALTHY
 Number of data-nodes:	2
 Number of racks:		2
 Total dirs:			0
 Total symlinks:		0

Replicated Blocks:
 Total size:	367001600 B
 Total files:	1
 Total blocks (validated):	6 (avg. block size 61166933 B)
 Minimally replicated blocks:	6 (100.0 %)
 Over-replicated blocks:	0 (0.0 %)
 Under-replicated blocks:	6 (100.0 %)
 Mis-replicated blocks:		0 (0.0 %)
 Default replication factor:	3
 Average block replication:	2.0
 Missing blocks:		0
 Corrupt blocks:		0
 Missing replicas:		6 (33.333332 %)
 Blocks queued for replication:	0

Erasure Coded Block Groups:
 Total size:	0 B
 Total files:	0
 Total block groups (validated):	0
 Minimally erasure-coded block groups:	0
 Over-erasure-coded block groups:	0
 Under-erasure-coded block groups:	0
 Unsatisfactory placement block groups:	0
 Average block group size:	0.0
 Missing block groups:		0
 Corrupt block groups:		0
 Missing internal blocks:	0
 Blocks queued for replication:	0
FSCK ended at Tue Oct 17 17:21:44 CEST 2023 in 1 milliseconds


The filesystem under path '/user/hdadmin/directorio_cuota/1' is HEALTHY



La información más crítica aquí es que todos los bloques están under-replicated y faltan réplicas en un 33.33% de los bloques. Esto es un problema importante ya que significa que no tienes suficientes réplicas de datos para garantizar la disponibilidad y la tolerancia a fallos.

Para resolver este problema, necesitas asegurarte de que los DataNodes estén funcionando correctamente y que todos los bloques se repliquen de acuerdo con el factor de replicación predeterminado (en este caso, 3). Puedes hacer esto revisando el estado de los DataNodes y los registros del clúster para detectar problemas con los nodos, y también puedes forzar la replicación de bloques faltantes utilizando el comando hdfs dfs -setrep.

Asegúrate de que los DataNodes estén en funcionamiento y de que no haya problemas en la red que estén impidiendo la replicación adecuada de los bloques. También, verifica que no haya problemas de almacenamiento en los DataNodes.

Para identificar los archivos afectados por los bloques under-replicated, puedes utilizar el comando hdfs fsck con la opción -list-corruptfileblocks, como sigue:

bash

hdfs fsck /user/hdadmin/directorio_cuota/1 -list-corruptfileblocks


hdfs fsck /user/hdadmin/directorio_cuota/1 -list-corruptfileblocks
Connecting to namenode via http://namenode:9870/fsck?ugi=hdadmin&listcorruptfileblocks=1&path=%2Fuser%2Fhdadmin%2Fdirectorio_cuota%2F1
The filesystem under path '/user/hdadmin/directorio_cuota/1' has 0 CORRUPT files



Esto te proporcionará información sobre los archivos que tienen bloques under-replicated y sus ubicaciones. Luego, puedes tomar medidas para solucionar el problema, como forzar la replicación de los bloques faltantes o verificar la integridad de los DataNodes.


se puede observar que si es accesible ya que solo se perdio Missing replicas:		6 (33.333332 %) The filesystem under path '/user/hdadmin/directorio_cuota/1' is HEALTHY por lo que se muestra que quedan 2 replicas


Esto te dará información sobre las réplicas de cada bloque y su ubicación. Comprueba cuántas réplicas de cada bloque están disponibles.

    La capacidad de recuperar el fichero depende de la cantidad de réplicas que haya sobrevivido en DataNodes activos. Si hay suficientes réplicas, es posible recuperar el fichero.



Parte 5: Agregar un nuevo DataNode (datanode7)

    Sigue los pasos que viste en la práctica 1 para agregar un nuevo DataNode (datanode7) al clúster Hadoop.

    Una vez que hayas agregado el nuevo DataNode, verifica la replicación de datos en el nuevo nodo ejecutando el comando hdfs dfsadmin -report y asegurándote de que no queden bloques under-replicated.

    Para saber cuántos bloques tiene datanode7 y el factor de replicación medio, puedes utilizar el comando hdfs fsck con la opción -locations para obtener información detallada.


desde 1_Hadoop_cluster

docker container run -d --name datanode7 --network=hadoop-cluster --hostname datanode$i \
--cpus=1 --memory=3072m --expose 8000-10000 --expose 50000-50200 -v ./docker/docker_volumen:/docker  \
datanode-image  /docker/inicio_NodeManager.sh format start

$ /docker/change_config.sh /docker/include_node $HADOOP_HOME/etc/hadoop


$ hdfs dfsadmin -refreshNodes
$ yarn rmadmin -refreshNodes


hdfs fsck /user/hdadmin/directorio_cuota/1 -files -blocks -locations
Connecting to namenode via http://namenode:9870/fsck?ugi=hdadmin&files=1&blocks=1&locations=1&path=%2Fuser%2Fhdadmin%2Fdirectorio_cuota%2F1
FSCK started by hdadmin (auth:SIMPLE) from /172.19.0.2 for path /user/hdadmin/directorio_cuota/1 at Tue Oct 17 17:46:46 CEST 2023

/user/hdadmin/directorio_cuota/1 367001600 bytes, replicated: replication=3, 6 block(s):  Under replicated BP-1236072688-172.19.0.2-1697554321959:blk_1073741846_1022. Target Replicas is 3 but found 2 live replica(s), 0 decommissioned replica(s), 0 decommissioning replica(s).
 Under replicated BP-1236072688-172.19.0.2-1697554321959:blk_1073741847_1023. Target Replicas is 3 but found 2 live replica(s), 0 decommissioned replica(s), 0 decommissioning replica(s).
 Under replicated BP-1236072688-172.19.0.2-1697554321959:blk_1073741848_1024. Target Replicas is 3 but found 2 live replica(s), 0 decommissioned replica(s), 0 decommissioning replica(s).
0. BP-1236072688-172.19.0.2-1697554321959:blk_1073741846_1022 len=67108864 Live_repl=2  [DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK]]
1. BP-1236072688-172.19.0.2-1697554321959:blk_1073741847_1023 len=67108864 Live_repl=2  [DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK]]
2. BP-1236072688-172.19.0.2-1697554321959:blk_1073741848_1024 len=67108864 Live_repl=2  [DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK]]
3. BP-1236072688-172.19.0.2-1697554321959:blk_1073741849_1025 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.3:9866,DS-1d7fc3ec-b0c4-43d3-b67f-8edb04cd6c5d,DISK]]
4. BP-1236072688-172.19.0.2-1697554321959:blk_1073741850_1026 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.3:9866,DS-1d7fc3ec-b0c4-43d3-b67f-8edb04cd6c5d,DISK]]
5. BP-1236072688-172.19.0.2-1697554321959:blk_1073741851_1027 len=31457280 Live_repl=3  [DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], DatanodeInfoWithStorage[172.19.0.3:9866,DS-1d7fc3ec-b0c4-43d3-b67f-8edb04cd6c5d,DISK]]


Status: HEALTHY
 Number of data-nodes:	3
 Number of racks:		2
 Total dirs:			0
 Total symlinks:		0

Replicated Blocks:
 Total size:	367001600 B
 Total files:	1
 Total blocks (validated):	6 (avg. block size 61166933 B)
 Minimally replicated blocks:	6 (100.0 %)
 Over-replicated blocks:	0 (0.0 %)
 Under-replicated blocks:	3 (50.0 %)
 Mis-replicated blocks:		0 (0.0 %)
 Default replication factor:	3
 Average block replication:	2.5
 Missing blocks:		0
 Corrupt blocks:		0
 Missing replicas:		3 (16.666666 %)
 Blocks queued for replication:	0

Erasure Coded Block Groups:
 Total size:	0 B
 Total files:	0
 Total block groups (validated):	0
 Minimally erasure-coded block groups:	0
 Over-erasure-coded block groups:	0
 Under-erasure-coded block groups:	0
 Unsatisfactory placement block groups:	0
 Average block group size:	0.0
 Missing block groups:		0
 Corrupt block groups:		0
 Missing internal blocks:	0
 Blocks queued for replication:	0
FSCK ended at Tue Oct 17 17:46:46 CEST 2023 in 0 milliseconds


The filesystem under path '/user/hdadmin/directorio_cuota/1' is HEALTHY

Name: 172.19.0.3:9866 (datanode7.hadoop-cluster)
Hostname: datanode
Rack: /rack1
Decommission Status : Normal
Configured Capacity: 263086084096 (245.02 GB)
DFS Used: 1484779454 (1.38 GB)
Non DFS Used: 120444977218 (112.17 GB)
DFS Remaining: 127717777408 (118.95 GB)
DFS Used%: 0.56%
DFS Remaining%: 48.55%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 0
Last contact: Tue Oct 17 17:47:39 CEST 2023
Last Block Report: Tue Oct 17 17:46:27 CEST 2023
Num of Blocks: 39



Estos son los pasos generales para completar cada parte de la tarea. Ten en cuenta que cada paso requiere una comprensión profunda de la configuración de tu clúster Hadoop y de cómo funciona HDFS, por lo que debes tener cuidado y seguir los procedimientos con precaución. Además, ten en cuenta que esta tarea puede ser compleja y lleva tiempo, especialmente la resolución de errores y la recuperación de datos.



Tercera parte: Probar el uso de códigos de borrado (erasure codes o EC)
Para poder utilizar EC en vez de replicación es necesario tener activos como mínimo 5 datanodes. EC se aplica a ficheros nuevos que se guarden en carpetas en las que se haya especificado una política de  EC.

Para probar el uso de códigos de borrado (erasure codes o EC) en HDFS, seguirás estos pasos paso a paso:

Nota: Asegúrate de que tus nodos de datos estén en funcionamiento y que el HDFS se haya recuperado de los problemas mencionados anteriormente antes de comenzar.

    Iniciar los Dockers: Inicia los nodos de datos que detuviste previamente:

    bash

docker start datanode1 datanode3 datanode5

Espera a que todos los bloques se recuperen y el HDFS deje de estar corrupto.

$ hdfs dfsadmin -refreshNodes
$ yarn rmadmin -refreshNodes


Verificar Políticas Disponibles:

En el NameNode, como usuario hdadmin, verifica las políticas de EC disponibles con el siguiente comando:

bash

hdfs ec -listPolicies

Esto te mostrará las políticas de EC disponibles en tu clúster HDFS.

hdadmin@namenode:~$ hdfs ec -listPolicies
Erasure Coding Policies:
ErasureCodingPolicy=[Name=RS-10-4-1024k, Schema=[ECSchema=[Codec=rs, numDataUnits=10, numParityUnits=4]], CellSize=1048576, Id=5], State=DISABLED
ErasureCodingPolicy=[Name=RS-3-2-1024k, Schema=[ECSchema=[Codec=rs, numDataUnits=3, numParityUnits=2]], CellSize=1048576, Id=2], State=DISABLED
ErasureCodingPolicy=[Name=RS-6-3-1024k, Schema=[ECSchema=[Codec=rs, numDataUnits=6, numParityUnits=3]], CellSize=1048576, Id=1], State=ENABLED
ErasureCodingPolicy=[Name=RS-LEGACY-6-3-1024k, Schema=[ECSchema=[Codec=rs-legacy, numDataUnits=6, numParityUnits=3]], CellSize=1048576, Id=3], State=DISABLED
ErasureCodingPolicy=[Name=XOR-2-1-1024k, Schema=[ECSchema=[Codec=xor, numDataUnits=2, numParityUnits=1]], CellSize=1048576, Id=4], State=DISABLE


Habilitar la Política EC:

Habilita la política "RS-3-2-1024k" con el siguiente comando:

bash

hdfs ec -enablePolicy -policy RS-3-2-1024k


hdadmin@namenode:~$ hdfs ec -enablePolicy -policy RS-3-2-1024k
Erasure coding policy RS-3-2-1024k is enabled
hdadmin@namenode:~$ hdfs ec -listPolicies
Erasure Coding Policies:
ErasureCodingPolicy=[Name=RS-10-4-1024k, Schema=[ECSchema=[Codec=rs, numDataUnits=10, numParityUnits=4]], CellSize=1048576, Id=5], State=DISABLED
ErasureCodingPolicy=[Name=RS-3-2-1024k, Schema=[ECSchema=[Codec=rs, numDataUnits=3, numParityUnits=2]], CellSize=1048576, Id=2], State=ENABLED
ErasureCodingPolicy=[Name=RS-6-3-1024k, Schema=[ECSchema=[Codec=rs, numDataUnits=6, numParityUnits=3]], CellSize=1048576, Id=1], State=ENABLED
ErasureCodingPolicy=[Name=RS-LEGACY-6-3-1024k, Schema=[ECSchema=[Codec=rs-legacy, numDataUnits=6, numParityUnits=3]], CellSize=1048576, Id=3], State=DISABLED
ErasureCodingPolicy=[Name=XOR-2-1-1024k, Schema=[ECSchema=[Codec=xor, numDataUnits=2, numParityUnits=1]], CellSize=1048576, Id=4], State=DISABLED


Crear una Carpeta con Política EC:

Crea una carpeta en HDFS (por ejemplo, /user/grandes) y aplica la política EC habilitada (RS-3-2-1024k) a esa carpeta con el siguiente comando:

hdfs dfs -mkdir -p /user/grandes


bash

hdfs ec -setPolicy -path /user/grandes -policy RS-3-2-1024k

hdadmin@namenode:~$ hdfs ec -setPolicy -path /user/grandes -policy RS-3-2-1024k
Set RS-3-2-1024k erasure coding policy on /user/grandes


Ahora, cualquier archivo colocado en esta carpeta utilizará la política EC especificada.

#no 3# hdfs dfs -get /user/hdadmin/directorio_cuota/1 /ruta/local


$ hdfs dfs -get /user/hdadmin/directorio_cuota/1


hdadmin@namenode:~$ hdfs dfs -get /user/hdadmin/directorio_cuota/1 /user/hdadmin/directorio_cuota/
get: `/user/hdadmin/directorio_cuota/': No such file or directory: `file:///user/hdadmin/directorio_cuota'
hdadmin@namenode:~$ hdfs dfs -get /user/hdadmin/directorio_cuota/1 /user/hdadmin/directorio_cuota/1
get: `/user/hdadmin/directorio_cuota/1': No such file or directory: `file:///user/hdadmin/directorio_cuota/1'
hdadmin@namenode:~$ hdfs dfs -ls /user/hdadmin/directorio_cuota/1
-rw-r--r--   3 hdadmin supergroup  367001600 2023-10-17 16:52 /user/hdadmin/directorio_cuota/1
hdadmin@namenode:~$ hdfs dfs -get 1 /user/hdadmin/directorio_cuota/1
get: `/user/hdadmin/directorio_cuota/1': No such file or directory: `file:///user/hdadmin/directorio_cuota/1'
hdadmin@namenode:~$ hdfs dfs -get /user/hdadmin/directorio_cuota/1
hdadmin@namenode:~$ ls
1  fichero_grande  hadoop  hadoop-3.3.6
hdadmin@namenode:~$ hdfs dfs -rm  /user/hdadmin/directorio_cuota/1
Deleted /user/hdadmin/directorio_cuota/1
hdadmin@namenode:~$ hdfs dfs -expunge
hdadmin@namenode:~$ hdfs dfs -moveFromLocal 1 /user/grandes/
2023-10-17 18:06:30,174 WARN erasurecode.ErasureCodeNative: Loading ISA-L failed: Failed to load libisal.so.2 (libisal.so.2: cannot open shared object file: No such file or directory)
2023-10-17 18:06:30,174 WARN erasurecode.ErasureCodeNative: ISA-L support is not available in your platform... using builtin-java codec where applicable
hdadmin@namenode:~$ hdfs dfs -moveFromLocal ./1 /user/grandes/
moveFromLocal: `./1': No such file or directory
hdadmin@namenode:~$ ls
fichero_grande  hadoop  hadoop-3.3.6
hdadmin@namenode:~$ 



hdfs fsck /user/grandes/ -files -blocks -locations
Connecting to namenode via http://namenode:9870/fsck?ugi=hdadmin&files=1&blocks=1&locations=1&path=%2Fuser%2Fgrandes
FSCK started by hdadmin (auth:SIMPLE) from /172.19.0.2 for path /user/grandes at Tue Oct 17 18:11:14 CEST 2023

/user/grandes <dir>
/user/grandes/1 367001600 bytes, erasure-coded: policy=RS-3-2-1024k, 2 block(s):  OK
0. BP-1236072688-172.19.0.2-1697554321959:blk_-9223372036854775792_1040 len=201326592 Live_repl=5  [blk_-9223372036854775792:DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], blk_-9223372036854775791:DatanodeInfoWithStorage[172.19.0.7:9866,DS-5bc0f6e2-6c36-4474-97a6-43d54fed1154,DISK], blk_-9223372036854775790:DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK], blk_-9223372036854775789:DatanodeInfoWithStorage[172.19.0.5:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], blk_-9223372036854775788:DatanodeInfoWithStorage[172.19.0.10:9866,DS-3a40a112-5daf-4397-842b-f5b093b577cb,DISK]]
1. BP-1236072688-172.19.0.2-1697554321959:blk_-9223372036854775776_1041 len=165675008 Live_repl=5  [blk_-9223372036854775776:DatanodeInfoWithStorage[172.19.0.8:9866,DS-26d06ad2-99c7-4ddc-a364-076c70c31b44,DISK], blk_-9223372036854775775:DatanodeInfoWithStorage[172.19.0.7:9866,DS-5bc0f6e2-6c36-4474-97a6-43d54fed1154,DISK], blk_-9223372036854775774:DatanodeInfoWithStorage[172.19.0.10:9866,DS-3a40a112-5daf-4397-842b-f5b093b577cb,DISK], blk_-9223372036854775773:DatanodeInfoWithStorage[172.19.0.5:9866,DS-1c8d33ec-1e5a-4d13-b70e-2a51861f9dd4,DISK], blk_-9223372036854775772:DatanodeInfoWithStorage[172.19.0.4:9866,DS-3f03c651-9a22-4ac5-9464-2f2424757a1a,DISK]]


Status: HEALTHY
 Number of data-nodes:	6
 Number of racks:		4
 Total dirs:			1
 Total symlinks:		0

Replicated Blocks:
 Total size:	0 B
 Total files:	0
 Total blocks (validated):	0
 Minimally replicated blocks:	0
 Over-replicated blocks:	0
 Under-replicated blocks:	0
 Mis-replicated blocks:		0
 Default replication factor:	3
 Average block replication:	0.0
 Missing blocks:		0
 Corrupt blocks:		0
 Missing replicas:		0
 Blocks queued for replication:	0

Erasure Coded Block Groups:
 Total size:	367001600 B
 Total files:	1
 Total block groups (validated):	2 (avg. block group size 183500800 B)
 Minimally erasure-coded block groups:	2 (100.0 %)
 Over-erasure-coded block groups:	0 (0.0 %)
 Under-erasure-coded block groups:	0 (0.0 %)
 Unsatisfactory placement block groups:	0 (0.0 %)
 Average block group size:	5.0
 Missing block groups:		0
 Corrupt block groups:		0
 Missing internal blocks:	0 (0.0 %)
 Blocks queued for replication:	0
FSCK ended at Tue Oct 17 18:11:14 CEST 2023 in 1 milliseconds


The filesystem under path '/user/grandes' is HEALTHY
