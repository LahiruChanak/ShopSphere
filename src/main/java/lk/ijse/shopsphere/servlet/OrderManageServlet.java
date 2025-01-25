package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import lk.ijse.shopsphere.dto.OrderDTO;

@WebServlet({"/OrderManage", "/orders"})
public class OrderManageServlet extends HttpServlet {

    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/ecommerce");
        } catch (NamingException e) {
            throw new ServletException("DataSource lookup failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }

        if (action.equals("updateStatus")) {
            updateOrderStatus(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "UPDATE orders SET status = ? WHERE orderId = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setString(2, orderId);
                ps.executeUpdate();
            }

            response.sendRedirect("orders");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while updating order status", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<OrderDTO> orderList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT o.orderId, o.date, o.customerId, c.email, o.address, o.city, o.state, o.zipCode, o.subTotal, o.delivery, o.paymentMethod, o.status " +
                    "FROM orders o " +
                    "JOIN customer c ON o.customerId = c.id";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String orderId = rs.getString("orderId");
                    String date = rs.getString("date");
                    int customerId = rs.getInt("customerId");
                    String customerEmail = rs.getString("email"); // Fetch customer email
                    String address = rs.getString("address");
                    String city = rs.getString("city");
                    String state = rs.getString("state");
                    String zipCode = rs.getString("zipCode");
                    double subTotal = rs.getDouble("subTotal");
                    double delivery = rs.getDouble("delivery");
                    String paymentMethod = rs.getString("paymentMethod");
                    String status = rs.getString("status");

                    orderList.add(new OrderDTO(orderId, date, customerId, customerEmail, address, city, state, zipCode, subTotal, delivery, paymentMethod, status));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while fetching orders", e);
        }

        request.setAttribute("orders", orderList);
        request.getRequestDispatcher("/order-manage.jsp").forward(request, response);
    }

}
