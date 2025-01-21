<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Authentication - ShopSphere</title>
    <link rel="icon" href=""/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css"/>
</head>

<body>
<div class="container" id="container">
    <!-- Sign In Form -->
    <div class="form-container sign-in">
        <form action="AuthServlet" method="post">
            <h1>Sign In</h1>
            <br/>
            <input type="email" name="email" placeholder="Email"/>
            <span class="error">
                <%= request.getAttribute("signInEmailError") != null ? request.getAttribute("signInEmailError") : "" %>
            </span>
            <input type="password" name="password" placeholder="Password"/>
            <span class="error">
                <%= request.getAttribute("signInPasswordError") != null ? request.getAttribute("signInPasswordError") : "" %>
            </span>
            <button type="submit" name="action" value="signIn">Sign In</button>
            <div class="line-container">
                <hr/>
                Or
                <hr/>
            </div>
            <a href="#">Forget Your Password?</a>
        </form>
    </div>

    <!-- Sign Up Form -->
    <div class="form-container sign-up">
        <form action="AuthServlet" method="post">
            <h1>Create Account</h1>
            <br/>
            <input type="text" name="name" placeholder="Name"/>
            <span class="error">
                <%= request.getAttribute("signUpNameError") != null ? request.getAttribute("signUpNameError") : "" %>
            </span>
            <input type="email" name="email" placeholder="Email"/>
            <span class="error">
                <%= request.getAttribute("signUpEmailError") != null ? request.getAttribute("signUpEmailError") : "" %>
            </span>
            <input type="password" name="password" placeholder="Password"/>
            <span class="error">
                <%= request.getAttribute("signUpPasswordError") != null ? request.getAttribute("signUpPasswordError") : "" %>
            </span>
            <button type="submit" name="action" value="signUp">Sign Up</button>
        </form>
    </div>

    <!-- Reset Password -->
    <div class="form-container reset-password">
        <form action="AuthServlet" method="post">
            <div id="send-otp-form">
                <h1>Reset Password</h1>
                <p class="text-muted small mb-3">
                    Enter your email address to send OTP
                </p>
                <input type="email" name="email" placeholder="Email"/>
                <span class="error">
                    <%= request.getAttribute("resetPasswordEmailError") != null ? request.getAttribute("resetPasswordEmailError") : "" %>
                </span>
                <div class="d-flex justify-content-center align-items-center">
                    <button
                            type="button"
                            name="action"
                            value="sendOtp"
                            id="send-otp-btn"
                            onclick="showResetForm()"
                    >
                        Send OTP
                    </button>
                </div>
            </div>

            <div id="reset-pw-form" class="hide">
                <input type="password" name="password" placeholder="New Password"/>
                <span class="error">
                    <%= request.getAttribute("resetPasswordError") != null ? request.getAttribute("resetPasswordError") : "" %>
                </span>
                <div class="d-flex justify-content-center align-items-center">
                    <button type="submit" name="action" value="resetPassword">
                        Reset Password
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Overlay -->
    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-left">
                <h1>Hello, Friend!</h1>
                <p>
                    Register with your personal details to use all of site features
                </p>
                <button class="hidden" id="login">Sign In</button>
            </div>
            <div class="toggle-panel toggle-right">
                <h1>Welcome Back!</h1>
                <p>Enter your personal details to use all of site features</p>
                <button class="hidden" id="register">Sign Up</button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/auth.js"></script>
</body>
</html>
