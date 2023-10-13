# FROM hpcnube-base-image:latest
FROM  tfpena/hadoop-base:latest
#MAINTAINER

# Switch 

USER root

ENV HADOOP_VERSION 3.3.1
ENV LOG_TAG "[Name Node Hadoop_${HADOOP_VERSION}]:"
ENV BASE_DIR /opt/bd
ENV HADOOP_HOME ${BASE_DIR}/hadoop
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV DATA_DIR /var/data/hadoop/hdfs


# Crea los directoriso para los datos de HDFS del NameNode y propietario hdadmin

RUN echo "$LOG_TAG creamos los directoriso " &&\
    mkdir -p ${DATA_DIR}/backup &&  mkdir -p ${DATA_DIR}/backup/dfs/name && chown -R hdadmin:hadoop ${DATA_DIR}

# Creamos el directorio de logs hdoop

RUN mkdir ${HADOOP_HOME}/logs


# Copia los ficheros de configuracion
COPY  ./hadoop_backupnode/core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY  ./hadoop_backupnode/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY  ./hadoop_backupnode/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
COPY  ./hadoop_backupnode/yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml

# copiamos el elscro de imio 


# establecemos los permisos de 
RUN  chown -R hdadmin:hadoop ${BASE_DIR}
RUN  chown -R hdadmin:hadoop ${DATA_DIR}


# definomos los valores de entorno
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV BASE_DIR /opt/bd
ENV HADOOP_HOME ${BASE_DIR}/hadoop
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV PATH ${PATH}:${HADOOP_HOME}/bin/:${HADOOP_HOME}/sbin


# ponemos el workdir

# nano $HADOOP_CONF_DIR/core-site.xml
# docker container run -ti --name namenode --network=hadoop-cluster --hostname namenode --expose 8000-10000 --expose 50000-50200 -i namenode-image  /bin/bash
# CMD ["$BASE_DIR/inicio.sh format start"]