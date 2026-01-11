<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
.sidebar{
    position:fixed;
    top:0; left:0;
    width:260px;
    height:100vh;
    background:#ff4d88;
    color:white;
    padding:20px;
    z-index:1000;
    transition:0.3s;
}
.sidebar img{
    width:80px;
    height:80px;
    border-radius:50%;
    object-fit:cover;
    border:3px solid white;
    display:block;
    margin:0 auto 10px;
}
.sidebar h5{text-align:center;margin-bottom:20px;}
.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:10px;
    margin:8px 0;
    border-radius:8px;
}
.sidebar a:hover{background:#ff85a2;}

.content{margin-left:260px;padding:20px;}

.hamburger{
    font-size:26px;
    cursor:pointer;
    color:#ff4d88;
    position:fixed;
    top:15px;
    left:15px;
    z-index:1100;
    display:none;
}

@media(max-width:768px){
    .sidebar{left:-260px;}
    .sidebar.active{left:0;}
    .content{margin-left:0;padding-top:60px;}
    .hamburger{display:block;}
}
</style>

<%
String driverName = "Ambulance User";
String profileImg = "images/default.png"; // DEFAULT

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/hospital","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT driver_name, photo FROM ambulance_profile ORDER BY ambulance_id DESC LIMIT 1");

    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        driverName = rs.getString("driver_name");
        if(rs.getString("photo") != null && !rs.getString("photo").trim().equals("")){
            profileImg = rs.getString("photo");
        }
    }
    con.close();
}catch(Exception e){}
%>

<span class="hamburger" onclick="toggleSidebar()">☰</span>

<div class="sidebar" id="sidebar">
    <img src="<%= request.getContextPath()+"/"+profileImg %>">
    <h5><%= driverName %></h5>

  
    <a href="ambulanceProfile.jsp">Profile</a>
    <a href="ambulanceEmergency.jsp">Emergency</a>
    <a href="ambulanceRequests.jsp">Patient Requests</a>
</div>

<script>
function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("active");
}
</script>
