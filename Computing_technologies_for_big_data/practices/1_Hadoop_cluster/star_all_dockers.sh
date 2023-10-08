#!/bin/bash

#docker build -f Teacher.Dockerfile . -t namenode-image
docker build -f ./docker/ResourceManager.Dockerfile  -t namenode-image .

docker build -f ./docker/NodeManager.Dockerfile -t datanode-image .


docker build -f ./docker/Backup_Node.Dockerfile -t buckup-image .

docker network create hadoop-cluster 

#docker container run -ti --name namenode --network=hadoop-cluster --hostname namenode --expose 8000-10000 --expose 50000-50200 -i namenode-image  /bin/bash
#-p 9870:9870 -p 8088:8088




docker container run -ti --name namenode --network=hadoop-cluster --hostname namenode --net-alias resourcemanager --expose 8000-10000 -p 9870:9870 -p 8088:8088 -i namenode-image  /bin/bash



docker container run -ti --name datanode --network=hadoop-cluster --hostname datanode --expose 8000-10000 --expose 50000-50200 tfpena/hadoop-base /bin/bash


docker container run -ti --name backupnode --network=hadoop-cluster --hostname backupnode --cpus=1 --memory=3072m --expose 50100 -p 50105:50105 buckup-image /bin/bash

# docker start $(docker ps -aq)


docker container run -it --name namenode --network=hadoop-cluster --hostname namenode --net-alias resourcemanager --cpus=1 --memory=3072m \
--expose 8000-10000 -p 9870:9870 -p 8088:8088 \
-v ./docker/docker_volumen:/docker \
-i namenode-image  /bin/bash