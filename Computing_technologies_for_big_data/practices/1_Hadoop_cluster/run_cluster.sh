#!/bin/bash

# Nombre de las imágenes que deseas construir
NAMENODE_IMAGE="namenode-image"
DATANODE_IMAGE="datanode-image"
BUCKUP_IMAGE="buckup-image"
TIME_IMAGE="time-image"

docker stop  $(docker ps -aq)
docker rm  $(docker ps -aq)

# Verificar si la imagen del Namenode ya está construida
if ! docker images | grep -q "$NAMENODE_IMAGE" || [ "$1" == "--force" ]; then
    # Si la imagen no está construida o se especifica --force, construirla
    docker build -f ./docker/ResourceManager.Dockerfile -t "$NAMENODE_IMAGE" .
else
    echo "La imagen del Namenode ya está construida."
fi

# Verificar si la imagen del Datanode ya está construida
if ! docker images | grep -q "$DATANODE_IMAGE" || [ "$1" == "--force" ]; then
    # Si la imagen no está construida o se especifica --force, construirla
    docker build -f ./docker/NodeManager.Dockerfile -t "$DATANODE_IMAGE" .
else
    echo "La imagen del Datanode ya está construida."
fi

# Verificar si la imagen del Datanode ya está construida
if ! docker images | grep -q "$BUCKUP_IMAGE" || [ "$1" == "--force" ]; then
    # Si la imagen no está construida o se especifica --force, construirla
    docker build -f ./docker/Backup_Node.Dockerfile -t "$BUCKUP_IMAGE" .
else
    echo "La imagen del Datanode ya está construida."
fi

# Verificar si la imagen del Datanode ya está construida
if ! docker images | grep -q "$TIME_IMAGE" || [ "$1" == "--force" ]; then
    # Si la imagen no está construida o se especifica --force, construirla
    docker build -f ./docker/Timelineserver.Dockerfile -t "$TIME_IMAGE" .
else
    echo "La imagen del Datanode ya está construida."
fi


# Verificar si la red "hadoop-cluster" existe
if ! docker network inspect hadoop-cluster &> /dev/null; then
    # Si la red no existe, crearla
    docker network create hadoop-cluster
    echo "La red 'hadoop-cluster' ha sido creada."
else
    echo "La red 'hadoop-cluster' ya existe."
    docker network  rm hadoop-cluster
    #$(docker network list -aq)
    docker network create hadoop-cluster
fi


docker container run -d --name namenode --network=hadoop-cluster --hostname namenode --net-alias resourcemanager --cpus=1 --memory=3072m \
--expose 8000-10000 -p 9870:9870 -p 8088:8088 \
-v ./docker/docker_volumen:/docker \
"$NAMENODE_IMAGE" /docker/inicio_ResourceManager.sh format start

for i in {1..6}; do docker container run -d --name datanode$i --network=hadoop-cluster --hostname datanode$i \
--cpus=1 --memory=3072m --expose 8000-10000 --expose 50000-50200 -v ./docker/docker_volumen:/docker  \
"$DATANODE_IMAGE"  /docker/inicio_NodeManager.sh format start; done


docker container run -d --name backupnode --network=hadoop-cluster --hostname \
backupnode --cpus=1 --memory=3072m --expose 50100 -p 50105:50105  \
"$BUCKUP_IMAGE" su hdadmin -c "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 /opt/bd/hadoop/bin/hdfs namenode -backup"


#docker container run -d --name timelineserver --network=hadoop-cluster --hostname \
#timelineserver --cpus=1 --memory=3072m --expose 10200 -p 8188:8188 \
#"$TIME_IMAGE"  su hdadmin -c "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 /opt/bd/hadoop/bin/yarn --daemon start timelineserver"

#docker container run -d --name timelineserver --network=hadoop-cluster --hostname timelineserver \ 
#--cpus=1 --memory=3072m --expose 10200 -p 8188:8188  -i tfpena/hadoop-base  /docker/inicio_timelineserver.sh
#nano ${HADOOP_HOME}/etc/hadoop/yarn-site.xml


# Detener y eliminar contenedores existentes
# docker compose -f docker/cluster_datanode.yml  down -v 
#
## Lanzar Docker Compose en segundo plano
#docker compose -f docker/cluster_datanode.yml up 

# Puedes agregar comandos adicionales aquí si es necesario
# Por ejemplo, esperar a que los servicios estén disponibles antes de continuar
# O ejecutar pruebas automatizadas contra los servicios

# Fin del script
