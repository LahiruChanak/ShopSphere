package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;
import lk.ijse.shopsphere.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchQuery = req.getParameter("query"); // Get the search query from the request
        List<ProductDTO> products = new ArrayList<>();
        List<CategoryDTO> categories = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection()) {
            // Fetch products based on the search query (or all products if no query)
            String productQuery;
            PreparedStatement productStmt;

            if (searchQuery != null && !searchQuery.isEmpty()) {
                productQuery = "SELECT * FROM product WHERE name LIKE ? OR description LIKE ?";
                productStmt = connection.prepareStatement(productQuery);
                productStmt.setString(1, "%" + searchQuery + "%");
                productStmt.setString(2, "%" + searchQuery + "%");
            } else {
                productQuery = "SELECT * FROM product"; // Load all products if no query
                productStmt = connection.prepareStatement(productQuery);
            }

            ResultSet productRs = productStmt.executeQuery();

            while (productRs.next()) {
                ProductDTO product = new ProductDTO(
                        productRs.getInt("itemCode"),
                        productRs.getString("name"),
                        productRs.getDouble("unitPrice"),
                        productRs.getString("description"),
                        productRs.getInt("qtyOnHand"),
                        Base64.getEncoder().encodeToString(productRs.getBytes("image")) // Convert image to Base64
                );
                products.add(product);
            }

            // Fetch all categories
            String categoryQuery = "SELECT * FROM category";
            PreparedStatement categoryStmt = connection.prepareStatement(categoryQuery);
            ResultSet categoryRs = categoryStmt.executeQuery();

            while (categoryRs.next()) {
                CategoryDTO category = new CategoryDTO(
                        categoryRs.getInt("id"),
                        categoryRs.getString("name"),
                        categoryRs.getString("description"),
                        categoryRs.getString("status"),
                        Base64.getEncoder().encodeToString(categoryRs.getBytes("icon")) // Convert icon to Base64
                );
                categories.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes for JSP
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);

        // Forward to search.jsp
        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }
}