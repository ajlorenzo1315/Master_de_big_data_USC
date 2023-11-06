cd BDGE/
mkdir mongo1 mongo2 mongo3


nohup mongod --replSet rs0 --port 27017 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo1 > /dev/null &

nohup mongod --replSet rs0 --port 27018 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo2 > /dev/null &

nohup mongod --replSet rs0 --port 27019 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo3 > /dev/null &


> rs.initiate(
... {
...   _id: "rs0",
...   members: [
... {
...  _id: 0,
...  host: "localhost:27017"
... },
... {
...  _id: 1,
...  host: "localhost:27018"
... },
... {
...  _id: 2,
...  host: "localhost:27019"
... }
...    ]
... }
... )
{
        "ok" : 1,
        "$clusterTime" : {
                "clusterTime" : Timestamp(1698947307, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1698947307, 1)
}
rs0:SECONDARY> 

se supone que es este caso este queo en secundario el secundario no recive inserción de datos siempre conexión replicación 

exit salimos de nodo

@(shell):1:1
rs0:PRIMARY> rs.conf()
{
        "_id" : "rs0",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "localhost:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "localhost:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "localhost:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6543e0ebcd6742593374b3c3")
        }
}






ps -x

   1534 pts/0    Sl     0:03 mongod --replSet rs0 --port 27017 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo1                                                                                                                                          
   1580 pts/0    Sl     0:03 mongod --replSet rs0 --port 27018 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo2                                                                                                                                          
   1625 pts/0    Sl     0:03 mongod --replSet rs0 --port 27019 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo3   



# todos bien
rs0:PRIMARY> db.coleccionPrueba.find().count()
999
# menos un nodo queda 2 de 3
rs0:PRIMARY> db.coleccionPrueba.find().count()
999
# menos otro nodo queda 1 de 3
rs0:PRIMARY> db.coleccionPrueba.find().count()
^C

rs0:PRIMARY> db.coleccionPrueba.find().count()
^C{"t":{"$date":"2023-11-02T17:56:55.932Z"},"s":"I",  "c":"NETWORK",  "id":4333208, "ctx":"ReplicaSetMonitor-TaskExecutor","msg":"RSM host selection timeout","attr":{"replicaSet":"rs0","error":"FailedToSatisfyReadPreference: Could not find host matching read preference { mode: \"primary\", tags: [ {} ] } for set rs0"}}
Error: Could not find host matching read preference { mode: "primary", tags: [ {} ] } for set rs0 :
runClientFunctionWithRetries@src/mongo/shell/session.js:361:27
runCommand@src/mongo/shell/session.js:455:25
DB.prototype._runCommandImpl@src/mongo/shell/db.js:147:12
DB.prototype.runCommand@src/mongo/shell/db.js:162:16
DB.prototype.runReadCommand@src/mongo/shell/db.js:141:12
DBQuery.prototype.count@src/mongo/shell/query.js:383:15
@(shell):1:1
{"t":{"$date":"2023-11-02T17:57:05.828Z"},"s":"I",  "c":"NETWORK",  "id":4333208, "ctx":"ReplicaSetMonitor-TaskExecutor","msg":"RSM host selection timeout","attr":{"replicaSet":"rs0","error":"FailedToSatisfyReadPreference: Could not find host matching read preference { mode: \"primary\", tags: [ {} ] } for set rs0"}}
{"t":{"$date":"2023-11-02T17:57:05.828Z"},"s":"F",  "c":"CONTROL",  "id":4757800, "ctx":"main","msg":"Writing fatal message","attr":{"message":"terminate() called. An exception is active; attempting to gather more information"}}
{"t":{"$date":"2023-11-02T17:57:05.828Z"},"s":"F",  "c":"CONTROL",  "id":4757800, "ctx":"main","msg":"Writing fatal message","attr":{"message":"DBException::toString(): FailedToSatisfyReadPreference: Could not find host matching read preference { mode: \"primary\", tags: [ {} ] } for set rs0\nActual exception type: mongo::error_details::ExceptionForImpl<(mongo::ErrorCodes::Error)133, mongo::AssertionException>\n"}}
[1]   Terminado (killed)      nohup mongod --replSet rs0 --port 27017 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo1 > /dev/null
[2]-  Terminado (killed)      nohup mongod --replSet rs0 --port 27018 --bind_ip localhost --dbpath /home/alumnogreibd/BDGE/mongo2 > /dev/null
Abortado (`core' generado)

mongo "mongodb://localhost:27017,localhost:27018,localhost:27019/?replicaSet=rs0"
MongoDB shell version v4.4.24
connecting to: mongodb://localhost:27017,localhost:27018,localhost:27019/?compressors=disabled&gssapiServiceName=mongodb&replicaSet=rs0
^[[A^[[B^[[B^[[B{"t":{"$date":"2023-11-02T17:57:52.183Z"},"s":"I",  "c":"NETWORK",  "id":4333208, "ctx":"ReplicaSetMonitor-TaskExecutor","msg":"RSM host selection timeout","attr":{"replicaSet":"rs0","error":"FailedToSatisfyReadPreference: Could not find host matching read preference { mode: \"primary\", tags: [ {} ] } for set rs0"}}
Error: Could not find host matching read preference { mode: "primary", tags: [ {} ] } for set rs0 :
connect@src/mongo/shell/mongo.js:374:17
@(connect):2:6
exception: connect failed
exiting with code 1




nohup mongod --configsvr --replSet rsConfServer --port 27017 --dbpath /home/alumnogreibd/BDGE/servconf --bind_ip localhost > /dev/null &

mongo --host localhost --port 27017
MongoDB shell version v4.4.24
connecting to: mongodb://localhost:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("bce3f7f3-1041-43bd-8e36-ce428804ce12") }
MongoDB server version: 4.4.24
---
The server generated these startup warnings when booting: 
        2023-11-02T19:18:17.363+01:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
        2023-11-02T19:18:17.672+01:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
        2023-11-02T19:18:17.672+01:00: Soft rlimits too low
        2023-11-02T19:18:17.672+01:00:         currentValue: 1024
        2023-11-02T19:18:17.672+01:00:         recommendedMinimum: 64000
---
> rs.initiate({
...   _id: "rsConfServer",
...   configsvr: true,
...   members: [{_id: 0, host: "localhost:27017"}]
... })
{
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(1698949124, 1),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(0, 0),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1698949124, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1698949124, 1)
}
rsConfServer:SECONDARY> 

mkdir shard1
mkdir shard2

 nohup mongod --shardsvr --replSet rsShard1 --port 27018 --dbpath /home/alumnogreibd/BDGE/shard1 --bind_ip localhost > /dev/null &


 nohup mongod --shardsvr --replSet rsShard2 --port 27019 --dbpath /home/alumnogreibd/BDGE/shard2 --bind_ip localhost > /dev/null &
