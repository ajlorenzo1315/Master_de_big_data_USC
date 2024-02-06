/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gal.usc.etse.mbd.bdge.hbasetest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author alumnogreibd
 */
public class DAOPeliculasPgsql implements DAOPeliculas {
    Connection con;

    public DAOPeliculasPgsql(String servidor, String puerto, String baseDatos, String usuario, String clave){
        try {
            
            Properties propUsuario = new Properties();
            propUsuario.setProperty("user", usuario);
            propUsuario.setProperty("password", clave);
            this.con=DriverManager.getConnection("jdbc:postgresql://"+
                    servidor+":"+
                    puerto+"/"+
                    baseDatos,
                    propUsuario);
        } catch (SQLException ex) {
            System.out.print("Error conectando a la base de datos postgesql:"+ex.getMessage()+"\n");
        }
    }
    
    public void close(){
        try {
            con.close();
        } catch (SQLException ex) {
            System.out.print("Error desconectando de la base de datos postgesql:"+ex.getMessage()+"\n");
        }
    }

    @Override
    public List<Pelicula> getPeliculas(int num) {
       
            List<Pelicula> resultado = new ArrayList<Pelicula>();
            List<Reparto> reparto = new ArrayList<Reparto>();
            List<Personal> personal = new ArrayList<Personal>();
            
            Pelicula peliculaActual;
            PreparedStatement stmPeliculas=null;
            ResultSet rsPeliculas;
            PreparedStatement stmReparto=null;
            ResultSet rsReparto;
            PreparedStatement stmPersonal=null;
            ResultSet rsPersonal;
            
        try {
            String consultaPeliculas = "select *\n" +
                                        "from \n" +
                                        "(select id as id_pelicula,\n" +
                                        "       titulo,       \n" +
                                        "       presupuesto,\n" +
                                        "       ingresos,\n" +
                                        "       fecha_emision\n" +
                                        "from peliculas \n" +
                                        "where fecha_emision is not null \n"+
                                        "order by presupuesto desc, id\n" +
                                        "limit ?) as t\n" +
                                        //") as t\n" +
                                        "order by id_pelicula";

            stmPeliculas=con.prepareStatement(consultaPeliculas);
            stmPeliculas.setLong(1, num);
            rsPeliculas=stmPeliculas.executeQuery();
            
            while (rsPeliculas.next()){
                //Generamos el reparto
                String consultaReparto = "select  pr.orden as orden,\n" +
                                        "        pr.personaje as personaje,\n" +
                                        "        p.id as id_persona,\n" +
                                        "        p.nombre as nombre_persona\n" +
                                        "from pelicula_reparto pr, personas p \n" +
                                        "where pr.persona = p.id  and pr.pelicula = ?\n" +
                                        "order by orden";
                stmReparto=con.prepareStatement(consultaReparto);
                stmReparto.setLong(1, rsPeliculas.getLong("id_pelicula"));
                rsReparto=stmReparto.executeQuery();
                while(rsReparto.next()){
                    reparto.add(new Reparto(rsReparto.getInt("orden"),
                                            rsReparto.getString("personaje"),
                                            rsReparto.getInt("id_persona"),
                                            rsReparto.getString("nombre_persona")));
                }
                //Generamos el personal
                String consultaPersonal = "select  p.id as id_persona,\n" +
                                            "p.nombre as nombre_persona,\n" +
                                            "pp.departamento as departamento,\n" +
                                            "pp.trabajo as trabajo\n" +
                                            "from pelicula_personal pp, personas p \n" +
                                            "where pp.persona = p.id  and pp.pelicula = ?";
                stmPersonal=con.prepareStatement(consultaPersonal);
                stmPersonal.setLong(1, rsPeliculas.getLong("id_pelicula"));
                rsPersonal=stmPersonal.executeQuery();
                while(rsPersonal.next()){
                    personal.add(new Personal(rsPersonal.getInt("id_persona"),
                                            rsPersonal.getString("nombre_persona"),
                                            rsPersonal.getString("departamento"),
                                            rsPersonal.getString("trabajo")));
                }
                resultado.add(new Pelicula(rsPeliculas.getInt("id_pelicula"),
                                           rsPeliculas.getString("titulo"),
                                           rsPeliculas.getDate("fecha_emision"),
                                           rsPeliculas.getLong("ingresos"),
                                           rsPeliculas.getLong("presupuesto"),
                                           reparto.toArray(new Reparto[0]),
                                           personal.toArray(new Personal[0])));
                reparto.clear();
                personal.clear();
            }
            
            
        } catch (SQLException ex) {
            System.out.print("Error querying PostgreSQL database: "+ex.getMessage()+"\n");
        }finally {
                try {
                    stmPeliculas.close();
                } catch (SQLException ex) {
                    System.out.print("Imposible cerrar cursores: "+ex.getMessage()+"\n");
                }
        }
        return resultado;
    }
    @Override
    public void insertaPelicula(Pelicula p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    @Override
    public Pelicula getPeliculasID(int id) {
        Pelicula resultado = null;
        List<Reparto> reparto = new ArrayList<>();
        List<Personal> personal = new ArrayList<>();

        PreparedStatement stmPeliculas = null;
        ResultSet rsPeliculas;
        PreparedStatement stmReparto;
        ResultSet rsReparto;
        PreparedStatement stmPersonal;
        ResultSet rsPersonal;

        try {
            String consultaPeliculas =
                    "select *\n" +
                    "from \n" +
                    "(select id as id_pelicula,\n" +
                    "       titulo,       \n" +
                    "       presupuesto,\n" +
                    "       ingresos,\n" +
                    "       fecha_emision\n" +
                    "from peliculas \n" +
                    "where fecha_emision is not null \n" +
                    "   and id = ?\n" +
                    "order by presupuesto desc, id) as t\n" +
                    "order by id_pelicula";

            stmPeliculas = con.prepareStatement(consultaPeliculas);
            stmPeliculas.setLong(1, id);
            rsPeliculas = stmPeliculas.executeQuery();

            while (rsPeliculas.next()) {
                
                //Generamos el reparto
                String consultaReparto =
                        "select  pr.orden as orden,\n" +
                        "        pr.personaje as personaje,\n" +
                        "        p.id as id_persona,\n" +
                        "        p.nombre as nombre_persona\n" +
                        "from pelicula_reparto pr, personas p \n" +
                        "where pr.persona = p.id  and pr.pelicula = ?\n" +
                        "order by orden";

                stmReparto = con.prepareStatement(consultaReparto);
                stmReparto.setLong(1, rsPeliculas.getLong("id_pelicula"));
                rsReparto = stmReparto.executeQuery();

                while (rsReparto.next()) {
                    reparto.add(
                            new Reparto(rsReparto.getInt("orden"),
                            rsReparto.getString("personaje"),
                            rsReparto.getInt("id_persona"),
                            rsReparto.getString("nombre_persona"))
                    );
                }

                //Generamos el personal
                String consultaPersonal =
                        "select  p.id as id_persona,\n" +
                        "p.nombre as nombre_persona,\n" +
                        "pp.departamento as departamento,\n" +
                        "pp.trabajo as trabajo\n" +
                        "from pelicula_personal pp, personas p \n" +
                        "where pp.persona = p.id  and pp.pelicula = ?";

                stmPersonal = con.prepareStatement(consultaPersonal);
                stmPersonal.setLong(1, rsPeliculas.getLong("id_pelicula"));
                rsPersonal = stmPersonal.executeQuery();

                while (rsPersonal.next()) {
                    personal.add(
                            new Personal(rsPersonal.getInt("id_persona"),
                            rsPersonal.getString("nombre_persona"),
                            rsPersonal.getString("departamento"),
                            rsPersonal.getString("trabajo"))
                    );
                }

                resultado = new Pelicula(
                        rsPeliculas.getInt("id_pelicula"),
                        rsPeliculas.getString("titulo"),
                        rsPeliculas.getDate("fecha_emision"),
                        rsPeliculas.getLong("ingresos"),
                        rsPeliculas.getLong("presupuesto"),
                        reparto.toArray(new Reparto[0]),
                        personal.toArray(new Personal[0])
                );

                reparto.clear();
                personal.clear();
            }
        } catch (SQLException ex) {
            System.out.print("Error querying PostgreSQL database: " + ex.getMessage() + "\n");
        } finally {
            try {
                assert stmPeliculas != null;
                stmPeliculas.close();
            } catch (SQLException ex) {
                System.out.print("Imposible cerrar cursores: " + ex.getMessage() + "\n");
            }
        }
        return resultado;
    }

    @Override
    public Pelicula getRepartoNombre(String nombre) {
        PreparedStatement stmReparto;
        ResultSet rsReparto;
        Pelicula resultado = null;
        List<Reparto> reparto = new ArrayList<>();

        PreparedStatement stmPeliculas = null;
        ResultSet rsPeliculas;

        try {  String consultaPeliculas = "select p.id as id_pelicula, p.titulo as titulo, " +
                        "p.fecha_emision as fecha_emision , p.ingresos as ingresos , p.presupuesto as presupuesto  "+
                        "from peliculas p " +
                        "where p.titulo = ? and p.fecha_emision is not null " +
                        "order by  p.presupuesto desc, p.id";

        stmPeliculas = con.prepareStatement(consultaPeliculas);
        stmPeliculas.setString(1, nombre);
        rsPeliculas = stmPeliculas.executeQuery();

            while (rsPeliculas.next()) {
                //Generamos el reparto
                String consultaReparto =
                        "select  pr.orden as orden,\n" +
                        "        pr.personaje as personaje,\n" +
                        "        p.id as id_persona,\n" +
                        "        p.nombre as nombre_persona\n" +
                        "from pelicula_reparto pr, personas p \n" +
                        "where pr.persona = p.id  and pr.pelicula = ?\n" +
                        "order by orden";

                    stmReparto = con.prepareStatement(consultaReparto);
                    stmReparto.setLong(1, rsPeliculas.getLong("id_pelicula"));
                    rsReparto = stmReparto.executeQuery();

                    while (rsReparto.next()) {
                        reparto.add(
                                new Reparto(rsReparto.getInt("orden"),
                                rsReparto.getString("personaje"),
                                rsReparto.getInt("id_persona"),
                                rsReparto.getString("nombre_persona"))
                        );
                    }
                   
                    resultado = new Pelicula(
                        rsPeliculas.getInt("id_pelicula"),
                        rsPeliculas.getString("titulo"),
                        rsPeliculas.getDate("fecha_emision"),
                        rsPeliculas.getLong("ingresos"),
                        rsPeliculas.getLong("presupuesto"),
                        reparto.toArray(new Reparto[0]),
                        null);
                reparto.clear();
            }
            
            
        } 
        catch (SQLException ex) {
            System.out.print("Error querying PostgreSQL database: " + ex.getMessage() + "\n");
        } finally {
            try {
                assert stmPeliculas != null;
                stmPeliculas.close();
            } catch (SQLException ex) {
                System.out.print("Imposible cerrar cursores: " + ex.getMessage() + "\n");
            }
        }
        return resultado;
    }


    @Override
    public List<Pelicula> getPeliculasPresupuesto(long presupuesto) {
        List<Pelicula> resultado = new ArrayList<Pelicula>();
        PreparedStatement stmPeliculas = null;
        ResultSet rsPeliculas;

        try {  String consultaPeliculas = "select p.id as id_pelicula, p.titulo as titulo, " +
                        "p.fecha_emision as fecha_emision , p.ingresos as ingresos , p.presupuesto as presupuesto  "+
                        "from peliculas p " +
                        "where p.presupuesto > ?and p.fecha_emision is not null " +
                        "order by  p.presupuesto desc, p.id";

        stmPeliculas = con.prepareStatement(consultaPeliculas);
        stmPeliculas.setLong(1, presupuesto);
        rsPeliculas = stmPeliculas.executeQuery();

            while (rsPeliculas.next()) {
                
                   
                    resultado.add(new Pelicula(
                        rsPeliculas.getInt("id_pelicula"),
                        rsPeliculas.getString("titulo"),
                        rsPeliculas.getDate("fecha_emision"),
                        rsPeliculas.getLong("ingresos"),
                        rsPeliculas.getLong("presupuesto"),
                        null,
                        null));
                
            }
            
        } 
        catch (SQLException ex) {
            System.out.print("Error querying PostgreSQL database: " + ex.getMessage() + "\n");
        } finally {
            try {
                assert stmPeliculas != null;
                stmPeliculas.close();
            } catch (SQLException ex) {
                System.out.print("Imposible cerrar cursores: " + ex.getMessage() + "\n");
            }
        }
        return resultado;
    }
    
}

