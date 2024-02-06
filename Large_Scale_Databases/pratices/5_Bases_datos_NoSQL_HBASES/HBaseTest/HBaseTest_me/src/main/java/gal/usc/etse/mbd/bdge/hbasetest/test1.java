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
        testInsercionHBase();
        psql_ejercio_1(1856);
        hbase_ejercio_1(1856);
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

   private static void psql_ejercio_1(int id){
       DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
       List<Pelicula> pels = daopsql.getPeliculas_id(id);
       ImprimirPeliculas.imprimeTodo(pels);
       daopsql.close();
   }
    private static void hbase_ejercio_1(int id){
    DAOPeliculas daohbase = new DAOPeliculasHBase();
       List<Pelicula> pels = daohbase.getPeliculas_id(id);
       ImprimirPeliculas.imprimeTodo(pels);
       daopsql.close();
   }
}

