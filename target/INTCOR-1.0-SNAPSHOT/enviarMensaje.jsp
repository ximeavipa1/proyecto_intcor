<%-- 
    Document   : enviarMensaje
    Created on : 1/09/2024, 5:06:05 p. m.
    Author     : avila
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enviar Mensaje</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome CSS for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

        .btn-outline-light {
            border-color: #FFA500; /* Naranja */
            color: #FFA500;
        }

        .btn-outline-light:hover {
            background-color: #FFA500; /* Naranja */
            color: #FFFFFF; /* Texto blanco al pasar el ratón */
        }

        .btn-green-neon {
            background-color: #39FF14; /* Verde neón */
            border: none;
            color: #FFFFFF;
        }

        .btn-green-neon:hover {
            background-color: #32CD32; /* Verde lima para el hover */
            color: #FFFFFF;
        }

        .form-container {
            background-color: #FFFFFF; /* Blanco para el contenedor del formulario */
            color: #000000; /* Texto negro para el formulario */
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .attachment-icon {
            color: #2A1A72; /* Color del ícono */
            cursor: pointer;
            margin-right: 10px;
        }

        .attachment-icon:hover {
            color: #FFA500; /* Color del ícono al pasar el ratón */
        }

        .file-input {
            display: none; /* Ocultar el campo de archivo */
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
                <div class="mr-3">
                    <a href="pantallainicio.jsp" class="btn btn-outline-light">
                        <img src="home-icon.png" alt="Inicio" width="30" height="30">
                    </a>
                </div>
                <div class="mr-3">
                    <a href="mensajes.jsp" class="btn btn-outline-light">
                        <img src="back-icon.png" alt="Volver" width="30" height="30">
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="container mt-4">
        <h1>Enviar Mensaje</h1>

        <div class="form-container">
            <form action="MessageServlet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="subject">Asunto</label>
                    <input type="text" class="form-control" id="subject" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="content">Contenido</label>
                    <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                </div>
                <div class="form-group">
                    <label for="attachment">
                        <i class="fas fa-paperclip attachment-icon"></i>
                        <input type="file" id="attachment" name="attachment" class="file-input">
                    </label>
                    <small class="form-text text-muted">Adjuntar archivos (imágenes, videos, etc.)</small>
                </div>
                <button type="submit" class="btn btn-green-neon">Enviar Mensaje</button>
            </form>
        </div>
    </main>

    <script>
        document.querySelector('.attachment-icon').addEventListener('click', function() {
            document.querySelector('#attachment').click();
        });
    </script>
</body>
</html>


