<%@ page import="lk.ijse.shopsphere.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Category Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .preview-image {
            max-width: 100px;
            max-height: 100px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>Category Management</h2>

    <div class="card mb-4">
        <div class="card-header">
            <h5 class="mb-0">Add/Edit Category</h5>
        </div>
        <div class="card-body">
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
                    <input type="file" class="form-control" id="icon" name="icon" accept="image/*">
                    <div id="imagePreview" class="mt-2"></div>
                </div>
                <button type="submit" class="btn btn-primary">Save Category</button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">Categories List</h5>
        </div>
        <div class="card-body">
            <%
                List<CategoryDTO> categoryList = (List<CategoryDTO>) request.getAttribute("categories");
                if (categoryList != null && !categoryList.isEmpty()) {
            %>
            <table class="table table-striped">
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
                    <td><%= dto.getId() %></td>
                    <td>
                        <% if (dto.getIcon() != null) { %>
                        <img src="data:image/png;base64,<%= dto.getIcon() %>" class="preview-image" alt="Icon">
                        <% } else { %>
                        No Icon
                        <% } %>
                    </td>
                    <td><%= dto.getName() %></td>
                    <td><%= dto.getDescription() %></td>
                    <td><%= dto.getStatus() %></td>
                    <td>
                        <a href="deleteCategory?id=<%= dto.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                        <a href="editCategory?id=<%= dto.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p>No categories found.</p>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Image preview functionality
    document.getElementById('icon').addEventListener('change', function (e) {
        const preview = document.getElementById('imagePreview');
        preview.innerHTML = '';
        const file = e.target.files[0];
        if (file) {
            const img = document.createElement('img');
            img.src = URL.createObjectURL(file);
            img.className = 'preview-image';
            preview.appendChild(img);
        }
    });
</script>
</body>
</html>