<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Doctor Appointments</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* Mobile responsive table */
@media(max-width:768px){
    table thead { display:none; }
    table tr {
        display:block;
        margin-bottom:15px;
        background:white;
        border-radius:8px;
        padding:10px;
        box-shadow:0 2px 6px rgba(0,0,0,0.08);
    }
    table td {
        display:flex;
        justify-content:space-between;
        padding:6px 4px;
        border:none !important;
    }
    table td::before {
        content:attr(data-label);
        font-weight:600;
        color:#374151;
        margin-right:10px;
    }
    .btn-sm{
        padding:6px 10px;
        width:48%;
    }
    h3{
        text-align:center;
        font-size:1.3rem;
    }
    .alert { text-align:center; }
    .btn-back{ width:100%; margin-bottom:12px; }
}

/* Very small phones (320px) */
@media(max-width:360px){
    .btn-sm{ width:100%; margin-bottom:6px; }
}
</style>
</head>

<body class="bg-light">
<div class="container mt-4">

<!-- 🔙 BACK BUTTON -->
<a href="doctorDashboard.jsp" class="btn btn-outline-secondary mb-3 btn-back">
    ← Back to Dashboard
</a>

<h3 class="mb-3">All Appointment Requests</h3>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");

/* Count appointments */
Statement stCnt = con.createStatement();
ResultSet rc = stCnt.executeQuery("SELECT COUNT(*) FROM appointment");
int total=0;
if(rc.next()) total = rc.getInt(1);
rc.close();
stCnt.close();
%>

<div class="alert alert-info shadow-sm">
Total Appointments: <b><%= total %></b>
</div>

<div class="table-responsive">
<table class="table table-bordered bg-white shadow-sm">
<thead>
<tr class="table-primary">
    <th>Appointment ID</th>
    <th>Doctor ID</th>
    <th>Patient ID</th>
    <th>Status</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<%
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(
    "SELECT appointment_id, doctor_id, patient_id, status FROM appointment");

while(rs.next()){
%>
<tr>
    <td data-label="Appointment ID"><%= rs.getInt("appointment_id") %></td>
    <td data-label="Doctor ID"><%= rs.getInt("doctor_id") %></td>
    <td data-label="Patient ID"><%= rs.getInt("patient_id") %></td>
    <td data-label="Status"><%= rs.getString("status") %></td>
    <td data-label="Action">
        <form action="UpdateAppointment" method="post" class="d-flex gap-2 flex-wrap">
            <input type="hidden" name="appointmentId" value="<%= rs.getInt("appointment_id") %>">

            <button name="status" value="APPROVED" class="btn btn-success btn-sm">Accept</button>
            <button name="status" value="REJECTED" class="btn btn-danger btn-sm">Reject</button>
        </form>
    </td>
</tr>
<%
}
rs.close();
st.close();
con.close();
%>
</tbody>
</table>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
