package cursohadoop.simplereducesidejoin;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.SequenceFileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
/**
 * Driver para probar un Reduce Side Join simple
 * 
 * Utiliza la salida de 02-citationnumberbypatent_chained
 * y el fichero apat63_99.txt (información sobre las patentes)
 * 
 * Usa dos mappers:
 * 		CNBPTaggedMapper -> devuelve el nº de citas como un string etiquetado
 *      PBCMapper -> devuelve un string con el pais y el año de cada patente (etiquetado)
 *      
 * El reducer hace un join de la salida de los dos mappers (ordenada por patente) 
 * y devuelve:
 * 
 * 		n_patente	pais_de_la_patente,año_de_consesión,nº_de_citas
 * 
 * Si no tiene información sobre el pais/año de la patente, devuelve
 * 
 * 		n_patente	No disponible,nº_de_citas
 * 
 * Si la patente no tiene citas, devuelve
 * 
 * 		n_patente	País,año,0
 * 
 * Ejemplo de salida:
 * .............................................
 *         ....
 * 3070798 No disponible,5
 * 3070799 No disponible,1
 * 3070801 BE,1963,1
 * 3070802 US,1963,0
 * 3070803 US,1963,9
 * 3070804 US,1963,3
 *         ...
 * .............................................
 * 
 *
 */
public class SRSJDriver extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {
		/*
		 * Comprueba los parámetros de entrada  
		 */
		if (args.length != 3) {
			System.err.printf("Usar: %s [opciones genéricas] <entrada_ncitas> <entrada_info> <directorio_salida>%n",
					getClass().getSimpleName());
			System.err.printf("Recuerda que el directorio de salida no puede existir");
			ToolRunner.printGenericCommandUsage(System.err);
			return -1;
		}
		// TODO: Completa la creación del job a partir de la configuración actual
		// Creación del Job
		Job job = Job.getInstance(getConf(), "Simple Reduce Side Join");
		/* Fija el jar del trabajo a partir de la clase del objeto actual */
		//job.setJarByClass(getClass());
		job.setJarByClass(SRSJDriver.class);

		// Paths de entrada y salida
		Path entradaCitas = new Path(args[0]);
		Path entradaInfo = new Path(args[1]);
		Path salida = new Path(args[2]);

		// Como tenemos dos entradas diferentes (con dos mappers diferentes)
		// usamos MultipleInputs, indicando en path de entrada, el formato
		// de la entrada y el mapper a usar para cada una 
		// TODO: Completa
		MultipleInputs.addInputPath(job, entradaCitas, SequenceFileInputFormat.class, CNBPTaggedMapper.class);
		//MultipleInputs.addInputPath(job, entradaCitas, TextInputFormat.class, CNBPTaggedMapper.class);
		MultipleInputs.addInputPath(job, entradaInfo, TextInputFormat.class, PBCMapper.class);
		
		/* Añadimos el path de salida */
		// TODO: Completa
		// Configuración de salida
		FileOutputFormat.setOutputPath(job, salida);
		// Especifica el tipo de la clave y el valor de salida de los mappers
		// La clave intermedia es la patente (nº entero)
		// Los valores intermedios serán de tipo TaggedText
		// TODO: Completa

		//job.setInputFormatClass(TextInputFormat.class);
		//job.setOutputFormatClass(FileOutputFormat.class);

		// Tipos de clave y valor de salida de los mappers
		job.setMapOutputKeyClass(IntWritable.class);
		job.setMapOutputValueClass(TaggedText.class);

		// Tipos de clave y valor de salida final
		job.setOutputKeyClass(IntWritable.class);
		job.setOutputValueClass(Text.class);

		// Número de reducers
		job.setNumReduceTasks(1);

		// Especifica el reducer
		job.setReducerClass(SRSJReducer.class);

		// Lanza el trabajo y espera a que termine
		return job.waitForCompletion(true) ? 0 : 1;
	}
	
	/**
	 * Usar yarn jar SimpleReduceSideJoin.jar patentes_ncitas patentes_info dir_salida
	 * 
	 * @param args
	 *            patentes_citas patentes_info dir_salida
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		int exitCode = ToolRunner.run(new SRSJDriver(), args);
		System.exit(exitCode);
	}

}