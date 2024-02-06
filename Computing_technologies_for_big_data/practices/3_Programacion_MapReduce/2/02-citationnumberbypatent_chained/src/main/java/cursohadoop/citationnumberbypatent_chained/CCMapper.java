package cursohadoop.citationnumberbypatent_chained;

/**
 * Mapper Count Cites 
 * Para cada línea, obtiene la clave (patente) y cuenta el número de patentes que la citan
 */
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.commons.lang.StringUtils;

// TODO: Completa la clase Mapper
public class CCMapper extends  Mapper<IntWritable, Text ,IntWritable, Text>  {
	// TODO: Completar el mapper
	@Override
	public void map(IntWritable key, Text numbers, Context context)
			throws IOException, InterruptedException {
	

	String[] numberArray = numbers.toString().split(",");  // Divide la cadena en cada coma

    /*  manera arcaica 
		int sum = 0;
        for (String numberStr : numberArray) {
            try {
                int number = Integer.parseInt(numberStr);  // Convierte el string a un entero
                sum += number;  // Suma el número al total
            } catch (NumberFormatException e) {
                System.out.println(numberStr + " no es un número válido.");
            }
        }
	// Escribe la salida
	context.write(key, new Text(sum));	
	*/
	  
    int count = numberArray.length; // Cuenta el número de elementos en el array mas optimo

    // Escribe la salida
    context.write(key, new Text(String.valueOf(count)));
	

	}
	
	
}
