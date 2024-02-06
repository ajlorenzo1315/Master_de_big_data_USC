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
public class ImprimirPeliculas {
    public static void imprimeTodo(List<Pelicula> pels){
        for (Pelicula p:pels){
            System.out.print("\n");
            System.out.printf("Titulo: %s\n",p.getTitulo());
            System.out.printf("Id: %d\n",p.getIdPelicula());
            System.out.printf("Fecha Emision: %tF\n",p.getFechaEmsion());
            System.out.printf("Presupuesto: %d\n",p.getPresupuesto());
            System.out.printf("Ingresos: %d\n",p.getIngresos());
            System.out.print("Reparto(Orden, Personaje, Id, Actriz/Actor)\n");
            for (int i=0;i<p.getTamanoReparto();i++){
                System.out.printf("  %d, %s, %d, %s\n",p.getReparto(i).getOrden(),
                                                       p.getReparto(i).getPersonaje(),
                                                       p.getReparto(i).getIdPersona(),
                                                       p.getReparto(i).getNombrePersona());
            }
            System.out.print("Personal del equipo (Departamento, Trabajo, Id, Nombre)\n");
            for (int i=0;i<p.getTamanoPersonal();i++){
                System.out.printf("  %s, %s, %d, %s\n",p.getPersonal(i).getDepartamento(),
                                                       p.getPersonal(i).getTrabajo(),
                                                       p.getPersonal(i).getIdPersona(),
                                                       p.getPersonal(i).getNombrePersona());
            }
        }
    }

    public static void imprime(Pelicula pelicula){
    // Utiliza StringBuilder para construir el resultado y reducir la cantidad de operaciones de salida
    StringBuilder sb = new StringBuilder();

    //  detalles de la película
    sb.append("\n")
      .append("Titulo: ").append(pelicula.getTitulo()).append("\n")
      .append("Id: ").append(pelicula.getIdPelicula()).append("\n")
      .append("Fecha Emision: ").append(String.format("%tF", pelicula.getFechaEmsion())).append("\n")
      .append("Presupuesto: ").append(pelicula.getPresupuesto()).append("\n")
      .append("Ingresos: ").append(pelicula.getIngresos()).append("\n");

    // Añade información del reparto
    sb.append("Reparto (Orden, Personaje, Id, Actriz/Actor)\n");
    for (int i = 0; i < pelicula.getTamanoReparto(); i++) {
        Reparto miembroReparto = pelicula.getReparto(i);
        sb.append(String.format("  %d, %s, %d, %s\n",
                                miembroReparto.getOrden(),
                                miembroReparto.getPersonaje(),
                                miembroReparto.getIdPersona(),
                                miembroReparto.getNombrePersona()));
    }

    // información del personal
    sb.append("Personal (Departamento, Trabajo, Id, Nombre)\n");
    for (int i = 0; i < pelicula.getTamanoPersonal(); i++) {
        Personal miembroPersonal = pelicula.getPersonal(i);
        sb.append(String.format("  %s, %s, %d, %s\n",
                                miembroPersonal.getDepartamento(),
                                miembroPersonal.getTrabajo(),
                                miembroPersonal.getIdPersona(),
                                miembroPersonal.getNombrePersona()));
    }

    // Imprime todo el resultado de una sola vez
    System.out.print(sb.toString());
}
    
    public static void imprimereparto(Pelicula pelicula){
    // Utiliza StringBuilder para construir el resultado y reducir la cantidad de operaciones de salida
    StringBuilder sb = new StringBuilder();

    //  detalles de la película
    sb.append("\n")
      .append("Titulo: ").append(pelicula.getTitulo()).append("\n")
      .append("Id: ").append(pelicula.getIdPelicula()).append("\n")
      .append("Fecha Emision: ").append(String.format("%tF", pelicula.getFechaEmsion())).append("\n")
      .append("Presupuesto: ").append(pelicula.getPresupuesto()).append("\n")
      .append("Ingresos: ").append(pelicula.getIngresos()).append("\n");

    // Añade información del reparto
    sb.append("Reparto (Orden, Personaje, Id, Actriz/Actor)\n");
    for (int i = 0; i < pelicula.getTamanoReparto(); i++) {
        Reparto miembroReparto = pelicula.getReparto(i);
        sb.append(String.format("  %d, %s, %d, %s\n",
                                miembroReparto.getOrden(),
                                miembroReparto.getPersonaje(),
                                miembroReparto.getIdPersona(),
                                miembroReparto.getNombrePersona()));
    }

    // Imprime todo el resultado de una sola vez
    System.out.print(sb.toString());
    }
    public static void imprimepresupuesto(List<Pelicula> pels){
        for (Pelicula p:pels){
            System.out.print("\n");
            System.out.printf("Titulo: %s\n",p.getTitulo());
            System.out.printf("Id: %d\n",p.getIdPelicula());
            System.out.printf("Fecha Emision: %tF\n",p.getFechaEmsion());
            System.out.printf("Presupuesto: %d\n",p.getPresupuesto());
            System.out.printf("Ingresos: %d\n",p.getIngresos());
        }
    }


}
