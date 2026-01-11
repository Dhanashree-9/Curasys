<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Doctor Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- AOS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
  font-family:Poppins,sans-serif;
  background:#f4f7ff;
  margin:0;
}

/* ===== SIDEBAR (DESKTOP) ===== */
.sidebar{
  position:fixed;
  top:0;
  left:0;
  width:300px;
  max-width:100%;
  height:100vh;
  background:#1e3a8a;
  color:#fff;
  padding:30px;
  overflow-y:auto;
  transition:0.3s;
}

/* Doctor Profile */
.doctor-box{
  background:rgba(255,255,255,.15);
  border-radius:20px;
  padding:25px;
  text-align:center;
  margin-bottom:35px;
}
.doctor-box img{
  width:100px;
  height:100px;
  border-radius:50%;
  border:4px solid #fff;
  object-fit:cover;
}
.doctor-box h5{
  margin-top:15px;
  font-weight:700;
}
.doctor-box p{
  font-size:14px;
  opacity:.85;
}

/* Sidebar Links */
.sidebar a{
  display:block;
  color:#fff;
  text-decoration:none;
  padding:16px 18px;
  margin-bottom:14px;
  border-radius:14px;
  background:rgba(255,255,255,.18);
  font-size:16px;
}
.sidebar a:hover{
  background:#3b82f6;
}

/* ===== MAIN CONTENT (DESKTOP) ===== */
.main-content{
  margin-left:300px;
  padding:40px;
}

/* Hero Section */
.hero{
  background:#fff;
  border-radius:28px;
  box-shadow:0 20px 45px rgba(0,0,0,.08);
}
.hero h1{
  font-weight:900;
  color:#000;
}
.hero p{
  color:#60a5fa;
  font-size:15px;
}
.hero .btn{
  background:#1e3a8a;
  color:#fff;
}

/* Cards */
.card-custom{
  border:2px solid #dbeafe;
  border-radius:22px;
  transition:.3s;
}
.card-custom:hover{
  transform:translateY(-6px);
  border-color:#2563eb;
}
.card-custom img{
  height:200px;
  object-fit:cover;
  border-radius:18px;
}

/* Info sections */
.info{
  max-width:900px;
  border-left:6px solid #2563eb;
}

/* ===== RESPONSIVE OPTION-A ===== */
@media(max-width:992px){
  .sidebar{
    position:relative;
    width:100%;
    height:auto;
    padding:22px;
  }
  .main-content{
    margin-left:0 !important;
    padding:22px;
  }
}

@media(max-width:768px){
  .hero{ padding:20px; }
  .hero img{ max-height:240px !important; }
}

@media(max-width:576px){
  .doctor-box img{
    width:75px;
    height:75px;
  }
  .card-custom img{
    height:150px !important;
  }
  .card-custom{ padding:14px; }
}
</style>
</head>

<body>

<!-- MOBILE NAVBAR -->
<nav class="navbar navbar-dark bg-primary d-lg-none">
  <div class="container-fluid">
    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#mobileSidebar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <span class="navbar-brand">Doctor Panel</span>
  </div>
</nav>

<!-- SIDEBAR -->
<div class="sidebar collapse navbar-collapse d-lg-block" id="mobileSidebar">

  <div class="doctor-box">
    <img src="<%=session.getAttribute("doctorImg")%>">
    <h5><%=session.getAttribute("doctorName")%></h5>
    <p><%=session.getAttribute("doctorSpec")%></p>
  </div>

  <a href="doctorProfile.jsp">👨‍⚕️ Profile</a>
  <a href="DoctorAppointments.jsp">📅 Appointments</a>
  <a href="bloodbank.jsp">🩸 Blood Banks</a>
  <a href="drequestOrgan.jsp">🫀 Organ Requests</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">

<!-- HERO SECTION -->
<div class="hero p-5 mb-5" data-aos="fade-up">
  <div class="row align-items-center">
    <div class="col-lg-7">
      <h1>MAKING HEALTHCARE BETTER TOGETHER</h1>
      <p class="mt-3">
        Our digital healthcare platform empowers doctors with seamless access
        to patient information, appointment scheduling, organ donation requests,
        and secure medical workflows.
      </p>
      <a href="doctorForm.jsp" class="btn px-4 py-2 rounded-pill mt-3">
        Register Now
      </a>
    </div>
    <div class="col-lg-5 text-center">
      <img src="images/doctor1.jpg" class="img-fluid" style="max-height:340px">
    </div>
  </div>
</div>

<!-- CARDS -->
<div class="row g-4 mb-5">
  <div class="col-md-4" data-aos="fade-up">
    <div class="card card-custom p-3 text-center">
      <img src="images/doctor2.jpg" class="img-fluid mb-3">
      <h6 class="fw-bold">⭐ 4.9 out of 5 Rating</h6>
      <p class="text-muted small">Trusted by thousands of patients.</p>
    </div>
  </div>

  <div class="col-md-4" data-aos="fade-up" data-aos-delay="150">
    <div class="card card-custom p-3 text-center">
      <img src="images/doctor3.jpg" class="img-fluid mb-3">
      <h6 class="fw-bold">24 × 7 Availability</h6>
      <p class="text-muted small">Support available day & night.</p>
    </div>
  </div>

  <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
    <div class="card card-custom p-3 text-center">
      <img src="images/doctor4.png" class="img-fluid mb-3">
      <h6 class="fw-bold">100% Confidential</h6>
      <p class="text-muted small">Secure medical experience.</p>
    </div>
  </div>
</div>

<!-- INFO BLOCKS -->
<div class="card info mx-auto p-4 mb-4" data-aos="zoom-in">
  <h6 class="fw-bold text-primary">Expert Care to Your Fingertips</h6>
  <p class="text-muted mb-0">Technology that simplifies healthcare.</p>
</div>

<div class="card info mx-auto p-4" data-aos="zoom-in" data-aos-delay="150">
  <h6 class="fw-bold text-primary">Better Communication = Better Health</h6>
  <p class="text-muted mb-0">Less paperwork, more patient focus.</p>
</div>

</div>

<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>AOS.init({duration:900,once:true});</script>

</body>
</html>
