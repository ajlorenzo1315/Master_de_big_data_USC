[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJReducer.java:[30,38] variable value is already defined in method reduce(org.apache.hadoop.io.IntWritable,java.lang.Iterable<cursohadoop.simplereducesidejoin.TaggedText>,org.apache.hadoop.mapreduce.Reducer<org.apache.hadoop.io.IntWritable,cursohadoop.simplereducesidejoin.TaggedText,org.apache.hadoop.io.IntWritable,org.apache.hadoop.io.Text>.Context)
[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJReducer.java:[30,51] cannot find symbol
[ERROR] symbol:   method getValue()
[ERROR] location: variable value of type java.lang.String
[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJDriver.java:[91,42] incompatible types: java.lang.String cannot be converted to org.apache.hadoop.fs.Path
[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJDriver.java:[92,40] incompatible types: java.lang.String cannot be converted to org.apache.hadoop.fs.Path
[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJDriver.java:[93,35] incompatible types: java.lang.String cannot be converted to org.apache.hadoop.fs.Path
[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJDriver.java:[113,46] incompatible types: java.lang.Class<org.apache.hadoop.io.Text> cannot be converted to java.lang.Class<? extends org.apache.hadoop.mapreduce.OutputFormat>
[ERROR] -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException

solution:

Variable value ya definida:
En tu clase SRSJReducer, en el método reduce, tienes una variable value que se define dos veces. Una vez como parámetro del método reduce (como parte de Iterable<TaggedText> values) y otra vez dentro del bucle for (final String value = value.getValue().toString();). Necesitas cambiar el nombre de una de estas variables para evitar la confusión.
Método getValue() no encontrado:
Este error está relacionado con el anterior. Estás tratando de llamar a getValue() en una variable String, lo cual no es posible. Debes llamar a getValue() en un objeto TaggedText. Cambia el nombre de la variable dentro del bucle para solucionar esto.
Tipos incompatibles en SRSJDriver:
En tu clase SRSJDriver, estás intentando asignar String a variables que esperan objetos Path. Necesitas convertir las cadenas String de los argumentos en objetos Path. Puedes hacer esto usando new Path(args[index]).
Incompatibilidad de tipos en el método setOutputFormatClass:
En la línea job.setOutputFormatClass(Text.class);, estás intentando establecer el formato de salida como Text.class, que es un Writable, no un OutputFormat. Debes usar una clase que sea subclase de OutputFormat, como TextOutputFormat.class.