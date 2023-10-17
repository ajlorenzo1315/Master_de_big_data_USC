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

0. BP-1785851482-172.23.0.2-1697476152291:blk_1073741840_1016 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.23.0.8:9866,DS-b49de670-4cfd-49a9-a170-20c332e93e88,DISK], DatanodeInfoWithStorage[172.23.0.3:9866,DS-0365f90f-9698-4bb6-bac5-2f9c9595781a,DISK], DatanodeInfoWithStorage[172.23.0.4:9866,DS-668425b6-4b34-45de-b2c5-cee0e6ba4b30,DISK]]

Block ID: 1073741840

Block Pool ID: BP-1785851482-172.23.0.2-1697476152291

Generation Stamp: 1016

Size: 67108864

Availability:

    datanode1
    datanode2
    datanode6

1. BP-1785851482-172.23.0.2-1697476152291:blk_1073741841_1017 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.23.0.8:9866,DS-b49de670-4cfd-49a9-a170-20c332e93e88,DISK], DatanodeInfoWithStorage[172.23.0.4:9866,DS-668425b6-4b34-45de-b2c5-cee0e6ba4b30,DISK], DatanodeInfoWithStorage[172.23.0.5:9866,DS-1f7470c1-0d95-4b0b-abe8-88beb844736a,DISK]]

Block ID: 1073741841

Block Pool ID: BP-1785851482-172.23.0.2-1697476152291

Generation Stamp: 1017

Size: 67108864

Availability:

    datanode3
    datanode2
    datanode6

2. BP-1785851482-172.23.0.2-1697476152291:blk_1073741842_1018 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.23.0.4:9866,DS-668425b6-4b34-45de-b2c5-cee0e6ba4b30,DISK], DatanodeInfoWithStorage[172.23.0.7:9866,DS-1e2752da-d036-47f7-ae19-df3ebe537fe8,DISK], DatanodeInfoWithStorage[172.23.0.8:9866,DS-b49de670-4cfd-49a9-a170-20c332e93e88,DISK]]

Block ID: 1073741842

Block Pool ID: BP-1785851482-172.23.0.2-1697476152291

Generation Stamp: 1018

Size: 67108864

Availability:

    datanode6
    datanode5
    datanode2

3. BP-1785851482-172.23.0.2-1697476152291:blk_1073741843_1019 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.23.0.8:9866,DS-b49de670-4cfd-49a9-a170-20c332e93e88,DISK], DatanodeInfoWithStorage[172.23.0.7:9866,DS-1e2752da-d036-47f7-ae19-df3ebe537fe8,DISK], DatanodeInfoWithStorage[172.23.0.3:9866,DS-0365f90f-9698-4bb6-bac5-2f9c9595781a,DISK]]

Block ID: 1073741843

Block Pool ID: BP-1785851482-172.23.0.2-1697476152291

Generation Stamp: 1019

Size: 67108864

Availability:

    datanode6
    datanode5
    datanode1

4. BP-1785851482-172.23.0.2-1697476152291:blk_1073741844_1020 len=67108864 Live_repl=3  [DatanodeInfoWithStorage[172.23.0.5:9866,DS-1f7470c1-0d95-4b0b-abe8-88beb844736a,DISK], DatanodeInfoWithStorage[172.23.0.7:9866,DS-1e2752da-d036-47f7-ae19-df3ebe537fe8,DISK], DatanodeInfoWithStorage[172.23.0.4:9866,DS-668425b6-4b34-45de-b2c5-cee0e6ba4b30,DISK]]

Block ID: 1073741844

Block Pool ID: BP-1785851482-172.23.0.2-1697476152291

Generation Stamp: 1020

Size: 67108864

Availability:

    datanode3
    datanode5
    datanode2

5. BP-1785851482-172.23.0.2-1697476152291:blk_1073741845_1021 len=31457280 Live_repl=3  [DatanodeInfoWithStorage[172.23.0.7:9866,DS-1e2752da-d036-47f7-ae19-df3ebe537fe8,DISK], DatanodeInfoWithStorage[172.23.0.5:9866,DS-1f7470c1-0d95-4b0b-abe8-88beb844736a,DISK], DatanodeInfoWithStorage[172.23.0.8:9866,DS-b49de670-4cfd-49a9-a170-20c332e93e88,DISK]]


Block ID: 1073741845

Block Pool ID: BP-1785851482-172.23.0.2-1697476152291

Generation Stamp: 1021

Size: 31457280

Availability:

    datanode5
    datanode3
    datanode6

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

Este comando te mostrará un informe que incluirá información sobre los DataNodes activos y su capacidad.

    Para obtener información sobre la disponibilidad de bloques y réplicas, puedes utilizar el siguiente comando:

bash

hdfs fsck / -files -blocks -locations

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

Esto te dará información sobre las réplicas de cada bloque y su ubicación. Comprueba cuántas réplicas de cada bloque están disponibles.

    La capacidad de recuperar el fichero depende de la cantidad de réplicas que haya sobrevivido en DataNodes activos. Si hay suficientes réplicas, es posible recuperar el fichero.

Parte 5: Agregar un nuevo DataNode (datanode7)

    Sigue los pasos que viste en la práctica 1 para agregar un nuevo DataNode (datanode7) al clúster Hadoop.

    Una vez que hayas agregado el nuevo DataNode, verifica la replicación de datos en el nuevo nodo ejecutando el comando hdfs dfsadmin -report y asegurándote de que no queden bloques under-replicated.

    Para saber cuántos bloques tiene datanode7 y el factor de replicación medio, puedes utilizar el comando hdfs fsck con la opción -locations para obtener información detallada.

Estos son los pasos generales para completar cada parte de la tarea. Ten en cuenta que cada paso requiere una comprensión profunda de la configuración de tu clúster Hadoop y de cómo funciona HDFS, por lo que debes tener cuidado y seguir los procedimientos con precaución. Además, ten en cuenta que esta tarea puede ser compleja y lleva tiempo, especialmente la resolución de errores y la recuperación de datos.