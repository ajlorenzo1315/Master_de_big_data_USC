#/bin/bash

echo "Iniciando hsdf load..."
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hdadmin"
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/luser"
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -chown luser /user/luser"
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -ls /user"

su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -mkdir -p /tmp/hadoop-yarn/staging"
su hdadmin -c "$HADOOP_HOME/bin/hdfs dfs -chmod -R 1777 /tmp"


echo "Iniciando hsdf load..."
#su - luser
su hdadmin -c "echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.bashrc"
su hdadmin -c "echo 'export HADOOP_HOME=/opt/bd/hadoop' >> ~/.bashrc"
su hdadmin -c "echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> ~/.bashrc"
su hdadmin -c ". ~/.bashrc"

su hdadmin -c "tar xvf /docker/libros.tar -C /tmp"

su hdadmin -c "cd /tmp && $HADOOP_HOME/bin/hdfs dfs -put libros . && $HADOOP_HOME/bin/hdfs dfs -ls libros"


#hdfs dfs -chown hdadmin:hadoop -R /user/hdadmin

#tar xvzf wordcount.tgz

#tar xvzf /docker/wordcount.tgz -C /home/luser