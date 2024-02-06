package cursohadoop.simplereducesidejoin;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class SRSJReducer extends Reducer<IntWritable, TaggedText, IntWritable, Text> {
	/**
	 * Método reduce
	 * @param key Patente
	 * @param values Lista que contiene la patente y el número de citas o la patente y el país,año
	 * @param context Contexto MapReduce
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public void reduce(IntWritable key, Iterable<TaggedText> values, Context context) throws IOException, InterruptedException {
		String country = "";
		String ncites = "";

		for (TaggedText val : values) {
			// Obtiene la etiqueta y el valor
			final String tag = val.getTag().toString();
			final String value = val.getValue().toString();

			// Según la etiqueta, asigna los valores correspondientes
			if (tag.equalsIgnoreCase("country")) {
				country = value + ",";
			} else if (tag.equalsIgnoreCase("ncitas")) {
				ncites = value;
			}
		}

		// Trata los casos vacíos
		if (ncites.isEmpty()) {
			ncites = "0";
		}
		if (country.isEmpty()) {
			country = "No disponible,";
		}

		// Escribe la patente y un string con el país y el número de citas
		context.write(key, new Text(country + ncites));
	}
}
