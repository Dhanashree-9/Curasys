<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
  margin:0;
  background:#f5f7fc;
  font-family:Poppins,Arial,Helvetica;
  color:#1e293b;
}

/* SIDEBAR */
.sidebar{
  position:fixed;
  top:0;
  left:0;
  width:260px;
  height:100vh;
  background:#0f172a;
  color:white;
  padding:20px;
  transition:transform .3s ease;
  z-index:2000;
}

.sidebar img{
  width:85px;
  height:85px;
  border-radius:50%;
  object-fit:cover;
}

.sidebar a{
  display:block;
  padding:12px;
  margin:6px 0;
  background:#1e293b;
  color:white;
  text-decoration:none;
  border-radius:8px;
  font-size:14px;
}

.sidebar a:hover{
  opacity:0.92;
}

.logout{
  background:#b91c1c!important;
}

/* MAIN SECTION */
.main{
  margin-left:260px;
  padding:35px;
  transition:.3s ease;
}

h4,h5,h6{
  font-weight:600;
  color:#1e293b;
}

/* BOX CSS */
.card-box{
  border-radius:14px;
  background:white;
  padding:24px 12px;
  border:1px solid #e2e8f0;
  box-shadow:0 2px 6px rgba(0,0,0,0.05);
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  min-height:110px;
}

.card-box h6{
  font-size:12px;
  font-weight:600;
  letter-spacing:0.5px;
  text-transform:uppercase;
  margin-bottom:6px;
  color:#475569;
}

.card-box h3{
  font-size:32px;
  font-weight:700;
  margin:0;
  color:#1e293b;
}

/* Responsive Fixes */
@media(max-width:380px){
  .card-box{
    min-height:95px;
    padding:18px 8px;
  }
  .card-box h6{ font-size:10px; }
  .card-box h3{ font-size:24px; }
}

/* RESPONSIVE SIDEBAR */
.toggle-btn{
  display:none;
  position:fixed;
  top:15px;
  left:15px;
  background:#0f172a;
  color:white;
  border:none;
  padding:10px 14px;
  border-radius:6px;
  z-index:3000;
}

@media(max-width:992px){
  .main{ margin-left:0; }
  .toggle-btn{ display:block; }
  .sidebar{ transform:translateX(-260px); }
  .sidebar.active{ transform:translateX(0); }
}
</style>
</head>

<body>

<button class="toggle-btn" onclick="toggleMenu()">
  <i class="fas fa-bars"></i>
</button>

<%
String adminName="", adminPhoto="";
int doctor=0,patient=0,pharmacy=0,ambulance=0;
int totalAppointments=0, approved=0, pending=0, rejected=0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/hospital","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT admin_name, photo FROM admin LIMIT 1"
    );
    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        adminName = rs.getString(1);
        adminPhoto = rs.getString(2);
    }

    Statement st = con.createStatement();
    rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='DOCTOR'"); rs.next(); doctor = rs.getInt(1);
    rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='PATIENT'"); rs.next(); patient = rs.getInt(1);
    rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='PHARMACY'"); rs.next(); pharmacy = rs.getInt(1);
    rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='AMBULANCE'"); rs.next(); ambulance = rs.getInt(1);

    rs = st.executeQuery("SELECT COUNT(*) FROM appointment"); rs.next(); totalAppointments = rs.getInt(1);
    rs = st.executeQuery("SELECT COUNT(*) FROM appointment WHERE status='APPROVED'"); rs.next(); approved = rs.getInt(1);
    rs = st.executeQuery("SELECT COUNT(*) FROM appointment WHERE status='PENDING'"); rs.next(); pending = rs.getInt(1);
    rs = st.executeQuery("SELECT COUNT(*) FROM appointment WHERE status='REJECTED'"); rs.next(); rejected = rs.getInt(1);

    con.close();
}catch(Exception e){ e.printStackTrace(); }
%>

<div class="sidebar" id="sidebar">
  <div class="text-center mb-3">
    <img src="<%= (adminPhoto!=null && !adminPhoto.isEmpty())? ("images/"+adminPhoto) : "images/default.png" %>">
    <h6 class="mt-2"><%= adminName %></h6>
  </div>

  <a href="ManageDoctorsServlet">Manage Doctors</a>
  <a href="ManagePatientsServlet">Manage Patients</a>
  <a href="ManagePharmacyServlet">Manage Pharmacy</a>
  <a href="ManageAmbulanceServlet">Manage Ambulance</a>
  <a href="login.jsp" class="logout">Logout</a>
</div>

<div class="main">

  <h4 class="text-center mb-4" data-aos="fade-down">Welcome Admin 👋</h4>

  <!-- MAIN BOXES RESPONSIVE -->
  <div class="row row-cols-2 row-cols-md-4 g-3 g-md-4 text-center">

      <div class="col">
        <div class="card-box" data-aos="fade-right">
          <h6>Total Doctors</h6>
          <h3><%=doctor%></h3>
        </div>
      </div>

      <div class="col">
        <div class="card-box" data-aos="fade-down">
          <h6>Total Patients</h6>
          <h3><%=patient%></h3>
        </div>
      </div>

      <div class="col">
        <div class="card-box" data-aos="fade-down">
          <h6>Total Pharmacy</h6>
          <h3><%=pharmacy%></h3>
        </div>
      </div>

      <div class="col">
        <div class="card-box" data-aos="fade-left">
          <h6>Total Ambulance</h6>
          <h3><%=ambulance%></h3>
        </div>
      </div>
  </div>

  <!-- APPOINTMENT BOXES -->
  <div class="row row-cols-2 row-cols-md-4 g-3 g-md-4 text-center mt-3">

      <div class="col">
        <div class="card-box">
          <h6>Total Appointments</h6>
          <h3><%=totalAppointments%></h3>
        </div>
      </div>

      <div class="col">
        <div class="card-box" style="border-left:5px solid #22c55e;">
          <h6>Approved</h6>
          <h3 style="color:#22c55e;"><%=approved%></h3>
        </div>
      </div>

      <div class="col">
        <div class="card-box" style="border-left:5px solid #facc15;">
          <h6>Pending</h6>
          <h3 style="color:#facc15;"><%=pending%></h3>
        </div>
      </div>

      <div class="col">
        <div class="card-box" style="border-left:5px solid #ef4444;">
          <h6>Rejected</h6>
          <h3 style="color:#ef4444;"><%=rejected%></h3>
        </div>
      </div>

  </div>

</div>

<script>
function toggleMenu(){
   document.getElementById("sidebar").classList.toggle("active");
}
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>AOS.init({ duration:800, once:true });</script>

</body>
</html>
