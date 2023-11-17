1.(35%) Plantilla 01-citingpatents: programa MapReduce escrito en Java que, para cada patente de cite75_99.txt, obtenga la lista de las que la citan

    Formato salida: patente patente1,patente2... (la separación entre la clave y los valores debe ser un tabulado)
        El mapper debe obtener cada línea del fichero de entrada, separar los campos y darle la vuelta (para obtener como clave intermedia la patente citada
        y como valor intermedio la patente que la cita):
            3858245,3755824 → 3755824 3858245
        El reducer, para cada patente recibe como valor una lista de las que la citan, y tiene que convertir esa lista en un string:
            3755824 {3858245 3858247. . . } → 3755824 3858245,3858247...
        La salida debe de estar numéricamente ordenada tanto para las patentes citadas como para las citantes.
        El carácter de separación entre clave y valor en la salida debe de ser el por defecto (tabulado).
        La lista de números de patente en el campo valor de la salida debe de estar separada por comas, y no debe de haber una coma al final.
        La salida debe de guardarse en formato comprimido gzip, para lo que debéis utilizar los métodos estáticos setCompressOutput y setOutputCompressorClass de la clase FileOutputFormat.
    IMPORTANTE:
        Los ficheros de entrada no deben modificarse de ningún modo.
        La cabecera del fichero no debe aparecer en la salida
        Utilizad como formato de entrada KeyValueTextInputFormat, indicando que el formato separador de campos es una coma.
        El carácter de separación entre clave y valor en la salida debe de ser el por defecto (tabulado)
        Para compilar la práctica y generar el fichero .jar usad maven: mvn package (el fichero .jar se crea en el directorio target)
    OPCIONAL:
        Crea un Combiner (modifica los códigos si es necesario). La salida con el Combiner debe se ser igual que antes. Recuerda que el Combiner debe ser opcional (el código debe funcionar igual se se usa el Combiner o si no se usa).


    