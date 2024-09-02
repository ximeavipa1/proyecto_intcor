<%-- 
    Document   : notificaciones
    Created on : 1/09/2024, 5:24:18?p.?m.
    Author     : avila
--%>

<%@ page import="java.util.List" %>
<%@ page import="com.Servlets.intcor.Notification" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notificaciones</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #2A1A72; /* Azul neón claro */
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }

        .notification-card {
            background-color: #FFFFFF; /* Blanco para los contenedores de notificaciones */
            color: #000000; /* Texto negro para las notificaciones */
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .notification-header {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .notification-body {
            border: 1px solid #BDC3C7; /* Borde gris claro */
            border-radius: 5px;
            padding: 10px;
            background-color: #F8F9FA; /* Gris claro */
        }

        .header-buttons {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-buttons a, .header-buttons button {
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <header class="bg-header text-white p-3">
        <div class="container">
            <div class="header-buttons">
                <!-- Botón de Inicio -->
                <a href="pantallainicio.jsp" class="btn btn-outline-light">
                    <img src="home-icon.png" alt="Inicio" width="30" height="30">
                </a>

                <!-- Botón de Notificaciones -->
                <button class="btn btn-outline-light">
                    <img src="notifications-icon.png" alt="Notificaciones" width="30" height="30">
                </button>

                <!-- Perfil Dropdown -->
                <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="profileDropdown" data-toggle="dropdown">
                        <img src="profile-icon.png" alt="Perfil" class="rounded-circle" width="40" height="40">
                    </button>
                    <div class="dropdown-menu" aria-labelledby="profileDropdown">
                        <a class="dropdown-item" href="#">Ver Perfil</a>
                        <a class="dropdown-item" href="LogoutServlet">Cerrar Sesión</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main class="container mt-4">
        <h1>Notificaciones</h1>

        <!-- Notificaciones -->
        <%
            List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
            if (notifications != null && !notifications.isEmpty()) {
                for (Notification notification : notifications) {
        %>
            <div class="notification-card">
                <div class="notification-header"><%= notification.getTitle() %></div>
                <div class="notification-body"><%= notification.getMessage() %></div>
                <a href="<%= notification.getLink() %>" class="btn btn-primary">Ver Más</a>
            </div>
        <% 
                }
            } else {
        %>
            <p>No tienes notificaciones.</p>
        <% 
            }
        %>
    </main>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

