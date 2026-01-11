<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Book Appointment</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.doctor-img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #0d6efd;
}

/* Mobile avatar resize */
@media (max-width: 576px){
  .doctor-img {
      width: 70px;
      height: 70px;
  }
}

/* Mobile app-like feel */
body {
    background: #f5f7fa;
}

.card {
    border-radius: 12px;
}
</style>
</head>

<body class="bg-light">

<div class="container-sm mt-4">

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

<!-- Responsive Card Column -->
<div class="col-12 col-sm-10 col-md-8 col-lg-6 mx-auto">

    <div class="card shadow h-100">
        <div class="card-body">

            <!-- Responsive Flex Doctor Header -->
            <div class="d-flex flex-column flex-sm-row gap-3 mb-3 align-items-center align-items-sm-start">
                <img src="<%= img %>" class="doctor-img" alt="Doctor">
                <div class="text-center text-sm-start">
                    <h5><%= rs.getString("name") %></h5>
                    <p class="mb-1"><b>Specialization:</b> <%= rs.getString("specialization") %></p>
                    <p class="mb-1"><b>Qualification:</b> <%= rs.getString("qualification") %></p>
                </div>
            </div>

            <% if(status == null){ %>

            <form action="BookAppointmentServlet" method="post"
                onsubmit="alert('Appointment booked successfully');">
                <input type="hidden" name="doctorId" value="<%= doctorId %>">
                <button class="btn btn-success w-100">
                    Book Your Appointment
                </button>
            </form>

            <% } else { %>

            <button class="btn btn-secondary w-100" disabled>
                Appointment Booked
            </button>

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

</body>
</html>
