### Ejercio_1
```bash
spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio_1.py patentes_new/cite75_99.txt patentes_new/apat63_99.txt out_practica_4/Ejercicio_1/NCitas.parquet out_practica_4/Ejercicio_1/Info.parquet

+--------+------+
|NPatente|ncitas|
+--------+------+
|       1|     2|
|      13|     2|
|      24|     1|
|      29|     1|
|      44|     1|
+--------+------+
only showing top 5 rows

None
Número de particiones del dfCitas: 200
Número de particiones del dfCitas_repartitioned: 10
+--------+----+----+
|NPatente|Pais|Anho|
+--------+----+----+
| 3070801|  BE|1963|
| 3070802|  US|1963|
| 3070803|  US|1963|
| 3070804|  US|1963|
| 3070805|  US|1963|
+--------+----+----+
only showing top 5 rows

None
Número de particiones del dfInfo: 200

```

### Ejercio_2
```bash
spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio_2.py out_practica_4/Ejercicio_1/NCitas.parquet out_practica_4/Ejercicio_1/Info.parquet /home/usc/cursos/curso111/patentes_new/country_codes.txt out_practica_4/Ejercicio_2
+--------+------+
|NPatente|ncitas|
+--------+------+
| 4629572|    37|
| 4629573|     1|
| 4629574|     2|
| 4629575|    19|
| 4629576|    11|
+--------+------+
only showing top 5 rows

None
+-------------+----+----+
|NPatente_Info|Pais|Anho|
+-------------+----+----+
|      5047548|  GB|1991|
|      5047549|  US|1991|
|      5047550|  US|1991|
|      5047551|  DE|1991|
|      5047552|  US|1991|
+-------------+----+----+
only showing top 5 rows

None
+--------+------+----+----+
|NPatente|NCitas|Pais|Anho|
+--------+------+----+----+
| 4629572|    37|  US|1986|
| 4629573|     1|  US|1986|
| 4629574|     2|  DE|1986|
| 4629575|    19|  US|1986|
| 4629576|    11|  US|1986|
+--------+------+----+----+
only showing top 5 rows

None
+----+----+-----------+----------+----------+--------+
|Pais|Anho|NumPatentes|TotalCitas|MediaCitas|MaxCitas|
+----+----+-----------+----------+----------+--------+
|  AD|1987|          1|         3|       3.0|       3|
|  AD|1993|          1|         1|       1.0|       1|
|  AD|1998|          1|         1|       1.0|       1|
|  AE|1984|          1|         5|       5.0|       5|
|  AE|1985|          1|        14|      14.0|      14|
+----+----+-----------+----------+----------+--------+
only showing top 5 rows

None
+--------------------+----+-----------+----------+----------+--------+
|                Pais|Anho|NumPatentes|TotalCitas|MediaCitas|MaxCitas|
+--------------------+----+-----------+----------+----------+--------+
|             Andorra|1987|          1|         3|       3.0|       3|
|             Andorra|1993|          1|         1|       1.0|       1|
|             Andorra|1998|          1|         1|       1.0|       1|
|United Arab Emirates|1984|          1|         5|       5.0|       5|
|United Arab Emirates|1985|          1|        14|      14.0|      14|
+--------------------+----+-----------+----------+----------+--------+
only showing top 5 rows

None
+-------+----+-----------+----------+----------+--------+
|   Pais|Anho|NumPatentes|TotalCitas|MediaCitas|MaxCitas|
+-------+----+-----------+----------+----------+--------+
|Algeria|1963|          2|         7|       3.5|       4|
|Algeria|1968|          1|         2|       2.0|       2|
|Algeria|1970|          1|         2|       2.0|       2|
|Algeria|1972|          1|         1|       1.0|       1|
|Algeria|1977|          1|         2|       2.0|       2|
+-------+----+-----------+----------+----------+--------+
only showing top 5 rows

None

```


### Ejercio_3
```bash
hdfs dfs -rm -r hdfs://nameservice1/user/curso111/out_practica_4/Ejercicio_3
spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio_3.py patentes_new/apat63_99.txt out_practica_4/Ejercicio_3

[(u'AD', [(u'1987', 1), (u'1993', 1), (u'1995', 1), (u'1998', 2), (u'1999', 1)]), (u'AE', [(u'1984', 2), (u'1985', 2), (u'1987', 1), (u'1989', 2), (u'1990', 1), (u'1991', 2), (u'1992', 1), (u'1993', 1), (u'1994', 1), (u'1996', 1), (u'1998', 1), (u'1999', 3)]), (u'AG', [(u'1978', 1), (u'1979', 1), (u'1991', 1), (u'1994', 1), (u'1995', 2), (u'1996', 2), (u'1999', 1)]), (u'AI', [(u'1998', 1)]), (u'AL', [(u'1999', 1)]), (u'AM', [(u'1995', 1), (u'1999', 1)]), (u'AN', [(u'1979', 1), (u'1980', 1), (u'1989', 1), (u'1991', 2), (u'1995', 1), (u'1997', 1), (u'1998', 1)]), (u'AR', [(u'1963', 19), (u'1964', 27), (u'1965', 18), (u'1966', 20), (u'1967', 16), (u'1968', 18), (u'1969', 17), (u'1970', 23), (u'1971', 22), (u'1972', 29), (u'1973', 28), (u'1974', 24), (u'1975', 24), (u'1976', 24), (u'1977', 20), (u'1978', 21), (u'1979', 24), (u'1980', 18), (u'1981', 25), (u'1982', 18), (u'1983', 21), (u'1984', 20), (u'1985', 11), (u'1986', 17), (u'1987', 18), (u'1988', 16), (u'1989', 20), (u'1990', 17), (u'1991', 16), (u'1992', 20), (u'1993', 24), (u'1994', 32), (u'1995', 31), (u'1996', 30), (u'1997', 35), (u'1998', 43), (u'1999', 44)]), (u'AT', [(u'1963', 86), (u'1964', 91), (u'1965', 143), (u'1966', 128), (u'1967', 151), (u'1968', 160), (u'1969', 191), (u'1970', 189), (u'1971', 251), (u'1972', 271), (u'1973', 237), (u'1974', 294), (u'1975', 310), (u'1976', 296), (u'1977', 243), (u'1978', 274), (u'1979', 223), (u'1980', 267), (u'1981', 279), (u'1982', 229), (u'1983', 267), (u'1984', 256), (u'1985', 318), (u'1986', 357), (u'1987', 345), (u'1988', 337), (u'1989', 402), (u'1990', 393), (u'1991', 359), (u'1992', 371), (u'1993', 312), (u'1994', 289), (u'1995', 337), (u'1996', 362), (u'1997', 376), (u'1998', 387), (u'1999', 479)]), (u'AU', [(u'1963', 69), (u'1964', 81), (u'1965', 110), (u'1966', 111), (u'1967', 151), (u'1968', 119), (u'1969', 155), (u'1970', 144), (u'1971', 201), (u'1972', 183), (u'1973', 202), (u'1974', 234), (u'1975', 248), (u'1976', 261), (u'1977', 243), (u'1978', 281), (u'1979', 211), (u'1980', 265), (u'1981', 318), (u'1982', 266), (u'1983', 237), (u'1984', 292), (u'1985', 340), (u'1986', 374), (u'1987', 389), (u'1988', 416), (u'1989', 501), (u'1990', 432), (u'1991', 463), (u'1992', 409), (u'1993', 378), (u'1994', 467), (u'1995', 459), (u'1996', 471), (u'1997', 478), (u'1998', 720), (u'1999', 707)])]

```
### Ejercio_4

```bash
hdfs dfs -rm -r hdfs://nameservice1/user/curso111/out_practica_4/Ejercicio_3
spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio_4.py out_practica_4/Ejercicio_1/NCitas.parquet out_practica_4/Ejercicio_1/Info.parquet  FR,ES out_practica_4/Ejercicio_4

+--------+------+
|NPatente|ncitas|
+--------+------+
| 4629572|    37|
| 4629573|     1|
| 4629574|     2|
| 4629575|    19|
| 4629576|    11|
+--------+------+
only showing top 5 rows

None
+-------------+----+----+
|NPatente_Info|Pais|Anho|
+-------------+----+----+
|      5047548|  GB|1991|
|      5047549|  US|1991|
|      5047550|  US|1991|
|      5047551|  DE|1991|
|      5047552|  US|1991|
+-------------+----+----+
only showing top 5 rows

None
+----+----+--------+------+
|Pais|Anho|NPatente|Ncitas|
+----+----+--------+------+
|  FR|1975| 3920378|     2|
|  FR|1975| 3923266|     1|
|  FR|1975| 3923895|     9|
|  FR|1975| 3927122|     6|
|  FR|1976| 3931735|     9|
+----+----+--------+------+
only showing top 5 rows

None
+----+----+--------+------+-----+
|Pais|Anho|NPatente|Ncitas|Rango|
+----+----+--------+------+-----+
|  ES|1963| 3093080|    20|    1|
|  ES|1963| 3099309|    19|    2|
|  ES|1963| 3071439|     9|    4|
|  ES|1963| 3081560|     9|    3|
|  ES|1963| 3074559|     6|    5|
+----+----+--------+------+-----+
only showing top 5 rows

None

```

### Ejercio_5

```bash

spark-submit --master yarn --num-executors 8 --driver-memory 4g --queue urgent ejercicio_5.py  out_practica_4/Ejercicio_1/Info.parquet  out_practica_4/Ejercicio_5
+--------+----+----+------+
|NPatente|Pais|Anho|Decada|
+--------+----+----+------+
| 5047548|  GB|1991|  1990|
| 5047549|  US|1991|  1990|
| 5047550|  US|1991|  1990|
| 5047551|  DE|1991|  1990|
| 5047552|  US|1991|  1990|
+--------+----+----+------+
only showing top 5 rows

None
+----+------+---------+---+
|Pais|Decada|NPatentes|Dif|
+----+------+---------+---+
|  AD|  1980|        1|  0|
|  AD|  1990|        5|  4|
|  AE|  1980|        7|  0|
|  AE|  1990|       11|  4|
|  AG|  1970|        2|  0|
+----+------+---------+---+
only showing top 5 rows

None
```
```bash
#consiguir resultados
hdfs dfs -get /user/curso111/out_practica_4 /home/usc/cursos/curso111/entrega
# subir archivos de patentes
hdfs dfs -put /home/usc/cursos/curso111/patentes_new /user/curso111/patentes_new 
```