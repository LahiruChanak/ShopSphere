<%@ page import="lk.ijse.shopsphere.dto.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Management</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-manage.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container my-5">
        <h2 class="mb-4">Product Management</h2>

        <!-- Button to Open Add Modal -->
        <button type="button" class="btn btn-primary d-flex align-items-center rounded-5 mb-4 px-3"
                data-bs-toggle="modal"
                data-bs-target="#addProductModal">
            <i class="hgi-stroke hgi-add-circle fs-4 me-2"></i>Add Product
        </button>

        <!-- Products List -->
        <div class="card p-4 rounded-4">
            <%
                List<ProductDTO> productList = (List<ProductDTO>) request.getAttribute("products");
                if (productList != null && !productList.isEmpty()) {
            %>
            <table class="table table-borderless table-hover text-center align-middle">
                <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Unit Price</th>
                    <th>Description</th>
                    <th>Qty On Hand</th>
                    <th>Category ID</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (ProductDTO dto : productList) { %>
                <tr>
                    <td><%= dto.getItemCode() %>
                    </td>
                    <td>
                        <% if (dto.getImage() != null) { %>
                        <img src="data:image/png;base64,<%= dto.getImage() %>" class="preview-image" alt="Image">
                        <% } else { %>
                        <span class="text-muted">No Image</span>
                        <% } %>
                    </td>
                    <td><%= dto.getName() %>
                    </td>
                    <td><%= dto.getUnitPrice() %>
                    </td>
                    <td><%= dto.getDescription() %>
                    </td>
                    <td><%= dto.getQtyOnHand() %>
                    </td>
                    <td><%= dto.getCategoryId() %>
                    </td>
                    <td>
                        <!-- Edit Button -->
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#updateProductModal<%= dto.getItemCode() %>"
                           class="text-warning text-decoration-none">
                            <i class="hgi-stroke hgi-pencil-edit-02 fs-5" data-bs-toggle="tooltip"
                               data-bs-placement="bottom" data-bs-title="Edit"></i>
                        </a>

                        <!-- Delete Button -->
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#confirm-delete-model"
                           data-product-id="<%= dto.getItemCode() %>"
                           data-product-name="<%= dto.getName() %>"
                           class="text-danger text-decoration-none ms-3">
                            <i class="hgi-stroke hgi-delete-02 fs-5" data-bs-toggle="tooltip" data-bs-placement="bottom"
                               data-bs-title="Delete"></i>
                        </a>
                    </td>
                </tr>

                <!-- Update Modal for Each Row -->
                <div class="modal fade" id="updateProductModal<%= dto.getItemCode() %>" tabindex="-1"
                     aria-labelledby="updateProductModalLabel<%= dto.getItemCode() %>" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateProductModalLabel<%= dto.getItemCode() %>">Update
                                    Product</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/ProductManage" method="post"
                                      enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="itemCode" value="<%= dto.getItemCode() %>">
                                    <div class="mb-3">
                                        <label for="updateProductName<%= dto.getItemCode() %>" class="form-label">Product
                                            Name</label>
                                        <input type="text" class="form-control"
                                               id="updateProductName<%= dto.getItemCode() %>" name="name"
                                               value="<%= dto.getName() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateUnitPrice<%= dto.getItemCode() %>" class="form-label">Unit
                                            Price</label>
                                        <input type="number" step="0.01" class="form-control"
                                               id="updateUnitPrice<%= dto.getItemCode() %>" name="unitPrice"
                                               value="<%= dto.getUnitPrice() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateDescription<%= dto.getItemCode() %>"
                                               class="form-label">Description</label>
                                        <textarea class="form-control" id="updateDescription<%= dto.getItemCode() %>"
                                                  name="description" rows="3"><%= dto.getDescription() %></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateQtyOnHand<%= dto.getItemCode() %>" class="form-label">Qty On
                                            Hand</label>
                                        <input type="number" class="form-control"
                                               id="updateQtyOnHand<%= dto.getItemCode() %>" name="qtyOnHand"
                                               value="<%= dto.getQtyOnHand() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateCategoryId<%= dto.getItemCode() %>" class="form-label">Category
                                            ID</label>
                                        <input type="number" class="form-control"
                                               id="updateCategoryId<%= dto.getItemCode() %>" name="categoryId"
                                               value="<%= dto.getCategoryId() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateImage<%= dto.getItemCode() %>"
                                               class="form-label">Image</label>
                                        <div class="file-upload">
                                            <input type="file"
                                                   id="updateImage<%= dto.getItemCode() %>"
                                                   name="image"
                                                   accept="image/*"
                                                   data-preview="updateImagePreview<%= dto.getItemCode() %>">
                                            <div class="file-upload-icon">
                                                <i class="hgi-stroke hgi-cloud-upload text-primary"></i>
                                            </div>
                                            <p class="file-upload-label text-primary mb-0">Click or drag to upload an
                                                image</p>
                                            <div id="updateImagePreview<%= dto.getItemCode() %>" class="mt-2">
                                                <% if (dto.getImage() != null) { %>
                                                <img src="data:image/png;base64,<%= dto.getImage() %>"
                                                     class="preview-image" alt="Image">
                                                <% } %>
                                            </div>
                                            <p class="text-muted small mt-2">Leave blank to keep the existing image.</p>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary rounded-5"
                                                data-bs-dismiss="modal">Close
                                        </button>
                                        <button type="submit" class="btn btn-primary rounded-5">
                                            Update Product
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="8" class="text-center">No products found</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <!-- Add Product Modal -->
        <div class="modal fade py-4 px-5" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/ProductManage" method="post"
                              enctype="multipart/form-data">
                            <input type="hidden" name="action" value="save">
                            <div class="mb-3">
                                <label for="productName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="unitPrice" class="form-label">Unit Price</label>
                                <input type="number" step="0.01" class="form-control" id="unitPrice" name="unitPrice"
                                       required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="qtyOnHand" class="form-label">Qty On Hand</label>
                                <input type="number" class="form-control" id="qtyOnHand" name="qtyOnHand" required>
                            </div>
                            <div class="mb-3">
                                <label for="categoryId" class="form-label">Category ID</label>
                                <input type="number" class="form-control" id="categoryId" name="categoryId" required>
                            </div>
                            <div class="mb-3">
                                <label for="image" class="form-label">Image</label>
                                <div class="file-upload">
                                    <input type="file" id="image" name="image" accept="image/*">
                                    <div class="file-upload-icon">
                                        <i class="hgi-stroke hgi-cloud-upload text-primary"></i>
                                    </div>
                                    <p class="file-upload-label text-primary mb-0">Click or drag to upload an image</p>
                                    <div id="imagePreview" class="mt-2"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary rounded-5" data-bs-dismiss="modal">
                                    Close
                                </button>
                                <button type="submit" class="btn btn-primary rounded-5">
                                    Save Product
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirm Delete Modal -->
        <div class="modal fade" id="confirm-delete-model" tabindex="-1" aria-labelledby="confirmDeleteModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content py-3">
                    <div class="modal-header d-flex flex-column align-items-center">
                        <div class="mb-3 bg-danger-subtle rounded-circle d-flex align-items-center justify-content-center text-danger fs-4 delete-modal-icon">
                            <i class="hgi-stroke hgi-alert-02 fs-4"></i>
                        </div>
                        <h5 class="modal-title" id="confirmDeleteModalLabel">Delete Confirmation</h5>
                    </div>
                    <div class="modal-body text-center">
                        Are you sure you want to delete '
                        <span id="deleteProductName" class="small text-danger"></span> '
                        product?
                    </div>
                    <div class="modal-footer d-flex justify-content-center gap-3">
                        <button type="button"
                                class="btn btn-secondary bg-secondary-subtle text-black border-0 rounded-pill"
                                data-bs-dismiss="modal">No, Keep
                        </button>
                        <button type="button" class="btn btn-danger rounded-pill" id="confirm-delete-btn">Yes, Delete!
                        </button>
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
<script src="${pageContext.request.contextPath}/assets/js/product-manage.js"></script>
</body>
</html>