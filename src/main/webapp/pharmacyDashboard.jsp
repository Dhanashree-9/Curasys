<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Pharmacy Dashboard</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Arial, sans-serif;
    background:#fffbea;
}

/* SIDEBAR */
.sidebar{
    width:260px;
    height:100vh;
    background:#facc15;
    position:fixed;
    top:0;
    left:0;
    padding:22px;
    text-align:center;
    transition:0.3s ease;
    z-index:1200;
}

.sidebar img{
    width:90px;
    height:90px;
    border-radius:50%;
    border:3px solid white;
    object-fit:cover;
}

.sidebar a{
    display:block;
    margin:12px 0;
    padding:10px;
    background:#fff3b0;
    text-decoration:none;
    color:#1f2937;
    border-radius:6px;
    font-weight:500;
}
.sidebar a:hover{
    background:#1f2937;
    color:white;
}

/* HAMBURGER */
.menu-btn{
    display:none;
    position:fixed;
    top:15px;
    left:15px;
    font-size:26px;
    background:#facc15;
    border:none;
    padding:8px 12px;
    border-radius:6px;
    z-index:1500;
}

/* OVERLAY */
#overlay{
    display:none;
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.35);
    z-index:1100;
}

/* MAIN */
.main{
    margin-left:280px;
    padding:20px;
    transition:0.3s ease;
}

/* HERO */
.hero{
    position:relative;
    height:300px;
    border-radius:16px;
    overflow:hidden;
    margin-top:8px;
    box-shadow:0 10px 24px rgba(0,0,0,0.18);
}
.hero img{
    width:100%;
    height:100%;
    object-fit:cover;
}

/* HERO TEXT */
.hero-center{
    position:absolute;
    top:50%;
    left:50%;
    transform:translate(-50%,-50%);
    text-align:center;
}

/* TYPEWRITER */
.typewriter{
    font-size:32px;
    font-weight:800;
    color:black;
    text-shadow:0 3px 8px rgba(0,0,0,.45);
    overflow:hidden;
    white-space:nowrap;
    border-right:3px solid white;
    animation:typing 2s steps(30,end), blink .9s infinite;
}

.hero-sub{
    font-size:15px;
    font-weight:500;
    color:black;
    margin-top:6px;
    opacity:0;
    animation:fadeIn .8s ease forwards;
    animation-delay:2s;
}

/* KEYFRAMES */
@keyframes typing{from{width:0}to{width:100%}}
@keyframes blink{50%{border-color:transparent}}
@keyframes fadeIn{to{opacity:1}}

/* STAT BOX */
.stat-box{
    border-radius:16px;
    background:white;
    padding:32px 20px;
    text-align:center;
    border:1px solid #e2e8f0;
    transition:.3s ease;
}
.stat-box:hover{
    transform:translateY(-6px);
    box-shadow:0 12px 30px rgba(0,0,0,0.18);
}

/* ICON */
.stat-icon{
    font-size:38px;
    margin-bottom:6px;
}
.roll{
    font-size:36px;
    font-weight:800;
    color:#0f172a;
}
.stat-label{
    font-size:15px;
    color:#475569;
    margin-top:6px;
    font-weight:600;
}

/* RESPONSIVE FIXES */
@media(max-width:992px){
    .sidebar{
        left:-260px;
        padding:18px;
        width:240px;
    }
    .sidebar.active{
        left:0;
    }
    .menu-btn{
        display:block;
    }
    .main{
        margin-left:0;
        padding:16px;
    }
    .hero{
        height:240px;
    }
    .typewriter{
        font-size:26px;
    }
}

@media(max-width:768px){
    .sidebar{
        width:220px;
    }
    .hero{
        height:210px;
    }
    .typewriter{
        font-size:22px;
    }
    .stat-box{
        padding:24px 16px;
    }
    .roll{
        font-size:30px;
    }
}

@media(max-width:576px){
    .sidebar{
        width:200px;
    }
    .hero{
        height:200px;
        border-radius:10px;
    }
    .hero-center{
        padding:0 10px;
        width:100%;
    }
    .typewriter{
        font-size:18px;
        white-space:normal;
        border-right:none;
    }
    .hero-sub{
        font-size:13px;
    }
    .stat-box{
        padding:20px 12px;
        border-radius:12px;
    }
    .roll{
        font-size:24px;
    }
    .stat-label{
        font-size:13px;
    }
}
</style>
</head>

<body>

<button class="menu-btn" onclick="toggleMenu()">☰</button>
<div id="overlay" onclick="toggleMenu()"></div>

<%
String name="Pharmacist Name";
String photo="pharmacy.png";
int totalMedicines=0,totalOrders=0,totalInventory=0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","root");
    Statement st=con.createStatement();

    ResultSet rs=st.executeQuery("SELECT * FROM pharmacy_profile WHERE id=1");
    if(rs.next()){
        name=rs.getString("name");
        if(rs.getString("photo")!=null) photo=rs.getString("photo");
    }

    rs=st.executeQuery("SELECT COUNT(*) FROM pharmacy_inventory");
    if(rs.next()) totalMedicines=rs.getInt(1);

    rs=st.executeQuery("SELECT COUNT(*) FROM medicine_orders");
    if(rs.next()) totalOrders=rs.getInt(1);

    rs=st.executeQuery("SELECT SUM(total_quantity) FROM pharmacy_inventory");
    if(rs.next()) totalInventory=rs.getInt(1);

    con.close();
}catch(Exception e){e.printStackTrace();}
%>

<div class="sidebar" id="sidebar">
    <img src="uploads/<%=photo%>">
    <h5 class="mt-2"><%=name%></h5>
    <hr>
    <a href="pharmacyProfile.jsp">My Profile</a>
    <a href="recentOrders.jsp">Recent Orders</a>
    <a href="inventory.jsp">Inventory</a>
    <a href="pharmacyHistory.jsp">History</a>
</div>

<div class="main">

<div class="hero" data-aos="fade-up">
    <img src="images/pharmacy1.jpg">
    <div class="hero-center">
        <h2 class="typewriter">Welcome to Pharmacist Dashboard 👋</h2>
        <p class="hero-sub">Manage medicines, orders and inventory.</p>
    </div>
</div>

<div class="row mt-4">

    <div class="col-lg-3 col-md-6 mb-3" data-aos="fade-up">
        <div class="stat-box">
            <div class="stat-icon">💊</div>
            <div class="roll" data-num="<%=totalMedicines%>">0</div>
            <div class="stat-label">Total Medicines</div>
        </div>
    </div>

    <div class="col-lg-3 col-md-6 mb-3" data-aos="fade-up" data-aos-delay="100">
        <div class="stat-box">
            <div class="stat-icon">📦</div>
            <div class="roll" data-num="<%=totalOrders%>">0</div>
            <div class="stat-label">Total Orders</div>
        </div>
    </div>

    <div class="col-lg-3 col-md-6 mb-3" data-aos="fade-up" data-aos-delay="200">
        <div class="stat-box">
            <div class="stat-icon">🏪</div>
            <div class="roll" data-num="<%=totalInventory%>">0</div>
            <div class="stat-label">Inventory Stock</div>
        </div>
    </div>

    <div class="col-lg-3 col-md-6 mb-3" data-aos="fade-up" data-aos-delay="300">
        <a href="inventory.jsp" style="text-decoration:none;">
            <div class="stat-box">
                <div class="stat-icon">➕</div>
                <div class="stat-label">Add Medicines</div>
            </div>
        </a>
    </div>
</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
AOS.init({duration:900, once:true});

function toggleMenu(){
    const sidebar=document.getElementById("sidebar");
    const overlay=document.getElementById("overlay");
    sidebar.classList.toggle("active");
    overlay.style.display=sidebar.classList.contains("active") ? "block" : "none";
}

/* NUMBER ROLL */
function rollNumber(el,target){
    let num=0;
    let timer=setInterval(()=>{
        num++;
        el.innerText=num;
        if(num>=target) clearInterval(timer);
    },10);
}

document.addEventListener("DOMContentLoaded",()=>{
    document.querySelectorAll(".roll").forEach(r=>{
        rollNumber(r,parseInt(r.dataset.num));
    });
});
</script>

</body>
</html>
