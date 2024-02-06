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
}
