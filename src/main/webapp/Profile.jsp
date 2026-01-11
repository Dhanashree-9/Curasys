<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session==null || session.getAttribute("email")==null){
        response.sendRedirect("login.jsp");
        return;
    }

    String email=(String)session.getAttribute("email");

    String fullName="",age="",dob="",gender="",blood="",address="",photo="";
    String chronic="", weight="", bp="", pulse="";

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hospital","root","root");

        PreparedStatement ps=con.prepareStatement(
            "SELECT * FROM patient_profile WHERE email=?");
        ps.setString(1,email);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            fullName=rs.getString("full_name");
            age=rs.getString("age");
            dob=rs.getString("dob");
            gender=rs.getString("gender");
            blood=rs.getString("blood_group");
            address=rs.getString("address");
            photo=rs.getString("photo");
        }

        PreparedStatement vs=con.prepareStatement(
            "SELECT * FROM vitals WHERE email=?");
        vs.setString(1,email);
        ResultSet vrs=vs.executeQuery();
        if(vrs.next()){
            chronic=vrs.getString("chronic_disease");
            weight=vrs.getString("weight");
            bp=vrs.getString("bp");
            pulse=vrs.getString("pulse");
        }

        con.close();
    }catch(Exception e){}
%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
  min-height:100vh;
  font-family:"Poppins",sans-serif;
  background:url("images/pat-doc.jpg");
  background-size:cover;
  background-position:center;
  background-repeat:no-repeat;
  background-attachment:fixed;
}

.card{
  border-radius:20px;
  transition:0.4s;
}
.card:hover{
  transform:translateY(-6px);
}

.form-control{
  border-radius:14px;
  transition:0.3s;
  border:1px solid #cfe0ff;
}
.form-control:hover{
  box-shadow:0 0 0 .2rem rgba(59,130,246,.15);
  border-color:#60a5fa;
}
.section-divider{
  border-top:1px dashed #c7d7ff;
  margin:28px 0;
}
.vital-summary-card{
  background:linear-gradient(180deg,#3b82f6,#2563eb);
}
.vital-box{
  border-radius:16px;
  padding:16px;
  transition:0.3s;
}
.vital-box:hover{
  transform:scale(1.03);
}
</style>
</head>

<body>

<!-- BACK BUTTON -->
<div class="mt-3 ms-3">
  <a href="PatientDashboard" class="btn btn-primary px-4 py-1 shadow"
     style="border-radius:30px;font-weight:500;">
     ← Back
  </a>
</div>

<div class="container-xl mt-4 mb-5">
<div class="row g-4 align-items-start">

<!-- LEFT -->
<div class="col-lg-8" data-aos="fade-right">
<div class="card shadow-lg border-0 p-4">

<h4 class="text-center text-primary fw-bold mb-4">Patient Profile</h4>

<form action="ProfileServlet" method="post" enctype="multipart/form-data">

<div class="text-center mb-4" data-aos="zoom-in">
<img src="<%= photo!=null && !photo.isEmpty() ? "uploads/"+photo : "images/empty-user.png" %>"
     class="rounded-circle border border-4 border-primary shadow"
     style="width:130px;height:130px;object-fit:cover;">
</div>

<input type="file" name="photo" class="form-control mb-3">

<div class="row g-3">
<div class="col-md-6">
<input type="text" name="fullName" value="<%=fullName%>" class="form-control" placeholder="Full Name" required>
</div>

<div class="col-md-6">
<input type="number" name="age" value="<%=age%>" class="form-control" placeholder="Age" required>
</div>

<div class="col-md-6">
<input type="date" name="dob" value="<%=dob%>" class="form-control" required>
</div>

<div class="col-md-6">
<select name="gender" class="form-control">
<option <%= "Male".equals(gender)?"selected":"" %>>Male</option>
<option <%= "Female".equals(gender)?"selected":"" %>>Female</option>
<option <%= "Other".equals(gender)?"selected":"" %>>Other</option>
</select>
</div>

<div class="col-md-6">
<select name="bloodGroup" class="form-control">
<option value="">Select Blood Group</option>
<option <%= "A+".equals(blood)?"selected":"" %>>A+</option>
<option <%= "A-".equals(blood)?"selected":"" %>>A-</option>
<option <%= "B+".equals(blood)?"selected":"" %>>B+</option>
<option <%= "B-".equals(blood)?"selected":"" %>>B-</option>
<option <%= "AB+".equals(blood)?"selected":"" %>>AB+</option>
<option <%= "AB-".equals(blood)?"selected":"" %>>AB-</option>
<option <%= "O+".equals(blood)?"selected":"" %>>O+</option>
<option <%= "O-".equals(blood)?"selected":"" %>>O-</option>
</select>
</div>

<div class="col-12">
<textarea name="address" class="form-control" placeholder="Address"><%=address%></textarea>
</div>
</div>

<div class="section-divider"></div>

<h6 class="text-primary fw-bold mb-3">🩺 Vital Information</h6>

<input type="text" name="chronic" value="<%=chronic%>" class="form-control mb-2" placeholder="Chronic Disease">
<input type="text" name="weight" value="<%=weight%>" class="form-control mb-2" placeholder="Weight (kg)">
<input type="text" name="bp" value="<%=bp%>" class="form-control mb-2" placeholder="Blood Pressure">
<input type="text" name="pulse" value="<%=pulse%>" class="form-control mb-3" placeholder="Pulse Rate">

<button class="btn btn-primary w-100 mt-3 py-2 shadow">Save Profile</button>

</form>
</div>
</div>

<!-- RIGHT -->
<div class="col-lg-4" data-aos="fade-left">
<div class="card shadow-lg border-0 p-4 text-white vital-summary-card">

<h6 class="text-center fw-bold mb-3">Vital Summary</h6>

<div class="bg-white text-dark vital-box mb-3 shadow-sm text-center">
<small class="text-muted">Chronic Disease</small>
<h6 class="fw-semibold mb-0"><%= chronic!=null&&!chronic.isEmpty()?chronic:"None" %></h6>
</div>

<div class="bg-white text-dark vital-box mb-3 shadow-sm text-center">
<small class="text-muted">Weight</small>
<h6 class="fw-semibold mb-0"><%= weight!=null&&!weight.isEmpty()?weight+" kg":"--" %></h6>
</div>

<div class="bg-white text-dark vital-box mb-3 shadow-sm text-center">
<small class="text-muted">Blood Pressure</small>
<h6 class="fw-semibold mb-0"><%= bp!=null&&!bp.isEmpty()?bp:"-- / --" %></h6>
</div>

<div class="bg-white text-dark vital-box shadow-sm text-center">
<small class="text-muted">Pulse Rate</small>
<h6 class="fw-semibold mb-0"><%= pulse!=null&&!pulse.isEmpty()?pulse+" bpm":"--" %></h6>
</div>

</div>
</div>

</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>AOS.init({duration:1000, once:true});</script>

</body>
</html>
