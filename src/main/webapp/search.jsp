<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.shopsphere.dto.ProductDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search - ShopSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
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
                    <input type="text" id="searchInput" class="form-control search-input text-black-50 rounded-5"
                           placeholder="Search for products, brands and more"/>
                    <button class="btn btn-dark px-3 rounded-5" id="searchButton">
                        <i class="hgi-stroke hgi-search-01 fs-5"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</header>

<main>
    <div class="container py-4">
        <div class="row justify-content-start w-auto">
            <div class="d-flex justify-content-between align-items-center gap-3 px-lg-5 mb-4">
                <div class="d-flex ps-lg-5 gap-2">
                    <div class="view-switch active" id="listView" data-bs-toggle="tooltip" data-bs-placement="right"
                         data-bs-title="List View">
                        <i class="hgi-stroke hgi-left-to-right-list-bullet align-middle"></i>
                    </div>
                    <div class="view-switch" id="gridView" data-bs-toggle="tooltip" data-bs-placement="right"
                         data-bs-title="Grid View">
                        <i class="hgi-stroke hgi-grid-view align-middle"></i>
                    </div>
                </div>
                <div class="d-flex justify-content-end align-items-center pe-lg-5 gap-3">
                    <div class="col-md-9 col-sm-7">
                        <select class="form-select" id="categoryFilter">
                            <option value="all-categories">All Categories</option>
                            <%
                                List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
                                if (categories != null) {
                                    for (CategoryDTO category : categories) {
                            %>
                            <option value="<%= category.getId() %>"><%= category.getName() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-9 col-sm-7">
                        <select class="form-select" id="priceFilter">
                            <option value="">All Prices (LKR)</option>
                            <option value="0-1000">0 - 1000</option>
                            <option value="1000-2000">1000 - 2000</option>
                            <option value="2000-3000">2000 - 3000</option>
                            <option value="3000-4000">3000 - 4000</option>
                            <option value="4000-5000">4000 - 5000</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product List -->
        <div id="productContainer" class="product-list">
            <%
                List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
                if (products != null) {
                    for (ProductDTO product : products) {
            %>
            <div class="product-item" data-category="<%= product.getCategoryId() %>"
                 data-price="<%= product.getUnitPrice() %>">
                <div class="product-image-container">
                    <img src="data:image/jpeg;base64,<%= product.getImage() %>" alt="<%= product.getName() %>"
                         class="product-image"/>
                </div>
                <div class="product-details">
                    <h3><%= product.getName() %>
                    </h3>
                    <p class="product-description"><%= product.getDescription() %>
                    </p>
                    <div class="product-meta">
                        <span class="product-price">Price: $<%= product.getUnitPrice() %></span>
                        <span class="product-quantity">In Stock: <%= product.getQtyOnHand() %></span>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
<script>
    // Function to filter products based on category and price
    function filterProducts() {
        const categoryFilter = document.getElementById("categoryFilter").value;
        const priceFilter = document.getElementById("priceFilter").value;
        const searchQuery = document.getElementById("searchInput").value.trim().toLowerCase();
        const productItems = document.querySelectorAll(".product-item");

        productItems.forEach((product) => {
            const category = product.getAttribute("data-category");
            const price = parseFloat(product.getAttribute("data-price"));
            const name = product.querySelector("h3").textContent.toLowerCase();
            const description = product.querySelector(".product-description").textContent.toLowerCase();

            // Check category filter
            const categoryMatch = categoryFilter === "all-categories" || category === categoryFilter;

            // Check price filter
            let priceMatch = true;
            if (priceFilter) {
                const [min, max] = priceFilter.split("-").map(Number);
                priceMatch = price >= min && price <= max;
            }

            // Check search query
            const searchMatch = searchQuery === "" ||
                name.includes(searchQuery) ||
                description.includes(searchQuery);

            // Show or hide product based on all filters
            if (categoryMatch && priceMatch && searchMatch) {
                product.style.display = "block";
            } else {
                product.style.display = "none";
            }
        });
    }

    // Remove separate search event listener, use single filterProducts function
    document.getElementById("searchInput").addEventListener("input", filterProducts);
    document.getElementById("categoryFilter").addEventListener("change", filterProducts);
    document.getElementById("priceFilter").addEventListener("change", filterProducts);

    // Rest of the existing view toggle code remains the same

    // Event listeners for filters
    document.getElementById("categoryFilter").addEventListener("change", filterProducts);
    document.getElementById("priceFilter").addEventListener("change", filterProducts);

    // Live search functionality
    document.getElementById("searchInput").addEventListener("input", function () {
        const query = this.value.trim().toLowerCase();
        const productItems = document.querySelectorAll(".product-item");

        productItems.forEach((product) => {
            const name = product.querySelector("h3").textContent.toLowerCase();
            const description = product.querySelector("p").textContent.toLowerCase();

            if (name.includes(query) || description.includes(query)) {
                product.style.display = "block";
            } else {
                product.style.display = "none";
            }
        });
    });

    // List/Grid view toggle
    const listView = document.getElementById("listView");
    const gridView = document.getElementById("gridView");
    const productContainer = document.getElementById("productContainer");

    listView.addEventListener("click", () => {
        productContainer.classList.remove("product-grid");
        productContainer.classList.add("product-list");
        listView.classList.add("active");
        gridView.classList.remove("active");
    });

    gridView.addEventListener("click", () => {
        productContainer.classList.remove("product-list");
        productContainer.classList.add("product-grid");
        gridView.classList.add("active");
        listView.classList.remove("active");
    });
</script>
</body>
</html>