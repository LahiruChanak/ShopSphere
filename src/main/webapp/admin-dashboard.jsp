<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-dashboard.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="admin-header.jsp" %>

<main>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="d-flex flex-column align-items-center my-3">
            <img src="https://img.icons8.com/?size=100&id=psevkzUhHRTs&format=png&color=000000" alt="Admin"
                 class="rounded-circle img-fluid admin-image"/>
            <h2 class="text-white text-center mt-2">Admin</h2>
        </div>
        <nav class="sidebar-nav">
            <a href="customers">
                <i class="hgi-stroke hgi-user-multiple-02 fs-5 align-middle me-2"></i>Customers
            </a>
            <a href="orders">
                <i class="hgi-stroke hgi-shopping-cart-check-in-02 fs-5 align-middle"></i> Orders
            </a>
            <a href="products">
                <i class="hgi-stroke hgi-package fs-5 align-middle"></i> Products
            </a>
            <a href="categories">
                <i class="hgi-stroke hgi-arrange fs-5 align-middle"></i> Categories
            </a>
            <a href="index.jsp">
                <i class="hgi-stroke hgi-login-01 fs-5 align-middle rotate-right"></i> Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h1>Dashboard</h1>

        <!-- Summary Cards -->
        <div class="row pt-5">
            <div class="col-md-3">
                <div class="summary-box">
                    <i class="hgi-stroke hgi-user-multiple-02 fs-2 text-primary"></i>
                    <div>
                        <h3>${totalCustomers}</h3>
                        <p>Total Customers</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="summary-box">
                    <i class="hgi-stroke hgi-shopping-cart-check-in-02 fs-2 text-success"></i>
                    <div>
                        <h3>${totalOrders}</h3>
                        <p>Total Orders</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="summary-box">
                    <i class="hgi-stroke hgi-package fs-2 text-warning"></i>
                    <div>
                        <h3>${totalProducts}</h3>
                        <p>Total Products</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="summary-box">
                    <i class="hgi-stroke hgi-arrange fs-2 text-danger"></i>
                    <div>
                        <h3>${totalCategories}</h3>
                        <p>Total Categories</p>
                    </div>
                </div>
            </div>
        </div>

<%--        <!-- Table -->--%>
<%--        <div class="table-responsive mt-4">--%>
<%--            <table class="table table-borderless table-hover">--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                    <th>Order ID</th>--%>
<%--                    <th>Customer</th>--%>
<%--                    <th>Date</th>--%>
<%--                    <th>Total</th>--%>
<%--                    <th>Status</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <!-- Add rows dynamically here -->--%>
<%--                </tbody>--%>
<%--            </table>--%>
<%--        </div>--%>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
</body>
</html>