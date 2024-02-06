package cursohadoop.simplereducesidejoin;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
/**
 * PBCMapper -> devuelve el pais de cada patente (etiquetado)
 * 
 * @author tomas
 * 
 */
public class PBCMapper extends Mapper<LongWritable, Text, IntWritable, TaggedText> {

	/**
	 * map - para cada línea del fichero apat63_99.txt obtiene la patente, el pais y el año
	 * Crea una variable etiquetada con la etiqueta "country" como valor de salida
	 * 
	 * @param key  n de línea (no usado)
	 * @parm value línea de entrada
	 * 
	 * @see org.apache.hadoop.mapreduce.Mapper#map(KEYIN, VALUEIN, org.apache.hadoop.mapreduce.Mapper.Context)
	 */
	// Completar el mapper
	@Override
	public void map(LongWritable key, Text value, Context context) throws IOException,
			InterruptedException {
		try {
			System.out.println("Value: " + value.toString());
			// Dividimos la línea value en campos usando "," como separador
			fields = value.toString().split(",");

			// Tomamos el número de patente (campo 0) como IntWritable (para que nos los ordene numéricamente)
			// TODO: Completa
			final IntWritable patente = new IntWritable(Integer.parseInt(fields[0]));
		
			// Cogemos el campo del país (campo 4), eliminando las comillas
			// TODO: Completa
			final String country = fields[4].replaceAll("\"", "");

			// Cogemos el campo del año de concesión (campo 1)
			// TODO: Completas
			final String year = fields[1];
			
			// Unimos el país y el año (con una coma y sin espacios en blanco)
			// TODO: Completa
			final String countryYear = country + "," + year;

			// Le ponemos la etiqueta "country" al pais, creando una variable TaggedText
			// TODO: Completa 
			countryTagged.set(new Text("pais"), new Text(countryYear));
			
			// Escribimos la patente y el país etiquetado
			// TODO: Completa
			context.write(patente, countryTagged);
			
		} catch (NumberFormatException e) {
			System.err.println("Error procesando patente en PBCMapper "+fields[0]);
			context.setStatus("Error procesando patente en PBCMapper "+fields[0]);
		}	
	}
	private TaggedText countryTagged = new TaggedText();
	private String [] fields;
}
