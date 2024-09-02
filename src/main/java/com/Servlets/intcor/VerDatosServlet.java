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
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/VerDatosServlet")
public class VerDatosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/intcor?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "amoryamista";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fecha = request.getParameter("fecha");
        String categoria = request.getParameter("categoria");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        List<DataItem> dataItems = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM informacioncontable WHERE 1=1";

            if (fecha != null && !fecha.isEmpty()) {
                query += " AND fecha = ?";
            }
            if (categoria != null && !categoria.isEmpty()) {
                query += " AND tipo_usuario = ?";
            }

            try (PreparedStatement statement = connection.prepareStatement(query)) {
                int parameterIndex = 1;

                if (fecha != null && !fecha.isEmpty()) {
                    statement.setString(parameterIndex++, fecha);
                }
                if (categoria != null && !categoria.isEmpty()) {
                    statement.setString(parameterIndex++, categoria);
                }

                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        DataItem item = new DataItem(
                                resultSet.getInt("id"),
                                resultSet.getDate("fecha").toString(),
                                resultSet.getString("usuario"),
                                resultSet.getString("nombre"),
                                resultSet.getString("concepto"),
                                resultSet.getDouble("monto"),
                                resultSet.getString("firma")
                        );
                        dataItems.add(item);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Error al obtener los datos.\"}");
            return;
        }

        Gson gson = new Gson();
        String json = gson.toJson(dataItems);
        out.write(json);
    }

    private static class DataItem {
        private int id;
        private String fecha;
        private String usuario;
        private String nombre;
        private String concepto;
        private double monto;
        private String firma;

        public DataItem(int id, String fecha, String usuario, String nombre, String concepto, double monto, String firma) {
            this.id = id;
            this.fecha = fecha;
            this.usuario = usuario;
            this.nombre = nombre;
            this.concepto = concepto;
            this.monto = monto;
            this.firma = firma;
        }
    }
}
