package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    private DataSource dataSource;

    private static final String ADMIN_EMAIL = "admin@shopsphere.com";
    private static final String ADMIN_PASSWORD = BCrypt.hashpw("Admin@123", BCrypt.gensalt(12));

    @Override
    public void init() throws ServletException {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/ecommerce");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize DataSource", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        boolean hasError = false;

        try (Connection connection = dataSource.getConnection()) {
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
                        if (ADMIN_EMAIL.equals(email)) {
                            if (BCrypt.checkpw(password, ADMIN_PASSWORD)) {
                                HttpSession session = request.getSession();
                                session.setAttribute("isAdmin", true);
                                session.setAttribute("email", ADMIN_EMAIL);
                                response.sendRedirect("admin-dashboard.jsp");
                                return;
                            } else {
                                request.setAttribute("signInPasswordError", "Email or Password is incorrect.");
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                                return;
                            }
                        }

                        // Customer login
                        String query = "SELECT id, name, email, password FROM customer WHERE email = ?";
                        try (PreparedStatement stmt = connection.prepareStatement(query)) {
                            stmt.setString(1, email);

                            try (ResultSet rs = stmt.executeQuery()) {
                                if (rs.next()) {
                                    String hashedPassword = rs.getString("password");
                                    if (BCrypt.checkpw(password, hashedPassword)) {
                                        HttpSession session = request.getSession();
                                        session.setAttribute("customerId", rs.getInt("id"));
                                        session.setAttribute("fullName", rs.getString("name"));
                                        session.setAttribute("email", rs.getString("email"));

                                        request.getSession().setAttribute("email", rs.getString("email"));
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

                    if (ADMIN_EMAIL.equals(email)) {
                        request.setAttribute("signUpEmailError", "This email is reserved for admin.");
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
                            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
                            String insertQuery = "INSERT INTO customer (name, email, password) VALUES (?, ?, ?)";
                            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                                insertStmt.setString(1, name);
                                insertStmt.setString(2, email);
                                insertStmt.setString(3, hashedPassword);
                                insertStmt.executeUpdate();
                                response.sendRedirect("index.jsp");
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
                        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
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