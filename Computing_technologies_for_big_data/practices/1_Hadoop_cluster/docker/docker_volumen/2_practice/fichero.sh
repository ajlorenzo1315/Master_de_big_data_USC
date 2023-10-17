#!/bin/bash


su luser -c "echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.bashrc"
su luser -c "echo 'export HADOOP_HOME=/opt/bd/hadoop' >> ~/.bashrc"
su luser -c "echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> ~/.bashrc"
su luser -c ". ~/.bashrc"


su luser -c "dd if=/dev/urandom of=fichero_grande bs=1M count=350 && $HADOOP_HOME/bin/hdfs dfs -moveFromLocal fichero_grande /user/luser/"
su luser -c "$HADOOP_HOME/bin/hdfs fsck /user/luser/fichero_grande -files -blocks -locations"


su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hdadmin/directorio_cuota"
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfsadmin -setSpaceQuota 4 /user/hdadmin/directorio_cuota"
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -copyFromLocal fichero_grande /user/hdadmin/directorio_cuota/"