<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Emergency Form</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* Toast style */
.toast-success{
    background:#0d1b3d;
    color:white;
    font-size:17px;
}

/* Center form nicely */
.emergency-wrapper{
    min-height:85vh;
    display:flex;
    justify-content:center;
    align-items:flex-start;
}
</style>

</head>

<body class="bg-light">

<!-- Hamburger -->
<span class="hamburger" onclick="toggleSidebar()">☰</span>

<!-- Sidebar -->
<%@ include file="ambulanceSidebar.jsp" %>

<div class="content">

<!-- Back button -->
<a href="ambulanceDashboard.jsp" class="btn btn-outline-primary mb-3">
← Back
</a>

<h3 class="mb-3">Emergency to Hospital</h3>

<!-- ✅ TOAST MESSAGE -->
<% if(request.getParameter("success") != null){ %>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div class="toast show toast-success">
        <div class="toast-body">
            ✅ Info sent to hospital successfully
        </div>
    </div>
</div>
<% } %>

<div class="emergency-wrapper">
<div class="card shadow p-4 w-100" style="max-width:520px">

<form action="SaveEmergencyServlet" method="post">

<input name="patientName"
       class="form-control mb-2"
       placeholder="Patient Name"
       required>

<input name="age"
       type="number"
       class="form-control mb-2"
       placeholder="Age"
       required>

<input name="accident"
       class="form-control mb-2"
       placeholder="Accident Type"
       required>

<input name="location"
       class="form-control mb-2"
       placeholder="Location"
       required>

<input name="hospital"
       class="form-control mb-2"
       placeholder="Hospital Name"
       required>

<input name="contact"
       class="form-control mb-3"
       placeholder="Contact Number"
       required>

<button type="submit" class="btn btn-danger w-100">
🚑 Send Emergency
</button>

</form>

</div>
</div>

</div>

<script>
/* Auto hide toast */
setTimeout(()=>{
  document.querySelectorAll('.toast').forEach(t=>{
    t.classList.remove('show');
  });
},3000);
</script>

</body>
</html>
