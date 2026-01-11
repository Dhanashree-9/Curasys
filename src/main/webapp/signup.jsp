<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - CuraSys</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eef3ff;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .card {
            border-radius: 15px;
            padding: 25px;
            max-width: 420px;
            width: 100%;
        }
        .card h3 {
            text-align: center;
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 20px;
        }
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
        }
    </style>
</head>

<body>

<div class="toast-container">
    <% if (request.getParameter("success") != null) { %>
    <div class="toast align-items-center text-bg-success border-0 show" role="alert">
        <div class="d-flex">
            <div class="toast-body">Signup successful!</div>
        </div>
    </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="toast align-items-center text-bg-danger border-0 show" role="alert">
        <div class="d-flex">
            <div class="toast-body">Email already exists!</div>
        </div>
    </div>
    <% } %>
</div>

<div class="card shadow">
    <h3>Create Account</h3>

    <form action="SignupServlet" method="post">

        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required minlength="5">
        </div>

        <div class="mb-3">
            <label class="form-label">Select Role</label>
            <select name="role" class="form-select" required>
                <option value="">Select role</option>
                <option value="admin">Admin</option>
                <option value="doctor">Doctor</option>
                <option value="pharmacy">Pharmacy</option>
                <option value="patient">Patient</option>
                <option value="ambulance">Ambulance</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Signup</button>

        <p class="text-center mt-3">
            Already have an account? <a href="login.jsp">Login</a>
        </p>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    setTimeout(() => {
        document.querySelectorAll('.toast').forEach(t => t.classList.remove('show'));
    }, 3000);
</script>

</body>
</html>
