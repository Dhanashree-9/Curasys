<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Nearby Blood Banks</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
  font-family:Poppins,sans-serif;
  background:#f4f7ff;
  margin:0;
  overflow:hidden;
}

/* ===== FIXED SIDEBAR (FROM DOCTOR DASHBOARD) ===== */
.sidebar{
  position:fixed;
  top:0;
  left:0;
  width:300px;
  height:100vh;
  background:#1e3a8a;
  color:#fff;
  padding:30px;
  overflow-y:auto;
}

/* Doctor Profile */
.doctor-box{
  background:rgba(255,255,255,.15);
  border-radius:20px;
  padding:25px;
  text-align:center;
  margin-bottom:35px;
}
.doctor-box img{
  width:100px;
  height:100px;
  border-radius:50%;
  border:4px solid #fff;
  object-fit:cover;
}
.doctor-box h5{
  margin-top:15px;
  font-weight:700;
}
.doctor-box p{
  font-size:14px;
  opacity:.85;
}

/* Sidebar Links */
.sidebar a{
  display:block;
  color:#fff;
  text-decoration:none;
  padding:16px 18px;
  margin-bottom:14px;
  border-radius:14px;
  background:rgba(255,255,255,.18);
  font-size:16px;
}
.sidebar a:hover{
  background:#3b82f6;
}

/* ===== MAIN CONTENT (BLOOD BANK UI ONLY) ===== */
.main-content{
  margin-left:300px;
  height:100vh;
  padding:30px;
  background:#fff0f6;
}

/* HEADER */
.header{
  text-align:center;
  margin-bottom:25px;
}
.header h2{
  color:#ff1a75;
  font-weight:800;
}
.header button{
  background:#ff1a75;
  color:#fff;
  border:none;
  padding:10px 26px;
  border-radius:30px;
}

/* SCROLLABLE BLOOD BANK AREA */
.scroll-area{
  height:calc(100vh - 120px);
  overflow-y:auto;
  padding-right:10px;
}

/* BLOOD BANK CARD */
.bb-card{
  background:#fff;
  border:2px solid #ff4d88;
  border-radius:18px;
  padding:16px;
  display:flex;
  gap:15px;
}
.bb-card img{
  width:80px;
  height:80px;
}
.bb-card h5{
  color:#ff1a75;
  font-weight:700;
}
.location-btn{
  background:#ff4d88;
  color:white;
  border:none;
  padding:6px 14px;
  border-radius:20px;
  font-size:14px;
}

/* MOBILE */
@media(max-width:992px){
  .sidebar{
    position:relative;
    width:100%;
    height:auto;
  }
  .main-content{
    margin-left:0;
    height:auto;
  }
}
</style>

<script>
function showLocation(lat,lng,name){
  document.getElementById("mapTitle").innerText=name;
  document.getElementById("mapFrame").src =
    "https://www.openstreetmap.org/export/embed.html?bbox="
    +lng+","+lat+","+lng+","+lat+"&layer=mapnik";
  new bootstrap.Modal(document.getElementById("mapModal")).show();
}
</script>
</head>

<body>

<!-- MOBILE NAVBAR -->
<nav class="navbar navbar-dark bg-primary d-lg-none">
  <div class="container-fluid">
    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#mobileSidebar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <span class="navbar-brand">Doctor Panel</span>
  </div>
</nav>

<!-- ===== SIDEBAR (UNCHANGED) ===== -->
<div class="sidebar collapse d-lg-block" id="mobileSidebar">

  <div class="doctor-box">
    <img src="<%=session.getAttribute("doctorImg")%>">
    <h5><%=session.getAttribute("doctorName")%></h5>
    <p><%=session.getAttribute("doctorSpec")%></p>
  </div>

  <a href="doctorProfile.jsp">👨‍⚕️ Profile</a>
  <a href="DoctorAppointments.jsp">📅 Appointments</a>
  <a href="bloodbank.jsp" style="background:#3b82f6">🩸 Blood Banks</a>
  <a href="drequestOrgan.jsp">🫀 Organ Requests</a>
 

</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">

  <div class="header">
    <h2>Nearby Blood Banks</h2>
    <button>Find Nearby Blood Banks</button>
  </div>

  <div class="scroll-area">
    <div class="row g-4">

<%
String[][] banks={
{"Om Blood Centre","Mangalwar Peth, Pune","4.0","24 Hrs","18.5204","73.8567"},
{"Red Cross Blood Bank","Camp, Pune","4.3","9AM-9PM","18.5136","73.8780"},
{"Sasoon Blood Bank","Shivajinagar","4.1","24 Hrs","18.5308","73.8475"},
{"Ruby Hall Blood Bank","Bund Garden","4.5","24 Hrs","18.5362","73.8936"},
{"KEM Blood Bank","Rasta Peth","4.2","24 Hrs","18.5231","73.8644"},
{"Deenanath Blood Bank","Erandwane","4.6","24 Hrs","18.5074","73.8304"},
{"YCM Blood Bank","Pimpri","4.0","24 Hrs","18.6298","73.7997"},
{"Noble Blood Bank","Hadapsar","4.1","10AM-8PM","18.5089","73.9260"},
{"Jupiter Blood Bank","Baner","4.4","24 Hrs","18.5590","73.7868"},
{"Sahyadri Blood Bank","Karve Nagar","4.3","24 Hrs","18.4986","73.8143"},
{"Apollo Blood Bank","Nigdi","4.5","24 Hrs","18.6517","73.7610"},
{"Jehangir Blood Bank","Camp","4.6","24 Hrs","18.5236","73.8746"}
};

for(int i=0;i<banks.length;i++){
%>

<div class="col-md-6">
  <div class="bb-card">
    <img src="images/blood.jpg">
    <div>
      <h5><%=banks[i][0]%></h5>
      <p><%=banks[i][1]%></p>
      <p>⭐ <%=banks[i][2]%> | ⏰ <%=banks[i][3]%></p>
      <p>Blood Groups: A+, B+, O+, AB+</p>
      <button class="location-btn"
        onclick="showLocation('<%=banks[i][4]%>','<%=banks[i][5]%>','<%=banks[i][0]%>')">
        Show Location
      </button>
    </div>
  </div>
</div>

<% } %>

    </div>
  </div>
</div>

<!-- MAP MODAL -->
<div class="modal fade" id="mapModal">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 id="mapTitle"></h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <iframe id="mapFrame" width="100%" height="350" style="border:0;"></iframe>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
