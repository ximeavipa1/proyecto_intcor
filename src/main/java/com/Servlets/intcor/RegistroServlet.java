/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Servlets.intcor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/intcor";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "amoryamista";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Obtener parámetros del formulario
        String nit = request.getParameter("nit");
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String confirmEmail = request.getParameter("confirmEmail");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String userType = request.getParameter("userType");

        // Validar entradas
        if (email == null || confirmEmail == null) {
            out.println("<html><body>Los correos electrónicos no pueden ser nulos.</body></html>");
            return;
        }

        if (!email.equals(confirmEmail)) {
            out.println("<html><body>Los correos electrónicos no coinciden.</body></html>");
            return;
        }

        if (password == null || confirmPassword == null) {
            out.println("<html><body>Las contraseñas no pueden ser nulas.</body></html>");
            return;
        }

        if (!password.equals(confirmPassword)) {
            out.println("<html><body>Las contraseñas no coinciden.</body></html>");
            return;
        }

        String hashedPassword = hashPassword(password);

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Registrar el driver JDBC para MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO cliente (nombre, nit, telefono, correo, contrasena, tipo_usuario) VALUES (?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, nit);
            pstmt.setString(3, telefono);
            pstmt.setString(4, email);
            pstmt.setString(5, hashedPassword);
            pstmt.setString(6, userType);
            pstmt.executeUpdate();

            // Configurar sesión y redirigir
            HttpSession session = request.getSession();
            session.setAttribute("usuario", nombre);
            session.setAttribute("tipoUsuario", userType);
            response.sendRedirect("InicioServlet");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<html><body>Error al cargar el controlador de la base de datos.</body></html>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<html><body>Error al registrar el usuario: " + e.getMessage() + "</body></html>");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al cifrar la contraseña", e);
        }
    }
}
