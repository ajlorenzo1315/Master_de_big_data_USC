# ANTES DE NADA 

Antes de nada tenemos que tener el cluster de la practica anterior terminada por lo que seguimos los paso de 

[README para lanzar el cluster de hadoop](../1_Hadoop_cluster/README.md)


docker container exec -ti namenode /bin/bash

hdfs dfsadmin -printTopology 

su hdadmin -c "$HADOOP_HOME/bin/hdfs dfsadmin -printTopology"


hdfs dfs -ls directorio_cuota/1

hdfs fsck /user/hdadmin/directorio_cuota/1 -files -blocks -locations
hdfs fsck /user/luser/fichero_grande -files -blocks -locations