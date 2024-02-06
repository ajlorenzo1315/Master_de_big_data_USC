####  E1.- Crea las tres máquinas clonando la máquina MongoBase proporcionada. Recuerda que MongoDB ya está instalado en esa máquina, pero es necesario generar nuevas direcciones MAC para los adaptadores de red, cambiar el nombre del host en el sistema operativo y cambiar el identificador de la máquina en el sistema operativo.

E1. Preparación de las Máquinas

    Clona la máquina 'MongoBase' tres veces para crear tres máquinas nuevas.
    En cada clon, cambia la dirección MAC del adaptador de red si no se cambió automáticamente durante el proceso de clonación.
    Cambia el hostname de cada máquina:

    sudo hostnamectl old-hostname new-hostname 

Edita el archivo /etc/hosts y actualiza cualquier referencia al hostname antiguo.
Cambia el identificador de la máquina si es necesario (esto puede depender de tu sistema operativo y entorno).

clonamos la maquina GreiBD Server Base la cual ya tiene instalado mongo esto se hizo para citus

#### E2.- Inicia el replicaSet "rsConfServer" para utilizar como Servidor de Configuración del cluster. Este replicaSet debe tener tres miembros, uno en cada máquina. Recuerda que ahora será necesario indicar la IP de la máquina correspondiente en la opción --bind_ip cuando se lanza cada proceso. Recuerda que además de lanzar el proceso es necesario configurar el replicaSet usando la función rs.initiate(), que en este caso no podrá usar los parámetros por defecto, al tener el replicaSet más de un miembro.

mongod --configsvr --replSet rsConfServer --bind_ip localhost --dbpath /data/configdb --port 27019
```bash
cd /BDGE/mongobd

# creamos una carpeta que contenga la configuración de nuestro cluster 
mkdir servconf

ifconfig
#  inet 192.168.56.103  nuestro manager

nohup mongod --configsvr --replSet rsConfServer --port 27019 --dbpath /home/alumnogreibd/BDGE/mongobd/servconf --bind_ip localhost,192.168.56.103  > /dev/null &

# EN LAS MAQUINAS VIRTUAL SERVIDOR SI SE CREA UNA CARPETA DE STORAGE, DAR PERMISOS PARA QUE SE PUEDA ESCRIBIR EN ELLA
sudo chown -R alumnogreibd:alumnogreibd /home/alumnogreibd/BDGE/mongobd/servconf # PARA citus1 y citus2 (en estse caso )
#  inet 192.168.56.102  nuestro citius2

nohup mongod --configsvr --replSet rsConfServer --port 27019 --dbpath /home/alumnogreibd/BDGE/mongobd/servconf --bind_ip localhost,192.168.56.102  > /dev/null &

#  inet 192.168.56.101  nuestro citius1

nohup mongod --configsvr --replSet rsConfServer --port 27019 --dbpath /home/alumnogreibd/BDGE/mongobd/servconf --bind_ip localhost,192.168.56.101  > /dev/null &


nohup mongod --configsvr --replSet rsConfServer --port 27019 --dbpath /home/alumnogreibd/BDGE/mongobd/servconf --bind_ip localhost,192.168.56.xxx > /dev/null &


nohup: Este comando se utiliza para ejecutar otro comando en segundo plano y permite que el proceso siga ejecutándose incluso después de que cierres la sesión o terminal. Es útil para ejecutar procesos que deben continuar funcionando después de cerrar la sesión de SSH o la terminal.

mongod: Este es el comando que inicia el servidor de MongoDB.

--configsvr: Esta opción indica que este servidor de MongoDB se utilizará como un servidor de configuración. En un clúster de MongoDB, los servidores de configuración almacenan los metadatos del clúster.

--replSet rsConfServer: Esto configura el replica set al que pertenecerá este servidor de configuración. El nombre del replica set es "rsConfServer", lo que significa que este servidor se unirá a ese replica set.

--port 27017: Esto especifica el puerto en el que se ejecutará el servidor de MongoDB. En este caso, se utilizará el puerto 27017.

--dbpath /home/alumnogreibd/servconf: Esto establece la ruta al directorio donde MongoDB almacenará sus datos. En este caso, los datos se almacenarán en "/home/alumnogreibd/servconf".

# 192.168.56.xxx: lo sustituimos por nuestra  ip en nuestro caso 192.168.56.103
--bind_ip localhost,192.168.56.xxx: Esto configura las direcciones IP a las que MongoDB escuchará las conexiones. Está configurado para escuchar en "localhost" y en una dirección IP específica "192.168.56.xxx".

 > /dev/null: Esto redirige la salida estándar del proceso (STDOUT) a "/dev/null", lo que significa que la salida se descarta y no se muestra en la pantalla. Es una forma común de silenciar la salida de un proceso en segundo plano.

 &: Esto ejecuta el comando en segundo plano, lo que significa que el proceso se ejecutará en segundo plano y no bloqueará la terminal.

```

**Nota** podemos usar el protocolo ssh para conectarnos desde greibd a las otras maquinas virtual para facilitar el copiado de comandos
ssh alumnogreibd@192.168.56.101 
ssh alumnogreibd@192.168.56.102

tras esto  habria que configurar replicaSet para ello desde una terminal de GreiBD

lanzamos mongo primero hay que iniciar el servicio 

```bash
sudo systemctl start mongod
# ahora lanzamos mongod
mongo --host localhost --port 27019

# out 
MongoDB shell version v4.4.24
connecting to: mongodb://localhost:27019/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("84261a39-69aa-4f91-aa12-458b871b452f") }
MongoDB server version: 4.4.24
---
The server generated these startup warnings when booting: 
        2023-11-13T20:06:22.072+01:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
        2023-11-13T20:06:22.720+01:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
        2023-11-13T20:06:22.720+01:00: Soft rlimits too low
        2023-11-13T20:06:22.720+01:00:         currentValue: 1024
        2023-11-13T20:06:22.720+01:00:         recommendedMinimum: 64000
---

```
ahora lo conmfiguramos
Dentro iniciamos el replicaSet con la función rs.initiate. Ahora debemos ejecutar esta función con el
siguiente contenido, para tener en cuenta a todos los miembros del replicaSet:

**Nota** Lanzar mongo tambien en lkas otras maquinas virtuales antes de esta configuración si no puede dar un error

**Nota** Usar ayuda visual para comprobar que los (),[],{} estan correctamente cerrados 

```bash 

rs.initiate({
_id: "rsConfServer",
configsvr: true,
members: [
{_id: 0, host: "192.168.56.103:27019"},
{_id: 1, host: "192.168.56.101:27019"},
{_id: 2, host: "192.168.56.102:27019"}
]
})

# out  mirar 

{
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(1699904493, 1),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(0, 0),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699904493, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1699904493, 1)
}



```
####  E3.- Inicia un replicaSet para cada uno de los tres shards (rsShard1, rsShard2, rsShard3). Cada uno de los tres replicaSets tendrá tres miembros, uno en cada una de las tres máquinas, tal y como se indica en la arquitectura. Usa rs.inititate() de forma apropiada para configurar cada uno de los tres replicaSet.

generaremos carpetas shar para que cada uno almacene datos en este caso se llamaran shardX siendo X la cantidad de shard que queramos en nuestro caso (1,2,3)

```bash
# nos dirigimos  a la carpeta donde vamos a guardar los datos 

cd  /home/alumnogreibd/BDGE/mongobd/
# creamos las carpetas 
mkdir shard1 shard2 shard3
# damos los permisos necesarios en este caso solo hace falta para citus1 y citus2 
sudo chown -R alumnogreibd:alumnogreibd shard1 shard2 shard3
```

```bash
# xx se incremaneta 1 apartir del 2019(puerto que usabanmos para la configuracion) 
# por lo que seria 2020,2021,2022 para todos los shar que tenemo y luego como 
# mencionamos antes cambiamos ip segun  la de cada maquina virtual

nohup mongod --shardsvr --replSet rsShardX --port 270xx --dbpath
/home/alumnogreibd/BDGE/mongobd/shardX --bind_ip localhost,192.168.56.10x > /dev/null &

# citus1
nohup mongod --shardsvr --replSet rsShard1 --port 27020 --dbpath /home/alumnogreibd/BDGE/mongobd/shard1 --bind_ip localhost,192.168.56.101 > /dev/null &

nohup mongod --shardsvr --replSet rsShard2 --port 27021 --dbpath /home/alumnogreibd/BDGE/mongobd/shard2 --bind_ip localhost,192.168.56.101 > /dev/null &

nohup mongod --shardsvr --replSet rsShard3 --port 27022 --dbpath /home/alumnogreibd/BDGE/mongobd/shard3 --bind_ip localhost,192.168.56.101 > /dev/null &

# citus2
nohup mongod --shardsvr --replSet rsShard1 --port 27020 --dbpath /home/alumnogreibd/BDGE/mongobd/shard1 --bind_ip localhost,192.168.56.102 > /dev/null &

nohup mongod --shardsvr --replSet rsShard2 --port 27021 --dbpath /home/alumnogreibd/BDGE/mongobd/shard2 --bind_ip localhost,192.168.56.102 > /dev/null &

nohup mongod --shardsvr --replSet rsShard3 --port 27022 --dbpath /home/alumnogreibd/BDGE/mongobd/shard3 --bind_ip localhost,192.168.56.102 > /dev/null &


# greibd
nohup mongod --shardsvr --replSet rsShard1 --port 27020 --dbpath /home/alumnogreibd/BDGE/mongobd/shard1 --bind_ip localhost,192.168.56.103 > /dev/null &

nohup mongod --shardsvr --replSet rsShard2 --port 27021 --dbpath /home/alumnogreibd/BDGE/mongobd/shard2 --bind_ip localhost,192.168.56.103 > /dev/null &

nohup mongod --shardsvr --replSet rsShard3 --port 27022 --dbpath /home/alumnogreibd/BDGE/mongobd/shard3 --bind_ip localhost,192.168.56.103 > /dev/null &



```

**NOTA** si quiers para uno de los rsShard1 por que te has equivocado en algo

```bash
#con:
ps

# Encuentrar el ID del proceso (PID): ID del proceso MongoDB en ejecución que inició con nohup.con  el comando ps para enumerar los procesos en ejecución y encontrar el PID para el proceso mongod que se ejecuta en el puerto 27021. 

ps aux | grep 'mongod --shardsvr --replSet rsShard1 --port 27021'

#Detener el proceso:

kill -2 <PID>

#Reemplace <PID> con el ID del proceso real.

# Reiniciar el proceso MongoDB con el nombre correcto del conjunto de réplicas

nohup mongod --shardsvr --replSet rsShard2 --port 27021 --dbpath /home/alumnogreibd/BDGE/mongobd/shard2 --bind_ip localhost,192.168.56.101 > /dev/null &

#Verificar
ps aux | grep 'mongod --shardsvr --replSet rsShard2 --port 27021'

```

para cada shardX configuramos  ejecutar este función ya tenemos iniciado el replicaSet

```bash

mongo --host localhost --port 2702x
# entramos en mongo y configuramos los rashar
rs.initiate({
_id: "rsShardX",
members: [
{_id: 0, host: "192.168.56.10x:2702x"},
{_id: 1, host: "192.168.56.10x:2702x"},
{_id: 2, host: "192.168.56.10x:2702x"}
]
})

# dentro de donde se creo el shard

mongo --host localhost --port 27020

rs.initiate({
_id: "rsShard1",
members: [
{_id: 0, host: "192.168.56.103:27020"},
{_id: 1, host: "192.168.56.101:27020"},
{_id: 2, host: "192.168.56.102:27020"}
]
})


mongo --host localhost --port 27021

rs.initiate({
_id: "rsShard2",
members: [
{_id: 0, host: "192.168.56.103:27021"},
{_id: 1, host: "192.168.56.101:27021"},
{_id: 2, host: "192.168.56.102:27021"}
]
})


mongo --host localhost --port 27022

rs.initiate({
_id: "rsShard3",
members: [
{_id: 0, host: "192.168.56.103:27022"},
{_id: 1, host: "192.168.56.101:27022"},
{_id: 2, host: "192.168.56.102:27022"}
]
})

# out 1

{
        "operationTime" : Timestamp(1699952669, 1),
        "ok" : 0,
        "errmsg" : "already initialized",
        "code" : 23,
        "codeName" : "AlreadyInitialized",
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(1699952669, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699952669, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}


```


####  E4.- Inicia una instancia de mongos en cada una de las tres máquinas. Conecta después con una de las instancias y añade los tres shards al cluster usando la función rs.addShard. Recuerda que ahora, al tener tres miembros cada replicaSet de cada shard, la URL de cada shard debe tener las IPs y puertos de todos los miembros.



```bash
nohup mongos --port 270XX --configdb rsConfServer/192.168.56.10x:270XX,192.168.56.10x:270XX,192.168.56.10x:270XX --bind_ip localhost,192.168.56.xxx > /dev/null &

# citus1
nohup mongos --port 27023 --configdb rsConfServer/192.168.56.101:27019,192.168.56.102:27019,192.168.56.103:27019 --bind_ip localhost,192.168.56.101 > /dev/null &
# citus2
nohup mongos --port 27023 --configdb rsConfServer/192.168.56.101:27019,192.168.56.102:27019,192.168.56.103:27019 --bind_ip localhost,192.168.56.102 > /dev/null &
# greibd
nohup mongos --port 27023 --configdb rsConfServer/192.168.56.101:27019,192.168.56.102:27019,192.168.56.103:27019 --bind_ip localhost,192.168.56.103 > /dev/null &

--port 27023: This option specifies the network port on which the mongos process will listen for connections. The port number is 27023.

--configdb rsConfServer/192.168.56.105:27017,192.168.56.106:27017,192.168.56.107:27017: This option points to the replica set of the configuration servers (rsConfServer) for the sharded cluster. It specifies the hostnames and ports of the configuration server instances. In this case, there are three configuration servers participating in the rsConfServer replica set.

--bind_ip localhost,192.168.56.xxx: This specifies the IP addresses where mongos should listen for client connections. You should replace 192.168.56.xxx with the actual IP address of the machine on which mongos is running. This allows mongos to accept connections both from the localhost and the specified IP address in the network.

```

luego me meto en 

Igual que en los pasos anteriores, debemos especificar para la opción –bind_ip la dirección IP
correspondiente a cada una de las tres máquinas.
Después nos conectamos en uno de las instancias (en nuestro caso al cluster1) mediante el
comando:
```bash

mongo --host localhost --port 27023

Y aquí añadimos los tres shards ejecutando los siguientes comandos:

sh.addShard("rsShard1/192.168.56.103:27020,192.168.56.101:27020,192.168.56.102:27020")
sh.addShard("rsShard2/192.168.56.101:27021,192.168.56.102:27021,192.168.56.103:27021")
sh.addShard("rsShard3/192.168.56.101:27022,192.168.56.102:27022,192.168.56.103:27022")

Esto es lo que hace cada parte del comando:

    sh.addShard(): Este es un método del shell utilizado para agregar un nuevo shard a un clúster fragmentado.

    "rsShard1/192.168.56.101:27020,192.168.56.102:27020,192.168.56.103:27020": Esta cadena es el identificador del shard, que en este caso es un conjunto de réplicas llamado rsShard1. La cadena también incluye los miembros del conjunto de réplicas con sus respectivas direcciones IP y el puerto en el que están escuchando (27020).

    Los comandos sh.addShard() subsiguientes hacen lo mismo para rsShard2 y rsShard3, pero en diferentes puertos (27020 y 27022).

Esto es lo que debes hacer para ejecutar estos comandos:

    Conectarte a una instancia de mongos: Necesitas estar conectado a un proceso de mongos para agregar shards. Esto se debe a que mongos es el enrutador que se comunica con la base de datos de configuración y los shards.

    Usar el Shell de MongoDB: Una vez conectado a mongos, puedes ejecutar los comandos sh.addShard() en el shell de MongoDB.

    Agregar cada shard: Ejecuta cada comando sh.addShard() uno por uno en el shell. Esto registrará cada shard en la configuración del clúster y permitirá que el clúster comience a usar los shards para almacenar datos.

# out

{
        "shardAdded" : "rsShard1",
        "ok" : 1,
        "operationTime" : Timestamp(1699957995, 3),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699957995, 3),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}


```

#### E5.- Carga los datos completos de la base de datos de películas, usando el mismo archivo json generado en la práctica. Para poder hacer esto debes de mover el archivo json generado en la máquina "GreiBD" a esta nueva máquina. Puedes usar una conexión SFTP.

En este paso debemos cargar los datos completos de la base de datos películas, usando el archivo JSON generado durante esta práctica. Para esto movemos el archivo películas.json de la máquina 
“GreiBD” a la máquina “cluster1” (en nuestro caso no hace falta moverla ya que usabos gribd como uno de los cluster ) podemos usar el protocolo scp para mover este archivo .
```bash
scp /home/alumnogreibd/public/peliculas.json alumnogreibd@192.168.56.101:/home/alumnogreibd/BDGE/mongobd/data

```
Después, cargamos los datos ejecutando el comando siguiente:
```bash 
# si lo lanzamos en greibd 
mongoimport --host=localhost:2702x --db=bdge --collection peliculas --file=/home/alumnogreibd/public/peliculas.json

mongoimport --host=localhost:27023 --db=bdge --collection peliculas --file=/home/alumnogreibd/public/peliculas.json

#out
mongoimport --host=localhost:27023 --db=bdge --collection peliculas --file=/home/alumnogreibd/public/peliculas json                                                                                                                                    
2023-11-14T12:13:04.510+0100    connected to: mongodb://localhost:27023/                                                                                                                                                                                                      
2023-11-14T12:13:07.511+0100    [#####...................] bdge.peliculas       27.3MB/124MB (22.0%)                                                                                                                                                                          
2023-11-14T12:13:10.523+0100    [###########.............] bdge.peliculas       60.1MB/124MB (48.5%)                                                                                                                                                                          
2023-11-14T12:13:13.511+0100    [#################.......] bdge.peliculas       89.5MB/124MB (72.2%)                                                                                                                                                                          
2023-11-14T12:13:16.514+0100    [#######################.] bdge.peliculas       122MB/124MB (98.5%)                                                                                                                                                                           
2023-11-14T12:13:16.811+0100    [########################] bdge.peliculas       124MB/124MB (100.0%)                                                                                                                                                                          
2023-11-14T12:13:16.811+0100    45433 document(s) imported successfully. 0 document(s) failed to import.                                                                                                                                                                                                                                                                  
```
Entramos al proceso mongo en cluster1 ejecutando de nuevo:

```bash

mongo --host localhost --port 27023

# usando la base de datos de bdge
use bdge

#  habilitar el sharding en una base de datos específica
sh.enableSharding("bdge")

# out

{
        "ok" : 1,
        "operationTime" : Timestamp(1699960905, 43),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699960905, 43),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}

```

#### E6.- Indexa y particiona la colección utilizando hashing sobre el atributo id.

```bash
#Creación de un Índice Hashed sobre el atributo id:


db.peliculas.createIndex({id:"hashed"})

#out

{
        "raw" : {
                "rsShard2/192.168.56.101:27021,192.168.56.102:27021,192.168.56.103:27021" : {
                        "createdCollectionAutomatically" : false,
                        "numIndexesBefore" : 1,
                        "numIndexesAfter" : 2,
                        "commitQuorum" : "votingMembers",
                        "ok" : 1
                }
        },
        "ok" : 1,
        "operationTime" : Timestamp(1699960961, 31),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699960961, 31),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}


# Particionamiento de la Colección para Sharding:


sh.shardCollection("bdge.peliculas", {id:"hashed"})

#out

{
        "collectionsharded" : "bdge.peliculas",
        "collectionUUID" : UUID("fab7fa66-e8d2-43e7-9382-02d96a5418f9"),
        "ok" : 1,
        "operationTime" : Timestamp(1699960999, 33),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699960999, 33),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}


```

#### E7.- Realiza una consulta en la que cuentes el número de películas que tienen un presupuesto mayor que medio millón de dólares.

```bash

# opcion 1
# Este comando primero utiliza el método find() para filtrar los documentos de la colección peliculas que cumplen con el criterio (presupuesto mayor a 500,000).
# Luego, el método count() se aplica al conjunto de resultados para contar el número de documentos filtrados.
# Es un enfoque más directo y sencillo para contar documentos, especialmente útil para consultas simples
db.peliculas.find(
{
presupuesto:{$gt:500000}
}
).count()

# out

7705


# opcion 2

# El operador $match se usa para filtrar los documentos, similar a find().

# Luego, el operador $count cuenta los documentos filtrados, devolviendo el resultado como un documento con un campo específico (numeroDePeliculas en este caso).


db.peliculas.aggregate([
    { $match: { presupuesto: { $gt: 500000 } } },
    { $count: "numeroDePeliculas que superan medio millón de dolares" }
])

# out

{ "numeroDePeliculas que superan medio millón de dolares" : 7705 }


```

#### E8.- Apaga una de las tres máquinas, y comprueba que todavía puedes resolver la consulta anterior.

Para ello pararemos una de las maquinas virtuales dandole al pausa en virtual box

```bash
# nota : con preferencia del primario, pero si no puede permitimos leer de cualquier otro
db.getMongo().setReadPref('primaryPreferred')

mongo --host localhost --port 27023
MongoDB shell version v4.4.24
connecting to: mongodb://localhost:27023/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("062c105c-cc94-434f-a532-6942731c19d5") }
MongoDB server version: 4.4.24
---
The server generated these startup warnings when booting: 
        2023-11-14T11:06:35.420+01:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
---
mongos> use bdge
switched to db bdge
mongos> db.peliculas.find(
... {
... presupuesto:{$gt:500000}
... }
... ).count()
7705


 
sh.status()
--- Sharding Status --- 
  sharding version: {
        "_id" : 1,
        "minCompatibleVersion" : 5,
        "currentVersion" : 6,
        "clusterId" : ObjectId("65527bf87ff9fdfca66fb43a")
  }
  shards:
        {  "_id" : "rsShard1",  "host" : "rsShard1/192.168.56.101:27020,192.168.56.102:27020,192.168.56.103:27020",  "state" : 1 }
        {  "_id" : "rsShard2",  "host" : "rsShard2/192.168.56.101:27021,192.168.56.102:27021,192.168.56.103:27021",  "state" : 1 }
        {  "_id" : "rsShard3",  "host" : "rsShard3/192.168.56.101:27022,192.168.56.102:27022,192.168.56.103:27022",  "state" : 1 }
  active mongoses:
        "4.4.3" : 1
        "4.4.24" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours: 
                683 : Success
  databases:
        {  "_id" : "bdge",  "primary" : "rsShard2",  "partitioned" : true,  "version" : {  "uuid" : UUID("493fb348-1e99-47d6-9b7d-73a4ec0e9575"),  "lastMod" : 1 } }
                bdge.peliculas
                        shard key: { "id" : "hashed" }
                        unique: false
                        balancing: true
                        chunks:
                                rsShard1        1
                                rsShard2        1
                        { "id" : { "$minKey" : 1 } } -->> { "id" : NumberLong("318651218963702313") } on : rsShard1 Timestamp(2, 0) 
                        { "id" : NumberLong("318651218963702313") } -->> { "id" : { "$maxKey" : 1 } } on : rsShard2 Timestamp(2, 1) 
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
                config.system.sessions
                        shard key: { "_id" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                rsShard1        342
                                rsShard2        341
                                rsShard3        341
                        too many chunks to print, use verbose if you want to force print


```

#### E9.- Apaga otra de las tres máquinas, y comprueba que ya no puedes resolver la consulta anterior.

Para ello pararemos una de las maquinas virtuales dandole al pausa en virtual box

error

```bash
mongos> db.peliculas.find( { presupuesto:{$gt:500000} } ).count()
uncaught exception: Error: count failed: {
        "ok" : 0,
        "errmsg" : "failed on: rsShard1 :: caused by :: Couldn't get a connection within the time limit of 657ms",
        "code" : 202,
        "codeName" : "NetworkInterfaceExceededTimeLimit",
        "operationTime" : Timestamp(1699962306, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699962311, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
} :
_getErrorWithCode@src/mongo/shell/utils.js:25:13
DBQuery.prototype.count@src/mongo/shell/query.js:386:11
@(shell):1:1

```

#### E10.- Vuelve a iniciar las dos máquinas apagadas y vuelve a lanzar los procesos mongod y mongos necesarios en cada una de ellas: un proceso mongos, un proceso mongod para el configsvr y tres procesos mongod, uno para cada uno los tres shardsvr. Comprueba ahora que la consulta anterior ya funciona de nuevo.

En este caso como usamons maquinas virtuales al pausarlas solo hay que quitar la pausa y ya deberia estar todo configurado

comprobamos que se a recuperado el cluster

```bash
mongos> db.peliculas.find( { presupuesto:{$gt:500000} } ).count()
7705

```
#### E11.- Modifica la columna "fecha_emision" para que en lugar de ser de tipo string sea de tipo Date. Utiliza para ello el operador "$dateFromString" dentro de una llamada "updateMany".

```bash
db.peliculas.updateMany(
    {},
    [{
        $set: {
            fecha_emision: {
                $dateFromString: {
                    dateString: "$fecha_emision",
                    // Opcional: Si tu fecha tiene un formato específico, puedes especificarlo aquí
                    // format: "%Y-%m-%d" // Ejemplo para el formato "YYYY-MM-DD"
                }
            }
        }
    }]
)


db.peliculas.updateMany(
    {},
    [{
        $set: {
            fecha_emision: {
                $cond: {
                    if: { $eq: [{ $type: "$fecha_emision" }, "string"] },
                    then: {
                        $dateFromString: {
                            dateString: "$fecha_emision"
                        }
                    },
                    else: "$fecha_emision"
                }
            }
        }
    }]
)

#En esta consulta, $cond verifica el tipo de fecha_emision:

#    Si es un string, usa $dateFromString para convertirlo a date.
#    Si no es un string (lo que significa que ya es un date o algún otro tipo), lo deja tal cual.

```

#### E12.- Realiza una consulta en la que obtengas todos los títulos y presupuestos de las películas del género "Science Fiction", que tengan unos ingresos de más de 800000000 dolares.


```bash
# opcion1 
db.peliculas.aggregate([
    { 
        $match: { 
            ingresos: { $gt: 800000000 }, 
            "generos.nombre": "Science Fiction" 
        }
    },
    { 
        $project: { 
            titulo: 1, // Incluye el campo 'titulo'
            presupuesto: 1, // Incluye el campo 'presupuesto'
            _id: 0 // Excluye el campo '_id'
        }
    }
])
# out

{ "titulo" : "Transformers: Revenge of the Fallen", "presupuesto" : 150000000 }
{ "titulo" : "Avatar", "presupuesto" : 237000000 }
{ "titulo" : "Inception", "presupuesto" : 160000000 }
{ "titulo" : "Transformers: Dark of the Moon", "presupuesto" : 195000000 }
{ "titulo" : "Transformers: Age of Extinction", "presupuesto" : 210000000 }
{ "titulo" : "The Hunger Games: Catching Fire", "presupuesto" : 130000000 }
{ "titulo" : "Star Wars: The Force Awakens", "presupuesto" : 245000000 }
{ "titulo" : "Guardians of the Galaxy Vol. 2", "presupuesto" : 200000000 }
{ "titulo" : "Captain America: Civil War", "presupuesto" : 250000000 }
{ "titulo" : "Independence Day", "presupuesto" : 75000000 }
{ "titulo" : "Jurassic Park", "presupuesto" : 63000000 }
{ "titulo" : "Star Wars: Episode III - Revenge of the Sith", "presupuesto" : 113000000 }
{ "titulo" : "Star Wars: Episode I - The Phantom Menace", "presupuesto" : 115000000 }
{ "titulo" : "The Avengers", "presupuesto" : 220000000 }
{ "titulo" : "Iron Man 3", "presupuesto" : 200000000 }
{ "titulo" : "Avengers: Age of Ultron", "presupuesto" : 280000000 }
{ "titulo" : "Jurassic World", "presupuesto" : 150000000 }
{ "titulo" : "Rogue One: A Star Wars Story", "presupuesto" : 200000000 }

# opcion 2
db.peliculas.find(
    {
        "generos.nombre": "Science Fiction", // Asegúrate de que la ruta al campo 'nombre' en el documento sea correcta
        ingresos: { $gt: 800000000 }
    },
    {
        titulo: 1, // 1 para incluir el campo
        presupuesto: 1, // 1 para incluir el campo
        _id: 0 // 0 para excluir este campo
    }
)
# out

{ "titulo" : "Star Wars: Episode III - Revenge of the Sith", "presupuesto" : 113000000 }
{ "titulo" : "Star Wars: Episode I - The Phantom Menace", "presupuesto" : 115000000 }
{ "titulo" : "The Avengers", "presupuesto" : 220000000 }
{ "titulo" : "Iron Man 3", "presupuesto" : 200000000 }
{ "titulo" : "Avengers: Age of Ultron", "presupuesto" : 280000000 }
{ "titulo" : "Jurassic World", "presupuesto" : 150000000 }
{ "titulo" : "Rogue One: A Star Wars Story", "presupuesto" : 200000000 }
{ "titulo" : "Transformers: Revenge of the Fallen", "presupuesto" : 150000000 }
{ "titulo" : "Avatar", "presupuesto" : 237000000 }
{ "titulo" : "Inception", "presupuesto" : 160000000 }
{ "titulo" : "Transformers: Dark of the Moon", "presupuesto" : 195000000 }
{ "titulo" : "Transformers: Age of Extinction", "presupuesto" : 210000000 }
{ "titulo" : "The Hunger Games: Catching Fire", "presupuesto" : 130000000 }
{ "titulo" : "Star Wars: The Force Awakens", "presupuesto" : 245000000 }
{ "titulo" : "Guardians of the Galaxy Vol. 2", "presupuesto" : 200000000 }
{ "titulo" : "Captain America: Civil War", "presupuesto" : 250000000 }
{ "titulo" : "Independence Day", "presupuesto" : 75000000 }
{ "titulo" : "Jurassic Park", "presupuesto" : 63000000 }

# opcion 1 ordenada 

db.peliculas.aggregate([
    { 
        $match: { 
            ingresos: { $gt: 800000000 }, 
            "generos.nombre": "Science Fiction" 
        }
    },
    { 
        $project: { 
            titulo: 1, // Incluye el campo 'titulo'
            presupuesto: 1, // Incluye el campo 'presupuesto'
            _id: 0 // Excluye el campo '_id'
        }
    },
    {
        $sort: {
            presupuesto: -1 // Ordena por 'presupuesto' en orden descendente
        }
    }
])

#out

{ "titulo" : "Avengers: Age of Ultron", "presupuesto" : 280000000 }
{ "titulo" : "Captain America: Civil War", "presupuesto" : 250000000 }
{ "titulo" : "Star Wars: The Force Awakens", "presupuesto" : 245000000 }
{ "titulo" : "Avatar", "presupuesto" : 237000000 }
{ "titulo" : "The Avengers", "presupuesto" : 220000000 }
{ "titulo" : "Transformers: Age of Extinction", "presupuesto" : 210000000 }
{ "titulo" : "Iron Man 3", "presupuesto" : 200000000 }
{ "titulo" : "Guardians of the Galaxy Vol. 2", "presupuesto" : 200000000 }
{ "titulo" : "Rogue One: A Star Wars Story", "presupuesto" : 200000000 }
{ "titulo" : "Transformers: Dark of the Moon", "presupuesto" : 195000000 }
{ "titulo" : "Inception", "presupuesto" : 160000000 }
{ "titulo" : "Jurassic World", "presupuesto" : 150000000 }
{ "titulo" : "Transformers: Revenge of the Fallen", "presupuesto" : 150000000 }
{ "titulo" : "The Hunger Games: Catching Fire", "presupuesto" : 130000000 }
{ "titulo" : "Star Wars: Episode I - The Phantom Menace", "presupuesto" : 115000000 }
{ "titulo" : "Star Wars: Episode III - Revenge of the Sith", "presupuesto" : 113000000 }
{ "titulo" : "Independence Day", "presupuesto" : 75000000 }
{ "titulo" : "Jurassic Park", "presupuesto" : 63000000 }


```

#### E13.- Realiza una consulta que obtenga el título y el título original de las películas protagonizadas por "Penélope Cruz" del género de acción (Action). Ordena el resultado por fecha de emisión.

```bash
db.peliculas.aggregate([
    { 
        $match: {  
            "reparto.persona.nombre": "Penélope Cruz",
            "generos.nombre": "Action" 
        }
    },
    { 
        $project: { 
            titulo: 1, // Incluye el campo 'titulo'
            titulo_original:1, // Incluye el campo 'titulo_original'
            fecha_emision: 1, // Incluye el campo 'fecha_emision'
            _id: 0 // Excluye el campo '_id'
        }
    },
    {
        $sort: {
            fecha_emision: -1 // Ordena por 'fecha_emision' en orden descendente
        }
    }
])
# out 

{ "titulo" : "Grimsby", "titulo_original" : "Grimsby", "fecha_emision" : ISODate("2016-02-24T00:00:00Z") }
{ "titulo" : "Pirates of the Caribbean: On Stranger Tides", "titulo_original" : "Pirates of the Caribbean: On Stranger Tides", "fecha_emision" : ISODate("2011-05-14T00:00:00Z") }
{ "titulo" : "G-Force", "titulo_original" : "G-Force", "fecha_emision" : ISODate("2009-07-21T00:00:00Z") }
{ "titulo" : "Bandidas", "titulo_original" : "Bandidas", "fecha_emision" : ISODate("2006-01-18T00:00:00Z") }
{ "titulo" : "Sahara", "titulo_original" : "Sahara", "fecha_emision" : ISODate("2005-04-06T00:00:00Z") }
{ "titulo" : "The Hi-Lo Country", "titulo_original" : "The Hi-Lo Country", "fecha_emision" : ISODate("1998-12-30T00:00:00Z") }


```

#### E14.- Realiza una agregación en la que obtengas para cada uno de los géneros disponibles en la base de datos, el número de películas que tiene, el total del presupuesto invertido, el total de ingresos generados y la diferencia entre los ingresos y el presupuesto. Ordena el resultado por esta diferencia.



```bash
db.peliculas.aggregate([
    {
        $unwind: "$generos"
    },
    {
        $group: {
            _id: "$generos.nombre", // Agrupar por nombre del género
            numeroDePeliculas: { $sum: 1 }, // Contar el número de películas por género
            totalPresupuesto: { $sum: "$presupuesto" }, // Sumar el presupuesto de todas las películas por género
            totalIngresos: { $sum: "$ingresos" } // Sumar los ingresos de todas las películas por género
        }
    },
    {
        $project: {
            numeroDePeliculas: 1,
            totalPresupuesto: 1,
            totalIngresos: 1,
            beneficios: { $subtract: ["$totalIngresos", "$totalPresupuesto"] }, // Calcular la diferencia entre ingresos y presupuesto
           
        }
    },
    {
        $sort: { beneficios: -1 } // Ordenar por la diferencia en orden descendente
    }
])

# out
{ "_id" : "Adventure", "numeroDePeliculas" : 3490, "totalPresupuesto" : NumberLong("65706926364"), "totalIngresos" : NumberLong("199978669360"), "beneficios" : NumberLong("134271742996") }
{ "_id" : "Action", "numeroDePeliculas" : 6592, "totalPresupuesto" : NumberLong("77709151433"), "totalIngresos" : NumberLong("201388050019"), "beneficios" : NumberLong("123678898586") }
{ "_id" : "Comedy", "numeroDePeliculas" : 13176, "totalPresupuesto" : NumberLong("60136127186"), "totalIngresos" : NumberLong("166862896741"), "beneficios" : NumberLong("106726769555") }
{ "_id" : "Drama", "numeroDePeliculas" : 20244, "totalPresupuesto" : NumberLong("70050619008"), "totalIngresos" : NumberLong("160803769347"), "beneficios" : NumberLong("90753150339") }
{ "_id" : "Thriller", "numeroDePeliculas" : 7619, "totalPresupuesto" : NumberLong("55510980272"), "totalIngresos" : NumberLong("129749706040"), "beneficios" : NumberLong("74238725768") }
{ "_id" : "Family", "numeroDePeliculas" : 2767, "totalPresupuesto" : NumberLong("33519899995"), "totalIngresos" : NumberLong("107099957659"), "beneficios" : NumberLong("73580057664") }
{ "_id" : "Fantasy", "numeroDePeliculas" : 2309, "totalPresupuesto" : NumberLong("34278683311"), "totalIngresos" : NumberLong("103938276500"), "beneficios" : NumberLong("69659593189") }
{ "_id" : "Science Fiction", "numeroDePeliculas" : 3044, "totalPresupuesto" : NumberLong("35364867470"), "totalIngresos" : NumberLong("97847960421"), "beneficios" : NumberLong("62483092951") }
{ "_id" : "Animation", "numeroDePeliculas" : 1931, "totalPresupuesto" : NumberLong("19957486079"), "totalIngresos" : NumberLong("67433244964"), "beneficios" : NumberLong("47475758885") }
{ "_id" : "Romance", "numeroDePeliculas" : 6730, "totalPresupuesto" : NumberLong("26037454973"), "totalIngresos" : NumberLong("73473647770"), "beneficios" : NumberLong("47436192797") }
{ "_id" : "Crime", "numeroDePeliculas" : 4304, "totalPresupuesto" : NumberLong("27601759972"), "totalIngresos" : NumberLong("63386623657"), "beneficios" : NumberLong("35784863685") }
{ "_id" : "Mystery", "numeroDePeliculas" : 2464, "totalPresupuesto" : NumberLong("14425146930"), "totalIngresos" : NumberLong("34754614989"), "beneficios" : NumberLong("20329468059") }
{ "_id" : "Horror", "numeroDePeliculas" : 4671, "totalPresupuesto" : NumberLong("11823585606"), "totalIngresos" : NumberLong("30837094673"), "beneficios" : NumberLong("19013509067") }
{ "_id" : "Music", "numeroDePeliculas" : 1597, "totalPresupuesto" : NumberLong("4466931321"), "totalIngresos" : NumberLong("13370292367"), "beneficios" : NumberLong("8903361046") }
{ "_id" : "War", "numeroDePeliculas" : 1322, "totalPresupuesto" : NumberLong("7805981358"), "totalIngresos" : NumberLong("15910458263"), "beneficios" : NumberLong("8104476905") }
{ "_id" : "History", "numeroDePeliculas" : 1398, "totalPresupuesto" : NumberLong("8914261694"), "totalIngresos" : NumberLong("14902198420"), "beneficios" : NumberLong("5987936726") }
{ "_id" : "Western", "numeroDePeliculas" : 1042, "totalPresupuesto" : NumberLong("3178439427"), "totalIngresos" : NumberLong("5122498884"), "beneficios" : NumberLong(1944059457) }
{ "_id" : "Documentary", "numeroDePeliculas" : 3930, "totalPresupuesto" : 466941285, "totalIngresos" : 1449528578, "beneficios" : 982587293 }
{ "_id" : "Foreign", "numeroDePeliculas" : 1619, "totalPresupuesto" : 401004833, "totalIngresos" : 291633311, "beneficios" : -109371522 }
{ "_id" : "TV Movie", "numeroDePeliculas" : 766, "totalPresupuesto" : 179449000, "totalIngresos" : 42000000, "beneficios" : -137449000 }

```

#### E15- Realiza una agregación para obtener los 10 directores que tiene la duración media de sus películas mas alta, de entre sus películas con ingresos (ingresos>0). Para cada director, saca el número total de películas, la duración media de las películas y la suma de los ingresos de las mismas.


```bash

db.peliculas.aggregate([
{ $unwind: '$personal' },
{
$replaceRoot: {
newRoot: {
$mergeObjects: [
{ ingresos: '$ingresos' },
{ duracion: '$duracion' },
"$personal"
]
}
}
},
{
$match: {
trabajo: "Director",
ingresos:{$gt:0}
}
},
{
$group: {
_id: '$persona.nombre',
peliculas: { $sum: 1 },
ingresos_totales: { $sum: '$ingresos' },
duracion_media: { $avg: '$duracion' }
}
},
{
"$project" : {
_id:0,
'director': '$_id',
'peliculas': '$peliculas',
'ingresos_totales' : '$ingresos_totales',
'duracion_media' : '$duracion_media'
}
},
{ $sort: {duracion_media:-1} },
{ $limit: 10 }
])

```