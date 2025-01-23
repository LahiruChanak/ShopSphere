<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/category.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container my-5">
        <h2 class="mb-4">Category Management</h2>

        <!-- Button to Open Modal -->
        <button type="button" class="btn btn-primary mb-4" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
            <i class="fas fa-plus me-2"></i>Add Category
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
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#updateCategoryModal"
                           data-bs-placement="bottom"
                           data-bs-title="Edit"
                           onclick="prepareUpdateModal(<%= dto.getId() %> , '<%= dto.getName() %>', '<%= dto.getDescription() %>', '<%= dto.getStatus() %>', '<%= dto.getIcon() %>')"
                           class="text-warning text-decoration-none">
                            <i class="hgi-stroke hgi-pencil-edit-02 fs-4" data-bs-toggle="tooltip"
                               data-bs-placement="bottom" data-bs-title="Edit"></i>
                        </a>

                        <a href="deleteCategory?id=<%= dto.getId() %>"
                           class="text-danger text-decoration-none ms-3"
                           onclick="return confirm('Are you sure you want to delete this category?')">
                            <i class="hgi-stroke hgi-delete-02 fs-4" data-bs-toggle="tooltip"
                               data-bs-placement="bottom" data-bs-title="Delete"></i>
                        </a>
                    </td>
                </tr>
                <% } %> <% } else { %>
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
                        <form action="saveCategory" method="post" enctype="multipart/form-data">
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
                                        <i class="hgi-stroke hgi-image-upload"></i>
                                    </div>
                                    <p class="file-upload-label">Click or drag to upload an icon</p>
                                    <div id="imagePreview" class="mt-2"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Save Category
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Category Modal -->
        <div class="modal fade" id="updateCategoryModal" tabindex="-1" aria-labelledby="updateCategoryModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateCategoryModalLabel">Update Category</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="updateCategory" method="post" enctype="multipart/form-data">
                            <input type="hidden" id="updateCategoryId" name="id">
                            <div class="mb-3">
                                <label for="updateCategoryName" class="form-label">Category Name</label>
                                <input type="text" class="form-control" id="updateCategoryName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="updateDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="updateDescription" name="description"
                                          rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="updateStatus" class="form-label">Status</label>
                                <select class="form-select" id="updateStatus" name="status">
                                    <option value="Active">Active</option>
                                    <option value="Draft">Draft</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="updateIcon" class="form-label">Icon</label>
                                <div class="file-upload">
                                    <input type="file" id="updateIcon" name="icon" accept="image/*">
                                    <div class="file-upload-icon">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                    </div>
                                    <p class="file-upload-label">Click or drag to upload an icon</p>
                                    <div id="updateImagePreview" class="mt-2"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Update Category
                                </button>
                            </div>
                        </form>
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
<script src="${pageContext.request.contextPath}/assets/js/category.js"></script>
</body>
</html>