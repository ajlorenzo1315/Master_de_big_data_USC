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
public class Personal implements Serializable {
    private int idPersona;
    private String nombrePersona;
    private String departamento;
    private String trabajo;
    
    public Personal (int idPersona, String nombrePersona, String departamento, String trabajo){
        this.idPersona=idPersona;
        this.nombrePersona=nombrePersona;
        this.departamento=departamento;
        this.trabajo=trabajo;
    }
    
    public int getIdPersona(){
     return idPersona;
    }
    
    public String getNombrePersona(){
     return nombrePersona;
    }
    
    public String getDepartamento(){
     return departamento;
    }
    
    public String getTrabajo(){
     return trabajo;
    }
    
}
