package lk.ijse.shopsphere.util;

import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductService {

    private final DataSource dataSource;

    public ProductService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public ProductDTO getProductById(int productId) {

        ProductDTO product = null;
        String query = "SELECT * FROM product WHERE itemCode = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new ProductDTO();
                product.setItemCode(rs.getInt("itemCode"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getDouble("unitPrice"));
                product.setDescription(rs.getString("description"));
                product.setQtyOnHand(rs.getInt("qtyOnHand"));
                product.setImageBase64(rs.getString("image"));
                product.setCategoryId(rs.getInt("categoryId"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public CategoryDTO getCategoryById(int categoryId) {
        CategoryDTO category = null;
        String query = "SELECT * FROM category WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new CategoryDTO();
                category.setId(rs.getString("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getString("status"));
                category.setIcon(rs.getString("icon"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return category;
    }
}