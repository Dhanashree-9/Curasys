<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

<title>Recent Orders</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
/* Mobile table stacking */
@media(max-width:768px){
    table thead{
        display:none;
    }
    table tr{
        display:block;
        margin-bottom:15px;
        border:1px solid #dee2e6;
        border-radius:8px;
        padding:10px;
        background:white;
    }
    table td{
        display:flex;
        justify-content:space-between;
        padding:6px 10px;
        border:none;
    }
    table td::before{
        content:attr(data-label);
        font-weight:bold;
        color:#374151;
    }
}
</style>

</head>

<body class="bg-light">

<div class="container-fluid px-3 px-md-4 mt-4">

<!-- BACK BUTTON -->
<a href="pharmacyDashboard.jsp" class="btn btn-outline-secondary mb-3">
    <i class="bi bi-arrow-left"></i> Back to Pharmacy
</a>

<h3>Recent Medicine Orders</h3>

<div class="table-responsive mt-3">
<table class="table table-bordered table-hover">

<thead class="table-warning">
<tr>
    <th>Order ID</th>
    <th>Medicine</th>
    <th>Dosage</th>
    <th>Quantity</th>
    <th>Total Amount</th>
    <th>Status</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital","root","root");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(
"SELECT * FROM medicine_orders ORDER BY order_id DESC");

while(rs.next()){
%>

<tr>
<td data-label="Order ID"><%=rs.getInt("order_id")%></td>
<td data-label="Medicine"><%=rs.getString("medicine_name")%></td>
<td data-label="Dosage"><%=rs.getString("dosage")%></td>
<td data-label="Quantity"><%=rs.getInt("quantity")%></td>
<td data-label="Total">₹ <%=rs.getDouble("total_amount")%></td>

<td data-label="Status">
<span class="badge 
<%= rs.getString("status").equals("PENDING") ? "bg-warning" :
    rs.getString("status").equals("ACCEPTED") ? "bg-success" : "bg-danger" %>">
<%=rs.getString("status")%>
</span>
</td>

<td data-label="Action">
<%
if("PENDING".equals(rs.getString("status"))){
%>
<form action="UpdateOrderServlet" method="post" class="d-inline">
    <input type="hidden" name="order_id" value="<%=rs.getInt("order_id")%>">
    <input type="hidden" name="inventory_id" value="<%=rs.getInt("inventory_id")%>">
    <input type="hidden" name="quantity" value="<%=rs.getInt("quantity")%>">
    <input type="hidden" name="action" value="ACCEPT">
    <button class="btn btn-success btn-sm mb-1">Accept</button>
</form>

<form action="UpdateOrderServlet" method="post" class="d-inline">
    <input type="hidden" name="order_id" value="<%=rs.getInt("order_id")%>">
    <input type="hidden" name="action" value="REJECT">
    <button class="btn btn-danger btn-sm">Reject</button>
</form>
<%
}else{
%>
—
<%
}
%>
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

</body>
</html>
