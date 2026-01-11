<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Doctor Organ Dashboard</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.card-border{
    border:2px solid #0d6efd;
}
</style>
</head>

<body class="bg-light">

<div class="container mt-4">

<a href="doctorDashboard.jsp" class="btn btn-outline-primary mb-3">
← Back to Dashboard
</a>

<h3 class="text-center mb-4">Organ Requests & Donations</h3>

<!-- BUTTONS -->
<div class="text-center mb-4">
<button class="btn btn-primary me-2" onclick="showRequests()">
Requested Organs
</button>
<button class="btn btn-primary" onclick="showDonations()">
Donated Organs
</button>
</div>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");
%>

<!-- ================= REQUESTED ORGANS ================= -->
<div id="requestSection">

<div class="row">

<%
Statement st1 = con.createStatement();
ResultSet rs1 = st1.executeQuery("SELECT * FROM organ_request");

while(rs1.next()){
%>

<div class="col-md-4 mb-3">
<div class="card card-border shadow p-3">
<h5><%= rs1.getString("name") %></h5>
<p><b>Blood:</b> <%= rs1.getString("blood_group") %></p>
<p><b>Organ:</b> <%= rs1.getString("organ_name") %></p>

<button class="btn btn-outline-primary btn-sm"
data-bs-toggle="modal"
data-bs-target="#req<%= rs1.getInt("request_id") %>">
View
</button>
</div>
</div>

<!-- MODAL -->
<div class="modal fade" id="req<%= rs1.getInt("request_id") %>">
<div class="modal-dialog">
<div class="modal-content p-3">
<h5>Requested Organ Details</h5>
<p><b>Name:</b> <%= rs1.getString("name") %></p>
<p><b>Age:</b> <%= rs1.getInt("age") %></p>
<p><b>Gender:</b> <%= rs1.getString("gender") %></p>
<p><b>Blood Group:</b> <%= rs1.getString("blood_group") %></p>
<p><b>Organ:</b> <%= rs1.getString("organ_name") %></p>
<p><b>City:</b> <%= rs1.getString("city") %></p>
<p><b>Contact:</b> <%= rs1.getString("contact_number") %></p>
<p><b>Emergency:</b> <%= rs1.getString("emergency_contact") %></p>
<p><b>Note:</b> <%= rs1.getString("note") %></p>
</div>
</div>
</div>

<%
}
rs1.close();
st1.close();
%>

</div>
</div>

<!-- ================= DONATED ORGANS ================= -->
<div id="donateSection" class="d-none">

<div class="row">

<%
Statement st2 = con.createStatement();
ResultSet rs2 = st2.executeQuery("SELECT * FROM organ_donation");

while(rs2.next()){
%>

<div class="col-md-4 mb-3">
<div class="card card-border shadow p-3">
<h5><%= rs2.getString("name") %></h5>
<p><b>Blood:</b> <%= rs2.getString("blood_group") %></p>
<p><b>Organ:</b> <%= rs2.getString("organ_name") %></p>

<button class="btn btn-outline-primary btn-sm"
data-bs-toggle="modal"
data-bs-target="#don<%= rs2.getInt("donation_id") %>">
View
</button>
</div>
</div>

<!-- MODAL -->
<div class="modal fade" id="don<%= rs2.getInt("donation_id") %>">
<div class="modal-dialog">
<div class="modal-content p-3">
<h5>Donor Details</h5>
<p><b>Name:</b> <%= rs2.getString("name") %></p>
<p><b>Age:</b> <%= rs2.getInt("age") %></p>
<p><b>Blood Group:</b> <%= rs2.getString("blood_group") %></p>
<p><b>Organ:</b> <%= rs2.getString("organ_name") %></p>
<p><b>Address:</b> <%= rs2.getString("address") %></p>
<p><b>Contact:</b> <%= rs2.getString("contact_number") %></p>
<p><b>Note:</b> <%= rs2.getString("note") %></p>
</div>
</div>
</div>

<%
}
rs2.close();
st2.close();
con.close();
%>

</div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function showRequests(){
    document.getElementById("requestSection").classList.remove("d-none");
    document.getElementById("donateSection").classList.add("d-none");
}

function showDonations(){
    document.getElementById("donateSection").classList.remove("d-none");
    document.getElementById("requestSection").classList.add("d-none");
}
</script>

</body>
</html>
