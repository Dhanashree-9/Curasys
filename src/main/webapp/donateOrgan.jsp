<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Organ Services</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<style>
.card-img-top{height:180px;object-fit:cover;}
.toast-blue{background:#0d1b3d;color:white;}
</style>
</head>

<body class="bg-light">

<!-- TOAST -->
<% if(request.getParameter("success") != null){ %>
<div class="toast-container position-fixed top-0 end-0 p-3">
  <div class="toast show toast-blue">
    <div class="toast-body">
      ✅ Organ donation details saved successfully
    </div>
  </div>
</div>
<% } %>

<div class="container mt-4">

<!-- BACK BUTTON -->
<a href="PatientDashboard" class="btn btn-outline-primary mb-3">
← Back to Dashboard
</a>

<h3 class="text-center mb-4">Organ Services</h3>



<!-- ===================== -->
<!-- DONATE ORGAN CARDS -->
<!-- ===================== -->
<div id="donateCards">

<div class="row mb-5">
<div class="col-md-4 mb-3" data-aos="fade-up">
<div class="card shadow">
<img src="images/Heart.jpg" class="card-img-top">
<div class="card-body">
<h5>Heart Donation</h5>
<p>Give life to someone by donating your heart.</p>
</div>
</div>
</div>

<div class="col-md-4 mb-3" data-aos="fade-up">
<div class="card shadow">
<img src="images/kidney.jpg" class="card-img-top">
<div class="card-body">
<h5>Kidney Donation</h5>
<p>One kidney can save a life.</p>
</div>
</div>
</div>

<div class="col-md-4 mb-3" data-aos="fade-up">
<div class="card shadow">
<img src="images/eye.png" class="card-img-top">
<div class="card-body">
<h5>Eye Donation</h5>
<p>Help someone see the world.</p>
</div>
</div>
</div>
</div>

<!-- DONATE FORM -->
<div class="card shadow p-4 mb-5">
<h5 class="mb-3">Donate Organ Form</h5>

<form action="SaveDonateOrganServlet" method="post">
<input class="form-control mb-2" name="name" placeholder="Full Name" required>
<input class="form-control mb-2" name="age" placeholder="Age" required>

<select class="form-control mb-2" name="blood">
<option>O+</option><option>A+</option><option>B+</option><option>AB+</option>
</select>

<input class="form-control mb-2" name="organ" placeholder="Organ Name" required>
<textarea class="form-control mb-2" name="address" placeholder="Address"></textarea>
<input class="form-control mb-2" name="contact" placeholder="Contact Number" required>
<textarea class="form-control mb-3" name="note" placeholder="Note"></textarea>

<button class="btn btn-success w-100">Submit Donation</button>
</form>
</div>

</div>



</div>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init();</script>

<script>
function showDonate(){
  document.getElementById("donateCards").classList.remove("d-none");
  document.getElementById("requestCards").classList.add("d-none");
}

function showRequest(){
  document.getElementById("requestCards").classList.remove("d-none");
  document.getElementById("donateCards").classList.add("d-none");
}

// toast auto-hide
setTimeout(()=>{
  document.querySelectorAll('.toast').forEach(t=>t.classList.remove('show'));
},3000);
</script>

</body>
</html>
