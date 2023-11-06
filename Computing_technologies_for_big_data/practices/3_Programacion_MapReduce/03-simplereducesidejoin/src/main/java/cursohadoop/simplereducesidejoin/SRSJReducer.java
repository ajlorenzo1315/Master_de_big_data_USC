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
		
		// Recorre los valores, de tipo TaggedText
		// TODO: Completa
		for(...) {
			// Para cada valor, obtiene la etiqueta (country o cite) y el valor
			// TODO: Completa
			final String tag = ...;
			final String value = ...;
			// Si se trata del país, ponlo en el String country, en caso contrario, en ncites
			// TODO: Completa
			if(tag.equalsIgnoreCase("country")) {
				country += ...+",";
			}
			else {
				ncites += ...;
			}
		}
		
		// Trata los casos vacíos
		// TODO: Completa
		if(ncites.isEmpty()) {
			ncites = ...;
		}
		if(country.isEmpty()) {
			... = "No disponible,";
		}
		
		// Escribe la patente y un string con el pais y el número de citas
		// TODO: Completa
		context.write(...);
	}
}
