<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>My Orders</title>

<!-- META VIEWPORT FOR MOBILE -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
/* Responsive Table for Mobile */
@media(max-width:768px){
    table thead{
        display:none;
    }
    table tr{
        display:block;
        margin-bottom:15px;
        background:white;
        border-radius:8px;
        padding:10px;
        box-shadow:0 2px 6px rgba(0,0,0,0.08);
    }
    table td{
        display:flex;
        justify-content:space-between;
        padding:6px 0;
        border:none !important;
        font-size:15px;
    }
    table td::before{
        content:attr(data-label);
        font-weight:600;
        color:#374151;
        margin-right:10px;
    }

    h3{
        text-align:center;
        font-size:1.3rem;
        margin-bottom:15px;
    }

    .btn-outline-secondary{
        width:100%;
        margin-bottom:12px;
    }
}
</style>
</head>

<body class="bg-light">

<div class="container mt-4">

<!-- BACK BUTTON -->
<a href="patientpharmacy.jsp" class="btn btn-outline-secondary mb-3">
    <i class="bi bi-arrow-left"></i> Back to Pharmacy
</a>

<h3>My Medicine Orders</h3>

<div class="table-responsive">
<table class="table table-bordered">
<thead>
<tr class="table-warning">
    <th>Medicine</th>
    <th>Dosage</th>
    <th>Quantity</th>
    <th>Status</th>
</tr>
</thead>

<tbody>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(
    "SELECT medicine_name, dosage, quantity, status FROM medicine_orders ORDER BY order_id DESC");

while(rs.next()){
%>

<tr>
<td data-label="Medicine"><%=rs.getString("medicine_name")%></td>
<td data-label="Dosage"><%=rs.getString("dosage")%></td>
<td data-label="Quantity"><%=rs.getInt("quantity")%></td>
<td data-label="Status">
<span class="badge 
<%= rs.getString("status").equals("PENDING") ? "bg-warning" :
    rs.getString("status").equals("ACCEPTED") ? "bg-success" : "bg-danger" %>">
<%=rs.getString("status")%>
</span>
</td>
</tr>

<%
}
con.close();
%>
</tbody>
</table>
</div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
