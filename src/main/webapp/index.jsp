<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CuraSys - Login Selection</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- AOS CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <!-- Icons (Bootstrap Icons) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f3f7ff;
        }

        .login-card {
            transition: transform 0.3s;
            cursor: pointer;
        }

        .login-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .card-icon {
            font-size: 50px;
            color: #0d6efd;
            margin-bottom: 15px;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="container py-5">
        <h1 class="text-center mb-5" data-aos="fade-down">Welcome to CuraSys</h1>
        <p class="text-center text-secondary mb-4" data-aos="fade-down" data-aos-delay="100">
            Select your login type to continue
        </p>

        <div class="row g-4 justify-content-center">

            <!-- Admin Login -->
            <div class="col-md-4 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                <div class="card login-card text-center p-4" onclick="location.href='login.jsp?role=admin'">
                    <i class="bi bi-shield-lock card-icon"></i>
                    <h5 class="card-title">Admin Login</h5>
                </div>
            </div>

            <!-- Patient Login -->
            <div class="col-md-4 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                <div class="card login-card text-center p-4" onclick="location.href='login.jsp?role=patient'">
                    <i class="bi bi-person-heart card-icon"></i>
                    <h5 class="card-title">Patient Login</h5>
                </div>
            </div>

            <!-- Doctor Login -->
            <div class="col-md-4 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                <div class="card login-card text-center p-4" onclick="location.href='login.jsp?role=doctor'">
                    <i class="bi bi-person-badge card-icon"></i>
                    <h5 class="card-title">Doctor Login</h5>
                </div>
            </div>

            <!-- Ambulance Login -->
            <div class="col-md-4 col-lg-3" data-aos="fade-up" data-aos-delay="400">
                <div class="card login-card text-center p-4" onclick="location.href='login.jsp?role=ambulance'">
                    <i class="bi bi-truck card-icon"></i>
                    <h5 class="card-title">Ambulance Login</h5>
                </div>
            </div>

            <!-- Pharmacy Login -->
            <div class="col-md-4 col-lg-3" data-aos="fade-up" data-aos-delay="500">
                <div class="card login-card text-center p-4" onclick="location.href='login.jsp?role=pharmacy'">
                    <i class="bi bi-bag-heart card-icon"></i>
                    <h5 class="card-title">Pharmacy Login</h5>
                </div>
            </div>

        </div>
    </div>

    <!-- AOS JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script>AOS.init({ duration: 1200 });</script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
