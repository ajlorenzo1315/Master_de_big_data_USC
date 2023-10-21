#!/bin/bash
#su - hadadmin

su hdadmin -c "echo 'export MAPRED_EXAMPLES=$HADOOP_HOME/share/hadoop/mapreduce' >> ~/.bashrc && . ~/.bashrc"

su hdadmin -c "$HADOOP_HOME/bin/yarn jar $MAPRED_EXAMPLES/hadoop-mapreduce-examples-*.jar pi 16 1000"