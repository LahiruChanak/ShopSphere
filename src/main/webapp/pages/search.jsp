<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search - ShopSphere</title>

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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-manage.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="../header.jsp" %>

<main>
    <div class="container py-4">
        <div class="row justify-content-start w-auto">
            <div
                    class="d-flex justify-content-between align-items-center gap-3 px-lg-5 mb-4"
            >
                <div class="d-flex ps-lg-5 gap-2">
                    <div
                            class="view-switch active"
                            id="listView"
                            data-bs-toggle="tooltip"
                            data-bs-placement="right"
                            data-bs-title="List View"
                    >
                        <i
                                class="hgi-stroke hgi-left-to-right-list-bullet align-middle"
                        ></i>
                    </div>

                    <div
                            class="view-switch"
                            id="gridView"
                            data-bs-toggle="tooltip"
                            data-bs-placement="right"
                            data-bs-title="Grid View"
                    >
                        <i class="hgi-stroke hgi-grid-view align-middle"></i>
                    </div>
                </div>

                <!-- Filter Section -->
                <div
                        class="d-flex justify-content-end align-items-center pe-lg-5 gap-3"
                >
                    <div class="col-md-9 col-sm-7">
                        <select class="form-select" id="categoryFilter">
                            <option value="all-categories">All Categories</option>
                            <option value="t-shirts">
                                T-Shirts (<span id="t-shirts-count">50</span>)
                            </option>
                            <option value="shirts">
                                Shirts (<span id="shirts-count">50</span>)
                            </option>
                            <option value="pants">
                                Pants (<span id="pants-count">50</span>)
                            </option>
                            <option value="shoes">
                                Shoes (<span id="shoes-count">50</span>)
                            </option>
                        </select>
                    </div>
                    <div class="col-md-9 col-sm-7">
                        <select class="form-select" id="priceFilter">
                            <option value="">All Prices</option>
                            <option value="0-50">$0 - $50</option>
                            <option value="50-100">$50 - $100</option>
                            <option value="100-200">$100 - $200</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product List -->
        <div id="productContainer" class="product-list">
            <!-- Products will be dynamically inserted here -->
        </div>
    </div>
</main>

<%@ include file="../footer.jsp" %>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>

<script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/search.js"></script>
</body>
</html>