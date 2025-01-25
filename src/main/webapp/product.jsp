<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.shopsphere.dto.ProductDTO" %>
<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<html>
<head>
    <title>Product - ShopSphere</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

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
                <h2 class="mb-3"><%= product.getName() %>
                </h2>

                <div class="mb-4">
                    <span>
                        <i class="hgi-stroke hgi-checkmark-badge-03 fs-4 align-middle fw-bolder me-1
                            <%= product.getQtyOnHand() > 0 ? "text-success" : "text-danger" %>">
                        </i>
                        <span id="availability" class="<%= product.getQtyOnHand() > 0 ? "text-success" : "text-danger" %>">
                            <%= product.getQtyOnHand() > 0 ? "In Stock" : "Out of Stock" %>
                        </span>
                    </span>
                </div>




                <div class="mb-4">
                    <h6 class="mb-3">Description:</h6>
                    <p><%= product.getDescription() %>
                    </p>
                </div>

                <div class="mb-4">
                    <ul class="product-labels">
                        <li>
                            <span class="text-muted">Category:</span>
                            <%= category != null ? category.getName() : "Uncategorized" %>
                        </li>
                        <li>
                            <span class="text-muted">Stock:</span> <%= product.getQtyOnHand() %>
                        </li>
                    </ul>
                </div>
                <div class="mb-4">
                    <h6 class="mb-3">Select Size:</h6>
                    <div class="d-flex align-items-center flex-wrap gap-5">
                        <div class="d-flex gap-2">
                            <button class="size-btn active" id="size-1">S</button>
                            <button class="size-btn" id="size-2">M</button>
                            <button class="size-btn" id="size-3">L</button>
                            <button class="size-btn" id="size-4">XL</button>
                        </div>

                        <!-- View Size Chart Button -->
                        <button class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#size-modal">
                            View Size Chart
                        </button>
                    </div>
                </div>
                <% } else { %>
                <div class="alert alert-warning" role="alert">
                    Product not found.
                </div>
                <% } %>
            </div>

            <!-- Product Price -->
            <div class="col-md-3 px-4 price-card">
                <% if (product != null) { %>
                <div class="d-flex flex-column justify-content-center gap-1 mb-4">
                    <div class="d-flex gap-2 text-success">
                        <h3 class="mb-0">Rs. <%= product.getUnitPrice() %>
                        </h3>
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

                <div class="d-flex gap-3 mb-2">
                    <button class="btn btn-dark add-to-cart-btn rounded-5 w-100">Add to cart</button>
                    <button class="btn btn-outline-dark w-100 rounded-5 buy-now-btn">Buy now</button>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Size Chart Modal -->
    <div class="modal fade" id="size-modal" tabindex="-1" aria-labelledby="size-modal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header justify-content-between border-0">
                    <h5 class="modal-title">Size Chart</h5>
                    <button type="button" class="btn-close btn-close-black"
                            data-bs-dismiss="modal"
                            aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                    <img src="https://i.postimg.cc/tTbSyjvm/size-chart.png"
                         alt="Size Chart" class="w-100"/>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
</script>
<script src="${pageContext.request.contextPath}/assets/js/product.js"></script>
</body>
</html>