/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Servlets.intcor;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * Servlet para gestionar el envío de mensajes.
 * 
 * @author avila
 */
@WebServlet(name = "EnviarMensajeeServlet", urlPatterns = {"/EnviarMensajeeServlet"})
@MultipartConfig
public class EnviarMensajeeServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/intcor";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Insertar el mensaje en la base de datos
            String sql = "INSERT INTO mensajes (asunto, contenido) VALUES (?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, subject);
            statement.setString(2, content);
            statement.executeUpdate();

            // Manejar la carga de archivos si existen
            Part filePart = request.getPart("attachment");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String filePath = getServletContext().getRealPath("/") + "uploads/" + fileName;
                File file = new File(filePath);
                file.getParentFile().mkdirs();
                filePart.write(filePath);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Considera un manejo de errores más robusto
        } catch (SQLException e) {
            e.printStackTrace(); // Considera un manejo de errores más robusto
        } finally {
            // Asegurarse de cerrar recursos en el bloque finally
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        response.sendRedirect("pantallainicio.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para enviar mensajes y manejar archivos adjuntos";
    }
}
