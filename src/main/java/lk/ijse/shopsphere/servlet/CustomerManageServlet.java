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
import java.util.Base64;
import java.util.List;
import lk.ijse.shopsphere.dto.CustomerDTO;

@WebServlet({"/CustomerManage", "/customers"})
public class CustomerManageServlet extends HttpServlet {

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

        if (action.equals("changeStatus")) {
            changeCustomerStatus(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void changeCustomerStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        if (id <= 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID is required");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            // Toggle the status (Active <-> Inactive)
            String sql = "UPDATE customer SET status = IF(status = 'Active', 'Inactive', 'Active') WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }

            // Redirect to the customer list page
            response.sendRedirect("customers");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while changing customer status", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CustomerDTO> customerList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, name, email, address, phoneNumber, registeredDate, image, status FROM customer";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phoneNumber");
                    String registeredDate = rs.getString("registeredDate");
                    byte[] imageData = rs.getBytes("image");
                    String imageBase64 = (imageData != null) ? Base64.getEncoder().encodeToString(imageData) : null;
                    String status = rs.getString("status");

                    customerList.add(new CustomerDTO(id, name, email, address, phoneNumber, registeredDate, imageBase64, status));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while fetching customers", e);
        }

        request.setAttribute("customers", customerList);
        request.getRequestDispatcher("/customer-manage.jsp").forward(request, response);
    }
}