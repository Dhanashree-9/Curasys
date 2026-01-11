<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session==null || session.getAttribute("email")==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Hospital Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{font-family:Poppins,sans-serif;background:linear-gradient(135deg,#dbeafe,#eff6ff);}
.doctor-card{background:#fff;border-radius:22px;overflow:hidden;box-shadow:0 18px 40px rgba(30,64,175,.18);transition:.4s}
.doctor-card:hover{transform:translateY(-10px)}
.doctor-img{width:100%;height:170px;object-fit:cover}
.doctor-name{text-align:center;padding:15px;font-weight:700;color:#1e3a8a}
.back-arrow{position:fixed;top:20px;left:20px;width:45px;height:45px;background:#fff;color:#1e3a8a;font-size:26px;border-radius:50%;display:flex;align-items:center;justify-content:center;text-decoration:none;box-shadow:0 10px 25px rgba(30,64,175,.25)}
.back-arrow:hover{background:#2563eb;color:#fff}
</style>
</head>

<body>
<a href="PatientDashboard" class="back-arrow">&#8592;</a>

<div class="container py-4">
<h3 class="text-center fw-bold text-primary mb-4">Doctor Specializations</h3>

<div class="row g-4">

<%
String[][] specs = {
 {"gynaecologist","Gynaecologists"},
 {"cardiologist","Cardiologists"},
 {"dermatologist","Dermatologists"},
 {"orthopedic","Orthopedic"},
 {"neurologist","Neurologists"},
 {"pediatrician","Pediatricians"},
 {"psychiatrist","Psychiatrists"},
 {"oncologist","Oncologists"},
 {"ent","ENT Specialists"},
 {"ophthalmologist","Ophthalmologists"},
 {"urologist","Urologists"},
 {"nephrologist","Nephrologists"},
 {"dentist","Dentists"},
 {"pulmonologist","Pulmonologists"},
 {"gastroenterologist","Gastroenterologists"},
 {"endocrinologist","Endocrinologists"},
 {"radiologist","Radiologists"},
 {"generalphysician","General Physicians"},
 {"surgeon","Surgeons"},
 {"anesthesiologist","Anesthesiologists"}
};

for(String[] s: specs){
%>
<div class="col-md-3">
<a href="HospitalServlet?type=<%=s[0]%>" class="text-decoration-none">
<div class="doctor-card">
<img src="images/<%=s[0]%>.jpg" class="doctor-img">
<div class="doctor-name"><%=s[1]%></div>
</div>
</a>
</div>
<% } %>

</div>
</div>
</body>
</html>
