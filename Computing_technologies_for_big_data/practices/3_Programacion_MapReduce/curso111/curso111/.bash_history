hdfs dfs -mkdir patentes
ls
hdfs ls
hdfs ls .
hdfs | grep list
hdfs dfs -ls .
hdfs dfs -D dfs.block.size=32M -put cite75_99.txt apat63_99.txt patentes 
exi
exit
hdfs dfs -D dfs.block.size=32M -put cite75_99.txt apat63_99.txt patentes 
hdfs -ls
hdfs dfs -ls
ls
module load maven
cd 01-citingpatents
rm -rf out01; hdfs dfs -rm -r -f out01
mvn package
exit
module load maven
cd 01-citingpatents
rm -rf out01
hdfs dfs -rm -r -f out01
mvn package
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
ls
cd target/
ls
cd ../
ls
cd 01-citingpatents/
ls
 cd src/
ls
cd ../
hdfs dfs ls
hdfs dfs -ls 
hdfs dfs -ls out01
hdfs dfs -copyToLocal out01 .
ls
cd 01-citingpatents_combiner/
module load maven
rm -rf out01
hdfs dfs -rm -r -f out01
mvn package
ls
mvn clean package
mvn package
mvn clean package
ls
cd src/main/java/cursohadoop/citingpatents/
ls
cat CPDriver.java 
mvn clean package
cd ../
cd ../../
ls
cd ../
ls
cd ../
ls
mvn clean package
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
hdfs dfs -get out01
ls out01/
ls
cd ../
mvn clean package
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
ls
cd 01-citingpatents_combiner/
mvn clean package
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
hdfs dfs -rm -r -f out01
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
hdfs dfs -rm -r -f out01
mvn clean package
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
hdfs dfs -rm -r -f out01
ls
mvn clean package
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
hdfs dfs -rm -r -f out01
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01
hdfs dfs -get out01
rm -rf out01
hdfs dfs -get out01
hdfs dfs -rm -r -f out01
cd ../
ls
cd 02-citationnumberbypatent_chained/
export HADOOP_CLASSPATH="./src/resources/citingpatents-0.0.1-SNAPSHOT.jar"
ls ./src/resources/citingpatents-0.0.1-SNAPSHOT.jar
ls ~/01-citingpatents/src/resources/citingpatents-0.0.1-SNAPSHOT.jar
cd  02-citationnumberbypatent_chained 
module load maven
mvn package
cp 01-citingpatents/target/citingpatents-0.0.1-SNAPSHOT.jar 02-citationnumberbypatent_chained/src/resources
cd ../
cp 01-citingpatents/target/citingpatents-0.0.1-SNAPSHOT.jar 02-citationnumberbypatent_chained/src/resources
cd 02-citationnumberbypatent_chained/
mvn package
ls /src/resources
ls ./src/resources
cd ../
cd 02-citationnumberbypatent_chained/
mvn package
yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH path_a_cite75_99.txt_en_HDFS dir_salida_en_HDFS
hdfs dfs -ls
hdfs dfs -ls /user/curso111/
hdfs dfs -put path_a_cite75_99.txt /user/curso111/path_a_cite75_99.txt_en_HDFS
cd ../
ls
hdfs dfs -put path_a_cite75_99.txt /user/curso111/path_a_cite75_99.txt_en_HDFS
hdfs dfs -D dfs.block.size=32M -put cite75_99.txt apat63_99.txt
hdfs dfs -ls 
hdfs dfs -D dfs.block.size=32M -put cite75_99.txt 
hdfs dfs -ls 
cd 02-citationnumberbypatent_chained/
yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH path_a_cite75_99.txt_en_HDFS dir_salida_en_HDFS
cd ../
hdfs dfs -D dfs.block.size=32M -put path_a_cite75_99.txt 
hdfs dfs -put cite75_99.txt /user/curso111/path_a_cite75_99.txt_en_HDFS
cd 02-citationnumberbypatent_chained/
yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH path_a_cite75_99.txt_en_HDFS dir_salida_en_HDFS
hdfs dfs -get out01
hdfs dfs -get out02
yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH path_a_cite75_99.txt_en_HDFS dir_salida_en_HDFS out2
hdfs dfs -get dir_salida_en_HDFS
screen
screen -r 
screen 
screen -r 
ls
mkdir AE
cd AE/
mdkir 4_seleccion_de_modelos_y_KNN
ls
mkdir 4
ls
mdkir 4_seleccion_de_modelos_y_KNN
mkdir 4_seleccion_de_modelos_y_KNN
rm -r  4
ls
cd 4_seleccion_de_modelos_y_KNN/
pwd
ls
cd 03-simplereducesidejoin/
module load maven
mvn package
module load maven
mvn package
ls
cd 03-simplereducesidejoin/
mvn package
module load maven
mvn package
rm -rf out3
hdfs dfs -rm -r -f out3
hdfs -df ls
hdfs df -ls
hdfs dfs -ls
hdfs dfs -ls patentes
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
ls 
ls target/
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03Ç
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
cd ../
cd 03-simplereducesidejoin_reload/src/
cd ../
module load maven
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
cd ../03-simplereducesidejoin
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
CD ../
cd ../
ls
rm 03-simplereducesidejoin
rm -r 03-simplereducesidejoin
cd 03-simplereducesidejoin
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
cd ../
rm -rf out3
hdfs dfs -rm -r -f out3
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
ls
cd 03-simplereducesidejoin
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
mvn package
hdfs dfs -rm -r -f out3
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out3
cd ../03-simplereducesidejoin_D/
hdfs dfs -rm -r -f out3
mvn package
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out3
cd ::/
cd ../03-simplereducesidejoin
yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out3
hdfs dfs -get out3
EXIT
exit
