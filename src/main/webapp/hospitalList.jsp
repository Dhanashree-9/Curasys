<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
String type = (String) request.getAttribute("type");
if(type == null) type = "Hospital";

ArrayList<String[]> hospitals =
(ArrayList<String[]>) request.getAttribute("hospitals");

if(hospitals == null) hospitals = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<title>Hospitals</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body{font-family:Poppins,sans-serif;background:#eef4ff}
.card{border-radius:16px;box-shadow:0 10px 25px rgba(0,0,0,.1)}
.map-box{border-radius:16px;overflow:hidden}
</style>
</head>

<body>
<div class="container py-4">

<a href="PatientDashboard" class="btn btn-primary mb-3">← Back</a>

<h3 class="text-center fw-bold text-primary mb-4">
<%= type.toUpperCase() %> Hospitals Near You
</h3>

<div class="row">
<div class="col-md-5">

<% if(!hospitals.isEmpty()){ 
for(String[] h : hospitals){ %>
<div class="card p-3 mb-3">
<h5><%= h[0] %></h5>
<p><%= h[1] %></p>
<a class="btn btn-outline-primary btn-sm"
target="_blank"
href="https://www.google.com/maps?q=<%=h[2]%>,<%=h[3]%>">
View on Map
</a>
</div>
<% }} else { %>
<p class="text-danger">No hospitals found.</p>
<% } %>

</div>

<div class="col-md-7">
<div class="map-box">
<iframe width="100%" height="450"
src="https://www.google.com/maps?q=<%=type%> hospitals near me&output=embed">
</iframe>
</div>
</div>
</div>
</div>
</body>
</html>
