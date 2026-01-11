<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<title>Ambulance Requests</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

.request-card {
  border: 1px solid #e1e1e1;
  border-radius: 10px;
  padding: 14px;
  background: #ffffff;
  margin-bottom: 15px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.06);
}

.label-text {
  font-weight: 600;
  font-size: 14px;
}

@media(max-width: 768px) {
  body {
     padding: 4px;
     font-size: 14px;
  }
  .request-card {
     padding: 12px;
  }
}

</style>
</head>

<body class="bg-light">

<div class="container mt-4">
<a href="ambulanceDashboard.jsp" class="btn btn-outline-primary mb-3">← Back to Dashboard</a>
<h3>Patient Emergency Requests</h3>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");

PreparedStatement ps = con.prepareStatement("SELECT * FROM ambulance_request");
ResultSet rs = ps.executeQuery();

ArrayList<String[]> requests = new ArrayList<>();

while(rs.next()){
    requests.add(new String[]{
        rs.getString("request_id"),
        rs.getString("patient_name"),
        rs.getString("pickup_location"),
        rs.getString("contact_number"),
        rs.getString("status")
    });
}
con.close();
%>

<!-- Desktop Table -->
<div class="d-none d-md-block mt-3">
<table class="table table-bordered bg-white">
<thead class="table-primary">
<tr>
<th>Patient</th>
<th>Pickup</th>
<th>Contact</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<%
for(String[] r : requests){
%>
<tr>
<td><%= r[1] %></td>
<td><%= r[2] %></td>
<td><%= r[3] %></td>
<td><%= r[4] %></td>
<td>
<form action="UpdateAmbulanceRequest" method="post">
<input type="hidden" name="requestId" value="<%= r[0] %>">
<button name="status" value="APPROVED" class="btn btn-success btn-sm">Approve</button>
<button name="status" value="REJECTED" class="btn btn-danger btn-sm">Reject</button>
</form>
</td>
</tr>
<%
}
%>
</tbody>
</table>
</div>

<!-- Mobile Cards -->
<div class="d-block d-md-none mt-3">
<%
for(String[] r : requests){
%>
<div class="request-card">

<div class="row mb-1">
<div class="col-5 label-text">Patient:</div>
<div class="col-7"><%= r[1] %></div>
</div>

<div class="row mb-1">
<div class="col-5 label-text">Pickup:</div>
<div class="col-7"><%= r[2] %></div>
</div>

<div class="row mb-1">
<div class="col-5 label-text">Contact:</div>
<div class="col-7"><%= r[3] %></div>
</div>

<div class="row mb-2">
<div class="col-5 label-text">Status:</div>
<div class="col-7">
<span class="badge 
<%= r[4].equals("APPROVED") ? "bg-success" : r[4].equals("REJECTED") ? "bg-danger" : "bg-warning text-dark" %>">
<%= r[4] %>
</span>
</div>
</div>

<form action="UpdateAmbulanceRequest" method="post">
<input type="hidden" name="requestId" value="<%= r[0] %>">
<button name="status" value="APPROVED" class="btn btn-success btn-sm w-100 mb-1">Approve</button>
<button name="status" value="REJECTED" class="btn btn-danger btn-sm w-100">Reject</button>
</form>

</div>
<%
}
%>
</div>

</div>

</div>
</body>
</html>
