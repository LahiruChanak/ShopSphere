package lk.ijse.shopsphere.util;

import lk.ijse.shopsphere.dto.CartDTO;
import lk.ijse.shopsphere.dto.CartDetailDTO;
import lk.ijse.shopsphere.dto.ProductDTO;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartService {
    private final DataSource dataSource;

    public CartService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * Add a product to the cart.
     */
    public boolean addToCart(String userId, CartDetailDTO cartDetail) {
        // Check if the user has a cart
        int cartId = getCartIdByUserId(userId);
        if (cartId == -1) {
            // Create a new cart for the user
            cartId = createCart(userId);
            if (cartId == -1) {
                return false; // Failed to create cart
            }
        }

        // Add the product to the cart
        String query = "INSERT INTO cart_details (cartId, itemCode, quantity, productSize, color) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, cartId);
            ps.setInt(2, cartDetail.getItemCode());
            ps.setInt(3, cartDetail.getQuantity());
            ps.setString(4, cartDetail.getOrderedSize());
            ps.setString(5, cartDetail.getColor());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            System.err.println("Error adding product to cart: " + e.getMessage());
            return false;
        }
    }

    /**
     * Get the cart ID for the given user.
     */
    private int getCartIdByUserId(String userId) {
        String query = "SELECT id FROM cart WHERE customerId = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cartId");
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching cart ID: " + e.getMessage());
        }

        return -1; // Cart not found
    }

    /**
     * Create a new cart for the user.
     */
    private int createCart(String userId) {
        String query = "INSERT INTO cart (customerId) VALUES (?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, userId);
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the generated cartId
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error creating cart: " + e.getMessage());
        }

        return -1; // Failed to create cart
    }

    /**
     * Fetch cart details for the given user.
     */
    public List<CartDetailDTO> getCartDetailsByUserId(String userId) {
        List<CartDetailDTO> cartDetails = new ArrayList<>();
        String query = "SELECT cd.*, p.name, p.unitPrice, p.image " +
                "FROM cart_details cd " +
                "JOIN product p ON cd.itemCode = p.itemCode " +
                "WHERE cd.cartId = (SELECT cartId FROM cart WHERE customerId = ?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartDetailDTO detail = new CartDetailDTO();
                    detail.setCartDetailId(rs.getInt("cartDetailId"));
                    detail.setCartId(rs.getInt("cartId"));
                    detail.setItemCode(rs.getInt("itemCode"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setOrderedSize(rs.getString("orderedSize"));
                    detail.setColor(rs.getString("color"));

                    // Set product details
                    ProductDTO product = new ProductDTO();
                    product.setItemCode(rs.getInt("itemCode"));
                    product.setName(rs.getString("name"));
                    product.setUnitPrice(rs.getDouble("unitPrice"));
                    product.setImage(rs.getString("image"));
                    detail.setProduct(product);

                    cartDetails.add(detail);
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching cart details: " + e.getMessage());
        }

        return cartDetails;
    }

}