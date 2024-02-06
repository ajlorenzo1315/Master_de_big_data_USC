package gal.usc.etse.mbd.bdge.hbasetest;

import java.util.List;

/**
 * @author alumnogreibd
 */
public class test1 {
    public static void main(String[] args) {
        // testPostgresql();
        // testInsercionHBase();
        // testImpresion();
        // testConsultaHBase();
        
        //testPostgresql();
        //testInsercionHBase();
        int id = 1865;
        //PSQLejercio1(id);
        //HbaseEjercio1(id);
        String nombre = "Avatar";
        //PSQLejercio2(nombre);
        //HbaseEjercio2(nombre);
        //long presupuesto=250000000;
        //PSQLejercio3(presupuesto);
        //HbaseEjercio3(presupuesto);
        int year = 2015;
        int month = 1;
        int orden = 0;
        //PSQLejercio4(year,month,orden);
        //HbaseEjercio4(year,month,orden);
        String director = "Ridley Scott";
        //PSQLejercio5(director);
        HbaseEjercio5(director);
        //testImpresion();
        //testConsultaHBase();
    }

    private static void testPostgresql() {
        DAOPeliculas daop = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        List<Pelicula> pels = daop.getPeliculas(1000);
        pels.forEach(p -> {
            System.out.print(p.getIdPelicula() + ", " + p.getTitulo() + "\n");
        });
        daop.close();
    }

    private static void testInsercionHBase() {
        DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        List<Pelicula> pels = daopsql.getPeliculas(45433);
        DAOPeliculas daohbase = new DAOPeliculasHBase();

        pels.forEach(p -> {
            daohbase.insertaPelicula(p);
        });

        daopsql.close();
        daohbase.close();
    }

    private static void testConsultaHBase() {
        DAOPeliculas daohbase = new DAOPeliculasHBase();
        List<Pelicula> pels = daohbase.getPeliculas(2);
        ImprimirPeliculas.imprimeTodo(pels);
        daohbase.close();
    }

    private static void testImpresion() {
        DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        List<Pelicula> pels = daopsql.getPeliculas(1);
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


    private static void PSQLejercio4(int year, int month, int orden){
        DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        List<Pelicula> pels  = daopsql.getPeliculasPersonajeTitulo(year,month,orden);
        
        // Imprimimos los datos de esta pelicula
        ImprimirPeliculas.imprimeInforeparto(pels);
        
        // Cerramos la conexion
        daopsql.close();
   }
    private static void HbaseEjercio4(int year, int month, int orden){
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       List<Pelicula> pels = daohbase.getPeliculasPersonajeTitulo(year,month,orden);
       ImprimirPeliculas.imprimeInforeparto(pels);
       daohbase.close();
   }

    private static void PSQLejercio5(String nombre){
        DAOPeliculas daopsql = new DAOPeliculasPgsql("localhost", "5432", "bdge", "alumnogreibd", "greibd2021");
        daopsql.getPeliculasDirigidas(nombre);
        
        // Imprimimos los datos de esta pelicula
       
        
        // Cerramos la conexion
        daopsql.close();
   }
    private static void HbaseEjercio5(String nombre){
       DAOPeliculas daohbase = new DAOPeliculasHBase();
       daohbase.getPeliculasDirigidas(nombre);
       
       daohbase.close();
   }
}

