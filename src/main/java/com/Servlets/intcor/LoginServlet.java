/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Servlets.intcor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/intcor";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "amoryamista";

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String usuario = request.getParameter("usuario");
    String contraseña = request.getParameter("contraseña");

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

        // Verificar si el usuario es un Cliente
        String sqlCliente = "SELECT * FROM Cliente WHERE correo = ? AND contraseña = ?";
        pstmt = conn.prepareStatement(sqlCliente);
        pstmt.setString(1, usuario);
        pstmt.setString(2, contraseña);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Usuario encontrado como Cliente
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("tipoUsuario", "Cliente");
            response.sendRedirect("InicioServlet");
        } else {
            // Intentar con Administrador
            String sqlAdmin = "SELECT * FROM Administrador WHERE correo = ? AND contraseña = ?";
            pstmt = conn.prepareStatement(sqlAdmin);
            pstmt.setString(1, usuario);
            pstmt.setString(2, contraseña);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Usuario encontrado como Administrador
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setAttribute("tipoUsuario", "Administrador");
                response.sendRedirect("InicioServlet");
            } else {
                // Usuario no encontrado
                out.println("<html><body>Error en la autenticación. Usuario o contraseña incorrectos.</body></html>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<html><body>Error en la conexión a la base de datos: " + e.getMessage() + "</body></html>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
}
}
