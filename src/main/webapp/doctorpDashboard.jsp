<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Book Appointment</title>

<!-- META VIEWPORT -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.doctor-img{
    width:90px;
    height:90px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #0d6efd;
}

/* Responsive Layout */
@media(max-width:768px){
    h3{
        text-align:center;
        font-size:1.4rem;
    }
    .btn-outline-primary{
        width:100%;
        margin-bottom:10px;
    }
    .doctor-img{
        width:75px;
        height:75px;
    }
}

/* Small Phones (320) */
@media(max-width:350px){
    .doctor-img{
        width:65px;
        height:65px;
    }
    h5{
        font-size:1rem;
    }
    .card{
        padding:6px;
    }
    .d-flex{
        flex-direction:column;
        text-align:center;
    }
}
</style>
</head>

<body class="bg-light">

<div class="container mt-4">

<!-- BACK BUTTON -->
<a href="PatientDashboard" class="btn btn-outline-primary mb-3">
    ← Dashboard
</a>

<h3 class="mb-4">Available Doctors</h3>

<div class="row g-3">

<%
int patientId = 1;

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM doctor_profile");

while(rs.next()){

    int doctorId = rs.getInt("id");
    String status = null;

    PreparedStatement ps = con.prepareStatement(
        "SELECT status FROM appointment WHERE doctor_id=? AND patient_id=?");
    ps.setInt(1, doctorId);
    ps.setInt(2, patientId);
    ResultSet rs2 = ps.executeQuery();

    if(rs2.next()){
        status = rs2.getString("status");
    }

    rs2.close();
    ps.close();

    String img = rs.getString("image");
    if(img == null || img.trim().equals("")){
        img = "images/default-doctor.png";
    }
%>

<div class="col-12 col-md-6">
<div class="card shadow-sm h-100">
<div class="card-body">

<div class="d-flex align-items-center gap-3 mb-3">
    <img src="<%= img %>" class="doctor-img">
    <div>
        <h5 class="mb-1"><%= rs.getString("name") %></h5>
        <p class="mb-1"><b>Specialization:</b> <%= rs.getString("specialization") %></p>
        <p class="mb-0"><b>Qualification:</b> <%= rs.getString("qualification") %></p>
    </div>
</div>

<% if(status == null){ %>

<form action="BookAppointmentServlet" method="post"
      onsubmit="alert('Appointment booked successfully');">
    <input type="hidden" name="doctorId" value="<%= doctorId %>">
    <button class="btn btn-success w-100">Book Your Appointment</button>
</form>

<% } else { %>

<button class="btn btn-secondary w-100" disabled>Appointment Booked</button>

<p class="text-center mt-2">
    <b>Status:</b>
    <span class="badge 
        <%= "APPROVED".equals(status) ? "bg-success" :
            "REJECTED".equals(status) ? "bg-danger" : "bg-warning" %>">
        <%= status %>
    </span>
</p>

<% } %>

</div>
</div>
</div>

<%
}
rs.close();
con.close();
%>

</div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
