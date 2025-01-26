<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="main.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid min-vh-100 d-flex">
    <!-- Welcome Section -->
    <div class="d-none d-lg-flex col-lg-6 welcome-section align-items-center">
        <div>
            <h1>Password Recovery</h1>
            <p>Don't worry! It happens to the best of us. Enter your email address and we'll help you reset your password.</p>
        </div>
    </div>

    <!-- Reset Password Form Section -->
    <div class="col-12 col-lg-6 d-flex align-items-center justify-content-center p-4">
        <div class="card shadow-lg" style="max-width: 400px; width: 100%;">
            <div class="card-body p-4">
                <h2 class="text-center mb-4">Reset Password</h2>
                <p class="text-center text-muted mb-4" id="initialText">
                    Enter your email address and we'll send you a link to reset your password.
                </p>
                <form id="resetForm" action="reset-password" method="POST">
                    <div class="mb-4">
                        <label for="email" class="form-label">Email address</label>
                        <input
                                type="email"
                                class="form-control"
                                id="email"
                                name="email"
                                placeholder="name@example.com"
                                required
                        >
                    </div>

                    <!-- Hidden Password Fields -->
                    <div id="passwordFields" style="display: none;">
                        <div class="mb-4 position-relative">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input
                                    type="password"
                                    class="form-control"
                                    id="newPassword"
                                    name="newPassword"
                                    placeholder="Enter new password"
                                    minlength="8"
                                    required
                            >
                            <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                        <div class="mb-4 position-relative">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input
                                    type="password"
                                    class="form-control"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    placeholder="Confirm new password"
                                    minlength="8"
                                    required
                            >
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                    <button type="button" id="sendLinkBtn" class="btn btn-primary w-100 mb-3">
                        Send Reset Link
                    </button>
                    <button type="submit" id="resetPasswordBtn" class="btn btn-primary w-100 mb-3" style="display: none;">
                        Reset Password
                    </button>
                    <div class="text-center">
                        <p class="mb-0">
                            Remember your password? <a href="login.jsp" class="text-decoration-none">Login</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('sendLinkBtn').addEventListener('click', function() {
        const email = document.getElementById('email');
        if (email.checkValidity()) {
            // Show password fields
            document.getElementById('passwordFields').style.display = 'block';
            this.style.display = 'none';
            document.getElementById('resetPasswordBtn').style.display = 'block';
            document.getElementById('initialText').textContent = 'Please enter and confirm your new password.';
            email.readOnly = true;
        } else {
            email.reportValidity();
        }
    });

    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        const icon = input.nextElementSibling.querySelector('i');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('bi-eye-slash');
            icon.classList.add('bi-eye');
        }
    }

    document.getElementById('resetForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            alert('Passwords do not match!');
            return;
        }

        // Here you would typically submit the form
        this.submit();
    });
</script>
</body>
</html>