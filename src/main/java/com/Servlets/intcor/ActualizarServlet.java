/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Servlets.intcor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author avila
 */
@WebServlet(name = "ActualizarServlet", urlPatterns = {"/ActualizarServlet"})
public class ActualizarServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/intcor";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "amoryamista";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String fecha = request.getParameter("fecha");
        String usuario = request.getParameter("usuario");
        String nombre = request.getParameter("nombre");
        String concepto = request.getParameter("concepto");
        String monto = request.getParameter("monto");
        String firma = request.getParameter("firma");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Actualizar la información en la base de datos
            String sql = "UPDATE informacioncontable SET fecha = ?, usuario = ?, nombre = ?, concepto = ?, monto = ?, firma = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fecha);
            pstmt.setString(2, usuario);
            pstmt.setString(3, nombre);
            pstmt.setString(4, concepto);
            pstmt.setDouble(5, Double.parseDouble(monto));
            pstmt.setString(6, firma);
            pstmt.setString(7, id);  // Usar 'id' para identificar el registro a actualizar

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("exito.jsp"); // Redirige a una página de éxito
            } else {
                response.sendRedirect("error.jsp"); // Redirige a una página de error
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirige a una página de error
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}