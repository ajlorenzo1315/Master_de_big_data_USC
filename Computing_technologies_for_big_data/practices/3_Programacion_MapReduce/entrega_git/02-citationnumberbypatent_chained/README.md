 2. (30%) Plantilla 02-citationnumberbypatent_chained: programa MapReduce que usa ChainMapper y ChainReducer para concatenar trabajos MapReduce

- Obtener el número de citas de una patente, combinando el programa anterior 01-citingpatents con un mapper adicional (CCMapper) que, a partir de la salida del reducer del 01-citingpatents, para cada patente, cuente el número de patentes que la citan. 
- Al igual que en la práctica anterior, usar como formato de entrada KeyValueTextInputFormat, indicando que el formato separador de campos es una coma.-
- La salida debe guardarse como un fichero binario de tipo Sequence (formato clave/valor). Podéis ver el contenido de los ficheros de salida usando hdfs dfs -text
- Para compilar, copiad el fichero citingpatents-0.0.1-SNAPSHOT.jar generado en la práctica 1 al directorio src/resources de esta práctica, y usad maven para generar el nuevo .jar
    - Para ejecutar, haced lo siguiente:

        export HADOOP_CLASSPATH="./src/resources/citingpatents-0.0.1-SNAPSHOT.jar"
        yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH path_a_cite75_99.txt_en_HDFS dir_salida_en_HDFS



```bash
# o cambiar donde busca esto

hdfs dfs -put cite75_99.txt /user/curso111/path_a_cite75_99.txt_en_HDFS


cp 01-citingpatents/target/citingpatents-0.0.1-SNAPSHOT.jar 02-citationnumberbypatent_chained/src/resources
cd  02-citationnumberbypatent_chained 
# Cargar el módulo Maven en el entorno
module load maven

# Eliminar el directorio local "out01" si existe y el directorio "out01" en HDFS
rm -rf out2
hdfs dfs -rm -r -f out2


# Empaquetar el proyecto Java con Maven
mvn package

export HADOOP_CLASSPATH="./src/resources/citingpatents-0.0.1-SNAPSHOT.jar"

yarn jar target/citationnumberbypatent_chained-0.0.1-SNAPSHOT.jar -libjars $HADOOP_CLASSPATH  patentes/cite75_99.txt out2

hdfs dfs -get out2

hdfs dfs -text out2/part-r-00000

hdfs dfs -getmerge out2 out2/all
```