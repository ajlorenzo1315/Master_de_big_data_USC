

wget https://dlcdn.apache.org/hbase/2.5.6/hbase-2.5.6-bin.tar.gz

tar xvf hbase-2.5.6-bin.tar.gz

Entorno de la maquina virtual

update-java-alternatives -l
java-1.11.0-openjdk-amd64      1111       /usr/lib/jvm/java-1.11.0-openjdk-amd64
java-1.13.0-openjdk-amd64      1311       /usr/lib/jvm/java-1.13.0-openjdk-amd64


nano hbase-env.sh 
sudo apt-get install openjdk-8-jdk



export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 #d/usr/lib/jvm/java-1.11.0-openjdk-amd64

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH


cd hbase-2.5.6/
cd BDGE/HBaseTest/hbase-2.5.6/

bin/start-hbase.sh



192.168.56.103 
http://localhost:16010
http://192.168.56.103:16010



create 'peliculas', 'info', 'reparto', 'personal'


148 alumnogreibd@greibd:~/BDGE/HBaseTest/hbase-2.5.6$ bin/hbase shell
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
For Reference, please visit: http://hbase.apache.org/2.0/book.html#shell
Version 2.5.6, r6bac842797dc26bedb7adc0759358e4c8fd5a992, Sat Oct 14 23:36:46 PDT 2023
Took 0.0022 seconds                                                                                                                                                                                                
hbase:001:0> create 'peliculas', 'info', 'reparto', 'personal'
Created table peliculas
Took 1.2217 seconds                                                                                                                                                                                                
=> Hbase::Table - peliculas
hbase:002:0> 

other terminal 

sudo apt-get install maven

mvn clean install

Utilizar Maven para Obtener la Última Versión

Si tienes Maven instalado, puedes usarlo para obtener la última versión de un plugin. Abre una terminal y ejecuta el siguiente comando:

bash

mvn help:describe -DgroupId=org.apache.maven.plugins -DartifactId=maven-jar-plugin -Ddetail


java -jar  target/HBaseTest-1.0-SNAPSHOT.jar


javac src/main/java/gal/usc/etse/mbd/bdge/hbasetest/test1.java


scp alumnogreibd@192.168.56.103:/home/alumnogreibd/BDGE/HBaseTest/


scp -r HBaseTest/HBaseTest/ alumnogreibd@192.168.56.103:/home/alumnogreibd/BDGE/HBaseTest

psql -h localhost -U alumnogreibd -d bdge




