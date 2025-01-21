package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Ijse@123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        boolean hasError = false;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            switch (action) {
                case "signIn":
                    if (email == null || email.isEmpty()) {
                        request.setAttribute("signInEmailError", "Email is required.");
                        hasError = true;
                    }

                    if (password == null || password.isEmpty()) {
                        request.setAttribute("signInPasswordError", "Password is required.");
                        hasError = true;
                    }

                    if (!hasError) {
                        String query = "SELECT password FROM customer WHERE email = ?";
                        try (PreparedStatement stmt = connection.prepareStatement(query)) {
                            stmt.setString(1, email);

                            try (ResultSet rs = stmt.executeQuery()) {
                                if (rs.next()) {
                                    String hashedPassword = rs.getString("password");
                                    if (BCrypt.checkpw(password, hashedPassword)) {
                                        response.sendRedirect("pages/homepage.jsp");
                                    } else {
                                        request.setAttribute("signInPasswordError", "Email or Password is incorrect.");
                                        request.getRequestDispatcher("index.jsp").forward(request, response);
                                    }
                                } else {
                                    request.setAttribute("signInPasswordError", "Email or Password is incorrect.");
                                    request.getRequestDispatcher("index.jsp").forward(request, response);
                                }
                            }
                        }
                    } else {
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                    break;

                case "signUp":
                    if (name == null || name.isEmpty()) {
                        request.setAttribute("signUpNameError", "Name is required.");
                        hasError = true;
                    }

                    if (email == null || email.isEmpty()) {
                        request.setAttribute("signUpEmailError", "Email is required.");
                        hasError = true;
                    }

                    if (password == null || password.isEmpty()) {
                        request.setAttribute("signUpPasswordError", "Password is required.");
                        hasError = true;
                    }

                    if (!hasError) {
                        String checkQuery = "SELECT * FROM customer WHERE email = ?";
                        try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
                            checkStmt.setString(1, email);
                            try (ResultSet rs = checkStmt.executeQuery()) {
                                if (rs.next()) {
                                    request.setAttribute("signUpEmailError", "Email already in use.");
                                    hasError = true;
                                }
                            }
                        }

                        if (!hasError) {
                            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                            String insertQuery = "INSERT INTO customer (name, email, password) VALUES (?, ?, ?)";
                            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                                insertStmt.setString(1, name);
                                insertStmt.setString(2, email);
                                insertStmt.setString(3, hashedPassword);
                                insertStmt.executeUpdate();
                                response.sendRedirect("welcome.jsp");
                            }
                        } else {
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                    } else {
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                    break;

                case "resetPassword":
                    if (email == null || email.isEmpty()) {
                        request.setAttribute("resetPasswordEmailError", "Email is required.");
                        hasError = true;
                    }

                    if (password == null || password.isEmpty()) {
                        request.setAttribute("resetPasswordError", "New password is required.");
                        hasError = true;
                    }

                    if (!hasError) {
                        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                        String updateQuery = "UPDATE customer SET password = ? WHERE email = ?";
                        try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, hashedPassword);
                            updateStmt.setString(2, email);

                            int rowsUpdated = updateStmt.executeUpdate();
                            if (rowsUpdated > 0) {
                                response.sendRedirect("password-reset-success.jsp");
                            } else {
                                request.setAttribute("resetPasswordEmailError", "Email not found.");
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                            }
                        }
                    } else {
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                    break;

                default:
                    response.sendRedirect("index.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
        }
    }
}
