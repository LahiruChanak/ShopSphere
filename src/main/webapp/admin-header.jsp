<%@ page import="java.util.Base64" %>
<%@ page import="lk.ijse.shopsphere.dto.CustomerDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-header.css"/>
</head>
<body>
<%
    CustomerDTO user = (CustomerDTO) request.getAttribute("customer");
%>

<header class="bg-white border-bottom px-5">
    <div class="container py-3">
        <div class="row d-flex align-items-center justify-content-between">
            <div class="col d-flex align-items-center">
                <div class="col-auto mt-1 d-flex align-self-start align-items-center back-btn-container">
                    <a href="#" class="text-decoration-none text-secondary-emphasis" id="back">
                        <i class="hgi-stroke hgi-arrow-left-01 fs-2 me-lg-5 align-bottom back-icon" title="Back"></i>
                    </a>
                </div>
                <!-- Logo -->
                <div class="col-auto">
                    <span class="logo">ShopSphere</span>
                </div>
            </div>

            <!-- User Profile and Cart -->
            <div class="col-auto">
                <div class="d-flex align-items-center gap-5">
                    <!-- Profile -->
                    <a href="#" class="d-flex align-items-center text-decoration-none text-dark">
                        <img src="https://img.icons8.com/?size=100&id=psevkzUhHRTs&format=png&color=000000"
                             class="header-profile" alt="Profile Picture"/>
                        <span class="ms-2 fw-bold">Admin</span>
                    </a>

                    <!-- Logout -->
                    <a href="${pageContext.request.contextPath}/index.jsp"
                       class="nav-link position-relative"
                       data-bs-toggle="tooltip"
                       data-bs-placement="bottom"
                       title="Logout">
                        <i class="hgi-stroke hgi-login-01 me-2 fs-4 align-middle rotate-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script>
    // Bootstrap tooltip initialization
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

    // Navigate to back page
    const back = document.getElementById("back");

    back.addEventListener("click", () => {
        window.history.back();
    });
</script>
</body>
</html>