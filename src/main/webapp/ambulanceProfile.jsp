<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Ambulance Profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.profile-wrapper{
    min-height:90vh;
    display:flex;
    justify-content:center;
    align-items:flex-start;
    padding-top:20px;
}
.toast-success{
    background:#0d1b3d;
    color:white;
    font-size:18px;
}
</style>
</head>

<body class="bg-light">

<%@ include file="ambulanceSidebar.jsp" %>

<div class="content">

<a href="ambulanceDashboard.jsp" class="btn btn-outline-primary mb-3">← Back</a>

<div class="profile-wrapper">
<div class="card shadow p-4 w-100" style="max-width:480px">

<h4 class="text-center mb-3">Ambulance Profile</h4>

<% if(request.getParameter("success") != null){ %>
<div class="toast-container position-fixed top-0 end-0 p-3">
  <div class="toast show toast-success">
    <div class="toast-body">✅ Profile saved successfully</div>
  </div>
</div>
<% } %>

<div class="text-center mb-3">
<img src="images/default.png" id="preview"
     class="rounded-circle mb-2"
     style="width:120px;height:120px;object-fit:cover;border:3px solid #ff4d88;">
</div>

<form action="SaveAmbulanceProfile" method="post" enctype="multipart/form-data">

<input type="file" name="photo" class="form-control mb-2" accept="image/*"
       onchange="previewImage(event)" required>

<input name="driverName" class="form-control mb-2" placeholder="Driver Name" required>
<input name="ambulanceNumber" class="form-control mb-2" placeholder="Ambulance Number" required>
<input name="contact" class="form-control mb-2" placeholder="Contact Number" required>
<input name="area" class="form-control mb-2" placeholder="Area" required>
<input name="hospital" class="form-control mb-3" placeholder="Hospital Name" required>

<button class="btn btn-success w-100">Save Profile</button>

</form>
</div>
</div>
</div>

<script>
function previewImage(e){
  document.getElementById("preview").src =
      URL.createObjectURL(e.target.files[0]);
}

setTimeout(()=>{
  document.querySelectorAll('.toast').forEach(t=>t.classList.remove('show'));
},3000);
</script>

</body>
</html>
