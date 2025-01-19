<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart - ShopSphere</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link
            rel="stylesheet"
            href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main class="container py-5">
    <div class="cart-wrapper">
        <div class="cart-container position-relative d-inline-flex align-items-center">
            <div class="page-title">Cart</div>
            <div id="cart-count" class="cart-count">0</div>
        </div>

        <div class="cart-container">
            <!-- Left Section: Cart Items -->
            <div class="cart-items-section">
                <div class="cart-items">
                    <div class="cart-item">
                        <img src="/api/placeholder/100/100" alt="Product 1" class="item-image"/>
                        <div class="item-details">
                            <div class="item-title">Product</div>
                            <div class="quantity-control">
                                <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                                <span>01</span>
                                <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                            </div>
                        </div>
                        <div class="item-price">$49.00</div>
                    </div>

                    <div class="cart-item">
                        <img src="/api/placeholder/100/100" alt="Product 2" class="item-image"/>
                        <div class="item-details">
                            <div class="item-title">Product 2</div>
                            <div class="quantity-control">
                                <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                                <span>01</span>
                                <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                            </div>
                        </div>
                        <div class="item-price">$34.00</div>
                    </div>

                    <div class="cart-item">
                        <img src="/api/placeholder/100/100" alt="Product 3" class="item-image"/>
                        <div class="item-details">
                            <div class="item-title">Product 3</div>
                            <div class="quantity-control">
                                <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                                <span>03</span>
                                <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                            </div>
                        </div>
                        <div class="item-price">$30.00</div>
                    </div>
                </div>
            </div>

            <!-- Right Section -->
            <div>
                <div class="cart-summary-section">
                    <h2 class="summary-title">Order Summary</h2>
                    <div class="summary-row">
                        <span>Product Total</span>
                        <span>$114.48</span>
                    </div>
                    <div class="summary-row">
                        <span>Delivery Charges</span>
                        <span>+ $10.52</span>
                    </div>
                    <div class="summary-total">
                        <span>Sub Total</span>
                        <span class="total-amount">$125.00</span>
                    </div>
                    <button class="proceed-btn">
                        <a href="${pageContext.request.contextPath}/pages/order.jsp"
                           class="nav-link text-white"> Proceed to Checkout </a>
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
</body>
</html>