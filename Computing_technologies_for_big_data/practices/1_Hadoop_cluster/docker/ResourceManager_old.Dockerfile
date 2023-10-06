from tfpena/hadoop-base

ARG HADOOP_HOME=/opt/bd/hadoop


# Crea el directorio /var/data/hdfs/namenode
# Cambia el propietario del directorio creado
RUN mkdir -p /var/data/hdfs/namenode && \
    chown hdadmin:hadoop /var/data/hdfs/namenode


# Copia el archivo inicio.sh con permisos ejecutables al directorio /home/hdadmin
#COPY inicio.sh /home/hdadmin/inicio.sh
#RUN chmod +x /home/hdadmin/inicio.sh
# Cambiar al usuario hdadmin
USER hdadmin
# COPY --chown=<user>:<group> <hostPath> <containerPath>
COPY  hadoop_ResourceManager/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
# RUN cat $HADOOP_HOME/etc/hadoop/core-site.xml
COPY  hadoop_ResourceManager/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY  hadoop_ResourceManager/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
COPY  hadoop_ResourceManager/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml

RUN  chown -R hdadmin:hadoop /var/data/hdfs/namenode $HADOOP_HOME
# Vuelve al usuario original (por defecto, suele ser root)
USER root


#RUN ls 

# Copia el script de inicio.sh al directorio de trabajo del contenedor
# Establece el directorio de trabajo en /home/hdadmin
# WORKDIR /home/hdadmin

# Añade cualquier configuración adicional que necesites aquí

# Ejecuta el script de inicio.sh al iniciar el contenedor
# CMD ["/home/hdadmin/inicio.sh format start"]