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

# Script que, a partir del fichero apat63_99.txt obtener el número de patentes por país y año usando RDDs (no uséis DataFrames).
# 1. El RDD obtenido debe ser un RDD clave/valor, en el cual la clave es un país y el valor una lista de tuplas, en la que cada tupla 
#    esté formada por un año y el número de patentes de ese país en ese año.
# 2. Adicionalmente, el RDD creado debe estar ordenado por el código del país y, para cada país, la lista de valores ordenados por año.
#
# Ejemplo de par clave/valor de salida:
# (u'PA', [(u'1963', 2), (u'1964', 2), (u'1965', 1), (u'1966', 1), (u'1970', 1), (u'1971', 1), (u'1972', 6), (u'1974', 3)])
#
# Ejecutar en local con:
# spark-submit --master local[*] --driver-memory 4g path_a_ejercicio_3.py_en_local path_a_apat63_99.txt_en_HDFS path_a_ejercicio_3_output_en_HDFS
# Ejecución en un cluster YARN:
# spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent path_a_ejercicio_3.py_en_local path_a_apat63_99.txt_en_HDFS path_a_ejercicio_3_output_en_HDFS particiones


def main():

    # Comprobamos que el número de argumentos es correcto
     
    if len(sys.argv) != 3 and len(sys.argv) != 4  :

        print("Usar: ejercicio_3.py path_a_apat63_99.txt_en_HDFS path_a_ejercicio_3_output_en_HDFS particiones")
        exit(-1)
        
    elif len(sys.argv) == 3:
        particiones=8
    else:
        particiones=sys.argv[3]
    input_path = sys.argv[1]
    output_path = sys.argv[2]
    
    spark = SparkSession.\
            builder.\
            appName("Ejercicio 3 AJLL").\
            getOrCreate()

    # Iniciar SparkContext
    sc =  spark.sparkContext

    # Cambiamos la verbosidad para reducir el número de mensajes por pantalla
    sc.setLogLevel("FATAL")

    # Leer el archivo en un RDD con 8 particiones
    lines = sc.textFile(input_path, particiones)
    

    # Procesar el RDD
    
    country_year_count = (lines
                          # Primero, para cada línea en el RDD, elimina las comillas dobles y divide la línea en campos separados por comas.
                          .map(lambda line: line.replace('"', '').split(","))

                          # Luego, transforma cada línea en un par clave/valor. La clave es el país (índice 4) y el valor es el año (índice 1).
                          .map(lambda elements: (elements[4], elements[1]))  # (Country, Year)

                          # A continuación, mapea cada par clave/valor (Country, Year) a ((Country, Year), 1) para preparar el recuento.
                          .map(lambda country_year: (country_year, 1))  # ((Country, Year), 1)

                          # Utiliza reduceByKey para sumar los conteos por cada clave (Country, Year), resultando en ((Country, Year), Count).
                          .reduceByKey(lambda a, b: a + b)  # ((Country, Year), Count)

                          # Luego, mapea cada entrada a un nuevo par clave/valor. La clave es el país y el valor es una tupla (Año, Conteo).
                          .map(lambda country_year_count: (country_year_count[0][0], (country_year_count[0][1], country_year_count[1])))  # (Country, (Year, Count))

                          # Agrupa todos los valores (tuplas de año y conteo) por cada país.
                          .groupByKey()

                          # Convierte cada grupo de valores en una lista.
                          .mapValues(list)

                          # Ordena cada lista de valores (tuplas de año y conteo) por año.
                          .mapValues(lambda years: sorted(years, key=lambda x: x[0]))
                          # Ordenar por país
                          .sortByKey()
                          )


    print(country_year_count.take(10))

    # Guardar el RDD en formato de texto
    country_year_count.saveAsTextFile(output_path)

    sc.stop()

if __name__ == "__main__":
    main()