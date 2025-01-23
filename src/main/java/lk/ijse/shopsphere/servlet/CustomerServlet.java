package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.shopsphere.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static lk.ijse.shopsphere.util.DBConnection.getConnection;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try (Connection conn = DBConnection.getConnection()) {
            if ("viewProfile".equals(action)) {
                String customerEmail = (String) session.getAttribute("email");

                // Retrieve customer details
                String query = "SELECT * FROM customer WHERE email = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, customerEmail);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        request.setAttribute("fullName", rs.getString("name"));
                        request.setAttribute("email", rs.getString("email"));
                        request.setAttribute("phoneNumber", rs.getString("phoneNumber"));
                        request.setAttribute("address", rs.getString("address"));
                        request.setAttribute("image", rs.getBytes("image"));
                    }
                }

                request.getRequestDispatcher("profile.jsp").forward(request, response);

            } else {
                response.sendRedirect("home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try (Connection conn = getConnection()) {
            if ("updateProfile".equals(action)) {
                // Update profile details
                String customerEmail = (String) session.getAttribute("email");
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                String address = request.getParameter("address");

                String query = "UPDATE customer SET name = ?, email = ?, phoneNumber = ?, address = ? WHERE email = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, fullName);
                    stmt.setString(2, email);
                    stmt.setString(3, phoneNumber);
                    stmt.setString(4, address);
                    stmt.setString(5, customerEmail);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        session.setAttribute("fullName", fullName); // Update session attribute
                        request.setAttribute("successMessage", "Profile updated successfully!");
                    } else {
                        request.setAttribute("errorMessage", "Failed to update profile.");
                    }
                }

                // Fetch updated data to display
                String selectQuery = "SELECT * FROM customer WHERE email = ?";
                try (PreparedStatement selectStmt = conn.prepareStatement(selectQuery)) {
                    selectStmt.setString(1, email);
                    ResultSet rs = selectStmt.executeQuery();

                    if (rs.next()) {
                        request.setAttribute("fullName", rs.getString("name"));
                        request.setAttribute("email", rs.getString("email"));
                        request.setAttribute("phoneNumber", rs.getString("phoneNumber"));
                        request.setAttribute("address", rs.getString("address"));
                        request.setAttribute("image", rs.getBytes("image"));
                    }
                }

                request.getRequestDispatcher("profile.jsp").forward(request, response);

            } else if ("changePassword".equals(action)) {
                // Change password
                String customerEmail = (String) session.getAttribute("email");
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmNewPassword = request.getParameter("confirmNewPassword");

                String query = "SELECT password FROM customer WHERE email = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, customerEmail);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String dbPassword = rs.getString("password");
                        if (dbPassword.equals(currentPassword)) {
                            if (newPassword.equals(confirmNewPassword)) {
                                String updateQuery = "UPDATE customer SET password = ? WHERE email = ?";
                                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                                    updateStmt.setString(1, newPassword);
                                    updateStmt.setString(2, customerEmail);

                                    int rowsUpdated = updateStmt.executeUpdate();
                                    if (rowsUpdated > 0) {
                                        request.setAttribute("successMessage", "Password updated successfully!");
                                    } else {
                                        request.setAttribute("errorMessage", "Failed to update password.");
                                    }
                                }
                            } else {
                                request.setAttribute("errorMessage", "New passwords do not match.");
                            }
                        } else {
                            request.setAttribute("errorMessage", "Current password is incorrect.");
                        }
                    }
                }

                // Fetch updated data to display
                String selectQuery = "SELECT * FROM customer WHERE email = ?";
                try (PreparedStatement selectStmt = conn.prepareStatement(selectQuery)) {
                    selectStmt.setString(1, customerEmail);
                    ResultSet rs = selectStmt.executeQuery();

                    if (rs.next()) {
                        request.setAttribute("fullName", rs.getString("name"));
                        request.setAttribute("email", rs.getString("email"));
                        request.setAttribute("phoneNumber", rs.getString("phoneNumber"));
                        request.setAttribute("address", rs.getString("address"));
                        request.setAttribute("image", rs.getBytes("image"));
                    }
                }

                request.getRequestDispatcher("profile.jsp").forward(request, response);

            } else {
                response.sendRedirect("home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
