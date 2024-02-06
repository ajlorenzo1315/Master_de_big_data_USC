scp -r  curso$curso@hadoop3.cesga.es:~

scp -r ./Temas-5-6-Spark-Flink/ curso111@hadoop3.cesga.es:~

Los notebooks están en el directorio notebook y los datos en datos

Una vez iniciado el contenedor, accedemos al notebook a través de http://localhost:8080 (si no carga espera unos minutos y/o borra la cache del navegador)

El interfaz web de Spark está en http://localhost:4040

para la entrega hay que cargar en hdfs los archivos  esto se hace en la practica 3_MapReduce

```bash
hdfs dfs -put cite75_99.txt /user/curso111/path_a_cite75_99.txt_en_HDFS
```