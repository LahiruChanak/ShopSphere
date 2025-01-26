package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/AdminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/ecommerce");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize JNDI DataSource", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalCustomers = 0;
        int totalOrders = 0;
        int totalProducts = 0;
        int totalCategories = 0;

        try (Connection connection = dataSource.getConnection()) {
            String customerQuery = "SELECT COUNT(*) AS total_customers FROM customer";
            try (PreparedStatement ps = connection.prepareStatement(customerQuery); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalCustomers = rs.getInt("total_customers");
                }
            }

            String ordersQuery = "SELECT COUNT(*) AS total_orders FROM orders";
            try (PreparedStatement ps = connection.prepareStatement(ordersQuery); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalOrders = rs.getInt("total_orders");
                }
            }

            String productsQuery = "SELECT COUNT(*) AS total_products FROM product";
            try (PreparedStatement ps = connection.prepareStatement(productsQuery); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalProducts = rs.getInt("total_products");
                }
            }

            String categoriesQuery = "SELECT COUNT(*) AS total_categories FROM category";
            try (PreparedStatement ps = connection.prepareStatement(categoriesQuery); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalCategories = rs.getInt("total_categories");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);

        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}
