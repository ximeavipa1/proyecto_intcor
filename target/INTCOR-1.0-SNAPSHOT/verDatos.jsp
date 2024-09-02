<%-- 
    Document   : verDatos
    Created on : 30/08/2024, 3:06:00 p. m.
    Author     : avila
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ver Datos Almacenados</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .btn-custom {
            border-radius: 5px;
            font-weight: bold;
        }

        .btn-primary {
            background-color: #28a745; /* Verde */
            border-color: #28a745;
        }

        .btn-primary:hover {
            background-color: #218838; /* Verde oscuro */
            border-color: #1e7e34; /* Verde más oscuro */
        }

        .btn-secondary {
            background-color: #FFA500; /* Naranja */
            border-color: #FFA500;
        }

        .btn-secondary:hover {
            background-color: #e59400; /* Naranja más oscuro */
            border-color: #e59400;
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
            margin-bottom: 20px;
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

        .title-container {
            background-color: #FFFFFF;
            color: #000000;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
        }

        .card {
            border: 2px solid #FFA500; /* Naranja */
            background-color: rgba(0, 0, 255, 0.2); /* Fondo morado claro */
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
            <div class="icon-container">
                <!-- Enlace actualizado -->
                <a href="pantallainicio.jsp">
                    <img src="home-icon.png" alt="Inicio">
                </a>
                <img src="location-icon.png" alt="Ubicación">
                <img src="messages-icon.png" alt="Mensajes">
            </div>
        </div>
    </header>

    <main class="container mt-4">
        <div class="title-container">
            <h2>Datos Almacenados</h2>
        </div>

        <form id="filterForm" action="VerDatosServlet" method="get" class="mb-4">
            <div class="form-group">
                <label for="fecha">Fecha</label>
                <input type="date" class="form-control" id="fecha" name="fecha">
            </div>
            <div class="form-group">
                <label for="categoria">Categoría</label>
                <select class="form-control" id="categoria" name="categoria">
                    <option value="">Todos</option>
                    <option value="Diezmo">Diezmo</option>
                    <option value="Ofrenda">Ofrenda</option>
                    <option value="Siembra">Siembra</option>
                    <option value="Donación">Donación</option>
                    <option value="Otros">Otros</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary btn-custom">Buscar</button>
        </form>

        <div class="chart-container">
            <canvas id="progressChart"></canvas>
        </div>

        <div class="card">
            <div class="card-body">
                <table class="table table-striped text-white">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Fecha</th>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Concepto</th>
                            <th>Monto</th>
                            <th>Firma</th>
                        </tr>
                    </thead>
                    <tbody id="data-table-body">
                        <!-- Los datos se cargarán aquí mediante JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        // Datos de ejemplo para el gráfico
        const progressData = {
            labels: ['Diezmo', 'Ofrenda', 'Siembra', 'Donación', 'Otros'],
            datasets: [{
                label: 'Progreso del Mes',
                data: [10, 20, 15, 25, 30], // Ejemplo de datos, deberías actualizarlos con datos reales
                backgroundColor: 'rgba(255, 165, 0, 0.2)', // Naranja claro
                borderColor: 'rgba(255, 165, 0, 1)', // Naranja oscuro
                borderWidth: 1
            }]
        };

        const ctx = document.getElementById('progressChart').getContext('2d');
        const progressChart = new Chart(ctx, {
            type: 'pie',
            data: progressData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.label + ': ' + tooltipItem.raw + '%';
                            }
                        }
                    }
                }
            }
        });

        // Función para cargar los datos en la tabla
        function loadTableData(data) {
            const tableBody = document.getElementById('data-table-body');
            tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar los nuevos datos

            data.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${item.id}</td>
                    <td>${item.fecha}</td>
                    <td>${item.usuario}</td>
                    <td>${item.nombre}</td>
                    <td>${item.concepto}</td>
                    <td>${item.monto}</td>
                    <td>${item.firma}</td>
                `;
                tableBody.appendChild(row);
            });
        }

        // Realizar una solicitud AJAX al servlet para obtener los datos
        function fetchData() {
            const fecha = document.getElementById('fecha').value;
            const categoria = document.getElementById('categoria').value;

            fetch(`VerDatosServlet?fecha=${fecha}&categoria=${categoria}`)
                .then(response => response.json())
                .then(data => {
                    loadTableData(data);
                })
                .catch(error => {
                    console.error('Error al obtener los datos:', error);
                });
        }

        // Configurar el evento de búsqueda
        document.getElementById('filterForm').addEventListener('submit', function (event) {
            event.preventDefault(); // Evitar el envío del formulario
            fetchData();
        });

        // Cargar datos al inicio si es necesario
        fetchData();
    </script>
</body>
</html>





