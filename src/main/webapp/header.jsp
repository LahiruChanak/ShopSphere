<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <script rel="stylesheet" src="${pageContext.request.contextPath}/assets/css/common.css"></script>
</head>
<body>
<header class="bg-white border-bottom">
    <div class="container py-3">
        <div class="row justify-content-center align-items-center gap-lg-2">
            <div class="col-auto mt-1 d-flex align-self-start align-items-center back-btn-container">
                <a href="#" class="text-decoration-none text-secondary-emphasis" id="back">
                    <i class="hgi-stroke hgi-arrow-left-01 fs-2 me-lg-5 align-bottom back-icon" title="Back"></i>
                </a>
            </div>
            <div class="col-auto">
                <span class="logo">ShopSphere</span>
            </div>
            <div class="col col-lg-5">
                <div class="input-group d-flex align-items-center gap-1 border border-black rounded-5 search-bar">
                    <input type="text" class="form-control search-input text-black-50 rounded-5"
                           placeholder="Search for products, brands and more"
                    />
                    <button class="btn btn-dark px-3 rounded-5">
                        <a href="${pageContext.request.contextPath}/pages/search.jsp"
                           class="text-decoration-none text-white">
                            <i class="hgi-stroke hgi-search-01 fs-5"></i>
                        </a>
                    </button>
                </div>
            </div>
            <div class="col-auto position-relative small">
                <div class="d-flex gap-4 align-items-center">
                    <div class="dropdown">
                        <a href="#" class="nav-link position-relative ship-to-link">
                            <i class="hgi-stroke hgi-location-04 fs-3 mt-1"></i>
                        </a>
                        <!-- Ship to Popup -->
                        <div class="ship-to-popup pt-2 p-3 rounded-4 bg-white">
                            <div>
                                <div class="bg-transparent strap"></div>
                                <div class="triangle"></div>
                            </div>
                            <div class="mb-3">
                                <h6 class="modal-title mb-2 fw-bold">Ship to</h6>
                                <select class="form-select border">
                                    <option value="1">Sri Lanka</option>
                                    <option value="2">India</option>
                                    <option value="3">United States</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <h6 class="modal-title mb-2 fw-bold">Language</h6>
                                <select class="form-select border">
                                    <option value="1">English</option>
                                    <option value="2">Sinhala</option>
                                    <option value="3">Tamil</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <h6 class="modal-title mb-2 fw-bold">Currency</h6>
                                <select class="form-select border">
                                    <option value="1">LKR ( Sri Lankan Rupee )</option>
                                    <option value="2">INR ( Indian Rupee )</option>
                                    <option value="3">USD ( US Dollar )</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-dark rounded-5 w-100 mt-2">Save</button>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <div>
                            <% if (session.getAttribute("image") != null) { %>
                            <img
                                    src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString((byte[]) session.getAttribute("image")) %>"
                                    class="header-profile"
                                    alt="Profile Picture"/>
                            <% } else { %>
                            <i class="hgi-stroke hgi-user-circle fs-3"></i>
                            <% } %>
                        </div>

                        <div class="dropdown">
                            <a href="${pageContext.request.contextPath}/ProfileServlet"
                               class="text-decoration-none small auth-link">
                                <span class="text-black">Welcome</span><br/>
                                <span class="fw-bold nav-link"> <%= session.getAttribute("fullName") %> </span>
                            </a>
                            <div class="auth-popup pt-2 p-3 rounded-4 bg-white">
                                <div>
                                    <div class="bg-transparent strap"></div>
                                    <div class="triangle"></div>
                                </div>
                                <div class="pt-2">
                                    <div class="mb-3">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-task-01 me-2 fs-5 align-middle"></i>
                                            My Orders
                                        </a>
                                    </div>
                                    <div class="mb-3">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-message-02 me-2 fs-5 align-middle"></i>
                                            Message Center
                                        </a>
                                    </div>
                                    <div class="mb-3">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-credit-card-pos me-2 fs-5 align-middle"></i>
                                            Payments
                                        </a>
                                    </div>
                                    <div class="mb-3">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-coupon-percent me-2 fs-5 align-middle"></i>
                                            My Coupons
                                        </a>
                                    </div>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/profile.jsp" class="nav-link">
                                            <i class="hgi-stroke hgi-user-circle me-2 fs-5 align-middle"></i>
                                            My Account
                                        </a>
                                    </div>
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-link">
                                            <i class="hgi-stroke hgi-login-01 me-2 fs-5 align-middle rotate-right"></i>
                                            Log out
                                        </a>
                                    </div>
                                </div>
                                <hr/>
                                <div>
                                    <div class="mb-3">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-shield-user me-2 fs-5 align-middle"></i>
                                            Admin Login
                                        </a>
                                    </div>
                                    <div class="mb-3">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-customer-support me-2 fs-5 align-middle"></i>
                                            Help & Support
                                        </a>
                                    </div>
                                    <div class="mb-0">
                                        <a href="#" class="nav-link">
                                            <i class="hgi-stroke hgi-information-circle me-2 fs-5 align-middle"></i>
                                            About
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="nav-link position-relative">
                        <i class="hgi-stroke hgi-shopping-basket-01 fs-3"></i>
                        <span class="position-absolute translate-middle-y mt-1 badge rounded-pill cart-count"
                              id="cart-count">
                            0
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<script src="${pageContext.request.contextPath}/assets/js/header.js"></script>
</body>
</html>
