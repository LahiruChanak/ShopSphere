<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.Base64" %>
<%@ page import="lk.ijse.shopsphere.dto.CustomerDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Profile</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css">

</head>
<body>

<%@ include file="header.jsp" %>

<%
    CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");
%>

<main>
    <div class="container my-4">
        <%-- Success and Error Messages --%>
        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            <%= request.getAttribute("successMessage") %>
        </div>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i>
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <div class="welcome-section mb-5 mt-4">
            <h1 class="h3">Welcome, <span class="userName"> <%= session.getAttribute("fullName") %> </span></h1>
            <div id="current-time" class="text-muted ms-3"></div>
        </div>

        <div class="row g-4 pb-3">
            <div class="col-md-4">
                <%-- Profile Image Section --%>
                <div class="d-flex justify-content-center">
                    <div class="card profile-container w-auto rounded-5">
                        <div class="card-body text-center px-5 pt-3">
                            <div class="profile-image-container">
                                <img src="
                                <% if (customer.getImage() != null ) { %>
                                data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString((byte[]) customer.getImage()) %>
                                <% } else { %>
                                <%= request.getContextPath() %>/assets/images/default-profile.png
                                <% } %>
                                " class="profile-image" alt="Profile Picture"/>

                                <form action="ProfileServlet?action=updateImage" method="post"
                                      enctype="multipart/form-data">
                                    <div class="file-input-container">
                                        <label for="profileImage">
                                            <i class="hgi-stroke hgi-camera-01 fs-5"></i>
                                        </label>
                                        <input type="file" id="profileImage" name="profileImage" accept="image/*"
                                               class="form-control d-none" required>
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <button type="submit" class="btn btn-primary d-flex align-items-center mt-3"><i
                                                class="hgi-stroke hgi-cloud-upload fs-5 me-2"></i>Sync
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <%--- Password Management Section --%>
                <div class="card mt-4">
                    <div class="card-body p-4">
                        <h5 class="card-title mb-4">
                            <i class="hgi-stroke hgi-lock-password align-bottom fs-4 me-2"></i>Password Management
                        </h5>
                        <form action="ProfileServlet?action=changePassword" method="post" class="mb-0">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-control"
                                       required/>
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" id="newPassword" name="newPassword" class="form-control"
                                       required/>
                            </div>
                            <div class="mb-3">
                                <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                                <input type="password" id="confirmNewPassword" name="confirmNewPassword"
                                       class="form-control" required/>
                            </div>
                            <div class="d-flex justify-content-center">
                                <button type="submit" class="btn btn-primary d-flex align-items-center mx-4">
                                    <i class="hgi-stroke hgi-password-validation fs-5 me-2"></i>Update Password
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <%-- Personal Information Section --%>
            <div class="col-md-8 mb-5">
                <div class="card">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-4">
                            <i class="hgi-stroke hgi-account-setting-03 align-bottom fs-4 me-2"></i>Personal Information
                        </h4>
                        <form action="ProfileServlet?action=updateProfile" method="post">
                            <input type="hidden" name="id" value="<%= session.getAttribute("customerId") %>"/>
                            <div class="mb-4">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" id="fullName" name="fullName" class="form-control"
                                       value="<%= customer != null ? customer.getName() : "" %>" required/>
                            </div>
                            <div class="mb-4">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" id="email" name="email" class="form-control"
                                       value="<%= customer != null ? customer.getEmail() : "" %>" required/>
                            </div>
                            <div class="mb-4">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                                       value="<%= customer != null ? customer.getPhoneNumber() : "" %>"/>
                            </div>
                            <div class="mb-4">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" id="address" name="address" class="form-control"
                                       value="<%= customer != null ? customer.getAddress() : "" %>"/>
                            </div>
                            <div class="d-flex justify-content-end align-items-center">
                                <button type="submit" class="btn btn-primary d-flex align-items-center">
                                    <i class="hgi-stroke hgi-cloud-download fs-5 me-2"></i> Save Changes
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

<div class="toast-container"></div>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script src="${pageContext.request.contextPath}/assets/js/profile.js"></script>
</body>
</html>