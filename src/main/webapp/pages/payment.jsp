<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment - ShopSphere</title>

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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/payment.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="../header.jsp" %>

<main>
<div class="container py-5">
    <div class="row justify-content-around h-100 g-5 px-4 pt-4">
        <!-- Payment Form Section -->
        <div class="col-md-7 card-details-section rounded-4 p-3">
            <div class="p-4">
                <h2 class="mb-3">Let's Make Payment</h2>
                <p class="text-muted mb-5">
                    To start your subscription, input your card details to make
                    payment. You will be redirected to your bank's authorization page.
                </p>

                <form>
                    <div class="mb-3">
                        <label class="form-label">
                            Cardholder's Name <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" value="PAULINA CHIMAROKE"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Card Number <span class="text-danger">*</span>
                        </label>
                        <div class="row m-0 align-items-center w-100 card-container">
                            <input type="text" class="form-control" value="9870 3456 7890 6473"/>
                            <img src="${pageContext.request.contextPath}/assets/images/icons/visa.png"
                                 alt="card logo" id="card-logo"/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                Expiry <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" value="03/25"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                CVC <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" value="654"/>
                        </div>
                    </div>

                    <div class="mb-3 mt-2">
                        <input type="checkbox" name="save-card" id="save-card"/>
                        <label for="save-card" class="form-label">
                            Save card for future payments
                        </label>
                    </div>

                    <button type="submit" class="btn pay-btn rounded-5 text-white w-100"> Pay </button>
                </form>
            </div>
        </div>

        <!-- Summary Section -->
        <div class="col-md-4 summary-section rounded-4 p-3">
            <div class="p-4 d-flex flex-column flex-grow-0">
                <div class="mb-3">
                    <h3 class="mb-1">You're paying,</h3>
                    <div class="amount">$450.00</div>
                </div>

                <div class="overflow-y-auto d-flex flex-column pe-2 mb-3 product-container">
                    <div class="product-row">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h6 class="mb-1">Custom Gucci Shoes</h6>
                                <p class="product-details mb-0">Size: m Color: Red</p>
                            </div>
                            <span>$ 400.00</span>
                        </div>
                    </div>

                    <div class="product-row">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h6 class="mb-1">Nivea Cream 400ml</h6>
                                <p class="product-details mb-0">Size: m Color: Blue</p>
                            </div>
                            <span>$ 50.00</span>
                        </div>
                    </div>

                    <div class="product-row">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h6 class="mb-1">Nivea Cream 400ml</h6>
                                <p class="product-details mb-0">Size: m Color: Blue</p>
                            </div>
                            <span>$ 50.00</span>
                        </div>
                    </div>

                    <div class="product-row">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h6 class="mb-1">Nivea Cream 400ml</h6>
                                <p class="product-details mb-0">Size: m Color: Blue</p>
                            </div>
                            <span>$ 50.00</span>
                        </div>
                    </div>
                </div>

                <hr/>

                <div class="d-flex flex-column">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Discounts & Offers</span>
                        <span>$ 0.00</span>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span>Tax</span>
                        <span>$ 0.00</span>
                    </div>

                    <div class="d-flex justify-content-between mt-3">
                        <strong>Total</strong>
                        <strong>$ 450.00</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</main>

<%@ include file="../footer.jsp" %>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
</body>
</html>