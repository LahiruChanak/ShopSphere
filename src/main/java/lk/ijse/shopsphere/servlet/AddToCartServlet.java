package lk.ijse.shopsphere.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.shopsphere.dto.CartDetailDTO;
import lk.ijse.shopsphere.util.CartService;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        try {
            DataSource dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/ecommerce");
            cartService = new CartService(dataSource);
        } catch (NamingException e) {
            throw new ServletException("DataSource lookup failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Log the request body
        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            jsonBuffer.append(line);
        }
        String json = jsonBuffer.toString();
        System.out.println("Request JSON: " + json);

        // Get the user ID from the session
        String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            System.out.println("User not logged in. Redirecting to login page.");
            response.sendRedirect("login.jsp");
            return;
        }

        // Parse the request body
        CartDetailDTO cartDetail = parseJsonToCartDetail(json);
        System.out.println("Parsed CartDetail: " + cartDetail);

        // Add the product to the cart
        boolean success = cartService.addToCart(userId, cartDetail);
        System.out.println("Add to Cart success: " + success);

        // Send response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + "}");
        out.flush();
    }

    private CartDetailDTO parseJsonToCartDetail(String json) {
        // Use Gson to parse the JSON into a CartDetailDTO object
        Gson gson = new Gson();
        return gson.fromJson(json, CartDetailDTO.class);
    }

}