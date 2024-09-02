<%-- 
    Document   : ingresar
    Created on : 30/08/2024, 2:42:39 p. m.
    Author     : avila
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingreso de Información</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #2A1A72; /* Azul neón claro */
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 75%;
            margin: auto;
            padding: 20px;
            background-color: rgba(0, 0, 255, 0.5); /* Fondo morado */
            border-radius: 10px;
        }

        .form-control {
            background-color: #FFFFFF;
            color: #000000;
            border: 1px solid #FFA500; /* Naranja */
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #28a745; /* Verde */
            border-color: #28a745; /* Verde */
        }

        .btn-primary:hover {
            background-color: #218838; /* Verde oscuro */
            border-color: #1e7e34; /* Verde más oscuro */
        }

        .btn-group {
            display: flex;
            gap: 10px; /* Espacio entre los botones */
        }

        .btn-group .btn {
            flex: 1; /* Hace que los botones ocupen el mismo espacio */
            margin: 0; /* Elimina el margen adicional */
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .logo {
            height: 50px;
        }

        .icon-container {
            display: flex;
            align-items: center;
        }

        .icon-container img {
            width: 30px;
            height: 30px;
            margin-right: 15px;
        }
    </style>
    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <header class="bg-dark text-white p-3">
        <div class="container header-container">
            <img src="logo.png" alt="Logo" class="logo">
            <<div class="icon-container">
            <a href="pantallainicio.jsp">
                <img src="home-icon.png" alt="Inicio">
            </a>
                <img src="location-icon.png" alt="Ubicación">
                <img src="messages-icon.png" alt="Mensajes">
            </div>
        </div>
    </header>

    <main class="container mt-4">
        <h2 class="mb-4">Ingreso de Información</h2>
        <form action="IngresoServlet" method="post">
            <!-- Fecha -->
            <div class="form-group">
                <label for="fecha">Fecha</label>
                <input type="date" class="form-control" id="fecha" name="fecha" required>
            </div>

            <!-- Usuario -->
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" class="form-control" id="usuario" name="usuario" required>
            </div>

            <!-- Nombre de quien envía -->
            <div class="form-group">
                <label for="nombre">Nombre de quien envía</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>

            <!-- Concepto -->
            <div class="form-group">
                <label for="concepto">Concepto</label>
                <select class="form-control" id="concepto" name="concepto">
                    <option>Diezmo</option>
                    <option>Ofrenda</option>
                    <option>Siembra</option>
                    <option>Donación</option>
                    <option>Otros</option>
                </select>
            </div>

            <!-- Monto -->
            <div class="form-group">
                <label for="monto">Monto</label>
                <input type="number" class="form-control" id="monto" name="monto" step="0.01" required>
            </div>

            <!-- Firma Digital -->
            <div class="form-group">
                <label for="firma">Firma Digital</label>
                <input type="text" class="form-control" id="firma" name="firma" required>
            </div>

            <!-- Código -->
            <div class="form-group">
                <label for="codigo">Ingrese el código</label>
                <input type="text" class="form-control" id="codigo" name="codigo" required>
            </div>

            <!-- Botón Enviar -->
            <button type="submit" class="btn btn-primary">Enviar</button>
        </form>
    </main>
</body>
</html>

