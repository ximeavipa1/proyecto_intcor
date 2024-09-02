<%-- 
    Document   : login
    Created on : 28/08/2024, 12:32:27 p. m.
    Author     : avila
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <style>
        body {
            background-color: #2A1A72; /* Azul rey */
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            background-color: rgba(0, 0, 255, 0.5); /* Fondo morado */
            border-radius: 10px;
        }
        input[type="text"], input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #BDC3C7;
            border-radius: 5px;
            background-color: #FFFFFF;
            color: #000000;
        }
        input[type="submit"] {
            background-color: #00BFFF; /* Azul agua marina */
            border: none;
            padding: 10px;
            color: #FFFFFF;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        .logo {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="logo.png" alt="Logo de INTCOR" style="width: 150px;">
        </div>
        <h2>Iniciar Sesión</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="usuario" placeholder="Correo electrónico" required>
            <input type="password" name="contraseña" placeholder="Contraseña" required>
            <input type="submit" value="Iniciar Sesión">
        </form>
    </div>
</body>
</html>
