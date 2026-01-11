<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>

<title>Manage Doctors 👨‍⚕️</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{
  background:#f5f7fc;
  font-family:Poppins,Arial,Helvetica;
}

.container-box{
  max-width:1100px;
  margin:30px auto;
  background:white;
  padding:25px;
  border-radius:14px;
  box-shadow:0 10px 25px rgba(0,0,0,.1);
}

table thead{
  background:#e2e8f0;
  color:#111;
  font-weight:600;
  font-size:15px;
}

img{
  width:45px;
  height:45px;
  border-radius:50%;
  object-fit:cover;
}

.table tbody tr:nth-child(even){
  background:#f9fafb;
}

@media(max-width:650px){
  table thead{ display:none; }
  table, table tbody, table tr, table td{
    display:block;
    width:100%;
  }

  table tr{
    background:#f8fafc;
    margin:8px 0;
    padding:12px;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,.08);
  }

  table td{
    border:none !important;
    padding:6px 4px;
    font-size:14px;
  }

  table td::before{
    content:attr(data-label);
    font-weight:600;
    color:#475569;
    display:block;
    margin-bottom:3px;
  }
}

.back-btn{
  background:#1e293b;
  color:white;
  padding:9px 13px;
  border-radius:6px;
  text-decoration:none;
  font-size:14px;
}
</style>
</head>

<body>

<div class="container-box">

  <!-- Updated back button -->
  <a href="adminDashboard.jsp" class="back-btn mt-1 d-inline-block">
    <i class="fa-solid fa-arrow-left"></i> Back
  </a>

  <h4 class="mb-3">Registered Doctors 👨‍⚕️</h4>

  <div class="table-responsive">
    <table class="table table-bordered align-middle">
      <thead>
        <tr>
          <th>Photo</th>
          <th>Name</th>
          <th>Email</th>
          <th style="width:110px;">Action</th>
        </tr>
      </thead>

      <tbody>
      <%
      ArrayList<String[]> doctors = (ArrayList<String[]>) request.getAttribute("doctors");

      if(doctors != null && doctors.size() > 0){
        for(String[] d : doctors){
      %>

      <tr>
        <td data-label="Photo">
          <img src="<%= request.getContextPath() %>/<%= 
            (d[3] != null && !d[3].isEmpty()) ? d[3] : "images/default.png"
          %>">
        </td>

        <td data-label="Name"><%= d[1] %></td>
        <td data-label="Email"><%= d[2] %></td>

        <td data-label="Action">
          <form method="post" action="ManageDoctorsServlet"
            onsubmit="return confirm('Delete this doctor?');">

            <input type="hidden" name="id" value="<%= d[0] %>">

            <button class="btn btn-danger btn-sm">
              <i class="fa-solid fa-trash"></i> Delete
            </button>

          </form>
        </td>
      </tr>

      <% } } else { %>

      <tr>
        <td colspan="4" class="text-center text-muted py-3">
          No doctors registered yet.
        </td>
      </tr>

      <% } %>
      </tbody>
    </table>
  </div>

</div>

</body>
</html>
