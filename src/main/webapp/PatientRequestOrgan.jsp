<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Request Organ</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.toast-blue{background:#0d1b3d;color:white;}
</style>
</head>

<body class="bg-light">

<!-- TOAST -->
<% if(request.getParameter("success") != null){ %>
<div class="toast-container position-fixed top-0 end-0 p-3">
  <div class="toast show toast-blue">
    <div class="toast-body">
      ✅ Organ request submitted successfully
    </div>
  </div>
</div>
<% } %>

<div class="container mt-4">

<!-- BACK BUTTON -->
<a href="PatientDashboard" class="btn btn-outline-primary mb-3">
← Back to Dashboard
</a>

<h3 class="mb-3 text-center">Request Organ</h3>

<form action="SaveOrganRequestServlet" method="post" class="card p-4 shadow">

<input class="form-control mb-2" name="name" placeholder="Full Name" required>
<input class="form-control mb-2" name="age" placeholder="Age" required>

<select class="form-control mb-2" name="gender">
<option>Male</option><option>Female</option>
</select>

<input class="form-control mb-2" name="blood" placeholder="Blood Group">
<input class="form-control mb-2" name="organ" placeholder="Required Organ">
<input class="form-control mb-2" name="city" placeholder="City">
<textarea class="form-control mb-2" name="address" placeholder="Address"></textarea>

<select class="form-control mb-2" name="idType">
<option>Aadhar</option><option>PAN</option><option>Voter ID</option>
</select>

<input class="form-control mb-2" name="idNumber" placeholder="ID Number">
<input class="form-control mb-2" name="contact" placeholder="Contact Number">
<input class="form-control mb-2" name="emergency" placeholder="Emergency Contact">

<textarea class="form-control mb-3" name="note" placeholder="Note"></textarea>

<button class="btn btn-primary w-100">Submit Request</button>

</form>

</div>

<script>
setTimeout(()=> {
  document.querySelectorAll('.toast').forEach(t => t.classList.remove('show'));
},3000);
</script>

</body>
</html>
