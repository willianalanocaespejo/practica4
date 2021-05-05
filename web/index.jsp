<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.List"%>
<%@page import="com.emergentes.modelo.Tarea"%>
<%
    List<Tarea> lista = (List<Tarea>) request.getAttribute("lista");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>

        <h1>Listado de libros</h1>
        <p><a href="MainController?op=nuevo&id=0">Nuevo</a></p> 

        <table border="1">

            <tr>
                <th>Id</th>
                <th>Tarea</th>
                <th>Prioridad</th>
                <th>Completado</th>

                <th colspan="2" >Opciones</th>


            </tr>         


    <tr>             
                    

            <c:forEach var="item" items="${lista}">
                
                     <td>${item.id}</td>
                    <td>${item.tarea}</td>

                <c:if test="${item.prioridad == 1}" >
                    <td>Alta</td>
                </c:if>
                   

                <c:if test="${item.prioridad == 2}" >
                    <td>Media</td>
                </c:if>
                
                <c:if test="${item.prioridad == 3}" >
                    <td>Baja</td>
                </c:if>
                    
                    <c:if test="${item.completado == 1}">
                        
                    <td>
                     <input type="checkbox" id="vehicle3" name="vehicle3" value="Boat"checked>
                    </td>
                      </c:if>
                      <c:if test="${item.completado == 2}">
                        
                    <td>
                     <input type="checkbox" id="vehicle3" name="vehicle3" value="Boat">
                    </td>
                      </c:if>

                    <td><a href="MainController?op=editar&id=${item.id}">Editar</a></td>
                    <td><a href="MainController?op=eliminar&id=${item.id}" onclick="return(confirm('Esta seguro..?'))">Eliminar</a></td>
                </tr>
            </c:forEach>                  
        </table>


    </body>
</html>
