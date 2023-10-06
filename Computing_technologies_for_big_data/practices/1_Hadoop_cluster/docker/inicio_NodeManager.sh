#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/opt/bd/hadoop
echo "Iniciando manager..."
for arg in "$@"; do
  case "$arg" in
    format)
      # Formatear el NameNode
      su hdadmin -c "$HADOOP_HOME/bin/hdfs datanode -format"
      ;;
    start)
      # Iniciar el NameNode y el ResourceManager
      su hdadmin -c "$HADOOP_HOME/bin/hdfs --daemon start datanode"
      su hdadmin -c "$HADOOP_HOME/bin/yarn --daemon start nodemanager"
      ;;
    *)
      # Argumento no reconocido, mostrar un mensaje de error
      echo "Uso: $0 [format|start]"
      exit 1
      ;;
  esac
done

# Lazo para mantener activo el contenedor
while true; do sleep 10000; done
