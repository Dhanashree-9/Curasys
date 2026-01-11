<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Patient Pharmacy</title>

<!-- META VIEWPORT for responsiveness -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
/* Mobile Card Fix */
@media(max-width:768px){
    .card img{
        height:120px !important;
        object-fit:cover;
    }
    h3{
        font-size:1.4rem;
        text-align:center;
    }
    .btn-outline-secondary{
        width:100%;
        margin-bottom:10px;
    }
    .btn-outline-primary{
        width:100%;
        margin-bottom:10px;
    }
}

/* Small Phones (320px) */
@media(max-width:360px){
    .card{
        margin-bottom:12px;
    }
    .modal-dialog{
        margin:0 8px;
    }
}
</style>
</head>

<body class="bg-light">

<div class="container mt-3">

<!-- Back Button -->
<a href="PatientDashboard" class="btn btn-outline-secondary mb-3">
    <i class="bi bi-arrow-left"></i> Back
</a>

<!-- Check Orders Button -->
<a href="patientOrders.jsp" class="btn btn-outline-primary mb-3">
    Check Order Status
</a>

<% if("1".equals(request.getParameter("success"))){ %>
<div class="alert alert-success text-center">Medicine ordered successfully!</div>
<% } %>

<h3 class="mb-3">Available Medicines</h3>

<div class="row gy-3">

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/hospital","root","root");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM pharmacy_inventory");

while(rs.next()){
%>

<div class="col-6 col-md-4 col-lg-3">
<div class="card shadow-sm">
<img src="uploads/<%=rs.getString("image")%>" class="card-img-top" height="140">

<div class="card-body text-center">
<h6 class="fw-semibold"><%=rs.getString("medicine_name")%></h6>
<p class="text-muted m-0"><%=rs.getString("dosage")%></p>
<p class="m-0">₹ <%=rs.getDouble("price")%> / tablet</p>
<p class="m-0">Stock: <%=rs.getInt("total_quantity")%></p>

<button class="btn btn-primary btn-sm mt-2"
onclick="openBuy(
<%=rs.getInt("inventory_id")%>,
'<%=rs.getString("medicine_name")%>',
'<%=rs.getString("dosage")%>',
<%=rs.getDouble("price")%>
)">
Buy
</button>

</div>
</div>
</div>

<%
}
con.close();
%>

</div>
</div>

<!-- BUY MODAL -->
<div class="modal fade" id="buyModal">
<div class="modal-dialog">
<div class="modal-content">

<form action="PlaceOrderServlet" method="post">

<div class="modal-header">
<h5 class="m-0">Buy Medicine</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
<input type="hidden" name="inventory_id" id="inventory_id">
<input type="hidden" name="medicine_name" id="medicine_name">
<input type="hidden" name="dosage" id="dosage">
<input type="hidden" name="price" id="price">

<p id="medInfo" class="fw-semibold"></p>

<input type="number" name="quantity" class="form-control"
placeholder="Enter quantity" required min="1">
</div>

<div class="modal-footer">
<button class="btn btn-success w-100">Place Order</button>
</div>

</form>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function openBuy(id,name,dosage,price){
    document.getElementById("inventory_id").value = id;
    document.getElementById("medicine_name").value = name;
    document.getElementById("dosage").value = dosage;
    document.getElementById("price").value = price;

    document.getElementById("medInfo").innerHTML =
      "<b>"+name+"</b> ("+dosage+")<br>Price: ₹"+price;

    new bootstrap.Modal(document.getElementById("buyModal")).show();
}
</script>

</body>
</html>
