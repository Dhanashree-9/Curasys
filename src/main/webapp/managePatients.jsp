<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>

<title>Manage Patients 🏥</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
  background:#f5f7fc;
  font-family:Poppins,Arial,Helvetica;
}

.container-box{
  max-width:1100px;
  margin:30px auto;
  background:white;
  padding:25px;
  border-radius:14px;
  box-shadow:0 10px 25px rgba(0,0,0,.1);
}

img{
  width:50px;height:50px;
  border-radius:50%;
  object-fit:cover;
}

@media(max-width:650px){
  table thead{ display:none; }
  table, tbody, tr, td{ display:block; width:100%; }
  tr{
    margin:8px 0;
    background:#f8fafc;
    padding:12px;
    border-radius:10px;
  }
  td{ margin-bottom:8px; }
  td::before{
    content:attr(data-label);
    font-weight:600;
    display:block;
    color:#475569;
  }
}
</style>
</head>

<body>

<div class="container-box">
<a href="adminDashboard.jsp" class="btn btn-secondary">← Back</a>

<h4 class="mb-3">Registered Patients 🏥</h4>

<div class="table-responsive">
<table class="table table-bordered align-middle">
<thead>
<tr>
  <th>Photo</th>
  <th>Name</th>
  <th>Email</th>
  <th>Gender</th>
  <th>Age</th>
  <th>Blood</th>
  <th>Address</th>
  <th>Action</th>
</tr>
</thead>

<tbody>
<%
ArrayList<String[]> patients = (ArrayList<String[]>)request.getAttribute("patients");

if(patients!=null && patients.size()>0){
for(String[] p : patients){
%>

<tr>
<td data-label="Photo">
<img src="<%= request.getContextPath() %>/uploads/<%= 
    (p[6] != null && !p[6].isEmpty()) ? p[6] : "default.png"
%>">
</td>

<td data-label="Name"><%= p[1] %></td>
<td data-label="Email"><%= p[0] %></td>
<td data-label="Gender"><%= p[2] %></td>
<td data-label="Age"><%= p[3] %></td>
<td data-label="Blood"><%= p[4] %></td>
<td data-label="Address"><%= p[5] %></td>

<td data-label="Action">
<form method="post" action="ManagePatientsServlet"
onsubmit="return confirm('Delete this patient?');">
<input type="hidden" name="email" value="<%= p[0] %>">
<button class="btn btn-danger btn-sm">Delete</button>
</form>
</td>

</tr>

<% }} else { %>

<tr>
<td colspan="8" class="text-center text-muted">No Patients Found</td>
</tr>

<% } %>

</tbody>
</table>
</div>


</div>

</body>
</html>
