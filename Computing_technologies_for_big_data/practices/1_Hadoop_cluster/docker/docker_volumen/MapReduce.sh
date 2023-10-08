#/bin/bash

su - hadadmin

echo 'export MAPRED_EXAMPLES=$HADOOP_HOME/share/hadoop/mapreduce' >> ~/.bashrc
. ~/.bashrc
yarn jar $MAPRED_EXAMPLES/hadoop-mapreduce-examples-*.jar pi 16 1000