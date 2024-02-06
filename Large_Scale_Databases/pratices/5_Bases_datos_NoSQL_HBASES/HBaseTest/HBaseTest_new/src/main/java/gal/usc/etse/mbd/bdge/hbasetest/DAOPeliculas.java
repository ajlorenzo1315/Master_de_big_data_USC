package gal.usc.etse.mbd.bdge.hbasetest;

import java.util.List;

/**
 * @author alumnogreibd
 */
public interface DAOPeliculas {
    List<Pelicula> getPeliculas(int num);
    Pelicula getPeliculasID(int id);
    Pelicula getRepartoNombre(String nombre);
    List<Pelicula> getPeliculasPresupuesto(long presupuesto);
    List<Pelicula> getPeliculasPersonajeTitulo(int year, int month, int orden);
    void getPeliculasDirigidas(String nombre);
    void insertaPelicula(Pelicula p);
    void close();
    //void ejercicio4();
    //void ejercicio5();
}
