#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/opt/bd/hadoop

if [ "$1" == "format" ]; then
  # Si se proporciona el argumento "format", formatear el NameNode
  su hdadmin -c "$HADOOP_HOME/bin/hdfs namenode -format"
elif [ "$1" == "start"  ]; then
  # Si se proporciona el argumento "start", iniciar el NameNode y el ResourceManager
  su hdadmin -c "$HADOOP_HOME/bin/hdfs --daemon start namenode"
  su hdadmin -c "$HADOOP_HOME/bin/yarn --daemon start resourcemanager"
else
  # Si no se proporciona un argumento válido, mostrar un mensaje de error
  echo "Uso: $0 [format|start]"
fi

# Lazo para mantener activo el contenedor
while true; do sleep 10000; done
