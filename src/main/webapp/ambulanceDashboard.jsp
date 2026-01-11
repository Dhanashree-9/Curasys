<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Ambulance Dashboard</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- AOS -->
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<style>
/* ===== HERO CARD ===== */
.hero-card{
    border:2px solid #ff4d88;
    border-radius:12px;
    padding:25px;
    transition:0.4s ease;
    background:white;
}
.hero-card:hover{
    box-shadow:0 12px 30px rgba(255,77,136,0.3);
    transform:translateY(-5px);
}

/* ===== HERO IMAGE ===== */
.hero-img{
    transition:0.5s ease;
}
.hero-img:hover{
    transform:scale(1.05);
}

/* ===== SERVICE CARDS ===== */
.service-card{
    background:#e6f2ff;
    border-radius:10px;
    padding:20px;
    height:100%;
    transition:0.4s ease;
}
.service-card:hover{
    transform:translateY(-8px);
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
}

/* ===== AMBULANCE IMAGE GRID ===== */
.amb-img{
    width:100%;
    height:180px;
    object-fit:cover;
    border-radius:10px;
    transition:0.4s ease;
}
.amb-img:hover{
    transform:scale(1.05);
    box-shadow:0 8px 20px rgba(0,0,0,0.2);
}

/* ===== MOBILE FIX ===== */
@media(max-width:576px){
    .hero-card{padding:15px}
}
</style>

</head>

<body class="bg-light">

<!-- CONSTANT SIDEBAR -->
<%@ include file="ambulanceSidebar.jsp" %>

<div class="content">

<h3 class="mb-4" data-aos="fade-right">Ambulance Dashboard</h3>

<!-- ================= HERO SECTION ================= -->
<div class="hero-card mb-5" data-aos="fade-up">
<div class="row align-items-center">

<!-- LEFT TEXT -->
<div class="col-md-6 mb-3 mb-md-0" data-aos="fade-right">
<h4>24x7 Emergency Ambulance Service</h4>
<p>
We provide fast, reliable, and fully equipped ambulance services
to ensure patient safety and quick hospital connectivity.
</p>

<ul>
<li>Quick Response Time</li>
<li>Trained Medical Staff</li>
<li>Advanced Life Support</li>
<li>Hospital Coordination</li>
</ul>
</div>

<!-- RIGHT IMAGE -->
<div class="col-md-6 text-center" data-aos="zoom-in">
<img src="images/a-hero.jpg"
     class="img-fluid rounded hero-img"
     alt="Ambulance">
</div>

</div>
</div>

<!-- ================= SERVICES SECTION ================= -->
<h4 class="mb-3" data-aos="fade-up">Our Ambulance Services</h4>

<div class="row g-3 mb-5">

<div class="col-md-4" data-aos="fade-up">
<div class="service-card">
<h5>Emergency Care</h5>
<ul>
<li>24/7 Emergency Support</li>
<li>Immediate Dispatch</li>
<li>GPS Enabled Ambulance</li>
<li>Life Saving Equipment</li>
</ul>
</div>
</div>

<div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
<div class="service-card">
<h5>Patient Support</h5>
<ul>
<li>ICU Ambulance</li>
<li>Oxygen Facility</li>
<li>First Aid Treatment</li>
<li>Continuous Monitoring</li>
</ul>
</div>
</div>

<div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
<div class="service-card">
<h5>Hospital Connectivity</h5>
<ul>
<li>Nearest Hospital Access</li>
<li>Emergency Admission</li>
<li>Doctor Coordination</li>
<li>Fast Handover</li>
</ul>
</div>
</div>

</div>

</div>

</div>

<!-- AOS SCRIPT -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
AOS.init({
    duration:800,
    once:true
});
</script>

</body>
</html>
