<%@ page import="lk.ijse.shopsphere.dto.OrderDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order Management</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.hugeicons.com/font/hgi-stroke-rounded.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-manage.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css"/>
</head>
<body>
<%@ include file="header.jsp" %>

<main>
    <div class="container my-5">
        <h2 class="mb-4">Order Management</h2>

        <!-- Orders List -->
        <div class="card p-4 rounded-4">
            <%
                List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orders");
                if (orderList != null && !orderList.isEmpty()) {
            %>
            <table class="table table-borderless table-hover text-center align-middle">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Customer ID</th>
                    <th>Customer Email</th>
                    <th>Address</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Zip Code</th>
                    <th>Subtotal</th>
                    <th>Delivery</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (OrderDTO dto : orderList) { %>
                <tr>
                    <td><%= dto.getOrderId() %></td>
                    <td><%= dto.getDate() %></td>
                    <td><%= dto.getCustomerId() %></td>
                    <td><%= dto.getCustomerEmail() %></td>
                    <td><%= dto.getAddress() %></td>
                    <td><%= dto.getCity() %></td>
                    <td><%= dto.getState() %></td>
                    <td><%= dto.getZipCode() %></td>
                    <td><%= dto.getSubTotal() %></td>
                    <td><%= dto.getDelivery() %></td>
                    <td><%= dto.getPaymentMethod() %></td>
                    <td>
                <span class="badge <%= dto.getStatus().equals("Pending") ? "bg-warning text-black" : (dto.getStatus().equals("Shipped") ? "bg-info text-dark" : "bg-success") %>">
                    <%= dto.getStatus() %>
                </span>
                    </td>
                    <td>
                        <a href="#"
                           data-bs-toggle="modal"
                           data-bs-target="#updateStatusModal<%= dto.getOrderId() %>"
                           class="text-primary text-decoration-none">
                            <i class="hgi-stroke hgi-pencil-edit-02 fs-5" data-bs-toggle="tooltip"
                               data-bs-placement="bottom" data-bs-title="Update Status"></i>
                        </a>
                    </td>
                </tr>

                <!-- Update Status Modal for Each Row -->
                <div class="modal fade" id="updateStatusModal<%= dto.getOrderId() %>" tabindex="-1"
                     aria-labelledby="updateStatusModalLabel<%= dto.getOrderId() %>" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateStatusModalLabel<%= dto.getOrderId() %>">Update Order Status</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/OrderManage" method="post">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="orderId" value="<%= dto.getOrderId() %>">
                                    <div class="mb-3">
                                        <label for="updateStatus<%= dto.getOrderId() %>" class="form-label">Status</label>
                                        <select class="form-select" id="updateStatus<%= dto.getOrderId() %>" name="status">
                                            <option value="Pending" <%= dto.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                                            <option value="Shipped" <%= dto.getStatus().equals("Shipped") ? "selected" : "" %>>Shipped</option>
                                            <option value="Completed" <%= dto.getStatus().equals("Completed") ? "selected" : "" %>>Completed</option>
                                        </select>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary rounded-5"
                                                data-bs-dismiss="modal">Close
                                        </button>
                                        <button type="submit" class="btn btn-primary rounded-5">
                                            Update Status
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
                    <td colspan="13" class="text-center">No orders found</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script>
    // Bootstrap tooltip initialization
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
</script>
</body>
</html>