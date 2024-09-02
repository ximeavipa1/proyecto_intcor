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
 * Servlet para gestionar el envío de mensajes.
 * 
 * @author avila
 */
@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/intcor";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Implementar lógica para manejar solicitudes GET si es necesario
        // Puede ser redirigir a una página o mostrar mensajes
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "INSERT INTO mensajes (asunto, contenido) VALUES (?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, subject);
            statement.setString(2, content);
            statement.executeUpdate();
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Considera un manejo de errores más robusto
        } catch (SQLException e) {
            e.printStackTrace(); // Considera un manejo de errores más r
        }
    }
}
