<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product - ShopSphere</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    />

    <link
            rel="stylesheet"
            href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"
    />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container py-5">
        <div class="row justify-content-center gap-4">
            <!-- Product Images -->
            <div class="col-md-4 mb-4">
                <div class="d-flex flex-column">
                    <img src="https://i.postimg.cc/3RQ5zzHt/14981.jpg" alt="Product" class="product-img mb-3"/>
                    <!-- Thumbnail Images -->
                    <div class="d-flex justify-content-center align-items -center gap-2">
                        <img src="https://i.postimg.cc/3RQ5zzHt/14981.jpg" alt="Thumbnail" class="thumbnail active"/>
                        <img src="https://i.postimg.cc/P5ckQPVs/14982.jpg" alt="Thumbnail" class="thumbnail"/>
                        <img src="https://i.postimg.cc/qRcVrQJ4/14983.jpg" alt="Thumbnail" class="thumbnail"/>
                        <img src="https://i.postimg.cc/QMTZ4hvB/14984.jpg" alt="Thumbnail" class="thumbnail"/>
                    </div>
                </div>
            </div>

            <!-- Product Details -->
            <div class="col-md-4 product-details">
                <h2 class="mb-3">Simple Modern Minimalist Nordic T-Shirt</h2>

                <div class="d-flex align-items-center gap-3 mb-3">
                    <div class="d-flex gap-2">
                        <div class="product-rating">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star-half-stroke"></i>
                            <i class="fa-regular fa-star"></i>
                        </div>
                        <span>4.3</span>
                    </div>

                    <div class="text-muted">
                        • <span id="total-reviews">32</span> reviews
                    </div>
                    <div class="text-muted">
                        • <span id="total-orders">12</span> orders
                    </div>
                </div>

                <div class="text-success mb-4">
            <span>
              <i class="hgi-stroke hgi-tick-01 fs-4 align-middle fw-bolder me-1"></i>
              <span id="availability">In Stock</span>
            </span>
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

                        <button class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#size-modal">
                            Size Chart
                        </button>
                    </div>
                </div>

                <div class="mb-4">
                    <h6 class="mb-3">
                        Color:
                        <span id="selected-color" class="text-muted ms-2">Purple</span>
                    </h6>
                    <div class="d-flex gap-3">
                        <div class="color-option active" style="background: #6c71c4"></div>
                        <div class="color-option" style="background: #d33682"></div>
                        <div class="color-option" style="background: #2aa198"></div>
                        <div class="color-option" style="background: #dc322f"></div>
                    </div>
                </div>

                <div class="mb-4">
                    <ul class="product-labels">
                        <li><span class="text-muted">Category:</span> T-Shirts</li>
                        <li>
                            <span class="text-muted">Tags:</span> Casual, Modern, Cotton
                        </li>
                        <li><span class="text-muted">Material:</span> 100% Cotton</li>
                        <li><span class="text-muted">Shipping:</span> Free shipping</li>
                    </ul>
                </div>
            </div>

            <!-- Product Price -->
            <div class="col-md-3 price-card">
                <div class="d-flex flex-column justify-content-center gap-1 mb-4">
                    <div class="d-flex gap-2 text-success">
                        <h3 class="mb-0">$98.00</h3>
                        <span class="original-price">$128.00</span>
                    </div>
                    <span class="text-muted">All prices include VAT</span>
                </div>

                <div class="d-flex gap-3 align-items-center mb-4">
                    <div class="quantity-control">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">
                            -
                        </button>
                        <span>01</span>
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">
                            +
                        </button>
                    </div>
                </div>

                <div class="d-flex gap-3 mb-4">
                    <button class="btn add-to-cart-btn w-100">
                        <a href="${pageContext.request.contextPath}/pages/cart.jsp"
                           class="text-decoration-none text-white">Add to cart</a>
                    </button>
                    <button class="btn btn-outline-dark w-100 buy-now-btn">
                        <a href="${pageContext.request.contextPath}/pages/order.jsp"
                           class="text-decoration-none text-black">Buy now</a>
                    </button>
                </div>

                <div class="d-flex justify-content-center gap-4 text-muted">
            <span>
              <i class="hgi-stroke hgi-truck-delivery me-3 fs-4"></i>Free
              Delivery
            </span>
                    <span>
              <i class="hgi-stroke hgi-security-check me-3 fs-4"></i>Secure
              Payment
            </span>
                    <span>
              <i class="hgi-stroke hgi-truck-return me-3 fs-4"></i>Easy Returns
            </span>
                </div>
            </div>
        </div>

        <!-- Tabs Section -->
        <div class="row mt-5">
            <div class="col-12">
                <!-- Tab Navigation -->
                <div class="d-flex border-bottom mb-4">
                    <button class="specs-tab active" data-tab="specifications">
                        Specifications
                    </button>
                    <button class="specs-tab" data-tab="reviews">Reviews</button>
                    <button class="specs-tab" data-tab="shipping">Shipping info</button>
                    <button class="specs-tab" data-tab="seller">Seller profile</button>
                </div>

                <!-- Tab Contents -->
                <div class="tab-contents">
                    <!-- Specifications Tab -->
                    <div class="tab-content active" id="specifications">
                        <div class="row">
                            <div class="col-md-6">
                                <h5 class="mb-4">Product Details</h5>
                                <table class="table table-borderless">
                                    <tbody>
                                    <tr>
                                        <td class="text-muted" style="width: 150px">Brand</td>
                                        <td>Nordic Style</td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Material</td>
                                        <td>100% Cotton</td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Care Instructions</td>
                                        <td>Machine washable, tumble dry low</td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Style</td>
                                        <td>Casual, Modern</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h5 class="mb-4">Size & Fit</h5>
                                <table class="table table-borderless">
                                    <tbody>
                                    <tr>
                                        <td class="text-muted" style="width: 150px">Fit Type</td>
                                        <td>Regular Fit</td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Length</td>
                                        <td>Standard</td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Sleeve Type</td>
                                        <td>Long Sleeve</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Reviews Tab -->
                    <div class="tab-content" id="reviews">
                        <div class="p-4 bg-light rounded mb-4">
                            <h5>Customer Reviews</h5>
                            <p>Average rating: 4.5/5 based on 32 reviews</p>
                        </div>
                    </div>

                    <!-- Shipping Tab -->
                    <div class="tab-content" id="shipping">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body">
                                        <h6>Standard Shipping</h6>
                                        <p class="text-muted mb-0">7-14 business days</p>
                                        <p class="text-success">Free shipping on orders over $50</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body">
                                        <h6>Express Shipping</h6>
                                        <p class="text-muted mb-0">2-4 business days</p>
                                        <p>Additional $15 shipping fee</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Seller Tab -->
                    <div class="tab-content" id="seller">
                        <div class="d-flex align-items-center mb-4">
                            <img src="/api/placeholder/80/80" alt="Seller" class="rounded-circle me-3"/>
                            <div>
                                <h5 class="mb-1">Nordic Fashion Store</h5>
                                <p class="text-muted mb-0">Member since 2020</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body text-center">
                                        <h3 class="mb-1">98%</h3>
                                        <p class="text-muted mb-0">Positive Feedback</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body text-center">
                                        <h3 class="mb-1">24h</h3>
                                        <p class="text-muted mb-0">Response Time</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body text-center">
                                        <h3 class="mb-1">5k+</h3>
                                        <p class="text-muted mb-0">Products Sold</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
                    <img src="https://i.postimg.cc/tTbSyjvm/size-chart.png" alt="Size Chart" class="w-100"/>
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

<script src="${pageContext.request.contextPath}/assets/js/product.js"></script>
</body>
</html>