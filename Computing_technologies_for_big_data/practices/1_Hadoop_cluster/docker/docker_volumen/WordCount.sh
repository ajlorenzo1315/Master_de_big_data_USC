#!/bin/bash


#Cópialo en el NameNode
su luser -c "tar xvzf /docker/wordcount.tgz -C /home/luser"

# En el NameNode, como usuario luser descomprímelo y compílalo usando maven
su luser -c "cd /home/luser/wordcount && mvn package"
#En resumen, "mvn package" compila y empaqueta un proyecto 
#Java utilizando Maven, generando un archivo JAR o WAR que puede 
#ser utilizado o desplegado según las necesidades del proyecto
#mvn package

#Ejecútalo con el comando Yarn:

su luser -c "$HADOOP_HOME/bin/yarn jar target/wordcount*.jar libros wordcount-out"

#Comprueba en el interfaz web de Yarn la ejecución de esta tarea.
#Trae los ficheros de salida del HDFS al disco local del NameNode:
#guarda en el la ruta actual 
su luser -c "$HADOOP_HOME/bin/hdfs dfs -get wordcount-out"

# lo sacamos del docker
su luser -c "cp -r  wordcount-out/ /docker/"

# para lanzarlo realmente hay que hacer todo hdadmin