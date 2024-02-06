package cursohadoop.simplereducesidejoin;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;



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
			// La clave es el número de la patente
			// TODO: Completa
			IntWritable npatente = Integer.parseInt(key.toString());ç;
			
			// El valor es el número de citas
			// TODO: Completa
			int ncites = Integer.parseInt(value.toString());
		
			// Etiquetamos el número de citas con el texto "cite" para hacer el join
			// pasando el número de citas a String
			// TODO: Completa
			nCitesTagged.set("cite",ncites);
			
			// Escribimos en el contexto el número de patente y el número de citas etiquetado
			// TODO: Completa
			//context.write(new IntWritable(cited), new IntWritable(citing));
			context.write(new IntWritable(npatente),nCitesTagged);
		} catch (NumberFormatException e) {
			System.err.println("Error procesando patente en CNBPTaggedMapper "+key.toString());
			context.setStatus("Error procesando patente en CNBPTaggedMapper "+key.toString());
		}
	}
	private TaggedText nCitesTagged = new TaggedText();
}

public class CNBPTaggedMapper extends Mapper<IntWritable, IntWritable, IntWritable, TaggedText> {
    
    private TaggedText nCitesTagged = new TaggedText();

    @Override
    public void map(IntWritable key, IntWritable value, Context context) throws IOException, InterruptedException {
        try {
            // La clave es el número de la patente
            IntWritable npatente = key;
            
            // El valor es el número de citas
            int ncites = value;
            
            // Etiquetamos el número de citas con el texto "cite" y lo pasamos a String
            nCitesTagged.set(new Text("cite"), new Text(String.valueOf(ncites)));
            
            // Escribimos en el contexto el número de patente y el número de citas etiquetado
            context.write(npatente, nCitesTagged);
        } catch (NumberFormatException e) {
            System.err.println("Error procesando patente en CNBPTaggedMapper " + key.toString());
            context.setStatus("Error procesando patente en CNBPTaggedMapper " + key.toString());
        }
    }
}