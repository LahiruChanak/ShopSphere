<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.shopsphere.dto.CartDTO" %>
<%@ page import="lk.ijse.shopsphere.dto.CartDetailDTO" %>

<%
    CartDTO cart = (CartDTO) request.getAttribute("cart");
    List<CartDetailDTO> cartDetails = (List<CartDetailDTO>) request.getAttribute("cartDetails");

    double totalPrice = 0.0;
    if (cartDetails != null) {
        for (CartDetailDTO detail : cartDetails) {
            totalPrice += detail.getQuantity() * detail.getProduct().getUnitPrice();
        }
    }
    double deliveryCharges = 350.00;
    double subTotal = totalPrice + deliveryCharges;
%>
<html>
<head>
    <title>Cart - ShopSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main class="container py-5">
    <div class="cart-wrapper">
        <div class="cart-container position-relative d-inline-flex align-items-center">
            <div class="page-title">Cart</div>
            <div id="cart-count" class="cart-count"><%= cartDetails != null ? cartDetails.size() : 0 %>
            </div>
        </div>

        <div class="cart-container">

            <!-- Cart Items -->
            <div class="cart-items-section">
                <div class="cart-items">
                    <% if (cartDetails != null) { %>
                    <% for (CartDetailDTO detail : cartDetails) { %>
                    <div class="cart-item">
                        <img src="<%= detail.getProduct().getImage() %>" alt="<%= detail.getProduct().getName() %>"
                             class="item-image"/>
                        <div class="item-details">
                            <div class="item-title"><%= detail.getProduct().getName() %>
                            </div>
                            <div class="quantity-control">
                                <button class="quantity-btn"
                                        onclick="updateQuantity(this, -1, <%= detail.getItemCode() %>)">-
                                </button>
                                <span><%= detail.getQuantity() %></span>
                                <button class="quantity-btn"
                                        onclick="updateQuantity(this, 1, <%= detail.getItemCode() %>)">+
                                </button>
                            </div>
                            <div class="item-size-color">
                                Size: <%= detail.getOrderedSize() %>, Color: <%= detail.getColor() %>
                            </div>
                        </div>
                        <div class="item-price">
                            $<%= String.format("%.2f", detail.getProduct().getUnitPrice() * detail.getQuantity()) %>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="empty-cart-message">Your cart is empty.</div>
                    <% } %>
                </div>
            </div>

            <!-- Order Summary -->
            <div>
                <div class="cart-summary-section">
                    <h2 class="summary-title">Order Summary</h2>
                    <div class="summary-row">
                        <span>Product Total</span>
                        <span>Rs. <%= String.format("%.2f", totalPrice) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Delivery Charges</span>
                        <span>+ Rs. <%= String.format("%.2f", deliveryCharges) %></span>
                    </div>
                    <div class="summary-total">
                        <span>Sub Total</span>
                        <span class="total-amount">Rs. <%= String.format("%.2f", subTotal) %></span>
                    </div>
                    <button class="proceed-btn">
                        <a href="${pageContext.request.contextPath}/order.jsp" class="nav-link text-white">
                            Proceed to Checkout </a>
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