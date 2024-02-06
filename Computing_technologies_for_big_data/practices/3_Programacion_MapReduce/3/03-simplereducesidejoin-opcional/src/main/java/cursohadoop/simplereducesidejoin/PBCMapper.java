package cursohadoop.simplereducesidejoin;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;


import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;

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
    protected void setup(Context context) throws IOException, InterruptedException {
		// Recuperar el objeto de configuración del contexto
        Configuration conf = context.getConfiguration();
		// Obtener la ruta del primer archivo en caché, que se espera sea 'country_codes.txt'
		Path ccPath = new Path(Job.getInstance(conf).getCacheFiles()[0].getPath());
		// Extraer el nombre del archivo de la ruta
		String ccFileName = ccPath.getName();
		// Llamar al método para analizar el archivo de códigos de países y cargarlo en un mapa
		parseCCFile(ccFileName);
    }

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
			final String countryName = countryCodesMap.getOrDefault(country, country); 
			// Cogemos el campo del año de concesión (campo 1)
			// TODO: Completas
			final String year = fields[1];
			
			// Unimos el país y el año (con una coma y sin espacios en blanco)
			// TODO: Completa
			final String countryYear = countryName + "," + year;

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

	// Método para leer el fichero contry_codes.txt y convertirlo en un Map Java
    private void parseCCFile(String ccFileName) {
      BufferedReader file;
      try{
		// Abrir el archivo usando un BufferedReader para una lectura eficiente
        file = new BufferedReader(new FileReader(ccFileName));
        String[] linea;

        // Leer el archivo línea por línea
        while(file.ready()) {
		  // Dividir cada línea en partes usando el carácter de tabulación como delimitador
          linea = file.readLine().split("\t");
		  // Poner las partes divididas en el countryCodesMap: 
          // linea[0] es el código del país, linea[1] es el nombre del país
          countryCodesMap.put(linea[0], linea[1]);
        }
      } catch (IOException ioe) {
		  s// Imprimir un mensaje de error si hay un problema al analizar el archivo
          System.err.println("Error parseando el fichero country_codes.txt ");
          ioe.printStackTrace();
      }
    }


	private TaggedText countryTagged = new TaggedText();
	private String [] fields;
	private Map<String, String> countryCodesMap = new HashMap<>();
}
