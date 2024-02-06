/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gal.usc.etse.mbd.bdge.hbasetest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.NavigableMap;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.Admin;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.util.Bytes;

/**
 *
 * @author alumnogreibd
 */
public class DAOPeliculasHBase implements DAOPeliculas {
    Connection con;
    
    public DAOPeliculasHBase(){
        try {
            Configuration conf = HBaseConfiguration.create();
            this.con = ConnectionFactory.createConnection(conf);
        } catch (IOException ex) {
            System.out.print("Error conectando con HBase: "+ex.getMessage()+"\n");
        }
    }
    
    public void close(){
        try {
            con.close();
        } catch (IOException ex) {
            System.out.print("Error cerrando conexión con HBase: "+ex.getMessage()+"\n");
        }
    }

    @Override
    public List<Pelicula> getPeliculas(int num) {
        List<Pelicula> resultado = new ArrayList<Pelicula>();
        try {
            Scan scan = new Scan();
            scan.addFamily(Bytes.toBytes("info"));
            scan.addFamily(Bytes.toBytes("reparto"));
            scan.addFamily(Bytes.toBytes("personal"));
            scan.setLimit(num);
            Table pelsTable = con.getTable(TableName.valueOf("peliculas"));
            ResultScanner rs = pelsTable.getScanner(scan);
            try {
            for (Result filaPelicula = rs.next(); filaPelicula != null; filaPelicula = rs.next()) {
               NavigableMap mapReparto=filaPelicula.getFamilyMap(Bytes.toBytes("reparto"));
               Reparto[] reparto = new Reparto[mapReparto.size()];
               int i=0;
               for (Map.Entry<byte[], byte[]> elemReparto: (Set<Map.Entry>) mapReparto.entrySet()){
                 reparto[i]=(Reparto) Utils.deserialize(elemReparto.getValue());
                 i++;
               }
               NavigableMap mapPersonal=filaPelicula.getFamilyMap(Bytes.toBytes("personal"));
               Personal[] personal = new Personal[mapPersonal.size()];
               i=0;
               for (Map.Entry<byte[], byte[]> elemPersonal: (Set<Map.Entry>) mapPersonal.entrySet()){
                 personal[i]=(Personal) Utils.deserialize(elemPersonal.getValue());
                 i++;
               }
               NavigableMap mapInfo = filaPelicula.getFamilyMap(Bytes.toBytes("info"));
               resultado.add(new Pelicula(Bytes.toInt((byte[])mapInfo.get(Bytes.toBytes("id"))),
                                          Bytes.toString((byte[])mapInfo.get(Bytes.toBytes("titulo"))),
                                          new Date(Bytes.toLong((byte[])mapInfo.get(Bytes.toBytes("fechaEmision")))),
                                          Bytes.toLong((byte[])mapInfo.get(Bytes.toBytes("presupuesto"))),
                                          Bytes.toLong((byte[])mapInfo.get(Bytes.toBytes("ingresos"))),
                                          reparto, personal
                                         )
                             );
            }
            } finally {
                rs.close();  // always close the ResultScanner!
            }
            
        } catch (IOException | ClassNotFoundException ex) {
            System.out.print("Error al consultar la tabla de películas en HBase: "+ex.getMessage()+"\n");
        }
        return resultado;
    }

    @Override
    public void insertaPelicula(Pelicula p) {
        try {
            Put put = new Put(Bytes.toBytes(p.getIdPelicula()));
            put.addColumn(Bytes.toBytes("info"), Bytes.toBytes("id"), Bytes.toBytes(p.getIdPelicula()));
            put.addColumn(Bytes.toBytes("info"), Bytes.toBytes("titulo"), Bytes.toBytes(p.getTitulo()));
            put.addColumn(Bytes.toBytes("info"), Bytes.toBytes("fechaEmision"), Bytes.toBytes(p.getFechaEmsion().getTime()));
            put.addColumn(Bytes.toBytes("info"), Bytes.toBytes("presupuesto"), Bytes.toBytes(p.getPresupuesto()));
            put.addColumn(Bytes.toBytes("info"), Bytes.toBytes("ingresos"), Bytes.toBytes(p.getIngresos()));
            for(int i = 0;i<p.getTamanoReparto();i++){
                put.addColumn(Bytes.toBytes("reparto"), 
                              Bytes.toBytes(String.format("r%04d",p.getReparto(i).getOrden())), 
                              Utils.serialize(p.getReparto(i)));
            }
            for(int i = 0;i<p.getTamanoPersonal();i++){
                put.addColumn(Bytes.toBytes("personal"), 
                              Bytes.toBytes(String.format("p%04d",i)), 
                              Utils.serialize(p.getPersonal(i)));
            }
            Table pelsTable = con.getTable(TableName.valueOf("peliculas"));
            pelsTable.put(put);
        } catch (IOException ex) {
            System.out.print("Error al insertar la pelicula: "+ex.getMessage()+"\n");
        }
        
    }

    @Override
    public void getpelicula_id(int id) {
        Pelicula resultado = null; // Inicializa el resultado a null.

        try {
            Scan scan = new Scan(); // Crea un objeto Scan para buscar en la tabla de HBase.
            
            // Añade las familias de columnas a buscar.
            scan.addFamily(Bytes.toBytes("info"));
            scan.addFamily(Bytes.toBytes("reparto"));
            scan.addFamily(Bytes.toBytes("personal"));
            
            // Añade un filtro para buscar filas donde la columna "id" en "info" coincide con el id proporcionado.
            SingleColumnValueFilter filter = new SingleColumnValueFilter(
                    Bytes.toBytes("info"),
                    Bytes.toBytes("id"),
                    CompareOperator.EQUAL,
                    Bytes.toBytes(id)
            );
            scan.setFilter(filter);  
            
            // Obtiene la tabla "peliculas" para ejecutar la búsqueda.
            Table pelsTable = con.getTable(TableName.valueOf("peliculas"));

            // Ejecuta el scan y procesa los resultados.
            try (ResultScanner rs = pelsTable.getScanner(scan)) {
                for (Result filaPelicula = rs.next(); filaPelicula != null; filaPelicula = rs.next()) {
                    // Extrae el reparto de la película.
                    NavigableMap mapReparto = filaPelicula.getFamilyMap(Bytes.toBytes("reparto"));
                    Reparto[] reparto = new Reparto[mapReparto.size()];

                    int i = 0;
                    for (Map.Entry<byte[], byte[]> elemReparto : (Set<Map.Entry>) mapReparto.entrySet()) {
                        reparto[i] = (Reparto) Utils.deserialize(elemReparto.getValue());
                        i++;
                    }

                    // Extrae el personal de la película.
                    NavigableMap mapPersonal = filaPelicula.getFamilyMap(Bytes.toBytes("personal"));
                    Personal[] personal = new Personal[mapPersonal.size()];

                    i = 0;
                    for (Map.Entry<byte[], byte[]> elemPersonal : (Set<Map.Entry>) mapPersonal.entrySet()) {
                        personal[i] = (Personal) Utils.deserialize(elemPersonal.getValue());
                        i++;
                    }

                    // Extrae la información básica de la película.
                    NavigableMap mapInfo = filaPelicula.getFamilyMap(Bytes.toBytes("info"));
                    resultado = new Pelicula(
                            Bytes.toInt((byte[]) mapInfo.get(Bytes.toBytes("id"))),
                            Bytes.toString((byte[]) mapInfo.get(Bytes.toBytes("titulo"))),
                            new Date(Bytes.toLong((byte[]) mapInfo.get(Bytes.toBytes("fechaEmision")))),
                            Bytes.toLong((byte[]) mapInfo.get(Bytes.toBytes("presupuesto"))),
                            Bytes.toLong((byte[]) mapInfo.get(Bytes.toBytes("ingresos"))),
                            reparto,
                            personal
                    );
                }
            }
        } catch (IOException | ClassNotFoundException ex) {
            // Maneja excepciones relacionadas con IO y deserialización.
            System.out.print("Error al consultar la tabla de películas en HBase: " + ex.getMessage() + "\n");
        }
        return resultado; // Devuelve el resultado.

    }
}
