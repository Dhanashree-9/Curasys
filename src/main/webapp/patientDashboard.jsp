<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Patient Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:"Poppins",sans-serif;
    background:linear-gradient(135deg,#e8f1ff,#f5fbff);
    overflow-x:hidden;
}

/* SIDEBAR */
.sidebar{
    position:fixed;
    top:0;
    left:0;
    width:260px;
    height:100vh;
    background:#1e3a8a;
    color:white;
    padding:20px;
    transition:0.3s ease-in-out;
    z-index:1200;
}

.sidebar h3{
    text-align:center;
    margin-bottom:20px;
}

.profile-box{
    text-align:center;
    margin-bottom:20px;
}

.profile-box img{
    width:80px;
    height:80px;
    border-radius:50%;
    border:3px solid #fff;
    object-fit:cover;
}

.profile-box p{
    margin-top:10px;
    font-weight:600;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:12px;
    margin:8px 0;
    background:rgba(255,255,255,0.1);
    border-radius:8px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#2563eb;
    transform:translateX(6px);
}

/* MAIN */
.main{
    margin-left:260px;
    padding:40px;
}

/* HERO */
.hero-card{
    background:white;
    border-radius:20px;
    padding:40px;
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.hero-title{font-size:32px;font-weight:700;color:#1e3a8a;}
.hero-sub{font-size:18px;color:#475569;}
.hero-desc{color:#64748b;}

.start-btn{
    margin-top:20px;
    padding:12px 26px;
    background:#2563eb;
    color:white;
    border-radius:30px;
    display:inline-flex;
    align-items:center;
    gap:10px;
    font-weight:600;
    text-decoration:none;
}

.hero-img{max-width:100%;}

.quick-card{
    background:white;
    border-radius:16px;
    padding:25px;
    text-align:center;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    cursor:pointer;
    transition:0.3s;
}

.quick-card:hover{transform:scale(1.05);}
.quick-icon{font-size:40px;}

/*** MOBILE & TABLET (≤768px) ***/
#mobile-header,#overlay{display:none;}

@media(max-width:768px){

    /* HIDE HERO IMAGE ON MOBILE */
    .hero-img{display:none !important;}

    #mobile-header{
        display:flex;
        align-items:center;
        gap:10px;
        width:100%;
        background:#1e3a8a;
        color:white;
        padding:12px 15px;
        font-size:18px;
        font-weight:600;
        position:sticky;
        top:0;
        z-index:1500;
    }

    #hamburger{
        background:none;
        border:none;
        font-size:26px;
        color:white;
    }

    .mobile-title{white-space:nowrap;}

    .sidebar{
        transform:translateX(-100%) !important;
        width:240px;
    }

    .sidebar h3,
    .sidebar .profile-box,
    .sidebar a{
        display:none;
    }

    .sidebar.show{
        transform:translateX(0) !important;
    }

    .sidebar.show h3,
    .sidebar.show .profile-box,
    .sidebar.show a{
        display:block;
    }

    #overlay{
        display:none;
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background:rgba(0,0,0,0.4);
        z-index:1100;
    }

    .main{
        margin-left:0;
        padding:20px;
    }

    .hero-card .row{
        flex-direction:column-reverse;
        text-align:center;
    }
}

/*** SMALL PHONES (≤320px) ***/
@media(max-width:320px){
    .hero-img{display:none !important;}
    .hero-title{font-size:24px;}
    .hero-sub{font-size:15px;}
    .start-btn{padding:10px 20px;font-size:14px;}
}

/*** DESKTOP ≥992px ***/
@media(min-width:992px){
    .main{margin-left:260px;}
    #mobile-header,#overlay{display:none !important;}
}
</style>
</head>
<body>

<!-- MOBILE HEADER -->
<div id="mobile-header">
    <button id="hamburger" onclick="toggleSidebar()">☰</button>
    <span class="mobile-title">Patient Panel</span>
</div>

<!-- SIDEBAR -->
<div class="sidebar" id="sidebar">
    <h3>Patient Panel</h3>

    <div class="profile-box">
        <img src="<%= request.getAttribute("photo") != null ? request.getAttribute("photo") : "images/patient.png" %>" alt="Patient">
        <p><%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "Your Name" %></p>
    </div>

    <a href="Profile.jsp">👤 Profile</a>
    <a href="pAppointment.jsp">📅 Appointments</a>
    <a href="donateOrgan.jsp">🩺 Donate Organ</a>
    <a href="PatientRequestOrgan.jsp">⚕️ Request Organ</a>
    <a href="PHistory.jsp">📜 Medical History</a>
    <a href="Scheme.jsp">📑 Health Schemes</a>
</div>

<div id="overlay" onclick="toggleSidebar()"></div>

<!-- MAIN -->
<div class="main">

    <div class="hero-card mb-5">
        <div class="row align-items-center">

            <div class="col-lg-6" data-aos="fade-right">
                <div class="hero-title">Comprehensive Health Checkups</div>
                <div class="hero-sub">Personalized Care for Every Patient</div>
                <div class="hero-desc">
                    Start your health journey with CuraSys and access trusted doctors,
                    hospitals, pharmacies, and emergency services—all in one place.
                </div>
                <a href="Profile.jsp" class="start-btn">Start Your Health Journey →</a>
            </div>

            <div class="col-lg-6 text-center" data-aos="fade-left">
                <img src="images/Doctor.png" class="hero-img">
            </div>
        </div>
    </div>

    <div class="row g-4">

        <div class="col-md-6 col-lg-3" data-aos="zoom-in">
            <div class="quick-card bg-primary text-white"
                 onclick="location.href='doctorpDashboard.jsp'">
                <div class="quick-icon">👨‍⚕️</div>
                <h5 class="mt-2">Doctors</h5>
            </div>
        </div>

        <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="100">
            <div class="quick-card bg-success text-white"
                 onclick="location.href='hospitalDashboard.jsp'">
                <div class="quick-icon">🏥</div>
                <h5 class="mt-2">Hospitals</h5>
            </div>
        </div>

        <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="200">
            <div class="quick-card bg-warning text-white"
                 onclick="location.href='patientpharmacy.jsp'">
                <div class="quick-icon">💊</div>
                <h5 class="mt-2">Pharmacy</h5>
            </div>
        </div>

        <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="300">
            <div class="quick-card bg-danger text-white"
                 onclick="location.href='patientAmbulance.jsp'">
                <div class="quick-icon">🚑</div>
                <h5 class="mt-2">Ambulance</h5>
            </div>
        </div>

    </div>

</div>

<script>
function toggleSidebar(){
    const sb=document.getElementById("sidebar");
    const ov=document.getElementById("overlay");

    if(sb.classList.contains("show")){
        sb.classList.remove("show");
        ov.style.display="none";
    }else{
        sb.classList.add("show");
        ov.style.display="block";
    }
}
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>AOS.init({duration:1200});</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
