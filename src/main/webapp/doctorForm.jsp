<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
boolean editMode = "true".equals(request.getParameter("edit"));

String name = (String) session.getAttribute("doctorName");
String email = (String) session.getAttribute("doctorEmail");
String contact = (String) session.getAttribute("doctorContact");
String gender = (String) session.getAttribute("doctorGender");
String specialization = (String) session.getAttribute("doctorSpec");
String qualification = (String) session.getAttribute("doctorQualification");
String experience = (String) session.getAttribute("doctorExperience");
%>

<!DOCTYPE html>
<html>
<head>
<title><%= editMode ? "Edit Doctor Profile" : "Doctor Profile" %></title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
  background:#f4f7ff;
  font-family:Poppins,sans-serif;
}

.form-box{
  background:#fff;
  border:3px solid #1e3a8a;
  border-radius:24px;
  padding:40px;
}

label{ font-weight:700; }

.form-control, .form-select{
  border:2px solid #1e3a8a;
  border-radius:12px;
  padding:12px;
}

.upload-btn{
  background:#16a34a;
  color:#fff;
  padding:12px 26px;
  border-radius:30px;
  font-weight:700;
  cursor:pointer;
}

.save-btn{
  background:#22c55e;
  color:#fff;
  padding:14px;
  border-radius:30px;
  font-weight:700;
  border:none;
}

.back-btn{
  background:#e5e7eb;
  padding:14px;
  border-radius:30px;
  font-weight:700;
  border:none;
}

@media(max-width:576px){
  .form-box{ padding:25px; }
}
</style>
</head>

<body>

<div class="container py-5">
<div class="row justify-content-center">
<div class="col-lg-8 col-md-10 col-12">

<form class="form-box"
      action="DoctorProfileServlet"
      method="post"
      enctype="multipart/form-data"
      onsubmit="return validateForm();">

<h3 class="text-center fw-bold mb-4">
  <%= editMode ? "Edit Doctor Profile" : "Doctor Profile" %>
</h3>

<!-- IMAGE UPLOAD -->
<div class="text-center mb-4">
  <label class="upload-btn" for="imageInput">
    Upload Profile Image
  </label>

  <input type="file"
         id="imageInput"
         name="image"
         accept="image/*"
         class="d-none"
         onchange="showFileName(this)">

  <div id="fileName" class="mt-2 fw-semibold text-success"></div>
</div>

<!-- FORM FIELDS -->
<div class="row g-4">

  <div class="col-md-6">
    <label>Full Name</label>
    <input type="text" name="name" class="form-control"
           value="<%= editMode && name!=null ? name : "" %>" required>
  </div>

  <div class="col-md-6">
    <label>Email</label>
    <input type="email" name="email" class="form-control"
           value="<%= editMode && email!=null ? email : "" %>" required>
  </div>

  <div class="col-md-6">
    <label>Contact</label>
    <input type="tel" name="contact" class="form-control"
           value="<%= editMode && contact!=null ? contact : "" %>" required>
  </div>

  <div class="col-md-6">
    <label>Gender</label>
    <select name="gender" class="form-select" required>
      <option value="">Select</option>
      <option <%= "Male".equals(gender)?"selected":"" %>>Male</option>
      <option <%= "Female".equals(gender)?"selected":"" %>>Female</option>
      <option <%= "Other".equals(gender)?"selected":"" %>>Other</option>
    </select>
  </div>

  <div class="col-md-6">
    <label>Specialization</label>
    <select name="specialization" class="form-select" required>
      <option value="">Select</option>
      <option <%= "Cardiology".equals(specialization)?"selected":"" %>>Cardiology</option>
      <option <%= "Neurology".equals(specialization)?"selected":"" %>>Neurology</option>
      <option <%= "Orthopedics".equals(specialization)?"selected":"" %>>Orthopedics</option>
      <option <%= "Dermatology".equals(specialization)?"selected":"" %>>Dermatology</option>
      <option <%= "Gynecology".equals(specialization)?"selected":"" %>>Gynecology</option>
      <option <%= "Pediatrics".equals(specialization)?"selected":"" %>>Pediatrics</option>
      <option <%= "Psychiatry".equals(specialization)?"selected":"" %>>Psychiatry</option>
      <option <%= "ENT".equals(specialization)?"selected":"" %>>ENT</option>
      <option <%= "Radiology".equals(specialization)?"selected":"" %>>Radiology</option>
      <option <%= "Emergency".equals(specialization)?"selected":"" %>>Emergency</option>
    </select>
  </div>

  <div class="col-md-6">
    <label>Qualification</label>
    <select name="qualification" class="form-select" required>
      <option value="">Select</option>
      <option <%= "MBBS".equals(qualification)?"selected":"" %>>MBBS</option>
      <option <%= "MD".equals(qualification)?"selected":"" %>>MD</option>
      <option <%= "MS".equals(qualification)?"selected":"" %>>MS</option>
      <option <%= "DNB".equals(qualification)?"selected":"" %>>DNB</option>
    </select>
  </div>

  <div class="col-md-6">
    <label>Experience</label>
    <select name="experience" class="form-select" required>
      <option value="">Select</option>
      <option <%= "0 - 1 Years".equals(experience)?"selected":"" %>>0 - 1 Years</option>
      <option <%= "1 - 3 Years".equals(experience)?"selected":"" %>>1 - 3 Years</option>
      <option <%= "3 - 5 Years".equals(experience)?"selected":"" %>>3 - 5 Years</option>
      <option <%= "5+ Years".equals(experience)?"selected":"" %>>5+ Years</option>
    </select>
  </div>

</div>

<!-- BUTTONS -->
<div class="row mt-5 g-3">
  <div class="col-md-6">
    <button type="button" class="back-btn w-100" onclick="goBack()">← Go Back</button>
  </div>
  <div class="col-md-6">
    <button type="submit" class="save-btn w-100">
      <%= editMode ? "Update Profile" : "Save Profile" %>
    </button>
  </div>
</div>

</form>

</div>
</div>
</div>

<script>
const editMode = <%= editMode %>;

function showFileName(input){
  if(input.files && input.files[0]){
    document.getElementById("fileName").innerText =
      "✔ Selected file: " + input.files[0].name;
  }
}

function validateForm(){
  const imageInput = document.getElementById("imageInput");

  if(!editMode && imageInput.files.length === 0){
    alert("⚠ Please upload your profile image.");
    return false;
  }
  return true;
}

function goBack(){
  if(confirm("Unsaved changes will be lost. Continue?")){
    window.history.back();
  }
}
</script>

</body>
</html>
