/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Servlets.intcor;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author avila
 */
@WebServlet(name = "InicioServlet", urlPatterns = {"/InicioServlet"})
public class InicioServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.html"); // Redirige al login si no hay sesión
            return;
        }

        String usuario = (String) session.getAttribute("usuario");
        String tipoUsuario = (String) session.getAttribute("tipoUsuario");

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html>");
            out.println("<head><title>Inicio</title></head>");
            out.println("<body>");
            out.println("<h1>Bienvenido " + usuario + "</h1>");
            out.println("<p>Tipo de Usuario: " + tipoUsuario + "</p>");
            out.println("<a href='logout'>Cerrar Sesión</a>");
            out.println("<br/><br/>");
            out.println("<div>");
            // Agrega el contenido que quieras mostrar en la pantalla de inicio aquí
            out.println("<p>Contenido de la pantalla de inicio</p>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
