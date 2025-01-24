<%@ page import="lk.ijse.shopsphere.dto.CustomerDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Management</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customer-manage.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container my-5">
        <h2 class="mb-4">Customer Management</h2>

        <!-- Customers List -->
        <div class="card p-4 rounded-4">
            <%
                List<CustomerDTO> customerList = (List<CustomerDTO>) request.getAttribute("customers");
                if (customerList != null && !customerList.isEmpty()) {
            %>
            <table class="table table-borderless table-hover text-center align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Registered Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (CustomerDTO dto : customerList) { %>
                <tr>
                    <td><%= dto.getId() %>
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
                    <td><%= dto.getEmail() %>
                    </td>
                    <td><%= dto.getAddress() %>
                    </td>
                    <td><%= dto.getPhoneNumber() %>
                    </td>
                    <td><%= dto.getRegisteredDate() %>
                    </td>
                    <td>
                        <span class="badge <%= dto.getStatus().equals("Active") ? "bg-success" : "bg-danger" %>">
                            <%= dto.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <!-- Deactivate Button (for active accounts) -->
                        <% if (dto.getStatus().equals("Active")) { %>
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#confirm-status-model"
                           data-customer-id="<%= dto.getId() %>"
                           data-customer-name="<%= dto.getEmail() %>"
                           data-customer-status="<%= dto.getStatus() %>"
                           class="text-decoration-none text-success">
                            <i class="hgi-stroke hgi-toggle-on fs-3"
                               data-bs-toggle="tooltip"
                               data-bs-placement="bottom"
                               data-bs-title="Activated"></i>
                        </a>
                        <% } %>

                        <!-- Activate Button (for inactive accounts) -->
                        <% if (dto.getStatus().equals("Inactive")) { %>
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#confirm-status-model"
                           data-customer-id="<%= dto.getId() %>"
                           data-customer-name="<%= dto.getEmail() %>"
                           data-customer-status="<%= dto.getStatus() %>"
                           class="text-decoration-none text-danger">
                            <i class="hgi-stroke hgi-toggle-off fs-3"
                               data-bs-toggle="tooltip"
                               data-bs-placement="bottom"
                               data-bs-title="Deactivated"></i>
                        </a>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="9" class="text-center">No customers found</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <!-- Confirm Status Change Modal -->
        <div class="modal fade" id="confirm-status-model" tabindex="-1" aria-labelledby="confirmStatusModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content py-3">
                    <div class="modal-header d-flex flex-column align-items-center">
                        <div class="mb-3 bg-warning-subtle rounded-circle d-flex align-items-center justify-content-center text-warning fs-4 confirm-modal-icon">
                            <i class="hgi-stroke hgi-alert-02 fs-4"></i>
                        </div>
                        <h5 class="modal-title" id="confirmStatusModalLabel">Confirm Status Change</h5>
                    </div>
                    <div class="modal-body text-center">
                        Are you sure you want to
                        <span id="statusAction" class="fw-bold"></span>
                        the account of '
                        <span id="customerEmail" class="small text-danger"></span>'?
                    </div>
                    <div class="modal-footer d-flex justify-content-center gap-3">
                        <button type="button"
                                class="btn btn-secondary bg-secondary-subtle text-black border-0 rounded-pill"
                                data-bs-dismiss="modal">No, Cancel
                        </button>
                        <button type="button" class="btn btn-warning rounded-pill" id="confirm-status-btn">Yes, Confirm!
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
<script src="${pageContext.request.contextPath}/assets/js/customer-manage.js"></script>
</body>
</html>