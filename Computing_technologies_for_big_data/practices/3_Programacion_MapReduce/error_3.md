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



**error**

[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJDriver.java:[113,46] incompatible types: java.lang.Class<org.apache.hadoop.io.Text> cannot be converted to java.lang.Class<? extends org.apache.hadoop.mapreduce.OutputFormat>
[ERROR] /home/usc/cursos/curso111/03-simplereducesidejoin/src/main/java/cursohadoop/simplereducesidejoin/SRSJDriver.java:[127,42] cannot find symbol
[ERROR] symbol:   class TextOutputFormat
[ERROR] location: class cursohadoop.simplereducesidejoin.SRSJDriver
[ERROR] -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException


**ERROR**

Los mensajes de error en tu log de ejecución del trabajo Hadoop ofrecen información valiosa sobre por qué el trabajo está fallando. Aquí hay dos problemas principales que resaltan:

    Error de NullPointerException en PBCMapper
        En la línea PBCMapper.java:59, se está produciendo un NullPointerException. Esto suele ocurrir cuando se intenta acceder a un método o propiedad de un objeto que es null. Debes verificar esta línea en tu código PBCMapper y asegurarte de que todos los objetos que estás utilizando están inicializados correctamente antes de usarlos. Es posible que uno de los campos que estás tratando de acceder no exista o que el array fields no tenga la cantidad de elementos que esperas.

    Error de SequenceFile al Leer cite75_99.txt
        Varios errores indican que cite75_99.txt no es un SequenceFile, lo cual es requerido por SequenceFileInputFormat. Si tu archivo cite75_99.txt es un archivo de texto normal, debes cambiar el formato de entrada en tu SRSJDriver para esta entrada a TextInputFormat en lugar de SequenceFileInputFormat. Esto es importante porque debes usar un formato de entrada que coincida con el tipo de archivo que estás tratando de leer.

Soluciones Propuestas

    Corregir NullPointerException en PBCMapper:
        Revisa el código en PBCMapper.java alrededor de la línea 59. Asegúrate de que todos los objetos que estás utilizando allí estén inicializados y no sean null. Por ejemplo, si estás accediendo a un índice de un array, verifica que el array no sea null y que el índice exista.

    Cambiar el Formato de Entrada para cite75_99.txt:
        En tu clase SRSJDriver, cambia el formato de entrada para el archivo cite75_99.txt a TextInputFormat si es un archivo de texto plano.

java

MultipleInputs.addInputPath(job, entradaCitas, TextInputFormat.class, CNBPTaggedMapper.class); // Si cite75_99.txt es un archivo de texto

Haz estas correcciones y vuelve a ejecutar el trabajo. Estos cambios deberían resolver los problemas principales indicados en los logs de error.


**ERROR**

Error: java.lang.ClassCastException: org.apache.hadoop.io.Text cannot be cast to org.apache.hadoop.io.IntWritable
	at cursohadoop.simplereducesidejoin.CNBPTaggedMapper.map(CNBPTaggedMapper.java:9)
	at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:146)
	at org.apache.hadoop.mapreduce.lib.input.DelegatingMapper.run(DelegatingMapper.java:55)
	at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:799)
	at org.apache.hadoop.mapred.MapTask.run(MapTask.java:347)
	at org.apache.hadoop.mapred.YarnChild$2.run(YarnChild.java:174)
	at java.security.AccessController.doPrivileged(Native Method)
	at javax.security.auth.Subject.doAs(Subject.java:422)
	at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1731)
	at org.apache.hadoop.mapred.YarnChild.main(YarnChild.java:168)

**ERROR**

User
Error: java.lang.NullPointerException
	at cursohadoop.simplereducesidejoin.PBCMapper.map(PBCMapper.java:59)
	at cursohadoop.simplereducesidejoin.PBCMapper.map(PBCMapper.java:15)
	at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:146)
	at org.apache.hadoop.mapreduce.lib.input.DelegatingMapper.run(DelegatingMapper.java:55)
	at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:799)
	at org.apache.hadoop.mapred.MapTask.run(MapTask.java:347)
	at org.apache.hadoop.mapred.YarnChild$2.run(YarnChild.java:174)
	at java.security.AccessController.doPrivileged(Native Method)
	at javax.security.auth.Subject.doAs(Subject.java:422)
	at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1731)
	at org.apache.hadoop.mapred.YarnChild.main(YarnChild.java:168)


**SOLUTION**

change: 
final String year = fields[1];
to 
final String year = fields[1].trim();