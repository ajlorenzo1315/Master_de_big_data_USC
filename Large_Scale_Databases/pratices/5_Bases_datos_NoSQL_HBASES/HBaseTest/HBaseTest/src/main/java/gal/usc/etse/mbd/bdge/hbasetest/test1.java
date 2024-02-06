/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gal.usc.etse.mbd.bdge.hbasetest;

import java.util.List;

/**
 *
 * @author alumnogreibd
 */
public class test1 {
   public static void main(String args[]){
        //testPostgresql();
        //testInsercionHBase();
        int id = 1865;
        //PSQLejercio1(id);
        //HbaseEjercio1(id);
        String nombre = "Avatar";
        //PSQLejercio2(nombre);
        //HbaseEjercio2(nombre);
        long presupuesto=250000000;
        //PSQLejercio3(presupuesto);
        HbaseEjercio3(presupuesto);
        //testImpresion();
        //testConsultaHBase();
    }
   
   private static void testPostgresql(){
       DAOPeliculas daop = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        List<Pelicula> pels = daop.getPeliculas(1000);
        for (Pelicula p:pels){
            System.out.print(p.getIdPelicula()+", "+p.getTitulo()+"\n");
        }
       daop.close();
   }
   
   private static void testInsercionHBase(){
       DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
       List<Pelicula> pels = daopsql.getPeliculas(10000);
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       for (Pelicula p:pels){
            daohbase.insertaPelicula(p);
        }
       daopsql.close();
       daohbase.close();
   }
   
   private static void testConsultaHBase(){
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       List<Pelicula> pels = daohbase.getPeliculas(1);
       ImprimirPeliculas.imprimeTodo(pels);
       daohbase.close();
   }
   
   private static void testImpresion(){
       DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
       List<Pelicula> pels = daopsql.getPeliculas(2);
       ImprimirPeliculas.imprimeTodo(pels);
       daopsql.close();
   }

   private static void PSQLejercio1(int id){
       DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        Pelicula pel = daopsql.getPeliculasID(id);
        
        // Imprimimos los datos de esta pelicula
        ImprimirPeliculas.imprime(pel);
        
        // Cerramos la conexion
        daopsql.close();
   }
    private static void HbaseEjercio1(int id){
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       Pelicula pel = daohbase.getPeliculasID(id);
       ImprimirPeliculas.imprime(pel);
       daohbase.close();
   }

    private static void PSQLejercio2(String nombre){
       DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        Pelicula pel = daopsql.getRepartoNombre(nombre);
        
        // Imprimimos los datos de esta pelicula
        ImprimirPeliculas.imprimereparto(pel);
        
        // Cerramos la conexion
        daopsql.close();
   }
    private static void HbaseEjercio2(String nombre){
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       Pelicula pel = daohbase.getRepartoNombre(nombre);
       ImprimirPeliculas.imprimereparto(pel);
       daohbase.close();
   }

    private static void PSQLejercio3(long presupuesto){
        DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        List<Pelicula> pels  = daopsql.getPeliculasPresupuesto(presupuesto);
        
        // Imprimimos los datos de esta pelicula
        ImprimirPeliculas.imprimepresupuesto(pels);
        
        // Cerramos la conexion
        daopsql.close();
   }
    private static void HbaseEjercio3(long presupuesto){
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       List<Pelicula> pels = daohbase.getPeliculasPresupuesto(presupuesto);
       ImprimirPeliculas.imprimepresupuesto(pels);
       daohbase.close();
   }

}

