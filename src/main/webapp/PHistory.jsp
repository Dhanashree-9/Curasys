<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Patient History</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    font-family: "Poppins", sans-serif;
    background:#f8fafc;
}

h2{
    font-weight:600;
    color:#0d6efd;
}

.section-title{
    margin-top:30px;
    margin-bottom:15px;
    color:#0d6efd;
    font-weight:500;
}

/* Table Styling */
.table{
    background:#fff;
    border-radius:12px;
    overflow:hidden;
}

.table th{
    background:#0d6efd;
    color:#fff;
    text-align:center;
    vertical-align:middle;
    white-space:nowrap;
}

.table td{
    text-align:center;
    vertical-align:middle;
    white-space:nowrap;
}

.table tbody tr:hover{
    background:#f1f6ff;
}

.back-btn{
    border-radius:20px;
    padding:6px 18px;
}

/* MOBILE: Card View Formatting */
@media(max-width:768px){
    .table thead{
        display:none;
    }

    .table, .table tbody, .table tr, .table td{
        display:block;
        width:100%;
    }

    .table tr{
        margin-bottom:15px;
        border:1px solid #dee2e6;
        border-radius:12px;
        background:white;
        padding:10px;
        box-shadow:0 2px 6px rgba(0,0,0,0.05);
    }

    .table td{
        display:flex;
        justify-content:space-between;
        padding:8px 10px;
        border:none;
        font-size:0.9rem;
    }

    .table td::before{
        content:attr(data-label);
        font-weight:600;
        color:#0d6efd;
        margin-right:10px;
        text-align:left;
        flex-basis:45%;
    }

    .section-title{
        text-align:center;
        font-size:1.1rem;
    }

    h2{
        font-size:1.4rem;
        text-align:center;
    }

    .back-wrapper{
        text-align:center;
    }
}
</style>
</head>

<body>

<div class="container mt-4">

    <!-- BACK -->
    <div class="back-wrapper mb-3">
        <a href="PatientDashboard" class="btn btn-secondary back-btn">← Back</a>
    </div>

    <h2 class="mb-3 text-center">Patient History</h2>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");
%>

<!-- ============ APPOINTMENTS ============ -->
<h4 class="section-title">Appointments</h4>
<div class="table-responsive">
<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Appointment ID</th>
            <th>Doctor ID</th>
            <th>Patient ID</th>
            <th>Date</th>
            <th>Status</th>
        </tr>
    </thead>
<tbody>
<%
Statement st1 = con.createStatement();
ResultSet rs1 = st1.executeQuery("SELECT * FROM appointment");
while(rs1.next()){
%>
<tr>
    <td data-label="Appointment ID"><%=rs1.getInt("appointment_id")%></td>
    <td data-label="Doctor ID"><%=rs1.getInt("doctor_id")%></td>
    <td data-label="Patient ID"><%=rs1.getInt("patient_id")%></td>
    <td data-label="Date"><%=rs1.getString("appointment_date")%></td>
    <td data-label="Status"><%=rs1.getString("status")%></td>
</tr>
<% } %>
</tbody>
</table>
</div>

<!-- ============ ORGAN DONATION ============ -->
<h4 class="section-title">Organ Donations</h4>
<div class="table-responsive">
<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Blood Group</th>
            <th>Organ</th>
        </tr>
    </thead>
<tbody>
<%
Statement st2 = con.createStatement();
ResultSet rs2 = st2.executeQuery("SELECT * FROM organ_donation");
while(rs2.next()){
%>
<tr>
    <td data-label="Name"><%=rs2.getString("name")%></td>
    <td data-label="Age"><%=rs2.getInt("age")%></td>
    <td data-label="Blood Group"><%=rs2.getString("blood_group")%></td>
    <td data-label="Organ"><%=rs2.getString("organ_name")%></td>
</tr>
<% } %>
</tbody>
</table>
</div>

<!-- ============ ORGAN REQUEST ============ -->
<h4 class="section-title">Organ Requests</h4>
<div class="table-responsive mb-4">
<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Blood Group</th>
            <th>Organ</th>
            <th>City</th>
        </tr>
    </thead>
<tbody>
<%
Statement st3 = con.createStatement();
ResultSet rs3 = st3.executeQuery("SELECT * FROM organ_request");
while(rs3.next()){
%>
<tr>
    <td data-label="Name"><%=rs3.getString("name")%></td>
    <td data-label="Age"><%=rs3.getInt("age")%></td>
    <td data-label="Gender"><%=rs3.getString("gender")%></td>
    <td data-label="Blood Group"><%=rs3.getString("blood_group")%></td>
    <td data-label="Organ"><%=rs3.getString("organ_name")%></td>
    <td data-label="City"><%=rs3.getString("city")%></td>
</tr>
<% } %>
</tbody>
</table>
</div>

<% con.close(); %>

</div>
</body>
</html>
