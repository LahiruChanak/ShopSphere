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
import java.util.Base64;

@WebServlet("/ProfileServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        try (Connection connection = DBConnection.getConnection()) {
            if (customerId != null) {
                CustomerDTO customer = getCustomerDetails(connection, customerId);
                session.setAttribute("fullName", customer.getName());
                session.setAttribute("email", customer.getEmail());
                session.setAttribute("phoneNumber", customer.getPhoneNumber());
                session.setAttribute("address", customer.getAddress());
            }

            switch (action) {
                case "updateProfile":
                    updateProfile(request, response, connection, customerId);
                    break;
                case "changePassword":
                    changePassword(request, response, connection, customerId);
                    break;
                case "updateImage":
                    updateImage(request, response, connection, customerId);
                    break;
                default:
                    sendError(request, response, "Invalid action");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            sendError(request, response, "Database error: " + e.getMessage());
        }
    }

    private void handleMissingCustomerId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("errorMessage", "Customer ID not found. Please log in again.");
        request.getRequestDispatcher("pages/profile.jsp").forward(request, response);
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("pages/profile.jsp").forward(request, response);
    }

    private void updateImage(HttpServletRequest request, HttpServletResponse response, Connection connection, Integer customerId) throws ServletException, IOException, SQLException {
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) { // Check if a file was actually uploaded
            try (InputStream fileContent = filePart.getInputStream(); ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                byte[] imageBytes = outputStream.toByteArray();
                updateImageInDatabase(connection, customerId, imageBytes, request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Please select an image to upload.");
            request.getRequestDispatcher("pages/profile.jsp").forward(request, response);
        }
    }

    private void updateImageInDatabase(Connection connection, Integer customerId, byte[] imageBytes, HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String sql = "UPDATE customer SET image = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setBytes(1, imageBytes);
            statement.setInt(2, customerId);
            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                request.getSession().setAttribute("image", imageBytes);
                request.setAttribute("successMessage", "Profile image updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile image.");
            }
        }
        request.getRequestDispatcher("pages/profile.jsp").forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, Connection connection, Integer customerId) throws ServletException, IOException, SQLException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (!newPassword.equals(confirmNewPassword)) {
            sendError(request, response, "New passwords do not match.");
            return;
        }

        String sql = "SELECT password FROM customer WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, customerId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String hashedPasswordFromDB = resultSet.getString("password");
                    if (BCrypt.checkpw(currentPassword, hashedPasswordFromDB)) {
                        String newHashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12)); // Use recommended cost factor
                        String updateSql = "UPDATE customer SET password = ? WHERE id = ?";
                        try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                            updateStatement.setString(1, newHashedPassword);
                            updateStatement.setInt(2, customerId);
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
        request.getRequestDispatcher("pages/profile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, Connection connection, Integer customerId) throws ServletException, IOException, SQLException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        String sql = "UPDATE customer SET name = ?, email = ?, phoneNumber = ?, address = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, phoneNumber);
            statement.setString(4, address);
            statement.setInt(5, customerId);
            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("fullName", fullName);
                session.setAttribute("email", email);
                session.setAttribute("phoneNumber", phoneNumber);
                session.setAttribute("address", address);

                CustomerDTO customer = getCustomerDetails(connection, customerId);
                if (customer != null && customer.getImageBase64() != null) {
                    session.setAttribute("image", Base64.getDecoder().decode(customer.getImageBase64()));
                } else {
                    session.removeAttribute("image");
                }
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile.");
            }
        }
        request.getRequestDispatcher("pages/profile.jsp").forward(request, response);
    }

    private CustomerDTO getCustomerDetails(Connection connection, Integer customerId) throws SQLException {
        String sql = "SELECT id, name, email, address, phoneNumber, image FROM customer WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, customerId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    CustomerDTO customer = new CustomerDTO();
                    customer.setId(resultSet.getInt("id"));
                    customer.setName(resultSet.getString("name"));
                    customer.setEmail(resultSet.getString("email"));
                    customer.setAddress(resultSet.getString("address"));
                    customer.setPhoneNumber(resultSet.getString("phoneNumber"));
                    byte[] imageBytes = resultSet.getBytes("image");
                    if (imageBytes != null) {
                        customer.setImageBase64(Base64.getEncoder().encodeToString(imageBytes));
                    }
                    return customer;
                }
            }
        }
        return null;
    }
}