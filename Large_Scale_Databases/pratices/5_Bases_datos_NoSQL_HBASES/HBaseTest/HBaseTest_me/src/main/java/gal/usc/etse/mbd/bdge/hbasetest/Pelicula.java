/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gal.usc.etse.mbd.bdge.hbasetest;
import java.io.Serializable;
import java.util.Date;
/**
 *
 * @author alumnogreibd
 */
public class Pelicula {
    private int idPelicula;
    private String titulo;
    private Date fechaEmision;
    private long ingresos;
    private long presupuesto;
    private Reparto[] reparto;
    private Personal[] personal;
    
    public Pelicula(int idPelicula, String titulo, Date fechaEmision, long ingresos, long presupuesto, Reparto[] reparto, Personal[] personal){
        this.idPelicula=idPelicula;
        this.titulo=titulo;
        this.fechaEmision = fechaEmision;
        this.ingresos=ingresos;
        this.presupuesto=presupuesto;
        this.reparto=reparto;
        this.personal=personal;
    }
    
    public int getIdPelicula(){
        return idPelicula;
    }
    
    public String getTitulo(){
        return titulo;
    }
    
    public Date getFechaEmsion(){
        return fechaEmision;
    }
    
    public long getIngresos(){
        return ingresos;
    }
    
    public long getPresupuesto(){
        return presupuesto;
    }
    
    public int getTamanoReparto(){
        return reparto.length;
    }
    
    public Reparto getReparto(int i){
        return reparto[i];
    }
    
    public int getTamanoPersonal(){
        return personal.length;
    }
    
    public Personal getPersonal(int i){
        return personal[i];
    }
}
