package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private DataSource dataSource;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchQuery = req.getParameter("query");
        String categoryId = req.getParameter("categoryId");
        List<ProductDTO> products = new ArrayList<>();
        List<CategoryDTO> categories = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            // Fetch products based on the search query and category filter
            String productQuery;
            PreparedStatement productStmt;

            if (categoryId != null && !categoryId.isEmpty()) {
                // Fetch products by category
                productQuery = "SELECT * FROM product p JOIN category c ON p.categoryId = c.id WHERE c.status = 'Active' AND c.id = ?";
                productStmt = connection.prepareStatement(productQuery);
                productStmt.setInt(1, Integer.parseInt(categoryId));
            } else if (searchQuery != null && !searchQuery.isEmpty()) {
                // Fetch products by search query
                productQuery = "SELECT * FROM product WHERE name LIKE ? OR description LIKE ?";
                productStmt = connection.prepareStatement(productQuery);
                productStmt.setString(1, "%" + searchQuery + "%");
                productStmt.setString(2, "%" + searchQuery + "%");
            } else {
                // Fetch all products if no query or category is provided
                productQuery = "SELECT * FROM product";
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
                product.setCategoryId(productRs.getInt("categoryId")); // Set category ID
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