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
import java.sql.ResultSet;

/**
 *
 * @author avila
 */
@WebServlet("/IngresoServlet")
public class IngresoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/intcor";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "amoryamista";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fecha = request.getParameter("fecha");
        String usuario = request.getParameter("usuario");
        String nombre = request.getParameter("nombre");
        String concepto = request.getParameter("concepto");
        String monto = request.getParameter("monto");
        String firma = request.getParameter("firma");
        String codigo = request.getParameter("codigo");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Verificar el tipo de usuario (Cliente o Administrador)
            String userTypeQuery = "SELECT COUNT(*) FROM Usuario WHERE correo = ?";
            pstmt = conn.prepareStatement(userTypeQuery);
            pstmt.setString(1, usuario);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            boolean isClient = rs.getInt(1) > 0; // Asume que el correo existe

            // Insertar la información en la tabla correspondiente
            String sql = "INSERT INTO informacion (fecha, usuario, nombre, concepto, monto, firma, codigo, tipo_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fecha);
            pstmt.setString(2, usuario);
            pstmt.setString(3, nombre);
            pstmt.setString(4, concepto);
            pstmt.setDouble(5, Double.parseDouble(monto));
            pstmt.setString(6, firma);
            pstmt.setString(7, codigo);
            pstmt.setString(8, isClient ? "Cliente" : "Administrador");
            pstmt.executeUpdate();

            response.sendRedirect("exito.jsp"); // Redirige a una página de éxito

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirige a una página de error
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}

