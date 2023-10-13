#!/bin/bash

DATANODE_IMAGE="datanode-image"

# Verificar si la imagen del Datanode ya está construida
if ! docker images | grep -q "$DATANODE_IMAGE" || [ "$1" == "--force" ]; then
    # Si la imagen no está construida o se especifica --force, construirla
    docker build -f ./docker/NodeManager.Dockerfile -t "$DATANODE_IMAGE" .
else
    echo "La imagen del Datanode ya está construida."
fi


for i in {5..6}; do docker container run -d --name datanode$i --network=hadoop-cluster --hostname datanode$i \
--cpus=1 --memory=3072m --expose 8000-10000 --expose 50000-50200 -v ./docker/docker_volumen:/docker  \
"$DATANODE_IMAGE"  /docker/inicio_NodeManager.sh format start; done