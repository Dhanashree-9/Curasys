<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CuraSys</title>

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
    <% if (request.getParameter("signup") != null) { %>
    <div class="toast align-items-center text-bg-success border-0 show">
        <div class="d-flex">
            <div class="toast-body">Account created successfully! Please login.</div>
        </div>
    </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="toast align-items-center text-bg-danger border-0 show">
        <div class="d-flex">
            <div class="toast-body">Invalid email or password.</div>
        </div>
    </div>
    <% } %>
</div>

<div class="card shadow">
    <h3>Login</h3>

    <form action="LoginServlet" method="post">

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required minlength="5">
        </div>

        <button type="submit" class="btn btn-primary w-100">Login</button>

        <p class="text-center mt-3">
            New user? <a href="signup.jsp">Create Account</a>
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
