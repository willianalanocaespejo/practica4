<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.emergentes.modelo.Tarea"%>
<%
    Tarea ta = (Tarea) request.getAttribute("ta");
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

        <%            int id = Integer.parseInt(request.getParameter("id"));
            if (id != 0) {

        %>

        <h1>Editar Tarea</h1>


        <form action="MainController" method="post">
            <table>

                <c:forEach var="item" items="${lista}">
                    <tr> 
                        <td>
                            Id de Tarea 
                        </td>
                        <td>
                            <input type="number" name="id" value="${item.id}" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td>Tarea</td>
                        <td><input type="text" name="tarea" value="${item.tarea}"> </td>
                    </tr>
                    <tr>
                        <td>Prioridad</td>
                        <td>
                            <select name="prioridad" id="">
                                <option value="">--Seleccione la Prioridad--</option>
                                <option value="1">1 - Alta</option>
                                <option value="2">2 - Media</option>
                                <option value="3">3 - Baja</option>   
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Completado</td>
                       
                        <td>
                            <input type="checkbox" name="completado" value="1">
                        </td>
                          <td>Pendiente</td>
                        <td>
                            <input type="checkbox" name="completado" value="2">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Enviar"></td>
                    </tr>
                </c:forEach>
            </table>

        </form>

        <%        } else {
        %>    


        <h1>Nueva Tarea</h1>                
        <form action="MainController" method="post">
            <table>              
                <input type="hidden" name="id" value="${ta.id}">
                <tr>
                    <td>Tarea</td>
                    <td><input type="text" name="tarea" value="${ta.tarea}"> </td>
                </tr>

                <tr>
                    <td>Prioridad</td>
                  <!--  <td><input type="text" name="prioridad" value="${ta.prioridad}"> </td> -->



                    <td>
                        <select name="prioridad" id="">
                            <option value="">--Seleccione la Prioridad--</option>
                            <option value="1">Alta</option>
                            <option value="2">Media</option>
                            <option value="3">Baja</option>   
                        </select>
                    </td> 
                </tr>


                <tr>
                     <td>Completado</td>
                       
                        <td>
                            <input type="checkbox" name="completado" value="1">
                        </td>
                          <td>Pendiente</td>
                        <td>
                            <input type="checkbox" name="completado" value="2">
                        </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Enviar"></td>
                </tr>

            </table>

        </form>
        <%
            }
        %>

    </body>
</html>
