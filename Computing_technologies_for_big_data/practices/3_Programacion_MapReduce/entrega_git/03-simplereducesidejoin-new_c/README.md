   3. (35%) Programa simplereducesidejoin: Unir datos de dos entradas usando un Reduce Side Join

                    (a) Entrada 1: Ficheros binarios de salida del programa 02-citationnumberbypatent_chained
                    (b) Entrada 2: Fichero de texto apat63_99.txt

                   Salida: Fichero de texto en el que en cada línea aparezca

         patente    país, año,n_citas

    Entre la patente y el país debe haber un tabulado, y entre el país, año y número de citas una coma (sin espacios en blanco). 
    La salida debe quedar en un único fichero de texto sin comprimir y ordenada por patente (numéricamente).

   Mappers

       Deberemos utilizar un mapper diferente para cada entrada

           (a) Mapper-a: Obtiene el número de citas por patente y etiqueta cada salida con el string "ncitas"
                      3755824    9 → 3755824    ncitas ,9

          (b) Mapper-b: Para cada patente, obtiene el país,año y etiqueta cada salida con el string "pais"
                     3755824,1973,4995,1971,"US","NY",....  → 3755824   pais, US,1973

      ''ncitas'' y ''pais'' son simples etiquetas que nos permitirán diferenciar en el reducer si el valor es un número de citas o un país. La salida de los mappers debe ser, por lo tanto, un valor Writable compuesto. 

  Reducer

      Hace un join de los dos mappers utilizando como clave el número de patente

             3755824    ncitas, 9
                                                                →   3755824   US,1973,9
             3755824    pais, US,1973

  IMPORTANTE:  Queremos hacer un outer join, por lo que en el caso de que no dispongamos de información del país para una patente debería aparecer la expresión No disponible, y un 0 en el caso de que no dispongamos de información de citas.

     Ejemplo de salida:

          ......
     3070798 No disponible,5
     3070799 No disponible,1
     3070801 BE,1963,1
     3070802 US,1963,0
     3070803 US,1963,9
     3070804 US,1963,3

          ......

   OPCIONAL:

    Reemplazar en la salida el código del país por su nombre, obtenido del fichero  country_codes.txt.

    El fichero country_codes.txt debe residir en el disco local (no en HDFS) y se debe utilizar la localización de dependencias para copiarlo a los nodos del cluster.
    Para hacer que el fichero country_codes.txt sea accesible mediante localización de dependencias, indicadlo con la opción -files al lanzar para lanzar la tarea:

    yarn jar target/simplereducesidejoin*.jar -Dmapred.job.queue.name=urgent -files path_a_country_codes.txt_en_disco_local .... 



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

#yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent patentes/cite75_99.txt patentes/apat63_99.txt out3

yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent out2_1/part-r-00000 patentes/apat63_99.txt out3


yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent out2/all patentes/apat63_99.txt out3

hdfs dfs -get out3

# opcional
module load maven

# Empaquetar el proyecto Java con Maven
mvn package

chmod 644 /home/usc/cursos/curso111/patentes/country_codes.txt

yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent -files /home/usc/cursos/curso111/patentes/country_codes.txt out2_1/part-r-00000 patentes/apat63_99.txt out4


yarn jar target/simplereducesidejoin-0.0.1-SNAPSHOT.jar -Dmapred.job.queue.name=urgent -files  /home/usc/cursos/curso111/patentes/country_codes.txt out2_1/part-r-00000 patentes/apat63_99.txt out4
hdfs dfs -get out4_5

```


