<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Manage - ShopSphere</title>

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
<%@ include file="header.jsp" %>

<main>
    <div class="container py-4">
        <div
                class="d-flex justify-content-between align-items-center gap-3 mb-4"
        >
            <div class="d-flex gap-2">
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
            <div class="d-flex justify-content-center align-items-center gap-3">
                <div class="col-md-6">
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
                <div class="col-md-6">
                    <select class="form-select" id="priceFilter">
                        <option value="">All Prices</option>
                        <option value="0-50">$0 - $50</option>
                        <option value="50-100">$50 - $100</option>
                        <option value="100-200">$100 - $200</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <select class="form-select" id="statusFilter">
                        <option value="all-status">All Status</option>
                        <option value="available">Available</option>
                        <option value="out-of-stock">Out of Stock</option>
                        <option value="pending">Pending</option>
                        <option value="unknown">Unknown</option>
                    </select>
                </div>
            </div>

            <button class="btn btn-success rounded-5" id="addProductButton">
                <i class="hgi-stroke hgi-package-add fs-4 align-middle me-2"></i>
                Add Product
            </button>
        </div>

        <!-- Product List -->
        <div id="productContainer" class="product-list">
            <!-- Products will be dynamically inserted here -->
        </div>
    </div>

    <!-- Add Products Modal -->
    <div
            class="modal fade"
            id="addProductModal"
            tabindex="-1"
            aria-labelledby="addProductModalLabel"
            aria-hidden="true"
    >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">
                        Add New Product
                    </h5>
                    <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                    ></button>
                </div>
                <form id="addProductForm">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="productName" class="form-label">Product Name</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="productName"
                                    name="name"
                                    placeholder="Enter product name"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="productSku" class="form-label">SKU</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="productSku"
                                    name="sku"
                                    placeholder="Enter SKU"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="productPrice" class="form-label">Price</label>
                            <input
                                    type="number"
                                    class="form-control"
                                    id="productPrice"
                                    name="price"
                                    placeholder="Enter price"
                                    step="0.01"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="productQuantity" class="form-label">Products in Stock</label>
                            <input
                                    type="number"
                                    class="form-control"
                                    id="productQuantity"
                                    name="products"
                                    placeholder="Enter quantity"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="productViews" class="form-label">Views</label>
                            <input
                                    type="number"
                                    class="form-control"
                                    id="productViews"
                                    name="views"
                                    placeholder="Enter views"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="productStatus" class="form-label">Status</label>
                            <select
                                    class="form-select"
                                    id="productStatus"
                                    name="status"
                                    required
                            >
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="productImage" class="form-label">Image URL</label>
                            <input
                                    type="url"
                                    class="form-control"
                                    id="productImage"
                                    name="image"
                                    placeholder="Enter image URL"
                                    required
                            />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button
                                type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal"
                        >
                            Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            Add Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Update Products Modal -->
    <div
            class="modal fade"
            id="updateProductModal"
            tabindex="-1"
            aria-labelledby="updateProductModalLabel"
            aria-hidden="true"
    >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateProductModalLabel">
                        Update Product
                    </h5>
                    <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                    ></button>
                </div>
                <form id="updateProductForm">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="updateProductName" class="form-label">Product Name</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="updateProductName"
                                    name="name"
                                    placeholder="Enter product name"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="updateProductSku" class="form-label">SKU</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="updateProductSku"
                                    name="sku"
                                    placeholder="Enter SKU"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="updateProductPrice" class="form-label">Price</label>
                            <input
                                    type="number"
                                    class="form-control"
                                    id="updateProductPrice"
                                    name="price"
                                    placeholder="Enter price"
                                    step="0.01"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="updateProductQuantity" class="form-label">Products in Stock</label>
                            <input
                                    type="number"
                                    class="form-control"
                                    id="updateProductQuantity"
                                    name="products"
                                    placeholder="Enter quantity"
                                    required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="updateProductViews" class="form-label">Views</label>
                            <input type="number" class="form-control" id="updateProductViews" name="views"
                                   placeholder="Enter views" required
                            />
                        </div>
                        <div class="mb-3">
                            <label for="updateProductStatus" class="form-label">Status</label>
                            <select class="form-select" id="updateProductStatus" name="status" required>
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="updateProductImage" class="form-label">Image URL</label>
                            <input type="url" class="form-control" id="updateProductImage" name="image"
                                   placeholder="Enter image URL" required
                            />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            Update Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Products Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content py-3">
                <div class="modal-header border-0 d-flex flex-column align-items-center">
                    <div class="mb-3 bg-danger-subtle rounded-circle text-danger fs-3 delete-logo">
                        <i class="hgi-stroke hgi-alert-02"></i>
                    </div>
                    <h5 class="modal-title" id="deleteModalLabel">
                        Delete Confirmation
                    </h5>
                </div>
                <div class="modal-body text-center">
                    <h6>
                        Are you sure you want to delete the product: "<span
                            class="fw-bold text-danger"
                            id="product_name"
                    ></span
                    >"?
                    </h6>
                </div>
                <div class="modal-footer d-flex justify-content-center gap-4">
                    <button type="button"
                            class="btn btn-secondary bg-secondary-subtle text-black border-0 rounded-pill"
                            data-bs-dismiss="modal"> No, Keep
                    </button>
                    <button type="button" class="btn btn-danger rounded-pill" id="confirm-delete-btn">
                        Yes, Delete!
                    </button>
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

<script src="${pageContext.request.contextPath}/assets/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/product-manage.js"></script>
</body>
</html>