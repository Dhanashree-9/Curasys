<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Manage Ambulance</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{background:#f4f6fb;font-family:Poppins,Arial;}
.card{
    max-width:1100px;
    margin:40px auto;
    padding:20px;
    border-radius:14px;
    box-shadow:0 10px 25px rgba(0,0,0,.1);
}
img{
    width:50px;height:50px;
    border-radius:50%;object-fit:cover;
}
</style>
</head>

<body>

<div class="card">
<a href="adminDashboard.jsp" class="btn btn-secondary mt-3">
⬅ Back
</a>
<h4 class="mb-3">Registered Ambulances</h4>

<table class="table table-bordered table-hover">
<thead class="table-dark">
<tr>
<th>Photo</th>
<th>Driver Name</th>
<th>Contact</th>
<th>Action</th>
</tr>
</thead>

<tbody>
<%
ArrayList<String[]> ambulances =
(ArrayList<String[]>)request.getAttribute("ambulances");

for(String[] a : ambulances){
%>
<tr>
<td>
<img src="<%= request.getContextPath() %>/<%= 
(a[3] != null && !a[3].isEmpty()) ? a[3] : "images/default.png" 
%>">
</td>
<td><%= a[1] %></td>
<td><%= a[2] %></td>
<td>
<form method="post" action="ManageAmbulanceServlet"
onsubmit="return confirm('Delete this ambulance?');">
<input type="hidden" name="id" value="<%= a[0] %>">
<button class="btn btn-sm btn-danger">Delete</button>
</form>
</td>
</tr>
<% } %>
</tbody>
</table>


</div>

</body>
</html>
