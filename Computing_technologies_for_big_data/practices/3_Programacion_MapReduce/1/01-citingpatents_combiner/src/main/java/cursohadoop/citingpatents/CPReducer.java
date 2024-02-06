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
	@Override
	public void reduce(IntWritable key, Iterable<IntWritable> values, Context context)
			throws IOException, InterruptedException {
		/*
		Un Combiner es una función que se utiliza para reducir el tráfico de red y acelerar el procesamiento en un trabajo de MapReduce. 
		Debe realizar una operación similar a la del Reducer, pero solo a nivel local en cada nodo del clúster antes de que los datos se envíen al Reducer.

		En este caso, puedes crear un Combiner que realice la misma función que el Reducer:
		tomar una patente citada y una lista de patentes citantes, ordenar la lista y concatenar 
		las patentes citantes en un solo String separado por comas.
		*/ 
		// Convierte los valores en una lista de Integers para ordenarlos numéricamente
		List<Integer> listaValores = new ArrayList<Integer>();
		for (IntWritable value : values) {
			listaValores.add(value.get());
		}
		// Ordena la lista de valores
		Collections.sort(listaValores);
		// Convierte la lista ordenada en un string separado por comas
		final String csv = StringUtils.join(listaValores, ",");

		// Escribe la salida
		context.write(key, new Text(csv));
	}
}

