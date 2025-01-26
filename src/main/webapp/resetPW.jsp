<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password Page - ShopSphere</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="${pageContext.request.contextPath}/assets/css/auth.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid min-vh-100 d-flex align-items-center justify-content-center">
    <div class="card shadow-lg">
        <div class="row g-0">
            <div class="col-md-6">
                <div class="welcome-section h-100 d-flex flex-column justify-content-center">
                    <h1>Password Recovery</h1>
                    <p>Don't worry! It happens to the best of us. Enter your email address and we'll help you reset your password.</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card-body p-4 p-md-5">
                    <h2 class="text-center mb-4">Reset Password</h2>
                    <p class="text-center text-muted mb-4" id="initialText">Enter your email address and we'll send you a link to reset your password.</p>
                    <form id="resetForm" action="auth" method="POST">
                        <input type="hidden" name="action" value="reset-password">
                        <div class="mb-4">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control <%= request.getAttribute("resetPasswordEmailError") != null ? "is-invalid" : "" %>"
                                   id="email" name="email" placeholder="name@example.com" required>
                            <% if (request.getAttribute("resetPasswordEmailError") != null) { %>
                            <div class="invalid-feedback">
                                <%= request.getAttribute("resetPasswordEmailError") %>
                            </div>
                            <% } %>
                        </div>
                        <div id="passwordFields" style="display: none;">
                            <div class="mb-4 position-relative">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control <%= request.getAttribute("resetPasswordError") != null ? "is-invalid" : "" %>"
                                       id="newPassword" name="newPassword" placeholder="Enter new password" minlength="8" required>
                                <button type="button" class="password-toggle reset-pw" data-target="newPassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <% if (request.getAttribute("resetPasswordError") != null) { %>
                                <div class="invalid-feedback">
                                    <%= request.getAttribute("resetPasswordError") %>
                                </div>
                                <% } %>
                            </div>
                            <div class="mb-4 position-relative">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control <%= request.getAttribute("resetPasswordConfirmError") != null ? "is-invalid" : "" %>"
                                       id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" minlength="8" required>
                                <button type="button" class="password-toggle reset-pw" data-target="confirmPassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <% if (request.getAttribute("resetPasswordConfirmError") != null) { %>
                                <div class="invalid-feedback">
                                    <%= request.getAttribute("resetPasswordConfirmError") %>
                                </div>
                                <% } %>
                            </div>
                        </div>
                        <button type="button" id="sendLinkBtn" class="btn btn-primary w-100 mb-3">Send Reset Link</button>
                        <button type="submit" id="resetPasswordBtn" class="btn btn-primary w-100 mb-3" style="display: none;">Reset Password</button>
                        <div class="text-center">
                            <p class="mb-0">Remember your password? <a href="index.jsp" class="text-decoration-none">Login</a></p>
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