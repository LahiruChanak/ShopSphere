<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<%@ page import="lk.ijse.shopsphere.dto.ProductDTO" %>
<html>
<head>
    <title>Homepage - ShopSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/homepage.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%-- -------------------------------- Header ------------------------------ --%>
<%@ include file="header.jsp" %>

<%-- -------------------------------- Main Content ------------------------------ --%>
<main class="container pt-4 pb-5 d-flex flex-column gap-5">
    <nav class="nav justify-content-start align-items-center">
        <div class="dropdown-container">
            <div class="dropdown bg-secondary-subtle rounded-5 py-2 px-3 z-3" style="width: 200px;"> <!-- Fixed width -->
                <a href="#" class="text-decoration-none text-black fw-medium all-categories d-flex justify-content-between align-items-center">
                <span>
                    <i class="hgi-stroke hgi-menu-square fs-5 me-2 align-middle"></i>
                    <%
                        String selectedCategoryName = "All Categories"; // Default text
                        String categoryId = request.getParameter("categoryId");
                        if (categoryId != null && !categoryId.isEmpty()) {
                            List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
                            if (categories != null && !categories.isEmpty()) {
                                for (CategoryDTO category : categories) {
                                    if (category.getId().equals(categoryId)) {
                                        selectedCategoryName = category.getName();
                                        break;
                                    }
                                }
                            }
                        }
                    %>
                    <%= selectedCategoryName %>
                </span>
                    <i class="hgi-stroke hgi-arrow-down-01 fs-5 align-middle all-categories-icon"></i>
                </a>
            </div>

            <ul class="all-categories-menu bg-secondary-subtle rounded-5 rounded-bottom-4 z-2">
                <li class="my-2">
                    <a class="dropdown-item" href="home">
                        <i class="hgi-stroke hgi-shirt-01 fs-5 me-2 align-middle"></i>
                        Show All
                    </a>
                </li>
                <%
                    List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
                    if (categories != null && !categories.isEmpty()) {
                        for (CategoryDTO category : categories) {
                %>
                <li class="my-2">
                    <a class="dropdown-item" href="home?categoryId=<%= category.getId() %>">
                        <i class="hgi-stroke hgi-shirt-01 fs-5 me-2 align-middle"></i>
                        <%= category.getName() %>
                    </a>
                </li>
                <%
                        }
                    } else {
                        System.out.println("No categories found in the request.");
                    }
                %>
            </ul>
        </div>
    </nav>

    <div>
        <h1 class="text-center mb-5">Just For You</h1>

        <div class="product-container">
            <%
                List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (ProductDTO product : products) {
            %>
            <div class="product-card">
                <div class="product-image">
                    <img src="data:image/jpeg;base64,<%= product.getImage() %>"
                         alt="<%= product.getName() %>" class="img-fluid" loading="lazy"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/fallback.jpg';"/>
                </div>
                <div class="product-info">
                    <p class="product-title"><%= product.getName() %></p>
                    <p class="product-price">Rs. <%= product.getUnitPrice() %></p>
                </div>
            </div>
            <%
                    }
                } else {
                    System.out.println("No products found in the request.");
                }
            %>
        </div>
    </div>

    <!-- Business Banner -->
    <div class="business-banner p-4 rounded d-flex justify-content-around align-items-center flex-wrap gap-4">
        <div>
            <p class="fw-bold fs-5">
                <span class="logo fs-3 me-2">ShopSphere</span> Business
            </p>
            <div class="d-flex flex-wrap gap-4 my-4">
                <span><i class="hgi-stroke hgi-invoice-02 me-2 fs-3 align-middle"></i>Tax exemptions</span>
                <span><i class="hgi-stroke hgi-credit-card-pos me-2 fs-3 align-middle"></i>Express Payments</span>
                <span><i class="hgi-stroke hgi-agreement-01 me-2 fs-3 align-middle"></i>Financial Support</span>
            </div>
            <button class="btn shop-now-btn">Shop Now</button>
        </div>
        <div class="row text-center g-4 label-container">
            <div class="col-md-3 count-label">
                <div class="stat-number">15M+</div>
                <div>Factory direct supply</div>
            </div>
            <div class="col-md-3 count-label">
                <div class="stat-number">20M+</div>
                <div>Value dropshipping items</div>
            </div>
            <div class="col-md-3 count-label">
                <div class="stat-number">10</div>
                <div>Local warehouses worldwide</div>
            </div>
            <div class="col-md-3 count-label">
                <div class="stat-number">24H</div>
                <div>Personalized sourcing service</div>
            </div>
        </div>
    </div>
</main>

<!-- -------------------------------- Footer -------------------------------- -->
<%@ include file="footer.jsp" %>

<!-- -------------------------------- Script -------------------------------- -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>