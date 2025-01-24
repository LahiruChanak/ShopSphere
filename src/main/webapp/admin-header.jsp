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
        <div class="row align-items-center">
            <!-- Logo -->
            <div class="col-auto">
                <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none">
                    <span class="logo">ShopSphere</span>
                </a>
            </div>

            <!-- Search Bar -->
            <div class="col">
                <div class="input-group search-bar">
                    <input type="text" class="form-control search-input" placeholder="Search for products, brands, and more"/>
                    <button class="btn btn-dark">
                        <i class="hgi-stroke hgi-search-01 fs-5"></i>
                    </button>
                </div>
            </div>

            <!-- User Profile and Cart -->
            <div class="col-auto">
                <div class="d-flex align-items-center gap-4">
                    <!-- Profile Dropdown -->
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-decoration-none text-dark">
                            <img src="
                                <% if (user != null && user.getImage() != null) { %>
                                    data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(user.getImage()) %>
                                <% } else { %>
                                    ${pageContext.request.contextPath}/assets/images/default-profile.png
                                <% } %>
                            " class="header-profile" alt="Profile Picture"/>
                            <span class="ms-2 fw-bold"><%= session.getAttribute("fullName") %></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end auth-popup p-3">
                            <a href="${pageContext.request.contextPath}/ProfileServlet" class="dropdown-item">
                                <i class="hgi-stroke hgi-user-circle me-2"></i>My Account
                            </a>
                            <a href="#" class="dropdown-item">
                                <i class="hgi-stroke hgi-task-01 me-2"></i>My Orders
                            </a>
                            <a href="#" class="dropdown-item">
                                <i class="hgi-stroke hgi-coupon-percent me-2"></i>My Coupons
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/index.jsp" class="dropdown-item text-danger">
                                <i class="hgi-stroke hgi-login-01 me-2 rotate-right"></i>Log Out
                            </a>
                        </div>
                    </div>

                    <!-- Cart -->
                    <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="nav-link position-relative">
                        <i class="hgi-stroke hgi-shopping-basket-01 fs-3"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-count">
                            0
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<script src="${pageContext.request.contextPath}/assets/js/admin-header.js"></script>
</body>
</html>