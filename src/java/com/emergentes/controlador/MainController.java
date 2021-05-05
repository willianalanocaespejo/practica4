package com.emergentes.controlador;

import com.emergentes.ConexionDB;
import com.emergentes.modelo.Tarea;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String op;
            op = (request.getParameter("op") != null) ? request.getParameter("op") : "list";

            ArrayList<Tarea> lista = new ArrayList<Tarea>();

            //Conexion
            ConexionDB canal = new ConexionDB();
            Connection conn = canal.conectar();
            PreparedStatement ps;
            ResultSet rs;

            if (op.equals("list")) {
                //Para listar los datos
                String sql = "select * from tareas";

                //Consulta de seleccion y almacenar en una coleccion
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Tarea tar = new Tarea();
                    tar.setId(rs.getInt("id"));
                    tar.setTarea(rs.getString("tarea"));

               
                    tar.setPrioridad(rs.getInt("prioridad"));

                    tar.setCompletado(rs.getInt("completado"));
                    lista.add(tar);
                }
                request.setAttribute("lista", lista);

                //enviar al index.jsp para mostrar la informacion
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            if (op.equals("nuevo")) {

                //instanciar un objeto de la clase libro
                Tarea ta = new Tarea();
                //el objeto se pone como atributo de request
                request.setAttribute("ta", ta);

                //redireccionar a la vista editar.jsp
                request.getRequestDispatcher("editar.jsp").forward(request, response);
            }
            if (op.equals("editar")) {
                int id = Integer.parseInt(request.getParameter("id"));

                //instanciar un onjeto de la clase libro
                String sql = "select * from tareas where id =?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Tarea tar = new Tarea();
                    tar.setId(rs.getInt("id"));
                    tar.setTarea(rs.getString("tarea"));
                    tar.setPrioridad(rs.getInt("prioridad"));
                    tar.setCompletado(rs.getInt("completado"));
                    lista.add(tar);
                }
                request.setAttribute("lista", lista);

                //redireccionar a la vista editar.jsp
                request.getRequestDispatcher("editar.jsp").forward(request, response);

            }
            if (op.equals("eliminar")) {
                //optener el id
                int id = Integer.parseInt(request.getParameter("id"));
                //realizar la eliminacion en la base de datos
                String sql = "delete from tareas where id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                ps.executeUpdate();
                //redireccionar a MainController
                response.sendRedirect("MainController");
            }

        } catch (SQLException ex) {
            System.out.println("ERROR: AL CONECTAR" + ex.getMessage());
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String tarea = request.getParameter("tarea");
            int prioridad = Integer.parseInt(request.getParameter("prioridad"));
            int completado = Integer.parseInt(request.getParameter("completado"));

            Tarea tar = new Tarea();
            tar.setId(id);
            tar.setTarea(tarea);
            tar.setPrioridad(prioridad);
            tar.setCompletado(completado);

            ConexionDB canal = new ConexionDB();

            Connection conn = canal.conectar();
            PreparedStatement ps;
            ResultSet rs;

            if (id == 0) {
                //Nuevo Registro
                String sql = "insert into tareas(tarea,prioridad,completado) values(?,?,?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, tar.getTarea());
                ps.setInt(2, tar.getPrioridad());
                ps.setInt(3, tar.getCompletado());
                ps.executeUpdate();

            } else {

                //Edicion de registro
                String sql = "UPDATE tareas SET tarea=?,prioridad=?,completado=? WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, tar.getTarea());
                ps.setInt(2, tar.getPrioridad());
                ps.setInt(3, tar.getCompletado());
                ps.setInt(4, tar.getId());
                ps.executeUpdate();

            }
            response.sendRedirect("MainController");
        } catch (SQLException ex) {
            System.out.println("Error en SQL" + ex.getMessage());
        }

    }

}
