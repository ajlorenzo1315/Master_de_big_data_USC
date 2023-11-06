package cursohadoop.citingpatents;

/**
 * Mapper para CitingPatents - cites by number: Obtiene el número de citas de una patente.
 * Para cada línea, invierte las columnas (patente citante, patente a la que cita)
 * conviertiéndolas primero en enteros para tener una ordenación numérica por clave
 *
 * Entrada: 
 *   Clave: Patente citante (String)
 *   Valor: Patente citada (String)
 * Salida:
 *   Clave: Patente citada (entero)
 *   Valor: Patente citante (entero)
 *
 */
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import java.io.IOException;

// TODO: Completa la clase mapper
public class CPMapper extends Mapper<Text, Text, IntWritable, IntWritable> {
	/*
	 * Método map
	 * @param key patente que cita
	 * @param value patente citada
	 * @param context Contexto MapReduce
	 * @throws IOException
	 * 
	 * @see org.apache.hadoop.mapreduce.Mapper#map(KEYIN, VALUEIN,
	 * org.apache.hadoop.mapreduce.Mapper.Context)
	 */
	// TODO: Completar el mapper
	@Override
	public void map(Text key, Text value, Context context) throws IOException, InterruptedException {
		// Convierte la clave y valor de entrada a enteros
		try {

			/*En el primer fragmento de código:

			- Las claves y valores se convierten de Text a IntWritable.
			- Las claves se invierten para que las patentes citadas se conviertan en las nuevas claves, 
			y las patentes que las citan sean los nuevos valores.*/

			 // Convertir las claves (key) y valores (value) de tipo Text a enteros
			int citing = Integer.parseInt(key.toString());
			int cited = Integer.parseInt(value.toString());
			// Invertir las claves y valores para preparar para la fase de reducción
        	// La patente citada (cited) se convierte en la nueva clave, y la patente que la cita (citing) en el nuevo valor
			// IntWritable newKey = new IntWritable(cited);
        	// IntWritable newValue = new IntWritable(citing);
			// Emitir la nueva pareja clave-valor al contexto
			context.write(new IntWritable(cited), new IntWritable(citing));

			/*otra manera de hacerlo 
			
			- Se utiliza una expresión regular (regex) para buscar patrones en la clave (key) y,
			 en caso de encontrar una coincidencia, procesar la primera fila de datos.
            - No hay inversión de claves y valores; en su lugar, 
			se reconfiguran las claves y valores para la emisión al contexto.


			// Creamos un objeto Matcher para buscar patrones en la clave (key) utilizando una expresión regular
			Matcher matcher = pat.matcher(key.toString());

			// Iniciamos un bucle para procesar las coincidencias encontradas
			while (matcher.find()) {
				// Configuramos las claves y valores de salida para emitir al contexto

				// La clave de salida (key_out) se establece como el valor original (value)
				key_out.set(value.toString());

				// El valor de salida (value_out) se establece como la clave original (key)
				value_out.set(key.toString());

				// Emitimos la pareja clave-valor al contexto emitimos dandole la vuelta
				ctxt.write(key_out, value_out);
			}
			
			otra manera  si no se pasara el texto dividido por comas en dos 

			// Dividir la línea en campos utilizando la coma como separador
			String line = value.toString();
			String[] fields = line.split(",");

			// Asegurarse de que haya al menos dos campos en la línea
			if (fields.length >= 2) {
				// Invertir los campos y emitir la patente citada como clave y la patente que la cita como valor
				context.write(new Text(fields[1].trim()), new Text(fields[0].trim()));
        	}

			otra manera es

			context.write(value, key);
			
			*/
		} catch (NumberFormatException e) {
			// Captura valores no numéricos, como la cabecera
			// Permite saltar la cabecera, que produce una excepción al pasarla a Integer.
			System.err.println("Error procesando patentes CPMapper " + value.toString() + " " + key.toString());
			context.setStatus("Error procesando patentes en CPMapper " + value.toString() + " " + key.toString());
		}
	}
}