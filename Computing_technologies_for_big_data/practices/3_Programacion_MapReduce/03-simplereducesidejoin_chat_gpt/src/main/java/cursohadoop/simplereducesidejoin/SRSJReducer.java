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
		for (TaggedText value : values) {
			// Para cada valor, obtiene la etiqueta (country o cite) y el valor
			// TODO: Completa
			final String tag = value.tag.toString();
			final String value = value.value.toString();
			// Si se trata del país, ponlo en el String country, en caso contrario, en ncites
			// TODO: Completa
			if(tag.equalsIgnoreCase("country")) {
				//country += value+",";
				country += value;
			}
			else {
				ncites += value;
			}
		}
		
		// Trata los casos vacíos
		// TODO: Completa
		if(ncites.isEmpty()) {
			ncites = "0";
		}
		if(country.isEmpty()) {
			country = "No disponible,";
		}
		
		final String final_text = StringUtils.join(new String[]{country,ncites}, ",");
		// Escribe la patente y un string con el pais y el número de citas
		// TODO: Completa
		context.write(key, new Text(final_text));
	}
}



package cursohadoop.simplereducesidejoin;

// Importaciones...

public class SRSJReducer extends Reducer<IntWritable, TaggedText, IntWritable, Text> {

    public void reduce(IntWritable key, Iterable<TaggedText> values, Context context) throws IOException, InterruptedException {
        String country = "";
        String ncites = "";
        
        for (TaggedText val : values) {
            // Obtenemos la etiqueta y el valor
            final String tag = val.getTag().toString();
            final String value = val.getValue().toString();

            // Asignamos el valor a la variable correspondiente según la etiqueta
            if (tag.equalsIgnoreCase("country")) {
                country = value + ",";
            } else if (tag.equalsIgnoreCase("cite")) {
                ncites = value;
            }
        }
        
        // Tratamos los casos vacíos
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



public class SRSJReducer extends Reducer<IntWritable, TaggedText, IntWritable, Text> {

    public void reduce(IntWritable key, Iterable<TaggedText> values, Context context) throws IOException, InterruptedException {
        String country = "";
        String ncites = "";

        for (TaggedText val : values) {
            final String tag = val.getTag().toString();
            final String valueStr = val.getValue().toString();

            if (tag.equalsIgnoreCase("country")) {
                country = valueStr + ",";
            } else if (tag.equalsIgnoreCase("cite")) {
                ncites = valueStr;
            }
        }

        if (ncites.isEmpty()) {
            ncites = "0";
        }
        if (country.isEmpty()) {
            country = "No disponible,";
        }

        context.write(key, new Text(country + ncites));
    }
}
