package cursohadoop.citationnumberbypatent_chained;

/**
 *  CNBP_a - cites number by patent: Obtiene el número de citas de una patente 
 *     Combina mapper | reducer | mapper
 *     
 *  	mapper1 -> CPMapper
 *                Para cada línea, invierte las columnas (patente citada, patente que cita)
 *      reducer -> CPReducer
 *     		  Para cada línea, obtiene la clave (patente) y une en un string las patentes que la citan
 *      mapper2 -> CCMapper
 *     		  De la salida del reducer, para cada patente cuenta el número de patentes que la citan
 *      
 */

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.io.compress.GzipCodec;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.ToolRunner;
import org.apache.hadoop.mapreduce.lib.chain.ChainMapper;
import org.apache.hadoop.mapreduce.lib.chain.ChainReducer;

import cursohadoop.citingpatents.CPMapper;
import cursohadoop.citingpatents.CPReducer;

public class CNBPDriver_chained extends Configured implements Tool {
	/*
	 * (non-Javadoc)
	 * 
	 * @see org.apache.hadoop.util.Tool#run(java.lang.String[])
	 */
	@Override
	public int run(String[] arg0) throws Exception {

		/*
		 * Comprueba los parámetros de entrada  
		 */
		if (arg0.length != 2) {
			System.err.printf("Usar: %s [opciones genéricas] <directorio_entrada> <directorio_salida>%n",
					getClass().getSimpleName());
			System.err.printf("Recuerda que el directorio de salida no puede existir");
			ToolRunner.printGenericCommandUsage(System.err);
			return -1;
		}
		
		//Obtiene la configuración por defecto
		Configuration conf = getConf();	
		//TODO: Modifica el separador clave valor de entrada	
		// Modifica el parámetro para indicar que el caracter separador entre clave y valor en el fichero de entrada es una coma
		// valor en el fichero de entrada es una coma (ver más abajo)
		conf.set("mapreduce.input.keyvaluelinerecordreader.key.value.separator", ",");
				
		/* Define el job */
		Job job = Job.getInstance(conf);
		job.setJobName("Trabajo encadenado");

		/* Fija el jar del trabajo a partir de la clase del objeto actual */
		job.setJarByClass(getClass());

		// TODO: Añade al job los paths de entrada y salida */
		// Añade al job los paths de entrada y salida
		FileInputFormat.addInputPath(job, new Path(arg0[0]));
        FileOutputFormat.setOutputPath(job, new Path(arg0[1]));
		
	
		// TODO Fija el formato de los ficheros de entrada y salida 
		// Fija la compresión
		//FileOutputFormat.setCompressOutput(job, true);
		//FileOutputFormat.setOutputCompressorClass(job, GzipCodec.class);
		
		// TODO:
		// Fija el formato de los ficheros de entrada y salida 
		//   KeyValueTextInputFormat - Cada línea del fichero es un registro. El primer separador de la línea (por defecto \t)
		//                             separa la línea en clave y valor. El separador puede especificarse en la propiedad
		//                             mapreduce.input.keyvaluelinerecordreader.key.value.separator, por ejemplo, usando
		//                             conf.set("mapreduce.input.keyvaluelinerecordreader.key.value.separator", ",") antes 
		//                             de crear el job
		//                             Clave - Text; Valor - Text 
		//   TextOutputFormat - Escribe cada registro como una línea de texto. Claves y valores se escriben separadas
		//                      por \t (separador especificable mediante mapred.textoutputformat.separator)
		//

		// Fija el formato de los ficheros de entrada y salida
		job.setInputFormatClass(KeyValueTextInputFormat.class);
		//job.setOutputFormatClass(TextOutputFormat.class);
		job.setOutputFormatClass(SequenceFileOutputFormat.class);
		
		/* Con un mapp reduce de 01-citingpatents
		// TODO: Especifica el tipo de la clave y el valor de salida del mapper
		// No es necesario si los tipos son iguales a los tipos de la salida 
		// Especifica el tipo de la clave y el valor de salida del mapper
		job.setMapOutputKeyClass(IntWritable.class);
		job.setMapOutputValueClass(IntWritable.class);

		// TODO: Especifica el tipo de la clave y el valor de salida final 
		// Especifica el tipo de la clave y el valor de salida final
		job.setOutputKeyClass(IntWritable.class);
		job.setOutputValueClass(Text.class);
		
		 */
		// TODO Especifica el primer mapper
		/* El booleano (true) especifica si los datos en la cadena se pasan por valor (true) o referencia (false) */
		ChainMapper.addMapper(job, CPMapper.class, 
                              IntWritable.class, IntWritable.class, 
                              IntWritable.class, IntWritable.class, new Configuration(false));
		
		// TODO Añade el reducer */
		ChainReducer.setReducer(job, CPReducer.class, 
                                IntWritable.class, IntWritable.class,
                                IntWritable.class, Text.class, new Configuration(false));
		
		// TODO: El siguiente mapper se concatenan al reducer
		ChainReducer.addMapper(job,CCMapper.class,
							IntWritable.class, Text.class, 
							IntWritable.class, Text.class, new Configuration(false));

		// Especifica el número de reducers
		job.setNumReduceTasks(1);
		
		// Lanza el trabajo a ejecución
		return job.waitForCompletion(true) ? 0 : 1;
	}

	/**
	 * Usar yarn jar CitationNumberByPatent_chained.jar dir_entrada dir_salida
	 * 
	 * @param args
	 *            dir_entrada dir_salida
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		int exitCode = ToolRunner.run(new Configuration(), new CNBPDriver_chained(), args);
		System.exit(exitCode);
	}

}

