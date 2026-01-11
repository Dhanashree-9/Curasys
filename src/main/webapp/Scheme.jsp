<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session==null || session.getAttribute("email")==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Health Schemes</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
  font-family:"Poppins",sans-serif;
  background:linear-gradient(135deg,#dbeafe,#eff6ff);
}

/* Back */
.back-btn{
  font-size:18px;
  color:#1e3a8a;
  font-weight:600;
  text-decoration:none;
}
.back-btn:hover{color:#2563eb}

/* IMAGE CARD */
.scheme-card{
  background:#ffffff;
  border-radius:26px;
  overflow:hidden;
  box-shadow:0 20px 50px rgba(30,64,175,.18);
  transition:.4s;
  cursor:pointer;
  height:100%;
}
.scheme-card:hover{
  transform:translateY(-12px);
  box-shadow:0 35px 80px rgba(30,64,175,.28);
}

/* IMAGE */
.scheme-img{
  width:100%;
  height:180px;
  object-fit:cover;
}

/* TEXT AREA */
.scheme-text{
  padding:18px;
  text-align:center;
  background:#ffffff;
}
.scheme-text h5{
  font-weight:700;
  color:#1e3a8a;
  margin-bottom:6px;
}
.scheme-text p{
  font-size:14px;
  color:#475569;
  margin:0;
}
</style>
</head>

<body>

<div class="container py-4">

<a href="PatientDashboard" class="back-btn mb-3 d-inline-block">
← Back
</a>

<h3 class="text-center fw-bold text-primary mb-4">Government Health Schemes</h3>

<div class="row g-4">

<!-- WOMEN -->
<div class="col-md-4" data-aos="zoom-in">
<div class="scheme-card" data-bs-toggle="modal" data-bs-target="#womenModal">
<img src="images/women.jpg" class="scheme-img">
<div class="scheme-text">
<h5>Women</h5>
<p>Maternity & women care schemes</p>
</div>
</div>
</div>

<!-- SENIOR -->
<div class="col-md-4" data-aos="zoom-in">
<div class="scheme-card" data-bs-toggle="modal" data-bs-target="#seniorModal">
<img src="images/senior.jpg" class="scheme-img">
<div class="scheme-text">
<h5>Senior Citizens</h5>
<p>Old age healthcare</p>
</div>
</div>
</div>

<!-- CHILD -->
<div class="col-md-4" data-aos="zoom-in">
<div class="scheme-card" data-bs-toggle="modal" data-bs-target="#childModal">
<img src="images/child.jpg" class="scheme-img">
<div class="scheme-text">
<h5>Children & Babies</h5>
<p>Vaccination & child care</p>
</div>
</div>
</div>

<!-- INSURANCE -->
<div class="col-md-4" data-aos="zoom-in">
<div class="scheme-card" data-bs-toggle="modal" data-bs-target="#insuranceModal">
<img src="images/insurance.jpg" class="scheme-img">
<div class="scheme-text">
<h5>Insurance</h5>
<p>Health insurance schemes</p>
</div>
</div>
</div>

<!-- DISABILITY -->
<div class="col-md-4" data-aos="zoom-in">
<div class="scheme-card" data-bs-toggle="modal" data-bs-target="#disabilityModal">
<img src="images/disability.jpg" class="scheme-img">
<div class="scheme-text">
<h5>Disability</h5>
<p>Special support schemes</p>
</div>
</div>
</div>

</div>
</div>

<!-- ================= MODALS ================= -->

<div class="modal fade" id="womenModal">
<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
<div class="modal-content p-4">
<h5 class="fw-bold text-primary">Women Health Schemes</h5>
<p>Janani Suraksha Yojana, PM Matru Vandana Yojana</p>
<a target="_blank" href="https://www.google.com/search?q=women+health+schemes+india" class="btn btn-primary">Apply</a>
</div>
</div>
</div>

<div class="modal fade" id="seniorModal">
<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
<div class="modal-content p-4">
<h5 class="fw-bold text-primary">Senior Citizen Schemes</h5>
<p>NPHCE, Free geriatric healthcare</p>
<a target="_blank" href="https://www.google.com/search?q=senior+citizen+health+schemes+india" class="btn btn-primary">Apply</a>
</div>
</div>
</div>

<div class="modal fade" id="childModal">
<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
<div class="modal-content p-4">
<h5 class="fw-bold text-primary">Child & Baby Schemes</h5>
<p>Pulse Polio Programme, Child vaccination</p>
<a target="_blank" href="https://www.google.com/search?q=child+health+schemes+india" class="btn btn-primary">Apply</a>
</div>
</div>
</div>

<div class="modal fade" id="insuranceModal">
<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
<div class="modal-content p-4">
<h5 class="fw-bold text-primary">Insurance Schemes</h5>
<p>Ayushman Bharat – ₹5 lakh coverage</p>
<a target="_blank" href="https://www.google.com/search?q=ayushman+bharat+scheme" class="btn btn-primary">Apply</a>
</div>
</div>
</div>

<div class="modal fade" id="disabilityModal">
<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
<div class="modal-content p-4">
<h5 class="fw-bold text-primary">Disability Schemes</h5>
<p>ADIP scheme, rehabilitation support</p>
<a target="_blank" href="https://www.google.com/search?q=disability+health+schemes+india" class="btn btn-primary">Apply</a>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>AOS.init({duration:900, once:true});</script>

</body>
</html>
