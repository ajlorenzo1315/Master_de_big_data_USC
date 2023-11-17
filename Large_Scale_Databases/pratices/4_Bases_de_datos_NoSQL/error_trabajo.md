**COMANDO**

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
```

**ERRORES**

```bash
{
        "ok" : 0,
        "errmsg" : "replSetInitiate quorum check failed because not all proposed set members responded affirmatively: 192.168.56.101:27019 failed with Error connecting to 192.168.56.101:27019 :: caused by :: Connection refused, 192.168.56.102:27019 failed with Error connecting to 192.168.56.102:27019 :: caused by :: Connection refused",
        "code" : 74,
        "codeName" : "NodeNotFound",
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(0, 0)
}

```

poner bien las ip cuando se haga el rs.initiate (en mi caso puse el puerto 2017 por error)


---

```bash

 mongod --configsvr --replSet rsConfServer --port 27019 --dbpath /home/alumnogreibd/BDGE/mongobd/servconf --bind_ip localhost,192.168.56.101 
{"t":{"$date":"2023-11-13T19:34:52.907+00:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-11-13T19:34:52.908+00:00"},"s":"W",  "c":"ASIO",     "id":22601,   "ctx":"main","msg":"No TransportLayer configured during NetworkInterface startup"}
{"t":{"$date":"2023-11-13T19:34:52.908+00:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-11-13T19:34:52.909+00:00"},"s":"I",  "c":"STORAGE",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1516,"port":27019,"dbPath":"/home/alumnogreibd/BDGE/mongobd/servconf","architecture":"64-bit","host":"citus1"}}
{"t":{"$date":"2023-11-13T19:34:52.909+00:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"4.4.3","gitVersion":"913d6b62acfbb344dde1b116f4161360acd8fd13","openSSLVersion":"OpenSSL 1.1.1f  31 Mar 2020","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-11-13T19:34:52.909+00:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"Ubuntu","version":"20.04"}}}
{"t":{"$date":"2023-11-13T19:34:52.909+00:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{"net":{"bindIp":"localhost,192.168.56.101","port":27019},"replication":{"replSet":"rsConfServer"},"sharding":{"clusterRole":"configsvr"},"storage":{"dbPath":"/home/alumnogreibd/BDGE/mongobd/servconf"}}}}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"E",  "c":"STORAGE",  "id":20557,   "ctx":"initandlisten","msg":"DBException in initAndListen, terminating","attr":{"error":"IllegalOperation: Attempted to create a lock file on a read-only directory: /home/alumnogreibd/BDGE/mongobd/servconf"}}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"REPL",     "id":4784900, "ctx":"initandlisten","msg":"Stepping down the ReplicationCoordinator for shutdown","attr":{"waitTimeMillis":10000}}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"COMMAND",  "id":4784901, "ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"SHARDING", "id":4784902, "ctx":"initandlisten","msg":"Shutting down the WaitForMajorityService"}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"NETWORK",  "id":20562,   "ctx":"initandlisten","msg":"Shutdown: going to close listening sockets"}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "ctx":"initandlisten","msg":"Shutting down the global connection pool"}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"STORAGE",  "id":4784906, "ctx":"initandlisten","msg":"Shutting down the FlowControlTicketholder"}
{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"I",  "c":"-",        "id":20520,   "ctx":"initandlisten","msg":"Stopping further Flow Control ticket acquisitions."}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"NETWORK",  "id":4784918, "ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"SHARDING", "id":4784921, "ctx":"initandlisten","msg":"Shutting down the MigrationUtilExecutor"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"CONTROL",  "id":4784925, "ctx":"initandlisten","msg":"Shutting down free monitoring"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"STORAGE",  "id":4784927, "ctx":"initandlisten","msg":"Shutting down the HealthLog"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"STORAGE",  "id":4784929, "ctx":"initandlisten","msg":"Acquiring the global lock for shutdown"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"-",        "id":4784931, "ctx":"initandlisten","msg":"Dropping the scope cache for shutdown"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"FTDC",     "id":4784926, "ctx":"initandlisten","msg":"Shutting down full-time data capture"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"CONTROL",  "id":20565,   "ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-11-13T19:34:52.911+00:00"},"s":"I",  "c":"CONTROL",  "id":23138,   "ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":100}}


```

```bash
# linea error

{"t":{"$date":"2023-11-13T19:34:52.910+00:00"},"s":"E",  "c":"STORAGE",  "id":20557,   "ctx":"initandlisten","msg":"DBException in initAndListen, terminating","attr":{"error":"IllegalOperation: Attempted to create a lock file on a read-only directory: /home/alumnogreibd/BDGE/mongobd/servconf"}}

```

**SOLUCION**

dar permisos a la carpeta de storage

```bash
# opcion 1 
sudo chown -R alumnogreibd:alumnogreibd /home/alumnogreibd/BDGE/mongobd/servconf
# opcion 2
sudo chmod -R 700 /home/alumnogreibd/BDGE/mongobd/servconf

# out 
ls -l .
total 4
drwxr-xr-x 2 alumnogreibd alumnogreibd 4096 Nov 13 19:22 servconf

```

### 4

**COMANDO**


>  mongo --host localhost --port 27021
MongoDB shell version v4.4.24
connecting to: mongodb://localhost:27021/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("483f629c-8be3-4baf-b5c0-1df1c693e6dc") }                                                                                                                                                                                             
MongoDB server version: 4.4.24                                                                                                                                                                                                                                                
---                                                                                                                                                                                                                                                                           
The server generated these startup warnings when booting:                                                                                                                                                                                                                     
        2023-11-14T10:01:16.277+01:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem                                                                                           
        2023-11-14T10:01:17.251+01:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted                                                                                                                        
        2023-11-14T10:01:17.251+01:00: Soft rlimits too low                                                                                                                                                                                                                   
        2023-11-14T10:01:17.251+01:00:         currentValue: 1024                                                                                                                                                                                                             
        2023-11-14T10:01:17.251+01:00:         recommendedMinimum: 64000                                                                                                                                                                                                      
---                                                                                                                                                                                                                                                                           
> sh.addShard("rsShard1/192.168.56.101:27020,192.168.56.102:27020,192.168.56.103:27020")
{
        "ok" : 0,
        "errmsg" : "no such command: 'addShard'",
        "code" : 59,
        "codeName" : "CommandNotFound"
}


**ERROR**

{
        "ok" : 0,
        "errmsg" : "no such command: 'addShard'",
        "code" : 59,
        "codeName" : "CommandNotFound"
}



**SOLUCION**

mongo --host localhost --port 27023  #usar puerto correcto ya que es donde tenomos loa cnfiguración de shar

**COMANDO**

mongos> sh.addShard("rsShard1/192.168.56.101:27020,192.168.56.102:27020,192.168.56.103:27020")

**ERROR**

{
        "ok" : 0,
        "errmsg" : "Could not find host matching read preference { mode: \"primary\" } for set rsShard1",
        "code" : 133,
        "codeName" : "FailedToSatisfyReadPreference",
        "operationTime" : Timestamp(1699953949, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699953949, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}



**soluction**


El mensaje de error que estás viendo al intentar agregar el shard rsShard3 indica que el mongos no puede encontrar una instancia principal (primary) para el conjunto de réplicas especificado. Esto es esencial para que el conjunto de réplicas funcione correctamente y para que pueda ser añadido como un shard al clúster.

Para resolver este problema, sigue los siguientes pasos:

    Conéctate Directamente a cada Nodo del Conjunto de Réplicas:
    Necesitas verificar el estado de cada nodo dentro del conjunto de réplicas rsShard3. Conéctate a cada uno de los nodos de MongoDB utilizando el shell de MongoDB con el comando mongo y el puerto correspondiente a cada nodo. 
    mongo --host localhost --port 27020


    Verifica el Estado del Conjunto de Réplicas:
    Una vez conectado a cada nodo, ejecuta el comando rs.status() para ver el estado de cada nodo dentro del conjunto de réplicas. Debes buscar un nodo que tenga el rol PRIMARY.

    Revisa los Logs de MongoDB:
    Si no encuentras un nodo PRIMARY, revisa los logs de MongoDB en cada nodo para obtener más información sobre por qué no se ha podido elegir un nodo PRIMARY. Los logs pueden darte pistas sobre problemas de conectividad, configuración incorrecta o errores internos.

    Asegúrate de que Todos los Nodos estén en Ejecución:
    Todos los nodos del conjunto de réplicas deben estar en ejecución y ser capaces de comunicarse entre sí. Si algún nodo está apagado, debes iniciarlo.

    Verifica la Conectividad de la Red:
    Comprueba que no haya firewalls o configuraciones de red que bloqueen la comunicación entre los nodos del conjunto de réplicas y el mongos.

    Forzar una Nueva Elección del PRIMARY si es Necesario:
    Si no hay un nodo PRIMARY y es seguro hacerlo, puedes intentar forzar una nueva elección del PRIMARY utilizando el comando rs.stepDown() en el nodo PRIMARY actual, si existe. Si no hay un PRIMARY, una elección debería ocurrir automáticamente si todos los nodos están en línea y pueden comunicarse entre sí.

    Reintenta Agregar el Shard:
    Una vez que un nodo PRIMARY esté presente y funcional, regresa al shell de mongos y ejecuta nuevamente el comando sh.addShard().

Si después de seguir estos pasos aún enfrentas problemas, puede ser útil buscar en la documentación oficial de MongoDB o solicitar soporte profesional para diagnosticar y resolver problemas complejos de configuración de clústeres.



Resolution

I opened mongod.conf file and

security: authorization: enabled    
keyFile: /var/run/mongodb/secKey.key

was missing so I added that and restart the mongod. Then I created shard again from Mongos and it is working now.

```bash
sudo nano /etc/mongod.conf

security:
  authorization: enabled
  keyFile: /ruta/a/tu/secKey.key

sudo systemctl restart mongod

sudo chmod 400 /ruta/a/tu/secKey.key


```

**ERRO**

mongos> rs.status()
{
        "info" : "mongos",
        "ok" : 0,
        "errmsg" : "replSetGetStatus is not supported through mongos",
        "operationTime" : Timestamp(1699956733, 2),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1699956733, 2),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}

**SOLUTION**

sh.status()
--- Sharding Status --- 
  sharding version: {
        "_id" : 1,
        "minCompatibleVersion" : 5,
        "currentVersion" : 6,
        "clusterId" : ObjectId("65527bf87ff9fdfca66fb43a")
  }
  shards:
  active mongoses:
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours: 
                No recent migrations
  databases:
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }


El comando sh.status() que ejecutaste te proporciona un resumen del estado del sharding en tu clúster de MongoDB. De acuerdo con la salida que compartiste, parece que el sharding está habilitado y configurado, pero aún no hay shards (fragmentos) activos ni bases de datos particionadas (sharded) listadas aparte de la base de datos de configuración interna de MongoDB.

Aquí está el significado de la información proporcionada:

    sharding version: Muestra la versión de sharding y el clusterId que es el identificador único de tu clúster de sharding.

    shards: Este debería ser un arreglo de los shards en tu clúster. Como no se muestra nada bajo este título, parece que no hay shards añadidos al clúster todavía, o al menos no se reconocen en el estado actual.

    active mongoses: Este debería mostrar una lista de instancias mongos activas y sus versiones, pero no se muestra ninguna, lo que podría indicar que el comando no recopiló o no pudo acceder a esa información.

    autosplit: Indica si la división automática de chunks está habilitada.

    balancer: Muestra el estado del balanceador, que redistribuye chunks a través de los shards. Según la salida, está habilitado pero no está ejecutándose actualmente, y no ha habido fallos recientes ni migraciones en las últimas 24 horas.

    databases: Muestra las bases de datos en tu clúster. Hasta ahora, solo se muestra la base de datos config, que MongoDB utiliza internamente para almacenar metadatos sobre el clúster.

Para continuar con la configuración de tu clúster, necesitarás:

**SOLUTION**

error

mongos> db.peliculas.updateMany(
...     {},
...     [{
...         $set: {
...             fecha_emision: {
...                 $dateFromString: {
...                     dateString: "$fecha_emision",
...                 }
...             }
...         }
...     }]
... )

WriteError({
        "index" : 0,
        "code" : 241,
        "errmsg" : "$dateFromString requires that 'dateString' be a string, found: date with value 1965-12-07T00:00:00.000Z",
        "op" : {
                "q" : {

                },
                "u" : [
                        {
                                "$set" : {
                                        "fecha_emision" : {
                                                "$dateFromString" : {
                                                        "dateString" : "$fecha_emision"
                                                }
                                        }
                                }
                        }
                ],
                "multi" : true,
                "upsert" : false
        }
}) :
WriteError({
        "index" : 0,
        "code" : 241,
        "errmsg" : "$dateFromString requires that 'dateString' be a string, found: date with value 1965-12-07T00:00:00.000Z",
        "op" : {
                "q" : {

                },
                "u" : [
                        {
                                "$set" : {
                                        "fecha_emision" : {
                                                "$dateFromString" : {
                                                        "dateString" : "$fecha_emision"
                                                }
                                        }
                                }
                        }
                ],
                "multi" : true,
                "upsert" : false
        }
})
WriteError@src/mongo/shell/bulk_api.js:458:48
mergeBatchResults@src/mongo/shell/bulk_api.js:855:49
executeBatch@src/mongo/shell/bulk_api.js:919:13
Bulk/this.execute@src/mongo/shell/bulk_api.js:1163:21
DBCollection.prototype.updateMany@src/mongo/shell/crud_api.js:690:17
@(shell):1:1

**SOLUTION**

El error que estás experimentando indica que el campo fecha_emision ya contiene datos en formato de fecha (date), no en formato de string (string). El operador $dateFromString espera un string como entrada para convertirlo en una fecha, pero en tu caso, parece que ya se ha realizado previamente esta conversión.

Si tu objetivo era asegurarte de que todos los campos fecha_emision sean del tipo Date, entonces parece que ya se ha cumplido. Sin embargo, si crees que hay algunos documentos donde fecha_emision todavía está como string y otros donde ya se ha convertido a fecha, necesitarás realizar una operación condicional para manejar ambos casos.

Puedes hacer esto usando $cond para verificar el tipo de dato del campo fecha_emision y luego aplicar $dateFromString solo si es necesario. Aquí te muestro cómo puedes hacerlo:

javascript

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

En esta consulta, $cond verifica el tipo de fecha_emision:

    Si es un string, usa $dateFromString para convertirlo a date.
    Si no es un string (lo que significa que ya es un date o algún otro tipo), lo deja tal cual.

Antes de ejecutar este comando, te recomendaría verificar nuevamente la consistencia de los datos en tu colección para asegurarte de que esta operación se comportará como esperas.

**13**


You
mongos> db.peliculas.aggregate([
...     { 
...         $match: {  
...             "reparto.persona.nombre": "Penélope Cruz"
...             "generos.nombre": "Science Fiction" 
...         }
...     },
...     { 
...         $project: { 
...             titulo: 1, // Incluye el campo 'titulo'
...             titulo_original:1, // Incluye el campo 'titulo_original'
...             fecha_emision: 1, // Incluye el campo 'presupuesto'
...             _id: 0 // Excluye el campo '_id'
...         }
...     },
...     {
...         $sort: {
...             fecha_emision: -1 // Ordena por 'presupuesto' en orden descendente
...         }
...     }
... ])
uncaught exception: SyntaxError: missing } after property list :
@(shell):5:12
ChatGPT
ChatGPT

El error "SyntaxError: missing } after property list" indica que falta una coma o un corchete de cierre en tu consulta de agregación. Revisando tu consulta, parece que falta una coma al final de la línea que contiene "reparto.persona.nombre": "Penélope Cruz". La sintaxis correcta para la sección $match debería tener una coma separando las condiciones de filtro. Además, ajustaré el comentario en la línea de fecha_emision para que refleje correctamente el campo que se está incluyendo. Aquí está la consulta corregida: