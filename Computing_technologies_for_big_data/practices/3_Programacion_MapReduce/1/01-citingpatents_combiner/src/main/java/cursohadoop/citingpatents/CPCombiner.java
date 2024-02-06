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
import java.util.Set;
import java.util.HashSet;

public class CPCombiner extends Reducer<IntWritable, IntWritable, IntWritable, IntWritable> {
	/*Este Combiner toma la patente citada (key) y un conjunto de patentes que la citan (values). 
	Utiliza un HashSet para eliminar cualquier patente citante duplicada, 
	lo que puede reducir significativamente la cantidad de datos que se transfieren al Reducer, especialmente si hay muchas repeticiones.
	El Reducer luego recibe una lista de patentes citantes únicas para cada patente citada, que procesa como antes.

	La implementación de este Combiner es tal que no altera la lógica del programa si se omite. 
	El Reducer aún recibirá la lista de todas las patentes citantes para cada patente citada, 
	ya sea que los duplicados hayan sido eliminados por el Combiner o no. Sin embargo, con el Combiner, 
	este proceso será más eficiente en términos de uso de la red y 
	posiblemente más rápido debido a la reducción del volumen de datos.*/
    @Override
    public void reduce(IntWritable key, Iterable<IntWritable> values, Context context)
            throws IOException, InterruptedException {

        // Utiliza un conjunto para eliminar duplicados y reducir la cantidad de datos
        Set<Integer> uniqueValues = new HashSet<>();
        // Agrega cada valor único al conjunto
        for (IntWritable value : values) {
            uniqueValues.add(value.get());
        }

        // Emite cada valor único
        for (Integer value : uniqueValues) {
            context.write(key, new IntWritable(value));
        }
    }
}