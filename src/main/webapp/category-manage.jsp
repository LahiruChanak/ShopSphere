<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Category Management</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/category-manage.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container my-5">
        <h2 class="mb-4">Category Management</h2>

        <!-- Button to Open Add Modal -->
        <button type="button" class="btn btn-primary d-flex align-items-center rounded-5 mb-4 px-3"
                data-bs-toggle="modal"
                data-bs-target="#addCategoryModal">
            <i class="hgi-stroke hgi-add-circle fs-4 me-2"></i>Add Category
        </button>

        <!-- Categories List -->
        <div class="card p-4 rounded-4">
            <%
                List<CategoryDTO> categoryList = (List<CategoryDTO>) request.getAttribute("categories");
                if (categoryList != null && !categoryList.isEmpty()) {
            %>
            <table class="table table-borderless table-hover text-center align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Icon</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (CategoryDTO dto : categoryList) { %>
                <tr>
                    <td><%= dto.getId() %>
                    </td>
                    <td>
                        <% if (dto.getIcon() != null) { %>
                        <img src="data:image/png;base64,<%= dto.getIcon() %>" class="preview-image" alt="Icon">
                        <% } else { %>
                        <span class="text-muted">No Icon</span>
                        <% } %>
                    </td>
                    <td><%= dto.getName() %>
                    </td>
                    <td><%= dto.getDescription() %>
                    </td>
                    <td>
                        <span class="badge <%= dto.getStatus().equals("Active") ? "bg-success" : "bg-warning text-black" %>">
                            <%= dto.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <!-- Edit Button -->
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#updateCategoryModal<%= dto.getId() %>"
                           class="text-warning text-decoration-none">
                            <i class="hgi-stroke hgi-pencil-edit-02 fs-5" data-bs-toggle="tooltip"
                               data-bs-placement="bottom" data-bs-title="Edit"></i>
                        </a>

                        <!-- Delete Button -->
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#confirm-delete-model"
                           data-category-id="<%= dto.getId() %>"
                           data-category-name="<%= dto.getName() %>"
                           class="text-danger text-decoration-none ms-3">
                            <i class="hgi-stroke hgi-delete-02 fs-5" data-bs-toggle="tooltip" data-bs-placement="bottom"
                               data-bs-title="Delete"></i>
                        </a>
                    </td>
                </tr>

                <!-- Update Modal for Each Row -->
                <div class="modal fade" id="updateCategoryModal<%= dto.getId() %>" tabindex="-1"
                     aria-labelledby="updateCategoryModalLabel<%= dto.getId() %>" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateCategoryModalLabel<%= dto.getId() %>">Update
                                    Category</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/CategoryManage" method="post"
                                      enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= dto.getId() %>">
                                    <div class="mb-3">
                                        <label for="updateCategoryName<%= dto.getId() %>" class="form-label">Category
                                            Name</label>
                                        <input type="text" class="form-control"
                                               id="updateCategoryName<%= dto.getId() %>" name="name"
                                               value="<%= dto.getName() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateDescription<%= dto.getId() %>"
                                               class="form-label">Description</label>
                                        <textarea class="form-control" id="updateDescription<%= dto.getId() %>"
                                                  name="description" rows="3"><%= dto.getDescription() %></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateStatus<%= dto.getId() %>" class="form-label">Status</label>
                                        <select class="form-select" id="updateStatus<%= dto.getId() %>" name="status">
                                            <option value="Active" <%= dto.getStatus().equals("Active") ? "selected" : "" %>>
                                                Active
                                            </option>
                                            <option value="Draft" <%= dto.getStatus().equals("Draft") ? "selected" : "" %>>
                                                Draft
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="updateIcon<%= dto.getId() %>" class="form-label">Icon</label>
                                        <div class="file-upload">
                                            <input type="file"
                                                   id="updateIcon<%= dto.getId() %>"
                                                   name="icon"
                                                   accept="image/*"
                                                   data-preview="updateImagePreview<%= dto.getId() %>">
                                            <div class="file-upload-icon">
                                                <i class="hgi-stroke hgi-cloud-upload text-primary"></i>
                                            </div>
                                            <p class="file-upload-label text-primary mb-0">Click or drag to upload an
                                                image</p>
                                            <div id="updateImagePreview<%= dto.getId() %>" class="mt-2">
                                                <% if (dto.getIcon() != null) { %>
                                                <img src="data:image/png;base64,<%= dto.getIcon() %>"
                                                     class="preview-image" alt="Icon">
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
                                            Update Category
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
                    <td colspan="6" class="text-center">No categories found</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade py-4 px-5" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">Add Category</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/CategoryManage" method="post"
                              enctype="multipart/form-data">
                            <input type="hidden" name="action" value="save">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Category Name</label>
                                <input type="text" class="form-control" id="categoryName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status">
                                    <option value="Active">Active</option>
                                    <option value="Draft">Draft</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="icon" class="form-label">Icon</label>
                                <div class="file-upload">
                                    <input type="file" id="icon" name="icon" accept="image/*">
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
                                    Save Category
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
                        <div class="mb-3 py-2 px-2 bg-danger-subtle rounded-circle d-flex text-danger fs-4">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <h5 class="modal-title" id="confirmDeleteModalLabel">Delete Confirmation</h5>
                    </div>
                    <div class="modal-body text-center">
                        Are you sure you want to delete '
                        <span id="deleteCategoryName" class="small text-danger"></span> '
                        category?
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
<script src="${pageContext.request.contextPath}/assets/js/category-manage.js"></script>
</body>
</html>