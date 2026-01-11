<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Inventory</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background:#fffbea;
    font-family:Arial;
}

/* Card image */
.card img{
    height:150px;
    object-fit:cover;
}

/* Chart responsive */
.chart-container{
    max-width:500px;
    margin:auto;
}

/* Mobile spacing */
@media(max-width:576px){
    h3{
        font-size:22px;
    }
    .card img{
        height:130px;
    }
}
</style>
</head>

<body>

<div class="container-fluid px-3 px-md-4 mt-4">

<!-- BACK BUTTON -->
<a href="pharmacyDashboard.jsp" class="btn btn-outline-secondary mb-3">
    <i class="bi bi-arrow-left"></i> Back to Pharmacy
</a>

<div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-3">
    <h3 class="mb-2 mb-md-0">Medicine Inventory</h3>

    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#addModal">
        + Add Medicine
    </button>
</div>

<div class="row g-3">

<%
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital","root","root");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM pharmacy_inventory");

String labels = "";
String data = "";

while(rs.next()){
    labels += "'" + rs.getString("medicine_name") + "',";
    data += rs.getInt("total_quantity") + ",";
%>

<div class="col-lg-3 col-md-6 col-sm-12">
<div class="card h-100 shadow-sm">
<img src="uploads/<%=rs.getString("image")%>" class="card-img-top">
<div class="card-body text-center">
<h6><%=rs.getString("medicine_name")%></h6>
<p class="mb-1"><%=rs.getString("dosage")%></p>
<p class="mb-1"><b>Stock:</b> <%=rs.getInt("total_quantity")%> tablets</p>
<p class="mb-0"><b>₹</b><%=rs.getDouble("price")%> / tablet</p>
</div>
</div>
</div>

<%
}
con.close();
%>

</div>

<!-- CHART -->
<h4 class="mt-5 text-center">Inventory Distribution</h4>
<div class="chart-container mt-3">
    <canvas id="pieChart"></canvas>
</div>

</div>

<!-- ADD MEDICINE MODAL -->
<div class="modal fade" id="addModal">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content">

<form action="AddInventoryServlet" method="post" enctype="multipart/form-data">

<div class="modal-header">
<h5>Add Medicine</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
<input class="form-control mb-2" name="medicine" placeholder="Medicine Name" required>
<input class="form-control mb-2" name="dosage" placeholder="Dosage (e.g. 500mg)" required>
<input class="form-control mb-2" type="number" name="quantity" placeholder="Total Tablets" required>
<input class="form-control mb-2" type="number" step="0.01" name="price" placeholder="Price per tablet" required>
<input class="form-control mb-2" type="file" name="image" required>
</div>

<div class="modal-footer">
<button class="btn btn-warning w-100">Save</button>
</div>

</form>

</div>
</div>
</div>

<!-- CHART SCRIPT -->
<script>
new Chart(document.getElementById("pieChart"), {
    type: 'pie',
    data: {
        labels: [<%=labels%>],
        datasets: [{
            data: [<%=data%>],
            backgroundColor: [
                '#0ea5e9','#22c55e','#f97316','#9333ea',
                '#ef4444','#14b8a6'
            ]
        }]
    },
    options:{
        responsive:true,
        plugins:{
            legend:{
                position:'bottom'
            }
        }
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
