package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;

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

@WebServlet("/home")
public class HomepageServlet extends HttpServlet {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CategoryDTO> categories = fetchCategories();
        List<ProductDTO> products = fetchProducts();

        request.setAttribute("categories", categories);
        request.setAttribute("products", products);

        request.getRequestDispatcher("/homepage.jsp").forward(request, response);
    }

    private List<CategoryDTO> fetchCategories() {
        List<CategoryDTO> categories = new ArrayList<>();
        String query = "SELECT * FROM category WHERE status = 'Active'";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setId(String.valueOf(rs.getInt("id")));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getString("status"));
                categories.add(category);
            }
        } catch (Exception e) {
            System.err.println("Error fetching categories: " + e.getMessage());
        }

        return categories;
    }

    private List<ProductDTO> fetchProducts() {
        List<ProductDTO> products = new ArrayList<>();
        String query = "SELECT * FROM product p JOIN category c ON p.categoryId = c.id WHERE c.status = 'Active' LIMIT 10";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setItemCode(rs.getInt("itemCode"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getDouble("unitPrice"));
                product.setDescription(rs.getString("description"));
                product.setQtyOnHand(rs.getInt("qtyOnHand"));

                byte[] imageBytes = rs.getBytes("image");
                if (imageBytes != null) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setImage(base64Image);
                }

                product.setCategoryId(rs.getInt("categoryId"));
                products.add(product);
            }
        } catch (Exception e) {
            System.err.println("Error fetching products: " + e.getMessage());
        }

        return products;
    }
}