#/bin/bash

#Cópialo en el NameNode
tar xvzf /docker/wordcount.tgz -C /home/luser

# En el NameNode, como usuario luser descomprímelo y compílalo usando maven
cd wordcount
#En resumen, "mvn package" compila y empaqueta un proyecto 
#Java utilizando Maven, generando un archivo JAR o WAR que puede 
#ser utilizado o desplegado según las necesidades del proyecto
mvn package

#Ejecútalo con el comando Yarn:

yarn jar target/wordcount*.jar libros wordcount-out

#Comprueba en el interfaz web de Yarn la ejecución de esta tarea.
#Trae los ficheros de salida del HDFS al disco local del NameNode:
#guarda en el la ruta actual 
hdfs dfs -get wordcount-out

# lo sacamos del docker
cp -r  wordcount-out/ /docker/
