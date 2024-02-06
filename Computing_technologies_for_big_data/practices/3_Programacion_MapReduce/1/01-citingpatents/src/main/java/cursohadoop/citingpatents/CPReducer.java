package cursohadoop.citingpatents;

/**
 * Reducer para CitingPatents - cites by number: Obtiene el número de citas de una patente.
 * Para cada línea, obtiene la clave (patente) y une en un string el número de patentes que la citan,
 * ordenándolas primero numéricamente.
 */
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class CPReducer extends Reducer<IntWritable, IntWritable, IntWritable, Text> {
	/**
	 * Método reduce
	 * @param key Patente citada
	 * @param values Lista con las patentes que la citan
	 * @param context Contexto MapReduce
	 * @throws IOException
	 * @throws InterruptedException
	 */
	@Override
	public void reduce(IntWritable key, Iterable<IntWritable> values, Context context)
			throws IOException, InterruptedException {

		// Convierte los valores en una lista de Integers para ordenarlos numéricamente
		
		List<Integer> listaValores = new ArrayList<Integer>();
		// Paso 1: Iteramos a través de los valores de entrada
		for (IntWritable value : values) {
			// Paso 1a: Obtenemos el valor numérico de cada entrada y lo agregamos a la lista
			listaValores.add(value.get());
		}

		// Paso 2: Ordenamos la lista de valores numéricamente
		Collections.sort(listaValores);

		// Paso 3: Convertimos la lista ordenada en una cadena separada por comas
		// Esta ya no mantiene la coma final por lo que no hay que quitarla
		final String csv = StringUtils.join(listaValores, ",");

		// Escribe la salida
		// Paso 4: Escribimos la salida
		context.write(key, new Text(csv));

		/*otra manera 
		// Creamos un StringBuilder llamado resultValues para construir la salida de valores
		StringBuilder resultValues = new StringBuilder();
		// Creamos un iterador para recorrer los valores de entrada
		Iterator<Text> it = values.iterator();

		// Paso 1: Obtenemos el primer valor y lo agregamos a resultValues
		resultValues.append(it.next().toString());

		// Paso 2: Iteramos a través del resto de valores
		while (it.hasNext()) {
			// Paso 2a: Obtenemos el siguiente valor
			// Paso 2b: Agregamos una coma para separar los valores en resultValues
			resultValues.append(",").append(it.next().toString());
		}
		// Paso 3: Escribimos la clave y la cadena resultante en el contexto
		context.write(key, new Text(resultValues.toString()));
		
		otra manera

		// Paso 1: Iteramos a través de los valores de entrada
		StringBuilder value_out = new StringBuilder();
		for (Text value : values){
			// Paso 2: Convertimos el valor actual a una cadena y lo agregamos a value_out
			value_out.append(value.toString()).append(",");
		}

		// Paso 3: Eliminamos la coma del final
		value_out.setLength(value_out.length() - 1);

		// Paso 4: Escribimos al contexto
		ctxt.write(key, new Text(value_out.toString()));
	
		*/
	}
}
