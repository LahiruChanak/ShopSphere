<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.shopsphere.dto.ProductDTO" %>
<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<html>
<head>
    <title>Product - ShopSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container py-5">
        <div class="row justify-content-center gap-4">
            <!-- Product Images -->
            <div class="col-md-4 mb-4">
                <div class="d-flex flex-column">
                    <img src="data:image/jpeg;base64,${product.image}" alt="Product" class="product-img mb-3"/>
                </div>
            </div>

            <!-- Product Details -->
            <div class="col-md-4 product-details">
                <%
                    ProductDTO product = (ProductDTO) request.getAttribute("product");
                    CategoryDTO category = (CategoryDTO) request.getAttribute("category");
                    if (product != null) {
                %>
                <h2 class="mb-3"><%= product.getName() %></h2>

                <div class="text-success mb-4">
                    <span>
                        <i class="fas fa-check-circle fs-4 align-middle fw-bolder me-1"></i>
                        <span id="availability"><%= product.getQtyOnHand() > 0 ? "In Stock" : "Out of Stock" %></span>
                    </span>
                </div>

                <div class="mb-4">
                    <h6 class="mb-3">Description:</h6>
                    <p><%= product.getDescription() %></p>
                </div>

                <div class="mb-4">
                    <ul class="product-labels">
                        <li>
                            <span class="text-muted">Category:</span>
                            <%= category != null ? category.getName() : "Uncategorized" %>
                        </li>
                        <li>
                            <span class="text-muted">Quantity Available:</span>
                            <%= product.getQtyOnHand() %>
                        </li>
                    </ul>
                </div>
                <% } else { %>
                <div class="alert alert-warning" role="alert">
                    Product not found.
                </div>
                <% } %>
            </div>

            <!-- Product Price -->
            <div class="col-md-3 price-card">
                <% if (product != null) { %>
                <div class="d-flex flex-column justify-content-center gap-1 mb-4">
                    <div class="d-flex gap-2 text-success">
                        <h3 class="mb-0">$<%= product.getUnitPrice() %></h3>
                    </div>
                    <span class="text-muted">All prices include VAT</span>
                </div>

                <div class="d-flex gap-3 align-items-center mb-4">
                    <div class="quantity-control">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                        <span>01</span>
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                    </div>
                </div>

                <div class="d-flex gap-3 mb-4">
                    <button class="btn add-to-cart-btn w-100">Add to cart</button>
                    <button class="btn btn-outline-dark w-100 buy-now-btn">Buy now</button>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/product.js"></script>
</body>
</html>