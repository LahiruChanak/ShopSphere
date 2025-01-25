package lk.ijse.shopsphere.util;

import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;

public class ProductService {

    private final DataSource dataSource;

    public ProductService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public ProductDTO getProductById(int productId) {
        ProductDTO product = null;
        String query = "SELECT * FROM product WHERE itemCode = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new ProductDTO();
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
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching product by ID: " + e.getMessage());
        }

        return product;
    }

    public CategoryDTO getCategoryById(int categoryId) {
        CategoryDTO category = null;
        String query = "SELECT * FROM category WHERE id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    category = new CategoryDTO();
                    category.setId(String.valueOf(rs.getInt("id")));
                    category.setName(rs.getString("name"));
                    category.setDescription(rs.getString("description"));
                    category.setStatus(rs.getString("status"));
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching category by ID: " + e.getMessage());
        }

        return category;
    }
}