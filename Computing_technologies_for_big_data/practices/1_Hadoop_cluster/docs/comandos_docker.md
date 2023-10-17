Eliminar contenedores y todo 

    docker system prune -a
    docker stop $(docker ps -aq)
Build docker 

    docker build -t $name_image
    docker build -t namenode-image -f ResourceManager.Dockerfile .

    