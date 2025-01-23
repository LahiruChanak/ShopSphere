<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.Base64" %>
<%@ page import="lk.ijse.shopsphere.dto.CustomerDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/profile.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/common.css"/>
    <style>
        .profile-image {
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="container py-4">

        <%-- Success and Error Messages --%>
        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success" role="alert"><%= request.getAttribute("successMessage") %>
        </div>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger" role="alert"><%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-1">Welcome, <%= session.getAttribute("fullName") %>
                </h1>
                <div class="text-muted"><%= new java.util.Date().toString() %>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <img src="
                            <% if (session.getAttribute("image") != null) { %>
                            data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString((byte[]) session.getAttribute("image")) %>
                            <% } else { %>
                            <%= request.getContextPath() %>/assets/images/default-profile.png
                        <% } %>
                            " class="rounded-circle img-fluid profile-image" alt="Profile Picture"/>
                        <form action="ProfileServlet?action=updateImage" method="post" enctype="multipart/form-data">
                            <div class="mt-3"><input type="file" name="profileImage" accept="image/*"
                                                     class="form-control"></div>
                            <button type="submit" class="btn btn-primary mt-2">Update Image</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Personal Information</h5>
                        <form action="ProfileServlet?action=updateProfile" method="post">
                            <input type="hidden" name="id" value="<%= session.getAttribute("customerId") %>"/>
                            <div class="mb-3"><label for="fullName" class="form-label">Full Name</label><input
                                    type="text" id="fullName" name="fullName" class="form-control"
                                    value="<%= session.getAttribute("fullName") %>" required/></div>
                            <div class="mb-3"><label for="email" class="form-label">Email Address</label><input
                                    type="email" id="email" name="email" class="form-control"
                                    value="<%= session.getAttribute("email") %>" required/></div>
                            <div class="mb-3"><label for="phoneNumber" class="form-label">Phone Number</label><input
                                    type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                                    value="<%= session.getAttribute("phoneNumber") %>"/>
                            </div>
                            <div class="mb-3"><label for="address" class="form-label">Address</label>
                                <input type="text"
                                       id="address"
                                       name="address"
                                       class="form-control"
                                       value="<%= session.getAttribute("address") %>"/>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-body">
                        <h5 class="card-title">Password Management</h5>
                        <form action="ProfileServlet?action=changePassword" method="post">
                            <div class="mb-3"><label for="currentPassword" class="form-label">Current
                                Password</label><input type="password" id="currentPassword" name="currentPassword"
                                                       class="form-control" required/></div>
                            <div class="mb-3"><label for="newPassword" class="form-label">New Password</label><input
                                    type="password" id="newPassword" name="newPassword" class="form-control" required/>
                            </div>
                            <div class="mb-3"><label for="confirmNewPassword" class="form-label">Confirm New
                                Password</label><input type="password" id="confirmNewPassword" name="confirmNewPassword"
                                                       class="form-control" required/></div>
                            <button type="submit" class="btn btn-primary">Update Password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>