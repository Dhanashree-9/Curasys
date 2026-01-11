<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    background:#f8fafc;
    font-family:Arial, sans-serif;
}
.profile-card{
    max-width:650px;
    margin:auto;
}
</style>
</head>

<body>

<div class="container mt-4">

<!-- BACK BUTTON -->
<a href="pharmacyDashboard.jsp" class="btn btn-outline-secondary mb-3">
    <i class="bi bi-arrow-left"></i> Back to Dashboard
</a>

<h3 class="mb-3">My Profile</h3>

<%
String name="",email="",contact="",degree="",license="";
int age=0,experience=0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/hospital","root","root");

    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery(
        "SELECT * FROM pharmacy_profile WHERE id=1");

    if(rs.next()){
        name=rs.getString("name");
        email=rs.getString("email");
        contact=rs.getString("contact");
        degree=rs.getString("degree");
        license=rs.getString("license_number");
        age=rs.getInt("age");
        experience=rs.getInt("experience");
    }
    con.close();
}catch(Exception e){}
%>

<div class="card profile-card shadow-sm p-4">

<form action="PharmacyProfileServlet" method="post" enctype="multipart/form-data">

<div class="row g-3">

<div class="col-md-6">
<label class="form-label">Name</label>
<input name="name" value="<%=name%>" class="form-control" required>
</div>

<div class="col-md-6">
<label class="form-label">Email</label>
<input name="email" value="<%=email%>" class="form-control">
</div>

<div class="col-md-6">
<label class="form-label">Contact</label>
<input name="contact" value="<%=contact%>" class="form-control">
</div>

<div class="col-md-6">
<label class="form-label">Degree</label>
<input name="degree" value="<%=degree%>" class="form-control">
</div>

<div class="col-md-6">
<label class="form-label">License Number</label>
<input name="license" value="<%=license%>" class="form-control">
</div>

<div class="col-md-3">
<label class="form-label">Age</label>
<input name="age" value="<%=age%>" class="form-control">
</div>

<div class="col-md-3">
<label class="form-label">Experience (Years)</label>
<input name="experience" value="<%=experience%>" class="form-control">
</div>

<div class="col-12">
<label class="form-label">Profile Photo</label>
<input type="file" name="photo" class="form-control">
</div>

</div>

<div class="mt-4 text-end">
<button class="btn btn-warning px-4">Save Profile</button>
</div>

</form>

</div>

</div>

</body>
</html>
