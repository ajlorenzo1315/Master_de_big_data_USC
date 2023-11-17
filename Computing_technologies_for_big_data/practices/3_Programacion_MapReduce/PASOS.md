1-

ssh cursoxxx@hadoop3.cesga.es

1.0- enviamos los datos para la practica

scp cite75_99.txt  cursoxxx@hadoop3.cesga.es:~
scp cite75_99.txt  cursoxxx@hadoop3.cesga.es:~


2- dentro cramos un directorio

hdfs dfs -mkdir patentes

3- luego creamos (limistamos el block size para que genere mas bloques y mas mapreduces )

hdfs dfs -D dfs.block.size=32M -put cite75_99.txt apat63_99.txt patentes 

4_0- GENERAMOS LA APLICAICIÓN

4- cargamos una de las aplicaciones 


scp -r 01-citingpatents curso$curso@hadoop3.cesga.es:~
M.B.D111

```bash
#!/bin/bash

# Cargar el módulo Maven en el entorno
module load maven

# Cambiar al directorio "01-citingpatents"
cd 01-citingpatents

# Eliminar el directorio local "out01" si existe y el directorio "out01" en HDFS
rm -rf out01
hdfs dfs -rm -r -f out01

# Empaquetar el proyecto Java con Maven
mvn package

# Ejecutar un trabajo Hadoop YARN con un archivo JAR y configuración adicional
yarn jar target/citingpatents-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt out01

# Descargar los resultados del trabajo desde HDFS al directorio local
hdfs dfs -get out01

# Descomprimir archivos con extensión ".gz" en el directorio "out01"
gzip -d out01/*.gz

```
```bash
#Recompile: After making these changes, try recompiling your project with Maven:


mvn clean package



```

ejercicio 2


Para compilar, copiad el fichero citingpatents-0.0.1-SNAPSHOT.jar generado en la práctica 1 al directorio src/resources de esta práctica, y usad maven para generar el nuevo .jar
Para ejecutar, haced lo siguiente:



```bash
# o cambiar donde busca esto

hdfs dfs -put cite75_99.txt /user/curso111/path_a_cite75_99.txt_en_HDFS


cp 01-citingpatents/target/citingpatents-0.0.1-SNAPSHOT.jar 02-citationnumberbypatent_chained/src/resources
cd  02-citationnumberbypatent_chained 
# Cargar el módulo Maven en el entorno
module load maven

# Eliminar el directorio local "out01" si existe y el directorio "out01" en HDFS
rm -rf dir_salida_en_HDFS
hdfs dfs -rm -r -f dir_salida_en_HDFS


# Empaquetar el proyecto Java con Maven
mvn package

export HADOOP_CLASSPATH="./src/resources/citingpatents-0.0.1-SNAPSHOT.jar"

yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH  patentes/cite75_99.txt dir_salida_en_HDFS

hdfs dfs -get dir_salida_en_HDFS
```


ejercicio 3

``` bash
# o cambiar donde busca esto
# Cargar el módulo Maven en el entorno
module load maven

# Eliminar el directorio local "out01" si existe y el directorio "out01" en HDFS
rm -rf out3
hdfs dfs -rm -r -f out3


# Empaquetar el proyecto Java con Maven
mvn package

yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out03

hdfs dfs -get out3


```

