#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function,division
from pyspark.sql import SparkSession
from pyspark.sql.types import StringType
import pyspark.sql.functions as f
import sys

#---------
import subprocess
import csv

# Script que, a partir de los datos en Parquet de la práctica anterior, obtenga para cada país y para cada año el total de patentes, 
# el total de citas obtenidas por todas las patentes, la media de citas y el máximo número de citas.
# Obtener solo aquellos casos en los que existan valores en ambos ficheros (inner join).
# Cada país tiene que aparecer con su nombre completo, obtenido del fichero country_codes.txt, residente en el disco local.
# El DataFrame generado debe estar ordenado por país y, para cada país, por año
# Ejemplo de salida:
# +-------------------+----+-----------+----------+------------------+--------+
# |Pais               |Anho|NumPatentes|TotalCitas|MediaCitas        |MaxCitas|
# +-------------------+----+-----------+----------+------------------+--------+
# |Algeria            |1963|2          |7         |3.5               |4       |
# |Algeria            |1968|1          |2         |2.0               |2       |
# |Algeria            |1970|1          |2         |2.0               |2       |
# |Algeria            |1972|1          |1         |1.0               |1       |
# |Algeria            |1977|1          |2         |2.0               |2       |
# |Andorra            |1987|1          |3         |3.0               |3       |
# |Andorra            |1993|1          |1         |1.0               |1       |
# |Andorra            |1998|1          |1         |1.0               |1       |
# |Antigua and Barbuda|1978|1          |6         |6.0               |6       |
# |Antigua and Barbuda|1979|1          |14        |14.0              |14      |
# |Antigua and Barbuda|1991|1          |8         |8.0               |8       |
# |Antigua and Barbuda|1994|1          |19        |19.0              |19      |
# |Antigua and Barbuda|1995|2          |12        |6.0               |11      |
# |Antigua and Barbuda|1996|2          |3         |1.5               |2       |
# |Argentina          |1963|14         |35        |2.5               |7       |
# |Argentina          |1964|20         |60        |3.0               |8       |
# |Argentina          |1965|10         |35        |3.5               |10      |
# |Argentina          |1966|16         |44        |2.75              |9       |
# |Argentina          |1967|13         |60        |4.615384615384615 |14      |
#
# Ejecutar en local con:
# spark-submit --master local[*] --driver-memory 4g ejercicio2.py path_a_NCitas.parquet_en_HDFS path_a_Info.parquet_en_HDFS path_a_country_codes.txt_en_local path_a_output_en_HDF
# Ejecución en un cluster YARN:
# spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio2.py path_a_NCitas.parquet_en_HDFS path_a_Info.parquet_en_HDFS path_a_country_codes.txt_en_local path_a_output_en_HDF



def main():

    # Comprobamos que el número de argumentos es correcto
    if len(sys.argv) != 5:

        print("Usar: path_a_ejercicio_2.py path_a_NCitas.parquet_en_HDFS  path_a_Info.parquet_en_HDFS  path_a_country_codes.txt_en_local  path_a_output_en_HDFS")
        print("Usar: path_a_ejercicio_2.py path_a_cite75_99.txt  path_a_apat63_99.txt path_out_NCitas.parquet path_a_output_en_HDFS")
        exit(-1)
    
    # Input
    input_file_Ncites = sys.argv[1]
    input_file_Info = sys.argv[2]
    input_file_Country = sys.argv[3]

    # Output
    output_path = sys.argv[4]
    

    spark = SparkSession.\
            builder.\
            appName("Ejercicio 2 AJLL").\
            getOrCreate()

    # Cambiamos la verbosidad para reducir el número de mensajes por pantalla
    spark.sparkContext.setLogLevel("FATAL")
    
    
    # Cargamos el archivo txt y guardamos como un Dataframe
    # El token de separacion es , y luego 
    country_dict = {}
    with open(input_file_Country, mode='r') as infile:
          country_dict = {line.split()[0]: ' '.join(line.split()[1:]) for line in infile if line.strip()}


    # Broadcast del diccionario de códigos de países
    broadcast_countries = spark.sparkContext.broadcast(country_dict)
    # Función para reemplazar código de país por nombre completo
    def country_name(code):
        return broadcast_countries.value.get(code, code)

    country_name_udf = f.udf(country_name, StringType())

    Ncites = spark.read.parquet(input_file_Ncites)
    print(Ncites.show(5))
    
    Info  = spark.read.parquet(input_file_Info).withColumnRenamed("NPatente", "NPatente_Info")
    print(Info.show(5))

    result = Ncites.join(Info, Ncites.NPatente == Info.NPatente_Info, "inner").select('NPatente', 'NCitas', 'Pais', 'Anho')
    print(result.show(5))

    result = result.groupBy("Pais", "Anho")\
               .agg(f.count("NPatente").alias("NumPatentes"),
                    f.sum("ncitas").alias("TotalCitas"),
                    f.avg("ncitas").alias("MediaCitas"),
                    f.max("ncitas").alias("MaxCitas"))\
               .orderBy("Pais", "Anho")
    print(result.show(5))

    result=result.withColumn("Pais", country_name_udf(f.col("Pais")))
    print(result.show(5))

    result=result.orderBy("Pais", "Anho")
    print(result.show(5))
    print("Número de particiones del dfCitas: {0}".format(result.rdd.getNumPartitions()))
    #result.write.format("parquet").mode("overwrite").option("compression", "gzip").save(output_path)
    # Escribimos a un único fichero csv
    result.coalesce(1).write.csv(output_path, mode='overwrite', header=True)
if __name__ == "__main__":
    main()