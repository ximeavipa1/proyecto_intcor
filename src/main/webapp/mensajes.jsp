<%-- 
    Document   : mensajes
    Created on : 30/08/2024, 8:41:57 p. m.
    Author     : avila
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mensajes</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #2A1A72; /* Azul neón claro */
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }

        header.bg-header {
            background-color: #2A1A72; /* Azul neón claro */
            color: #FFFFFF; /* Color del texto en el encabezado */
        }

        .logo {
            height: 50px;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .dropdown-menu a {
            color: #000; /* Color de los enlaces en el menú desplegable */
        }

        .btn-outline-light {
            border-color: #FFA500; /* Naranja */
            color: #FFA500;
        }

        .btn-outline-light:hover {
            background-color: #FFA500; /* Naranja */
            color: #FFFFFF; /* Texto blanco al pasar el ratón */
        }

        .message-container {
            background-color: #FFFFFF; /* Blanco para los contenedores de mensajes */
            color: #000000; /* Texto negro para los mensajes */
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .message-header {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .message-body {
            border: 1px solid #BDC3C7; /* Borde gris claro */
            border-radius: 5px;
            padding: 10px;
            background-color: #F8F9FA; /* Gris claro */
        }

        .message-footer {
            text-align: right;
            margin-top: 10px;
        }
    </style>
    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <header class="bg-header text-white p-3">
        <div class="container header-container">
            <img src="logo.png" alt="Logo" class="logo">
            <div class="d-flex align-items-center">
                <div class="dropdown mr-3">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="profileDropdown" data-toggle="dropdown">
                        <img src="profile-icon.png" alt="Perfil" class="rounded-circle" width="40" height="40">
                    </button>
                    <div class="dropdown-menu" aria-labelledby="profileDropdown">
                        <a class="dropdown-item" href="#">Ver Perfil</a>
                        <a class="dropdown-item" href="LogoutServlet">Cerrar Sesión</a>
                    </div>
                </div>
                <div class="mr-3">
                    <a href="pantallainicio.jsp" class="btn btn-outline-light">
                        <img src="home-icon.png" alt="Inicio" width="30" height="30">
                    </a>
                </div>
                <div class="mr-3">
                    <a href="enviarMensaje.jsp" class="btn btn-outline-light">
                        <img src="mail-icon.png" alt="Enviar Mensaje" width="30" height="30">
                    </a>
                </div>
                <div class="mr-3">
                    <button class="btn btn-outline-light" onclick="window.location.href='NotificationServlet';">
                        <img src="notifications-icon.png" alt="Notificaciones" width="30" height="30">
                    </button>
                </div>
            </div>
        </div>
    </header>

    <main class="container mt-4">
        <h1>Mensajes</h1>

        <!-- Mensajes -->
        <%@ page import="java.sql.*, java.util.ArrayList" %>
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/intcor";
            String dbUser = "root";
            String dbPassword = "password";
            ArrayList<String> messages = new ArrayList<>();
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM mensajes");
                while (resultSet.next()) {
                    String subject = resultSet.getString("asunto");
                    String body = resultSet.getString("contenido");
                    messages.add(subject + "|" + body);
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <% for (String message : messages) { 
            String[] parts = message.split("\\|");
            String subject = parts[0];
            String body = parts[1];
        %>
        <div class="message-container">
            <div class="message-header"><%= subject %></div>
            <div class="message-body">
                <%= body %>
            </div>
            <div class="message-footer">
                <button class="btn btn-outline-light">Responder</button>
                <button class="btn btn-outline-light">Eliminar</button>
            </div>
        </div>
        <% } %>
    </main>
</body>
</html>


