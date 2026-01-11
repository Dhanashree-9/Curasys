<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Doctor History</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
  font-family:Arial, sans-serif;
  background:#f4f7ff;
  margin:0;
}

/* ===== SIDEBAR ===== */
.sidebar{
  position:fixed;
  top:0;
  left:0;
  width:260px;
  height:100vh;
  background:#1e3a8a;
  color:#fff;
  padding:25px;
}
.sidebar h5{
  margin-bottom:20px;
}
.sidebar a{
  display:block;
  color:#fff;
  text-decoration:none;
  padding:12px;
  margin-bottom:10px;
  border-radius:10px;
  background:rgba(255,255,255,.15);
}
.sidebar a:hover{
  background:#3b82f6;
}

/* ===== MAIN ===== */
.main{
  margin-left:260px;
  padding:25px;
  background:#fff;
  min-height:100vh;
}

/* ===== SUMMARY BOX ===== */
.summary{
  border-radius:14px;
  padding:18px;
  color:white;
  text-align:center;
  font-weight:bold;
}
.bg-blue{background:#2563eb;}
.bg-green{background:#16a34a;}
.bg-red{background:#dc2626;}

/* ===== HISTORY CARD ===== */
.history-card{
  background:#f8fafc;
  border-left:5px solid #2563eb;
  border-radius:12px;
  padding:15px;
  margin-bottom:15px;
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px){
  .sidebar{
    position:relative;
    width:100%;
    height:auto;
  }
  .main{
    margin-left:0;
  }
}
</style>
</head>

<body>

<%
/* ===== GET DOCTOR ID FROM URL ===== */
int doctorId = 1;
if(request.getParameter("doctor_id") != null){
    doctorId = Integer.parseInt(request.getParameter("doctor_id"));
}else{
    out.println("<h4 class='text-danger'>Doctor ID missing</h4>");
    return;
}


/* ===== COUNTS ===== */
int total=0, approved=0, rejected=0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/hospital","root","root");

    PreparedStatement ps;

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM appointment WHERE doctor_id=?");
    ps.setInt(1, doctorId);
    ResultSet rs = ps.executeQuery();
    if(rs.next()) total = rs.getInt(1);

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM appointment WHERE doctor_id=? AND status='APPROVED'");
    ps.setInt(1, doctorId);
    rs = ps.executeQuery();
    if(rs.next()) approved = rs.getInt(1);

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM appointment WHERE doctor_id=? AND status='REJECTED'");
    ps.setInt(1, doctorId);
    rs = ps.executeQuery();
    if(rs.next()) rejected = rs.getInt(1);

    con.close();
}catch(Exception e){
    e.printStackTrace();
}
%>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
  <h5>Doctor Panel</h5>
  <a href="doctorProfile.jsp?doctor_id=<%=doctorId%>">Profile</a>
  <a href="DoctorAppointments.jsp?doctor_id=<%=doctorId%>">Appointments</a>
  <a href="doctorHistory.jsp?doctor_id=<%=doctorId%>" style="background:#3b82f6">History</a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<h3>Doctor History</h3>
<p class="text-muted">Real-time appointment history</p>

<div class="row mb-4">
  <div class="col-md-4 mb-2">
    <div class="summary bg-blue">
      <h3><%=total%></h3>
      Total Appointments
    </div>
  </div>
  <div class="col-md-4 mb-2">
    <div class="summary bg-green">
      <h3><%=approved%></h3>
      Approved
    </div>
  </div>
  <div class="col-md-4 mb-2">
    <div class="summary bg-red">
      <h3><%=rejected%></h3>
      Rejected
    </div>
  </div>
</div>

<!-- ===== HISTORY LIST ===== -->
<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/hospital","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT a.*, p.name FROM appointment a " +
        "JOIN patient_profile p ON a.patient_id=p.patient_id " +
        "WHERE a.doctor_id=? AND a.status!='PENDING' " +
        "ORDER BY a.appointment_id DESC");

    ps.setInt(1, doctorId);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

<div class="history-card">
  <h6>Patient: <%=rs.getString("name")%></h6>
  <p><%=rs.getString("description")%></p>

  <span class="badge 
    <%=rs.getString("status").equals("APPROVED")?"bg-success":"bg-danger"%>">
    <%=rs.getString("status")%>
  </span>

  <span class="badge bg-secondary">
    <%=rs.getDate("appointment_date")%>
  </span>
</div>

<%
    }
    con.close();
}catch(Exception e){
    e.printStackTrace();
}
%>

</div>

</body>
</html>
