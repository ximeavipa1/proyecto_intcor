<%-- 
    Document   : registro
    Created on : 28/08/2024, 12:33:20 p. m.
    Author     : avila
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <style>
        body {
            background-color: #2A1A72; /* Azul neón claro */
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
        input[type="text"], input[type="email"], input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #BDC3C7;
            border-radius: 5px;
            background-color: #FFFFFF;
            color: #000000;
        }
        input[type="submit"] {
            background-color: #FFA500; /* Naranja */
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
        <h2>Registro</h2>
        <form action="RegistroServlet" method="post">
            <!-- Opción para elegir el tipo de usuario -->
            <label for="userType">Tipo de usuario:</label>
            <select name="userType" id="userType" required>
                <option value="cliente">Cliente</option>
                <option value="administrador">Administrador</option>
            </select>
            <input type="text" name="nombre" placeholder="Nombre de entidad" required>
            <input type="text" name="nit" placeholder="NIT" required>
            <input type="text" name="telefono" placeholder="Teléfono" required>
            <input type="text" name="direccion" placeholder="Dirección" required>
            <input type="email" name="email" placeholder="Correo electrónico" required>
            <input type="email" name="confirmEmail" placeholder="Confirmar correo electrónico" required>
            <input type="text" name="nombreUsuario" placeholder="Nombre de usuario" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <input type="password" name="confirmPassword" placeholder="Confirmar contraseña" required>
            <input type="submit" value="Registrar">
        </form>
    </div>
</body>
</html>
