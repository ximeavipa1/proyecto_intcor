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
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author avila
 */
@WebServlet("/MensajesServlet")
public class MensajesServlet extends HttpServlet {

    // Simulación de almacenamiento de mensajes (normalmente se usaría una base de datos)
    private List<Message> mensajes = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        // Inicialización de algunos mensajes de ejemplo
        mensajes.add(new Message(1, "Asunto del Mensaje 1", "Este es el contenido del primer mensaje. Aquí puedes agregar detalles del mensaje recibido."));
        mensajes.add(new Message(2, "Asunto del Mensaje 2", "Este es el contenido del segundo mensaje. Aquí puedes agregar detalles del mensaje recibido."));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Preparar la lista de mensajes para la vista
        request.setAttribute("mensajes", mensajes);

        // Redirigir a la página JSP que mostrará los mensajes
        request.getRequestDispatcher("/mensajes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros del formulario (debe incluir los campos necesarios para responder a un mensaje)
        String accion = request.getParameter("accion");
        int mensajeId = Integer.parseInt(request.getParameter("mensajeId"));
        String contenidoRespuesta = request.getParameter("contenidoRespuesta");

        if ("responder".equals(accion)) {
            // Buscar el mensaje correspondiente por ID (en un caso real, esto se haría con una base de datos)
            for (Message mensaje : mensajes) {
                if (mensaje.getId() == mensajeId) {
                    // Aquí se agregaría la lógica para responder al mensaje
                    mensaje.addRespuesta(contenidoRespuesta);
                    break;
                }
            }
        }

        // Redirigir de nuevo a la página de mensajes después de procesar la respuesta
        response.sendRedirect("MensajesServlet");
    }

    // Clase interna para representar un mensaje (normalmente se usaría un modelo separado)
    public static class Message {
        private int id;
        private String asunto;
        private String contenido;
        private List<String> respuestas = new ArrayList<>();

        public Message(int id, String asunto, String contenido) {
            this.id = id;
            this.asunto = asunto;
            this.contenido = contenido;
        }

        public int getId() {
            return id;
        }

        public String getAsunto() {
            return asunto;
        }

        public String getContenido() {
            return contenido;
        }

        public List<String> getRespuestas() {
            return respuestas;
        }

        public void addRespuesta(String respuesta) {
            respuestas.add(respuesta);
        }
    }
}