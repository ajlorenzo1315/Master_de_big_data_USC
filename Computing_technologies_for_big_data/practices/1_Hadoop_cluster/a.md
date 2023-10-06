

docker container run -ti --name namenode --network=hadoop-cluster --hostname namenode --net-alias resourcemanager --expose 8000-10000 -p 9870:9870 -p 8088:8088 tfpena/hadoop-base /bin/bash

# mkdir -p /var/data/hdfs/namenode
# chown hdadmin:hadoop /var/data/hdfs/namenode

# su - hdadmin

edito core-site.xml tengo el archivo editado en fuera del docker
hdfs namenode -format
hdfs --daemon start namenode


