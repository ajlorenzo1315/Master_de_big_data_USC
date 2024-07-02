package cursohadoop.simplereducesidejoin;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

//public class CNBPTaggedMapper extends Mapper<IntWritable, Text, IntWritable, TaggedText>

public class CNBPTaggedMapper extends Mapper<IntWritable, IntWritable, IntWritable, TaggedText> {
	/**
	 * map - para cada línea de la salida de 02-citationnumberbypatent_chained, 
	 * obtiene la patente y el número de citas con la etiqueta "cite"
	 * 
	 * @param key  n de patente
	 * @parm value string con las citas de la patente separadas por coma
	 * 
	 * @see org.apache.hadoop.mapreduce.Mapper#map(KEYIN, VALUEIN,
	 * org.apache.hadoop.mapreduce.Mapper.Context)
	 */	
	// Completar el mapper
	
	@Override
	public void map(IntWritable key, IntWritable value, Context context) throws IOException, InterruptedException {
		try {
			// debug
			System.out.println("Clave recibida: " + key.getClass().getName());
			System.out.println("Valor recibido: " + value.getClass().getName());
			// La clave es el número de la patente
			// TODO: Completa
			IntWritable npatente = key;

			// El valor es el número de citas
			// TODO: Completa
			int ncites = value.get();

			// Etiquetamos el número de citas con el texto "ncitas"
			// pasando el número de citas a String
			// TODO: Completa
			nCitesTagged.set(new Text("ncitas"), new Text(String.valueOf(ncites)));

			// Escribimos en el contexto el número de patente y el número de citas etiquetado
			// TODO: Completa
			context.write(npatente, nCitesTagged);
		} catch (NumberFormatException e) {
			System.err.println("Error procesando patente en CNBPTaggedMapper " + key.toString());
			context.setStatus("Error procesando patente en CNBPTaggedMapper " + key.toString());
		}
	}

	private TaggedText nCitesTagged = new TaggedText();
}