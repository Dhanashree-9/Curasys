<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to CuraSys</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- AOS CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        body {
            background: #f3f7ff;
            scroll-behavior: smooth;
        }

        /* NAVBAR */
        .navbar-brand {
            font-weight: 700;
            font-size: 26px;
            color: #0d6efd !important;
        }

        .nav-link {
            font-weight: 500;
            margin-right: 12px;
            color: #333 !important;
        }

        .nav-link:hover {
            color: #0d6efd !important;
        }

        /* HERO SECTION */
        .hero {
            position: relative;
            padding: 80px 0;
        }

        .hero-img {
            width: 100%;
            max-width: 500px;
            filter: drop-shadow(0px 8px 20px rgba(0,0,0,0.15));
        }

        .btn-started {
            background: #0d6efd;
            padding: 12px 28px;
            font-weight: 600;
            border-radius: 50px;
            transition: .3s;
        }

        .btn-started:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(13,110,253,0.3);
        }

        @media (max-width: 992px) {
            .hero-text {
                text-align: center;
            }
            .hero-img {
                margin-top: 30px;
            }
        }

        /* SERVICE CARDS */
        .service-card {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: .3s;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .service-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        /* ABOUT */
        #about {
            position: relative;
            background: url('images/aboutus.jpg') no-repeat center center;
            background-size: cover;
            padding: 100px 20px;
            color: white;
            text-align: center;
        }

        #about::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(0,0,0,0.55);
            z-index: 1;
        }

        #about .about-content {
            position: relative;
            z-index: 2;
            max-width: 700px;
            margin: auto;
        }
#contact .form-control {
    border-radius: 12px;
    box-shadow: none;
}

#contact .form-control:focus {
    border-color: #0d6efd;
    box-shadow: 0 0 4px rgba(13,110,253,0.4);
}

#contact button {
    padding: 12px;
    font-weight: 600;
}

        /* FOOTER */
        footer {
            background: #0d6efd;
            padding: 20px 0;
            color: white;
        }
    </style>
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#home">CuraSys</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navMenu">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- HERO -->
    <section class="hero container" id="home">
        <div class="row align-items-center">
            <div class="col-lg-6 hero-text" data-aos="fade-right">
                <h1 class="fw-bold display-5">
                    Welcome to <span style="color:#0d6efd;">CuraSys</span>
                </h1>
                <p class="mt-3 text-secondary">
                    Your trusted healthcare companion — connecting you to hospitals, clinics, doctors,
                    pharmacies, and emergency services instantly.
                </p>
                <a href="index.jsp" class="btn btn-started mt-4">Get Started</a>
            </div>

            <div class="col-lg-6 text-center" data-aos="fade-left">
                <img src="images/banner_img.png" class="hero-img">
            </div>
        </div>
    </section>

    <!-- SERVICES -->
    <section class="container my-5" id="services">
        <h2 class="text-center fw-bold mb-4">
            Our <span style="color:#0d6efd;">Services</span>
        </h2>

        <div class="row g-4">

            <!-- SERVICE 1 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">🏥</div>
                    <h5 class="fw-bold">Hospital Finder</h5>
                    <p class="text-secondary">Find verified hospitals near you instantly.</p>
                </div>
            </div>

            <!-- SERVICE 2 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">👨‍⚕️</div>
                    <h5 class="fw-bold">Doctor Appointments</h5>
                    <p class="text-secondary">Book consultations with top specialists.</p>
                </div>
            </div>

            <!-- SERVICE 3 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">💊</div>
                    <h5 class="fw-bold">Pharmacy Access</h5>
                    <p class="text-secondary">Locate nearby medical stores anytime.</p>
                </div>
            </div>

            <!-- SERVICE 4 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">🚑</div>
                    <h5 class="fw-bold">Emergency Support</h5>
                    <p class="text-secondary">Quick access to ambulance and emergency services.</p>
                </div>
            </div>

            <!-- SERVICE 5 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">📅</div>
                    <h5 class="fw-bold">Appointment Scheduler</h5>
                    <p class="text-secondary">Manage and track all your medical bookings.</p>
                </div>
            </div>

            <!-- SERVICE 6 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">📍</div>
                    <h5 class="fw-bold">Nearby Clinics</h5>
                    <p class="text-secondary">Get directions to verified healthcare clinics.</p>
                </div>
            </div>

            <!-- NEW SERVICE 7 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">🧪</div>
                    <h5 class="fw-bold">Lab Test Booking</h5>
                    <p class="text-secondary">Book blood tests and diagnostics easily.</p>
                </div>
            </div>

            <!-- NEW SERVICE 8 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">🛡️</div>
                    <h5 class="fw-bold">Health Insurance Support</h5>
                    <p class="text-secondary">Compare and manage medical insurance plans.</p>
                </div>
            </div>

            <!-- NEW SERVICE 9 -->
            <div class="col-md-6 col-lg-4" data-aos="fade-up">
                <div class="service-card text-center">
                    <div class="service-icon">🍏</div>
                    <h5 class="fw-bold">Diet & Nutrition Guidance</h5>
                    <p class="text-secondary">Get diet plans from certified nutritionists.</p>
                </div>
            </div>

        </div>
    </section>

    <!-- ABOUT -->
    <section id="about">
        <div class="about-content" data-aos="fade-up">
            <h2 class="fw-bold mb-4">About <span style="color:#0d6efd;">Us</span></h2>
            <p>
                CuraSys is a unified healthcare platform that connects users with trusted medical
                facilities, expert doctors, pharmacies, and emergency services. We aim to make
                healthcare accessible, reliable, and instant.
            </p>
        </div>
    </section>

   

       
   <!-- CONTACT -->
<section class="container my-5" id="contact">
    <h2 class="text-center fw-bold mb-4">
        Contact <span style="color:#0d6efd;">Us</span>
    </h2>

    <div class="row g-4">

        <!-- Contact Info -->
        <div class="col-lg-5" data-aos="fade-right">
            <div class="p-4 shadow-sm rounded-4 bg-white">
                <h4 class="fw-bold mb-3">Get in Touch</h4>

                <p class="mb-3">
                    <span style="font-size:20px;">📍</span>
                    <strong> Location: </strong> Pune, Maharashtra
                </p>

                <p class="mb-3">
                    <span style="font-size:20px;">📧</span>
                    <strong> Email: </strong> support@curasys.com
                </p>

                <p class="mb-3">
                    <span style="font-size:20px;">📞</span>
                    <strong> Phone: </strong> +91 1010101010
                </p>

                <p class="mb-1">
                    <span style="font-size:20px;">⏰</span>
                    <strong>Working Hours:</strong>
                24/7 service!
                </p>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="col-lg-7" data-aos="fade-left">
            <div class="p-4 shadow-sm rounded-4 bg-white">
                <form id="contactForm">
                    <div class="row g-3">

                        <div class="col-md-6">
                            <input type="text" class="form-control form-control-lg" placeholder="Your Name" required>
                        </div>

                        <div class="col-md-6">
                            <input type="email" class="form-control form-control-lg" placeholder="Your Email" required>
                        </div>

                        <div class="col-12">
                            <textarea class="form-control form-control-lg" rows="4" placeholder="Your Message" required></textarea>
                        </div>

                        <div class="col-12">
                            <button class="btn btn-primary btn-lg w-100 rounded-pill">
                                Send Message
                            </button>
                        </div>

                        <!-- SUCCESS MESSAGE -->
                        <div class="col-12">
                            <div id="successMessage" 
                                 class="alert alert-success mt-3" 
                                 style="display:none; border-radius: 12px;">
                                ✅ Your message has been sent. We will reach you soon!
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>

    </div>
</section>

<!-- JAVASCRIPT SUCCESS ALERT -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("contactForm");
    const messageBox = document.getElementById("successMessage");

    form.addEventListener("submit", function (e) {
        e.preventDefault(); 
        messageBox.style.display = "block"; 
        form.reset();
    });
});
</script>
   
      
       

    </div>
</section>


    <!-- FOOTER -->
    <footer class="text-center">
        © 2025 CuraSys. All Rights Reserved.
    </footer>

    <!-- AOS JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script>AOS.init({ duration: 1500 });</script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
