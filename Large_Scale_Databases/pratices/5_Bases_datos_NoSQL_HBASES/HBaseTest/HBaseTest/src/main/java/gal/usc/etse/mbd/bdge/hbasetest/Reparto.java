/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gal.usc.etse.mbd.bdge.hbasetest;
import java.io.Serializable;

/**
 *
 * @author alumnogreibd
 */
public class Reparto implements Serializable {
    private int orden;
    private String personaje;
    private int idPersona;
    private String nombrePersona;
    
    public Reparto (int orden, String personaje, int idPersona, String nombrePersona){
        this.orden=orden;
        this.personaje=personaje;
        this.idPersona=idPersona;
        this.nombrePersona=nombrePersona;
    }
    
    public int getOrden(){
        return orden;
    }
    
    public String getPersonaje(){
        return personaje;
    }
    
    public int getIdPersona(){
        return idPersona;
    }
    
    public String getNombrePersona(){
        return nombrePersona;
    }
}
