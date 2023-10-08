#/bin/bash

su hdadmin -c "$HADOOP_HOME/bin/yarn --daemon start timelineserver"