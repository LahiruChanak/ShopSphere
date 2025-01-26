document.addEventListener('DOMContentLoaded', function () {
    // Form validation
    const forms = document.querySelectorAll('form');

    forms.forEach(form => {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');

            // Additional validation for specific forms
            if (form.id === 'registerForm') {
                validateRegisterForm(event);
            } else if (form.id === 'resetForm') {
                validateResetForm(event);
            }
        });
    });

    // Email validation
    const emailInputs = document.querySelectorAll('input[type="email"]');
    emailInputs.forEach(input => {
        input.addEventListener('input', function () {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(input.value)) {
                input.setCustomValidity('Please enter a valid email address');
            } else {
                input.setCustomValidity('');
            }
        });
    });

    // Password toggle functionality
    const passwordToggles = document.querySelectorAll('.password-toggle');
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function () {
            const inputId = this.getAttribute('data-target');
            const input = document.getElementById(inputId);
            const icon = this.querySelector('i');

            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });
    });

    // Register form validation
    function validateRegisterForm(event) {
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        // Password length validation
        if (password.value.length < 8) {
            password.setCustomValidity('Password must be at least 8 characters long');
            event.preventDefault();
        } else {
            password.setCustomValidity('');
        }

        // Password match validation
        if (password.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity('Passwords do not match');
            event.preventDefault();
        } else {
            confirmPassword.setCustomValidity('');
        }
    }

    // Reset password form validation
    function validateResetForm(event) {
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');

        // Password length validation
        if (newPassword.value.length < 8) {
            newPassword.setCustomValidity('Password must be at least 8 characters long');
            event.preventDefault();
        } else {
            newPassword.setCustomValidity('');
        }

        // Password match validation
        if (newPassword.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity('Passwords do not match');
            event.preventDefault();
        } else {
            confirmPassword.setCustomValidity('');
        }
    }

    // Reset password form logic
    document.getElementById('sendLinkBtn').addEventListener('click', function () {
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
});