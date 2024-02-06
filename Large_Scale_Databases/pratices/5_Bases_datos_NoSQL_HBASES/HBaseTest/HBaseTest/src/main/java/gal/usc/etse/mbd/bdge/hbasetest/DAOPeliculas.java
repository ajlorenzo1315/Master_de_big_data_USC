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
public interface DAOPeliculas {
    List<Pelicula> getPeliculas(int num);
    void insertaPelicula(Pelicula p);
    void close();
    Pelicula getPeliculasID(int id);
    Pelicula getRepartoNombre(String nombre);
    List<Pelicula> getPeliculasPresupuesto(long presupuesto);
}
