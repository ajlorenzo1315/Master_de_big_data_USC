#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function,division
from pyspark.sql import SparkSession
import pyspark.sql.functions as f
import sys

#---------
import subprocess

# Script para extraer información de los ficheros cite75_99.txt y apat63_99.txt. 
# a) A partir del fichero cite75_99.txt obtener el número de citas de cada patente. 
#    Debes obtener un DataFrame de la siguiente forma:
#   +--------+------+ 
#   |NPatente|ncitas|
#   +--------+------+
#   | 3060453|  3   |
#   | 3390168|  6   |
#   | 3626542| 18   | 
#   | 3611507|  5   |
#   | 3000113|  4   |
#
# b) A partir del fichero apat63_99.txt, crear un DataFrame que contenga el número de patente, 
# el país y el año, descartando el resto de campos del fichero.
# Ese DataFrame debe tener la siguiente forma:
#
#   +--------+----+----+ 
#   |NPatente|Pais|Anho|
#   +--------+----+----+
#   | 3070801| BE| 1963| 
#   | 3070802| US| 1963| 
#   | 3070803| US| 1963| 
#   | 3070804| US| 1963| 
#   | 3070805| US| 1963|
#
# Ejecutar en local con:
# spark-submit --master local[*] --driver-memory 4g ejercicio1.py path_a_cite75_99.txt path_a_apat63_99.txt dfCitas.parquet dfInfo.parquet
# Ejecución en un cluster YARN:
# spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio1.py path_a_cite75_99.txt_en_HDFS path_a_apat63_99.txt_en_HDFS dfCitas.parquet dfInfo.parquet

def main():

    # Comprobamos que el número de argumentos es correcto
    if len(sys.argv) != 5:
        
        # Ejecutar en local con:
        # spark-submit --master local[*] --driver-memory 4g p1.py path_a_cite75_99.txt path_a_apat63_99.txt NCitas.parquet Info.parquet
        # Ejecución en un cluster YARN:
        # spark-submit --master yarn --num-executors 8 --driver-memory 4g p1.py path_a_cite75_99.txt_en_HDFS path_a_apat63_99.txt_en_HDFS NCitas.parquet Info.parquet

        print("Usar: path_a_ejercicio_2.py path_a_NCitas.parquet_en_HDFS  path_a_Info.parquet_en_HDFS  path_out_NCitas.txt_en_HDFS   path_out_Info.parquet_en_HDFS ")
        print("Usar: path_a_ejercicio_2.py path_a_cite75_99.txt  path_a_apat63_99.txt path_out_NCitas.parquet path_out_Info.parquet")

        exit(-1)
    
    # Apartado A
    input_file_a = sys.argv[1]
    output_path_a = sys.argv[3]
    
    # Apartado B
    input_file_b = sys.argv[2]
    output_path_b = sys.argv[4]

    spark = SparkSession.\
            builder.\
            appName("Ejercicio 1 AJLL").\
            getOrCreate()

    # Cambiamos la verbosidad para reducir el número de mensajes por pantalla
    spark.sparkContext.setLogLevel("FATAL")
    
    # ------------------- Apartado A ---------------------------------------------------------------------------------------------------------------
    
    # Cargamos el archivo txt y guardamos como un Dataframe
    # El token de separacion es , y luego 
    dfCitas = spark.read.load(input_file_a, format='csv', sep=',', inferSchema='true', header='true')

    # Agrupamos por las patentes citadas y sumamos o contamos el numero de veces que aparece citada
    dfCitasPorCited = dfCitas.groupBy('CITED').count()
    

    # Renombramos las columnas y ordenamos por el nº de veces citadas una patente 
    # dfCitas = dfCitasPorCited.select(f.expr("CITED as NPatente"), f.expr("count as NCitas")).orderBy('ncitas', ascending = False)
    # opcion 2
    dfCitas = dfCitasPorCited.withColumnRenamed("CITED", "NPatente")\
                                 .withColumnRenamed("count", "ncitas").orderBy('ncitas', ascending = False)

    print(dfCitas.show(5))

    # Renombramos las columnas y ordenamos por el nº de patente 
    # dfCitas = dfCitasPorCited.select(f.expr("CITED as NPatente"), f.expr("count as NCitas")).orderBy('NPatente', ascending = True)
    # opcion 2
    dfCitas = dfCitasPorCited.withColumnRenamed("CITED", "NPatente")\
                                 .withColumnRenamed("count", "ncitas").orderBy('NPatente', ascending = True)

    print(dfCitas.show(5))
    
    # Imprimimos el numero de particiones del DataFrame este numero lo podemos modificar con 
    dfCitas_repartitioned = dfCitas.repartition(10)
    print("Número de particiones del dfCitas: {0}".format(dfCitas.rdd.getNumPartitions()))
    print("Número de particiones del dfCitas_repartitioned: {0}".format(dfCitas_repartitioned.rdd.getNumPartitions()))
    # Guardamos al fichero de salida usando Parquet, con compresión gzip
    dfCitas.write.format("parquet").mode("overwrite").option("compression", "gzip").save(output_path_a)

    ## Imprimimos el número de particiones del DataFrame
    #print("Número de particiones del dfInfo: {0}".format(dfInfo.rdd.getNumPartitions()))
    #
    ## El comando 'grep' filtra solo los archivos de datos (ignorando los archivos de metadatos)
    #cmd = "hdfs dfs -ls {} | grep 'part-' | wc -l".format(output_path_b)

    ## Ejecutar el comando y capturar la salida
    #try:
    #    num_files = subprocess.check_output(cmd, shell=True)
    #    print("Número de archivos:".format(num_files.decode('utf-8').strip()))
    #except subprocess.CalledProcessError as e:
    #    print("Error al ejecutar el comando:".format(e.output.decode('utf-8')))
    
    # Apartado B ---------------------------------------------------------------------------------------------------------------
    
    # En primer lugar, leemos el fichero .txt y almacenamos en un DataFrame
    dfInfo = spark.read.load(input_file_b, format='csv', sep=',', inferSchema='true', header='true', nullValue='null')
    
    # Descartamos los campos que no necesitamos
    # dfInfo = dfInfo.select(f.expr("PATENT as NPatente"), f.expr("COUNTRY as Pais"), f.expr("GYEAR as Anho")).orderBy('NPatente', ascending = True)
    # opcion 2 
    dfInfo = dfInfo.select(f.col("PATENT").alias("NPatente"), 
                           f.col("COUNTRY").alias("Pais"), 
                           f.col("GYEAR").alias("Anho")).orderBy('NPatente', ascending = True)
    
    print(dfInfo.show(5))
    
    # Guardamos al fichero de salida usando Parquet, con compresión gzip
    dfInfo.write.format("parquet").mode("overwrite").option("compression", "gzip").save(output_path_b)
    
    # Imprimimos el número de particiones del DataFrame
    print("Número de particiones del dfInfo: {0}".format(dfInfo.rdd.getNumPartitions()))
    #
    ## El comando 'grep' filtra solo los archivos de datos (ignorando los archivos de metadatos)
    #cmd = "hdfs dfs -ls {} | grep 'part-' | wc -l".format(output_path_b)

    ## Ejecutar el comando y capturar la salida
    #try:
    #    num_files = subprocess.check_output(cmd, shell=True)
    #    print("Número de archivos:".format(num_files.decode('utf-8').strip()))
    #except subprocess.CalledProcessError as e:
    #    print("Error al ejecutar el comando:".format(e.output.decode('utf-8')))
    
if __name__ == "__main__":
    main()