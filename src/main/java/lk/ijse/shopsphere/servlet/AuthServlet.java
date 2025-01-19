package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    // Simulating a user database for authentication
    private static final String VALID_EMAIL = "abc@gmail.com";
    private static final String VALID_PASSWORD = "123";

    // Simulating user registration details
    private static final String REGISTERED_EMAIL = "newuser@example.com";
    private static final String REGISTERED_PASSWORD = "newpassword123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        boolean hasError = false;

        switch (action) {
            case "signIn":
                if (email == null || email.isEmpty()) {
                    request.setAttribute("signInEmailError", "Email is required.");
                    hasError = true;
                } else if (!email.equals(VALID_EMAIL)) {
                    request.setAttribute("signInEmailError", "Email not found. Please sign up.");
                    hasError = true;
                }

                if (password == null || password.isEmpty()) {
                    request.setAttribute("signInPasswordError", "Password is required.");
                    hasError = true;
                } else if (!password.equals(VALID_PASSWORD)) {
                    request.setAttribute("signInPasswordError", "Email or Password is incorrect. Please try again.");
                    hasError = true;
                }

                if (hasError) {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    // User authenticated successfully
                    response.sendRedirect("pages/homepage.jsp");
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
                } else if (email.equals(VALID_EMAIL) || email.equals(REGISTERED_EMAIL)) {
                    request.setAttribute("signUpEmailError", "Email already in use.");
                    hasError = true;
                }

                if (password == null || password.isEmpty()) {
                    request.setAttribute("signUpPasswordError", "Password is required.");
                    hasError = true;
                } else if (password.equals(VALID_PASSWORD) || password.equals(REGISTERED_PASSWORD)) {
                    request.setAttribute("signUpPasswordError", "Password already in use.");
                    hasError = true;
                }

                if (hasError) {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    // Simulate user registration success
                    response.sendRedirect("welcome.jsp");
                }
                break;

            case "resetPassword":
                if (email == null || email.isEmpty()) {
                    request.setAttribute("resetPasswordEmailError", "Email is required.");
                    hasError = true;
                } else if (!email.equals(VALID_EMAIL) && !email.equals(REGISTERED_EMAIL)) {
                    request.setAttribute("resetPasswordEmailError", "Email not found.");
                    hasError = true;
                }

                if (hasError) {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    // Simulate password reset success
                    response.sendRedirect("password-reset-success.jsp");
                }
                break;

            default:
                response.sendRedirect("index.jsp");
        }
    }
}