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
                            <option value="<%= category.getId() %>"><%= category.getName() %></option>
                            <%
                                    }
                                }
                            %>
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
            <%
                List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
                if (products != null) {
                    for (ProductDTO product : products) {
            %>
            <div class="product-item" data-category="<%= product.getCategoryId() %>" data-price="<%= product.getUnitPrice() %>">
                <img src="data:image/jpeg;base64,<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-image"/>
                <h3><%= product.getName() %></h3>
                <p><%= product.getDescription() %></p>
                <p><strong>Price:</strong> $<%= product.getUnitPrice() %></p>
                <p><strong>Quantity:</strong> <%= product.getQtyOnHand() %></p>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
<script>
    // Bootstrap tooltip initialization
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(
        (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl)
    );

    // View management
    let currentView = "list";
    const listView = document.getElementById("listView");
    const gridView = document.getElementById("gridView");
    const productContainer = document.getElementById("productContainer");

    // Update active view style
    function updateViewButtons() {
        listView.classList.toggle("active", currentView === "list");
        gridView.classList.toggle("active", currentView === "grid");
    }

    // Render products
    function renderProducts(isGrid = false, filters = {}) {
        currentView = isGrid ? "grid" : "list";
        updateViewButtons();

        // Get all product items
        const productItems = document.querySelectorAll(".product-item");

        // Filter products based on selected filters
        productItems.forEach((product) => {
            const category = product.getAttribute("data-category");
            const price = parseFloat(product.getAttribute("data-price"));

            const categoryMatch = !filters.category || filters.category === "all-categories" || category === filters.category;
            const priceMatch = !filters.price || checkPriceRange(price, filters.price);

            if (categoryMatch && priceMatch) {
                product.style.display = "block";
            } else {
                product.style.display = "none";
            }
        });

        // Update container class for grid/list view
        productContainer.classList.remove("product-list", "product-grid");
        productContainer.classList.add(isGrid ? "product-grid" : "product-list");
    }

    // Check if price falls within the selected range
    function checkPriceRange(price, range) {
        const [min, max] = range.split("-").map(Number);
        return price >= min && price <= max;
    }

    // Event listeners for view toggles
    listView.addEventListener("click", () => renderProducts(false));
    gridView.addEventListener("click", () => renderProducts(true));

    // Filter handling
    const categoryFilter = document.getElementById("categoryFilter");
    const priceFilter = document.getElementById("priceFilter");

    categoryFilter.addEventListener("change", () => {
        const filters = {
            category: categoryFilter.value,
            price: priceFilter.value,
        };
        renderProducts(currentView === "grid", filters);
    });

    priceFilter.addEventListener("change", () => {
        const filters = {
            category: categoryFilter.value,
            price: priceFilter.value,
        };
        renderProducts(currentView === "grid", filters);
    });

    // Live search handling
    const searchInput = document.getElementById("searchInput");
    const searchButton = document.getElementById("searchButton");

    searchButton.addEventListener("click", () => {
        const query = searchInput.value.trim();
        if (query) {
            window.location.href = "${pageContext.request.contextPath}/search?query=" + encodeURIComponent(query);
        }
    });

    searchInput.addEventListener("keypress", (e) => {
        if (e.key === "Enter") {
            const query = searchInput.value.trim();
            if (query) {
                window.location.href = "${pageContext.request.contextPath}/search?query=" + encodeURIComponent(query);
            }
        }
    });

    // Initial render
    renderProducts(false);
</script>
</body>
</html>