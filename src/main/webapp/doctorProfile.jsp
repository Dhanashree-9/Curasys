<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
String name = (String) session.getAttribute("doctorName");
String spec = (String) session.getAttribute("doctorSpec");
String img  = (String) session.getAttribute("doctorImg");

String email = (String) session.getAttribute("doctorEmail");
String contact = (String) session.getAttribute("doctorContact");
String gender = (String) session.getAttribute("doctorGender");
String qualification = (String) session.getAttribute("doctorQualification");
String experience = (String) session.getAttribute("doctorExperience");

if(name == null){
    response.sendRedirect("doctorForm.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Doctor Profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- AOS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
  background:#f4f7ff;
  font-family:Poppins,sans-serif;
}

/* HERO */
.hero{
  background:#fff;
  border-radius:32px;
  padding:50px;
  box-shadow:0 25px 50px rgba(0,0,0,.12);
}

.profile-img{
  width:160px;
  height:160px;
  border-radius:50%;
  border:6px solid #1e3a8a;
  object-fit:cover;
}

/* INFO CARD */
.info-card{
  background:#fff;
  border-radius:20px;
  padding:22px;
  box-shadow:0 12px 30px rgba(0,0,0,.08);
  transition:.3s;
}
.info-card:hover{
  transform:translateY(-6px);
  box-shadow:0 22px 45px rgba(30,64,175,.25);
}

/* CERT FORM */
.cert-form{
  background:#fff;
  border-radius:20px;
  padding:25px;
  box-shadow:0 15px 35px rgba(0,0,0,.08);
}

.upload-chip{
  background:#1e3a8a;
  color:#fff;
  padding:10px 20px;
  border-radius:999px;
  cursor:pointer;
  font-weight:600;
}

/* CERT CARD */
.cert-card{
  background:#fff;
  border-radius:20px;
  padding:24px 18px;
  text-align:center;
  height:100%;
  box-shadow:0 15px 35px rgba(0,0,0,.08);
  transition:.35s;
}
.cert-card:hover{
  transform:translateY(-8px);
  box-shadow:0 25px 50px rgba(30,64,175,.28);
}

.cert-logo{
  width:64px;
  height:64px;
  object-fit:contain;
  margin-bottom:14px;
}

.cert-title{
  font-weight:700;
  color:#111827;
}
.cert-auth{
  font-size:14px;
  color:#6b7280;
}
.cert-card{
  background:#fff;
  border-radius:22px;
  padding:22px;
  text-align:center;
  height:100%;
  box-shadow:0 15px 35px rgba(0,0,0,.08);
  transition:.35s;
  position:relative;
}

.cert-card:hover{
  transform:translateY(-8px);
  box-shadow:0 28px 55px rgba(30,64,175,.28);
}

.cert-image{
  width:110px;
  height:110px;
  object-fit:cover;
  border-radius:16px;
  margin-bottom:14px;
  border:3px solid #e5e7eb;
}

.cert-name{
  font-weight:700;
  font-size:15px;
  color:#111827;
}

/* DELETE BUTTON */
.delete-form{
  position:absolute;
  top:10px;
  right:10px;
}

.delete-btn{
  background:#ef4444;
  color:#fff;
  border:none;
  width:30px;
  height:30px;
  border-radius:50%;
  font-weight:700;
  cursor:pointer;
  line-height:1;
}

.delete-btn:hover{
  background:#dc2626;
}

</style>
</head>

<body>

<div class="container py-5">

<!-- HERO -->
<div class="hero text-center mb-5" data-aos="fade-up">
  <img src="<%=img%>" class="profile-img mb-3">
  <h2 class="fw-bold"><%=name%></h2>
  <p class="text-primary fw-semibold fs-5"><%=spec%></p>

  <a href="doctorForm.jsp?edit=true"
     class="btn btn-primary rounded-pill px-4 mt-2">
    ✏️ Edit Profile
  </a>
</div>

<!-- BASIC DETAILS -->
<div class="row g-4 mb-5">

  <div class="col-md-6">
    <div class="info-card">
      <b>Email</b><br><%=email%>
    </div>
  </div>

  <div class="col-md-6">
    <div class="info-card">
      <b>Contact</b><br><%=contact%>
    </div>
  </div>

  <div class="col-md-6">
    <div class="info-card">
      <b>Gender</b><br><%=gender%>
    </div>
  </div>

  <div class="col-md-6">
    <div class="info-card">
      <b>Qualification</b><br><%=qualification%>
    </div>
  </div>

  <div class="col-md-12">
    <div class="info-card">
      <b>Experience</b><br><%=experience%>
    </div>
  </div>

</div>




<!-- ACTION -->
<div class="text-center mt-5">
  <a href="doctorDashboard.jsp"
     class="btn btn-outline-primary rounded-pill px-4 py-2">
    ← Back to Dashboard
  </a>
</div>

</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>AOS.init({duration:900,once:true});</script>

</body>
</html>
