package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.shopsphere.dto.CustomerDTO;
import lk.ijse.shopsphere.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

@WebServlet("/ProfileServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String email = (String) request.getSession().getAttribute("email");

        try (Connection connection = DBConnection.getConnection()) {
            if (email != null) {
                CustomerDTO customer = getCustomerDetails(connection, email);
                session.setAttribute("fullName", customer.getName());
                session.setAttribute("email", customer.getEmail());
                session.setAttribute("phoneNumber", customer.getPhoneNumber());
                session.setAttribute("address", customer.getAddress());

                // Set image in session if retrieved from the database
                if (customer.getImage() != null) {
                    session.setAttribute("image", customer.getImage());
                }
            }

            switch (action) {
                case "updateProfile":
                    updateProfile(request, response, connection, email);
                    break;
                case "changePassword":
                    changePassword(request, response, connection, email);
                    break;
                case "updateImage":
                    updateImage(request, response, connection, email);
                    break;
                default:
                    sendError(request, response, "Invalid action");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            sendError(request, response, "Database error: " + e.getMessage());
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void updateImage(HttpServletRequest request, HttpServletResponse response, Connection connection, String userEmail) throws ServletException, IOException, SQLException {
        Part filePart = request.getPart("profileImage");

        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            long fileSize = filePart.getSize();

            if (!contentType.startsWith("image/")) {
                request.setAttribute("errorMessage", "Only image files are allowed.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            if (fileSize > 5 * 1024 * 1024) {
                request.setAttribute("errorMessage", "Image file size must be less than 5MB.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            try (InputStream fileContent = filePart.getInputStream();
                 ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                byte[] imageBytes = outputStream.toByteArray();
                updateImageInDatabase(connection, userEmail, imageBytes, request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Please select an image to upload.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    private void updateImageInDatabase(Connection connection, String userEmail, byte[] imageBytes, HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String sql = "UPDATE customer SET image = ? WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setBytes(1, imageBytes);
            statement.setString(2, userEmail);
            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {

                request.getSession().setAttribute("image", imageBytes);
                request.setAttribute("successMessage", "Profile image updated successfully.");
//                request.getRequestDispatcher("profile.jsp").forward(request, response);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile image.");
//                request.getRequestDispatcher("profile.jsp").forward(request, response);
                response.sendRedirect("index.jsp");
            }
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, Connection connection, String userEmail) throws ServletException, IOException, SQLException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (!newPassword.equals(confirmNewPassword)) {
            sendError(request, response, "New passwords do not match.");
            return;
        }

        String sql = "SELECT password FROM customer WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, userEmail);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String hashedPasswordFromDB = resultSet.getString("password");
                    if (BCrypt.checkpw(currentPassword, hashedPasswordFromDB)) {
                        String newHashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12)); // Use recommended cost factor
                        String updateSql = "UPDATE customer SET password = ? WHERE email = ?";
                        try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                            updateStatement.setString(1, newHashedPassword);
                            updateStatement.setString(2, userEmail);
                            updateStatement.executeUpdate();
                            request.setAttribute("successMessage", "Password changed successfully.");
                        }
                    } else {
                        sendError(request, response, "Incorrect current password.");
                        return;
                    }
                } else {
                    sendError(request, response, "User not found.");
                    return;
                }
            }
        }

        response.sendRedirect("index.jsp");
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, Connection connection, String userEmail) throws ServletException, IOException, SQLException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        String sql = "UPDATE customer SET name = ?, email = ?, phoneNumber = ?, address = ? WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, phoneNumber);
            statement.setString(4, address);
            statement.setString(5, userEmail);

            int rowsUpdated = statement.executeUpdate();

            HttpSession session = request.getSession();
            if (rowsUpdated > 0) {
                // Update session attributes with new profile data
                session.setAttribute("fullName", fullName);
                session.setAttribute("email", email);
                session.setAttribute("phoneNumber", phoneNumber);
                session.setAttribute("address", address);

                // Fetch updated customer details
                CustomerDTO customer = getCustomerDetails(connection, email);
                if (customer != null && customer.getImage() != null) {
                    session.setAttribute("image", customer.getImage());
                } else {
                    session.removeAttribute("image");
                }

                // Set success message in session
                session.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                // Set error message in session
                session.setAttribute("errorMessage", "Failed to update profile.");
            }
        }

        response.sendRedirect("index.jsp");
    }

    private CustomerDTO getCustomerDetails(Connection connection, String userEmail) throws SQLException {
        String sql = "SELECT name, email, address, phoneNumber, image FROM customer WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, userEmail);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    CustomerDTO customer = new CustomerDTO();
                    customer.setName(resultSet.getString("name"));
                    customer.setEmail(resultSet.getString("email"));
                    customer.setAddress(resultSet.getString("address"));
                    customer.setPhoneNumber(resultSet.getString("phoneNumber"));
                    customer.setImage(resultSet.getBytes("image"));
                    return customer;
                }
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve the email from the session
        String email = (String) req.getSession().getAttribute("email");

        // Check if email is available in the session
        if (email == null || email.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer Email is required");
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            // Call the getCustomerDetails method
            CustomerDTO customer = getCustomerDetails(connection, email);

            // Check if the customer was found
            if (customer == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
                return;
            }

            // Set the customer as a request attribute to pass to a JSP (optional)
            req.setAttribute("customer", customer);

            // Forward to a JSP page to display customer details (optional)
            req.getRequestDispatcher("/profile.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Database error while retrieving customer details", e);
        }
    }

}