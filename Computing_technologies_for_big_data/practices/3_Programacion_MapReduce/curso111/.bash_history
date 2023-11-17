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
