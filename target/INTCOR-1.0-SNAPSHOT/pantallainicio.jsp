<%-- 
    Document   : pantallainicio
    Created on : 30/08/2024, 1:20:00 p. m.
    Author     : avila
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interfaz de Usuario</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #2A1A72; /* Azul neón claro */
            color: #FFFFFF;
            font-family: Arial, sans-serif;
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
            height: 50px;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .dropdown-menu a {
            color: #000;
        }

        .carousel-item img {
            width: 100%;
            height: auto;
        }

        .btn-secondary {
            background-color: #FFA500; /* Naranja */
            border-color: #FFA500;
        }

        .btn-outline-light {
            border-color: #FFA500;
            color: #FFA500;
        }

        .btn-outline-light:hover {
            background-color: #FFA500;
            color: #FFFFFF;
        }

        .carousel-control-prev-icon, .carousel-control-next-icon {
            background-color: #2A1A72; /* Azul neón claro */
        }

        .progress-bar {
            background-color: #FFA500; /* Naranja */
        }

        .btn-group {
            display: flex;
            gap: 10px; /* Espacio entre los botones */
        }

        .btn-group .btn {
            flex: 1; /* Hace que los botones ocupen el mismo espacio */
            margin: 0; /* Elimina el margen adicional */
        }
    </style>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <header class="bg-dark text-white p-3">
        <div class="container header-container">
            <img src="logo.png" alt="Logo" class="logo">
            <div class="d-flex align-items-center">
                <div class="dropdown mr-3">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="profileDropdown" data-toggle="dropdown">
                        <img src="profile-icon.png" alt="Perfil" class="rounded-circle" width="40" height="40">
                    </button>
                    <div class="dropdown-menu" aria-labelledby="profileDropdown">
                        <a class="dropdown-item" href="#">Ver Perfil</a>
                        <a class="dropdown-item" href="LogoutServlet">Cerrar Sesión <i class="fas fa-sign-out-alt"></i></a> <!-- Agregado -->
                    </div>
                </div>
                <div class="mr-3">
                    <button class="btn btn-outline-light">
                        <a href="mensajes.jsp">
    <img src="messages-icon.png" alt="Mensajes" width="30" height="30">
</a>
                    </button>
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
        <!-- Barra de Progreso Superior -->
        <div class="mb-4">
            <div class="progress">
                <div id="progressBar" class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
            </div>
        </div>

        <!-- Carrusel de Imágenes Contables -->
        <div id="accountingCarousel" class="carousel slide mb-4" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#accountingCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#accountingCarousel" data-slide-to="1"></li>
                <li data-target="#accountingCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="image1.jpg" class="d-block w-100" alt="Imagen Contable 1">
                </div>
                <div class="carousel-item">
                    <img src="image2.jpg" class="d-block w-100" alt="Imagen Contable 2">
                </div>
                <div class="carousel-item">
                    <img src="image3.jpg" class="d-block w-100" alt="Imagen Contable 3">
                </div>
            </div>
            <a class="carousel-control-prev" href="#accountingCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#accountingCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <div class="row">
            <div class="col-md-4">
                <!-- Buscador -->
                <div class="mb-3">
                    <input type="text" class="form-control" id="searchInput" placeholder="Buscar usuarios o información contable">
                </div>

                <!-- Barra de Progreso -->
                <div class="progress mb-3">
                    <div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">50%</div>
                </div>

                <!-- Gráficos -->
                <canvas id="monthlyChart"></canvas>
                <canvas id="yearlyChart"></canvas>
            </div>
            <div class="col-md-8">
                <!-- Botones -->
                <div class="btn-group mb-4">
                    <!-- Enlace agregado para los botones -->
                    <a href="actualizar.jsp" class="btn btn-secondary">Actualizar</a>
                    <a href="ingresar.jsp" class="btn btn-secondary">Ingresar</a>
                    <!-- Botón para ir a Ver Datos -->
                    <a href="verDatos.jsp" class="btn btn-secondary">Ver Datos</a>
                </div>

                <!-- Código QR -->
                <div class="text-center">
                    <img src="qr-code.png" alt="Código QR">
                    <p>Compartir código QR</p>
                </div>
            </div>
        </div>
    </main>

    <script>
        const ctxMonthly = document.getElementById('monthlyChart').getContext('2d');
        const ctxYearly = document.getElementById('yearlyChart').getContext('2d');

        // Datos de ejemplo
        const monthlyData = [10, 20, 30, 40, 50]; // Datos mensuales
        const yearlyData = [100, 200, 300]; // Datos anuales

        const monthlyLabels = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'];
        const yearlyLabels = ['2022', '2023', '2024'];

        const monthlyChart = new Chart(ctxMonthly, {
            type: 'bar',
            data: {
                labels: monthlyLabels,
                datasets: [{
                    label: 'Datos Mensuales',
                    data: monthlyData,
                    backgroundColor: 'rgba(255, 165, 0, 0.2)', // Naranja claro
                    borderColor: 'rgba(255, 165, 0, 1)', // Naranja oscuro
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        ticks: {
                            color: 'rgba(255, 165, 0, 1)' // Naranja
                        }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: 'rgba(255, 165, 0, 1)' // Naranja
                        }
                    }
                },
                elements: {
                    line: {
                        borderColor: 'rgba(255, 165, 0, 1)' // Naranja
                    },
                    point: {
                        borderColor: 'rgba(255, 165, 0, 1)' // Naranja
                    }
                }
            }
        });

        const yearlyChart = new Chart(ctxYearly, {
            type: 'bar',
            data: {
                labels: yearlyLabels,
                datasets: [{
                    label: 'Datos Anuales',
                    data: yearlyData,
                    backgroundColor: 'rgba(255, 165, 0, 0.2)', // Naranja claro
                    borderColor: 'rgba(255, 165, 0, 1)', // Naranja oscuro
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        ticks: {
                            color: 'rgba(255, 165, 0, 1)' // Naranja
                        }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: 'rgba(255, 165, 0, 1)' // Naranja
                        }
                    }
                },
                elements: {
                    line: {
                        borderColor: 'rgba(255, 165, 0, 1)' // Naranja
                    },
                    point: {
                        borderColor: 'rgba(255, 165, 0, 1)' // Naranja
                    }
                },
                onClick: function(e) {
                    const activePoints = yearlyChart.getElementsAtEventForMode(e, 'nearest', { intersect: true }, true);

                    if (activePoints.length) {
                        const yearIndex = activePoints[0].index;
                        const yearData = yearlyData[yearIndex];
                        const yearLabel = yearlyLabels[yearIndex];
                        
                        // Actualizar la barra de progreso
                        const totalYearlyData = yearlyData.reduce((acc, val) => acc + val, 0);
                        const percentage = (yearData / totalYearlyData) * 100;
                        
                        document.getElementById('progressBar').style.width = `${percentage}%`;
                        document.getElementById('progressBar').innerText = `${percentage.toFixed(2)}%`;

                        // Actualizar el gráfico mensual
                        monthlyChart.data.datasets[0].data = monthlyData; // Aquí puedes actualizar con datos reales
                        monthlyChart.update();
                    }
                }
            }
        });
    </script>
</body>
</html>






