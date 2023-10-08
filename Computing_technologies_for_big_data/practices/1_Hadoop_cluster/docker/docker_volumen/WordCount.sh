#/bin/bash



#Cópialo en el NameNode
su hdadmin -c "tar xvzf /docker/wordcount.tgz -C /home/luser"

# En el NameNode, como usuario luser descomprímelo y compílalo usando maven
su hdadmin -c "cd /home/luser/wordcount && mvn package"
#En resumen, "mvn package" compila y empaqueta un proyecto 
#Java utilizando Maven, generando un archivo JAR o WAR que puede 
#ser utilizado o desplegado según las necesidades del proyecto
#mvn package

#Ejecútalo con el comando Yarn:

su hdadmin -c "$HADOOP_HOME/bin/yarn jar target/wordcount*.jar libros wordcount-out"

#Comprueba en el interfaz web de Yarn la ejecución de esta tarea.
#Trae los ficheros de salida del HDFS al disco local del NameNode:
#guarda en el la ruta actual 
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -get wordcount-out"

# lo sacamos del docker
su hdadmin -c "cp -r  wordcount-out/ /docker/"
