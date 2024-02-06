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

# Obtener a partir de los fichero Parquet creados en la practica 1 un DataFrame que proporcione, 
# para un grupo de países especificado, las patentes ordenadas por número de citas, de mayor a menor, 
# junto con una columna que indique el rango (posición de la patente en ese país/año según las citas obtenidas.
#
# La ejecución y salida del script debe ser como sigue:
# +----+----+--------+------+-----+
# |Pais|Anho|Npatente|Ncitas|Rango|
# +----+----+--------+------+-----+
# |ES  |1963|3093080 |20    |1    |
# |ES  |1963|3099309 |19    |2    |
# |ES  |1963|3081560 |9     |3    |
# |ES  |1963|3071439 |9     |3    |
# |ES  |1963|3074559 |6     |4    |
# |ES  |1963|3114233 |5     |5    |
# |ES  |1963|3094845 |4     |6    |
# |ES  |1963|3106762 |3     |7    |
# |ES  |1963|3088009 |3     |7    |
# |ES  |1963|3087842 |2     |8    |
# |ES  |1963|3078145 |2     |8    |
# |ES  |1963|3094806 |2     |8    |
# |ES  |1963|3073124 |2     |8    |
# |ES  |1963|3112201 |2     |8    |
# |ES  |1963|3102971 |1     |9    |
# |ES  |1963|3112703 |1     |9    |
# |ES  |1963|3095297 |1     |9    |
# |ES  |1964|3129307 |11    |1    |
# |ES  |1964|3133001 |10    |2    |
# |ES  |1964|3161239 |8     |3    |
# .................................
# |FR  |1963|3111006 |35    |1    |
# |FR  |1963|3083101 |22    |2    |
# |FR  |1963|3077496 |16    |3    |
# |FR  |1963|3072512 |15    |4    |
# |FR  |1963|3090203 |15    |4    |
# |FR  |1963|3086777 |14    |5    |
# |FR  |1963|3074344 |13    |6    |
# |FR  |1963|3096621 |13    |6    |
# |FR  |1963|3089153 |13    |6    |
#
# Ejecutar en local con:
# spark-submit --master local[*] --driver-memory 4g ejercicio_4.py path_a_NCitas.parquet_en_HDFS path_a_Info.parquet_en_HDFS codigos_paises_separados_por_comas path_a_output_en_HDF
# Ejecución en un cluster YARN:
# spark-submit --master yarn --num-executors 8 --driver-memory 4g ejercicio_4.py path_a_NCitas.parquet_en_HDFS path_a_Info.parquet_en_HDFS codigos_paises_separados_por_comas path_a_output_en_HDF


def main():

    # Comprobamos que el número de argumentos es correcto
     
    if len(sys.argv) != 5:

        print("Usar: path_a_ejercicio_4.py path_a_NCitas.parquet_en_HDFS  path_a_Info.parquet_en_HDFS  codigos_paises_separados_por_comas  path_a_output_en_HDFS")
        exit(-1)
        
  
    # Input
    input_file_Ncites = sys.argv[1]
    input_file_Info = sys.argv[2]
    input_Countries = sys.argv[3].split(',')

    # Output
    output_path = sys.argv[4]
    
    
    spark = SparkSession.\
            builder.\
            appName("Ejercicio 4 AJLL").\
            getOrCreate()

    # Iniciar SparkContext
    sc =  spark.sparkContext

    # Cambiamos la verbosidad para reducir el número de mensajes por pantalla
    sc.setLogLevel("FATAL")

    Ncites = spark.read.parquet(input_file_Ncites)
    print(Ncites.show(5))
    
    Info  = spark.read.parquet(input_file_Info).withColumnRenamed("NPatente", "NPatente_Info")
    print(Info.show(5))

    result = Ncites.join(Info, Ncites.NPatente == Info.NPatente_Info, "inner")\
            .select('NPatente', 'NCitas', 'Pais', 'Anho').filter(f.col("Pais").isin(input_Countries))
    
    
    result = result.groupBy("Pais", "Anho", "NPatente")\
               .agg(f.sum("ncitas").alias("Ncitas"))
    
    print(result.show(5))

    # Definir la ventana de partición por país y año, y ordenar por ncitas de manera descendente
    windowSpec = Window.partitionBy("Pais", "Anho").orderBy(f.col("Ncitas").desc())
    # Agregar una columna "Rango" que muestre el rango de cada patente en su respectivo país y año
    result_rango = result.withColumn("Rango", f.row_number().over(windowSpec))\
               .orderBy("Pais", "Anho", "Ncitas", ascending=[True, True, False])

    print(result_rango.show(5))
    result_rango.coalesce(1).write.csv(output_path, mode='overwrite', header=True)

if __name__ == "__main__":
    main()