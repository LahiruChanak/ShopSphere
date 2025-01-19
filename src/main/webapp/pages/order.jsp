<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order - ShopSphere</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container py-5">
        <h1 class="mb-4">Checkout</h1>

        <div class="row g-5">
            <!-- Shipping Information Column -->
            <div class="col-md-6 rounded-4 checkout-card">
                <div class="card border-0">
                    <div class="card-body">
                        <h4 class="mb-4 py-2">Shipping Information</h4>

                        <!-- Delivery Options -->
                        <div class="mb-4">
                            <div class="btn-group gap-3 w-100" role="group">
                                <div class="shipping-option">
                                    <input type="radio" id="delivery" name="shipping" checked/>
                                    <label for="delivery">
                                        <i class="hgi-stroke hgi-delivery-truck-01 fs-4 me-2"></i>
                                        Delivery
                                    </label>
                                </div>
                                <div class="shipping-option">
                                    <input type="radio" id="pickup" name="shipping"/>
                                    <label for="pickup" class="text-muted">
                                        <i class="hgi-stroke hgi-package fs-4 me-2"></i>
                                        Pick up
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Shipping Form -->
                        <form>
                            <div class="mb-3">
                                <label class="form-label">
                                    Full name <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" placeholder="Enter full name" required/>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    Email address <span class="text-danger">*</span>
                                </label>
                                <input type="email" class="form-control" placeholder="Enter email address" required/>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    Phone number <span class="text-danger">*</span>
                                </label>
                                <div class="input-group align-items-center phone-number-group">
                                    <input type="text" class="form-control country-code" value="+94 |" readonly/>
                                    <input type="tel" class="form-control phone-number" placeholder="Enter phone number"
                                           required/>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    Address <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" placeholder="Enter address" required/>
                            </div>

                            <div class="row mb-2">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">
                                        City <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" placeholder="Enter city"/>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">
                                        State <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" placeholder="Enter state"/>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">
                                        ZIP Code <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" placeholder="Enter ZIP code"/>
                                </div>
                            </div>

                            <div class="mb-3">
                                <button class="seller-note" data-bs-toggle="collapse" data-bs-target="#leave-note">
                                    <i class="hgi-stroke hgi-note-edit"></i>
                                    Leave Note For Seller
                                    <i class="hgi-stroke hgi-arrow-right-01 ms-auto"></i>
                                </button>
                                <div class="collapse" id="leave-note">
                                    <div class="collapse-content">
                                        <textarea class="form-control" rows="3"
                                                  placeholder="Write your note here...">
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Order Summary Column -->
            <div class="col-md-6 rounded-4">
                <div class="card border-0 px-3 summary-card rounded-4">
                    <div class="card-body p-4">
                        <h4 class="mb-4">Review your cart</h4>

                        <!-- Product List -->
                        <div class="product-list mb-4">
                            <div class="d-flex align-items-center mb-3">
                                <img src="/api/placeholder/80/80" alt="DuoComfort Sofa"
                                     class="product-image rounded me-3"/>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">DuoComfort Sofa Premium</h6>
                                    <span class="text-muted">1x</span>
                                </div>
                                <div class="ms-3">
                                    <span class="fw-bold">$20.00</span>
                                </div>
                            </div>

                            <div class="d-flex align-items-center mb-3">
                                <img src="/api/placeholder/80/80" alt="IronOne Desk"
                                     class="product-image rounded me-3"/>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">IronOne Desk</h6>
                                    <span class="text-muted">1x</span>
                                </div>
                                <div class="ms-3">
                                    <span class="fw-bold">$25.00</span>
                                </div>
                            </div>

                            <div class="d-flex align-items-center mb-3">
                                <img src="/api/placeholder/80/80" alt="DuoComfort Sofa"
                                     class="product-image rounded me-3"/>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">DuoComfort Sofa Premium</h6>
                                    <span class="text-muted">1x</span>
                                </div>
                                <div class="ms-3">
                                    <span class="fw-bold">$20.00</span>
                                </div>
                            </div>
                        </div>

                        <!-- Discount Code -->
                        <div class="mb-4">
                            <button class="discount-code" data-bs-toggle="collapse" data-bs-target="#apply-coupon">
                                <i class="hgi-stroke hgi-coupon-percent"></i>
                                Apply Coupon Code
                                <i class="hgi-stroke hgi-arrow-right-01 ms-auto"></i>
                            </button>
                            <div class="collapse" id="apply-coupon">
                                <div class="collapse-content d-flex align-items-center gap-2">
                                    <input type="text" class="form-control" placeholder="Enter coupon code"/>
                                    <button class="btn btn-success">Apply</button>
                                </div>
                            </div>
                        </div>

                        <!-- Order Summary -->
                        <div class="checkout-summary">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Subtotal</span>
                                <span>$45.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Shipping</span>
                                <span>$5.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Discount</span>
                                <span class="text-danger">-$10.00</span>
                            </div>
                            <div class="d-flex justify-content-between fw-bold mt-3">
                                <span>Total</span>
                                <span>$40.00</span>
                            </div>
                        </div>

                        <!-- Pay Button -->
                        <button class="btn w-100 py-3 mt-4 text-white proceed-pay-btn">
                            <a href="${pageContext.request.contextPath}/pages/payment.jsp"
                               class="nav-link text-white"> Proceed to Pay </a>
                        </button>

                        <!-- Secure Checkout -->
                        <div class="mt-4 secure-checkout">
                            <i class="hgi-stroke hgi-square-lock-02 fs-5 me-2"></i>
                            <strong>Secure Checkout - SSL Encrypted</strong>
                            <p class="mb-0 mt-2">
                                Ensuring your financial and personal details are secure during
                                every transaction.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script src="${pageContext.request.contextPath}/assets/js/order.js"></script>
</body>
</html>