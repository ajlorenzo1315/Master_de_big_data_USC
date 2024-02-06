#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function,division
from pyspark.sql import SparkSession
from pyspark.sql.types import StringType
import pyspark.sql.functions as f
from pyspark.sql.window import Window
import sys

#---------
import subprocess
import csv

# Obtener a partir del fichero Parquet con la información de (Npatente, Pais y Año) un DataFrame que nos muestre 
# el número de patentes asociadas a cada país por cada década (entendemos por década los años del 0 al 9, 
# es decir de 1970 a 1979 es una década). Adicionalmente, debe mostrar el aumento o disminución del número de 
# patentes para cada país y década con respecto a la década anterior.
#
# El DataFrame generado tiene que ser como este:
# +----+------+---------+----+
# |Pais|Decada|NPatentes|Dif |
# +----+------+---------+----+
# |AD  |1980  |1        |0   |
# |AD  |1990  |5        |4   |
# |AE  |1980  |7        |0   |
# |AE  |1990  |11       |4   |
# |AG  |1970  |2        |0   |
# |AG  |1990  |7        |5   |
# |AI  |1990  |1        |0   |
# |AL  |1990  |1        |0   |
# |AM  |1990  |2        |0   |
# |AN  |1970  |1        |0   |
# |AN  |1980  |2        |1   |
# |AN  |1990  |5        |3   |
# |AR  |1960  |135      |0   |
# |AR  |1970  |239      |104 |
# |AR  |1980  |184      |-55 |
# |AR  |1990  |292      |108 |
#
# Ejecutar en local con:
# spark-submit --master local[*] --driver-memory 4g ejercicio_5.py  path_a_Info.parquet_en_HDFS path_a_output_en_HDF
# Ejecución en un cluster YARN:
# spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio_5.py  path_a_Info.parquet_en_HDFS path_a_output_en_HDF
def main():

    # Comprobamos que el número de argumentos es correcto
     
    if len(sys.argv) != 3:

        print("Usar: path_a_ejercicio_5.py  path_a_Info.parquet_en_HDFS path_a_output_en_HDF")
        exit(-1)
        
  
    # Input
    input_file_Info = sys.argv[1]

    # Output
    output_path = sys.argv[2]
    
    
    spark = SparkSession.\
            builder.\
            appName("Ejercicio 5 AJLL").\
            getOrCreate()

    # Iniciar SparkContext
    sc =  spark.sparkContext

    # Cambiamos la verbosidad para reducir el número de mensajes por pantalla
    sc.setLogLevel("FATAL")

    Info  = spark.read.parquet(input_file_Info).withColumn("Decada", (f.col("Anho") / 10).cast("int") * 10)
    print(Info.show(5))

    # Agrupar por país y década y contar patentes
    Info_per_decada = Info.groupBy("Pais", "Decada").count().withColumnRenamed("count", "NPatentes")
   

    # Calcular la diferencia con la década anterior
    window = Window.partitionBy("Pais").orderBy("Decada")
    Info_dif = (Info_per_decada
            .withColumn("Dif", f.col("NPatentes") - f.lag("NPatentes").over(window)) # calculamos la diferencia
            .na.fill({"Dif": 0})  # Llenar los valores nulos con 0 (primera década para cada país)
            .orderBy("Pais", "Decada"))  # Ordenar por país y década

    print(Info_dif.show(5))
    Info_dif.coalesce(1).write.csv(output_path, mode='overwrite', header=True)

if __name__ == "__main__":
    main()