<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Page - ShopSphere</title>
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
                    <h1>Welcome to Our Platform</h1>
                    <p>Create an account and join our community today. We're excited to have you on board!</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card-body p-4 p-md-5">
                    <h2 class="text-center mb-4">Create Account</h2>
                    <form id="registerForm" action="auth" method="POST">
                        <input type="hidden" name="action" value="register">
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   placeholder="Enter your full name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="email" name="email"
                                   placeholder="name@example.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <div class="position-relative">
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Create a password" required>
                                <button type="button" class="password-toggle" data-target="password">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <div class="position-relative">
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                       placeholder="Confirm your password" required>
                                <button type="button" class="password-toggle" data-target="confirmPassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="terms" name="terms" required>
                            <label class="form-check-label" for="terms">I agree to the Terms and Conditions</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">Create Account</button>
                        <div class="text-center">
                            <p class="mb-0">Already have an account? <a href="index.jsp" class="text-decoration-none">Login</a>
                            </p>
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