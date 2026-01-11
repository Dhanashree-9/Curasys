<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Book Ambulance</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
<div class="container mt-4">
<a href="PatientDashboard" class="btn btn-outline-primary mb-3">
    ← Back to Dashboard
</a>

<h3>Available Ambulances</h3>
<div class="row">

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");

PreparedStatement ps = con.prepareStatement(
    "SELECT a.*, r.status " +
    "FROM ambulance_profile a " +
    "LEFT JOIN ambulance_request r " +
    "ON a.ambulance_number = r.ambulance_number");

ResultSet rs = ps.executeQuery();

while(rs.next()){
    String status = rs.getString("status");
    if(status == null) status = "NOT REQUESTED";
%>

<div class="col-md-6">
<div class="card mb-3">
<div class="card-body">

<h5><%= rs.getString("driver_name") %></h5>
<p>Ambulance No: <%= rs.getString("ambulance_number") %></p>
<p>Hospital: <%= rs.getString("hospital_name") %></p>

<p>Status:
<span class="badge 
<%= status.equals("APPROVED") ? "bg-success" :
    status.equals("REJECTED") ? "bg-danger" :
    status.equals("PENDING") ? "bg-warning" : "bg-secondary" %>">
<%= status %>
</span>
</p>

<% if(status.equals("NOT REQUESTED")) { %>
<form action="SavePatientAmbulanceRequest" method="post">
<input type="hidden" name="ambulanceNumber" value="<%= rs.getString("ambulance_number") %>">
<input type="text" name="patientName" placeholder="Patient Name" required class="form-control mb-2">
<input type="text" name="pickupLocation" placeholder="Pickup Location" required class="form-control mb-2">
<input type="text" name="contact" placeholder="Contact Number" required class="form-control mb-2">
<button class="btn btn-danger w-100">Book Ambulance</button>
</form>
<% } %>

</div>
</div>
</div>

<%
}
con.close();
%>

</div>
</div>
</body>
</html>
