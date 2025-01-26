<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Page - ShopSphere</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link href="${pageContext.request.contextPath}/assets/css/auth.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid min-vh-100 d-flex align-items-center justify-content-center">
    <div class="card shadow-lg">
        <div class="row g-0">
            <div class="col-md-6">
                <div class="welcome-section h-100 d-flex flex-column justify-content-center">
                    <h1>Welcome Back to ShopSphere</h1>
                    <p>Sign in to your account to continue your shopping experience.</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card-body p-4 p-md-5">
                    <h2 class="text-center mb-4">Login</h2>
                    <form id="loginForm" action="auth" method="POST">
                        <input type="hidden" name="action" value="login">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                            <div class="invalid-feedback">Please enter a valid email address.</div>
                        </div>
                        <div class="mb-3 position-relative">
                            <label for="password" class="form-label">Password</label>
                            <div class="position-relative">
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                                <button type="button" class="password-toggle" data-target="password">
                                    <i class="bi bi-eye-slash" id="toggleIcon"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">Password is required.</div>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">Sign In</button>
                        <div class="text-center">
                            <a href="resetPW.jsp" class="text-decoration-none">Forgot Password?</a>
                            <p class="mt-3 mb-0">Don't have an account? <a href="register.jsp" class="text-decoration-none">Register</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script src="${pageContext.request.contextPath}/assets/js/auth.js"></script>
</body>
</html>