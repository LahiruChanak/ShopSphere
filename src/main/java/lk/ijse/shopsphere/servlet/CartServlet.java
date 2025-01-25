package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.shopsphere.dto.CartDTO;
import lk.ijse.shopsphere.dto.CartDetailDTO;
import lk.ijse.shopsphere.dto.ProductDTO;
import lk.ijse.shopsphere.util.CartService;
import lk.ijse.shopsphere.util.ProductService;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.naming.InitialContext;
import javax.sql.DataSource;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartService cartService;
    private ProductService productService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        String userId = (String) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Fetch the cart for the user
        CartDTO cart = (CartDTO) cartService.getCartDetailsByUserId(userId);
        if (cart == null) {
            // If no cart exists, create a new one
            cart = new CartDTO();
            cart.setCustomerId(userId);
            cart.setCartDetails(new ArrayList<>());
        }

        // Fetch product details for each item in the cart
        List<CartDetailDTO> cartDetails = cart.getCartDetails();
        for (CartDetailDTO detail : cartDetails) {
            ProductDTO product = productService.getProductById(detail.getItemCode());
            detail.setProduct(product);
        }

        // Set cart and cart details as request attributes
        request.setAttribute("cart", cart);
        request.setAttribute("cartDetails", cartDetails);

        // Forward to the cart page
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private CartDTO getCartDetails(int customerId) {
        CartDTO cartDTO = new CartDTO();
        List<CartDetailDTO> cartItems = new ArrayList<>();

        try {
            InitialContext context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/your_database_name");

            try (Connection connection = dataSource.getConnection()) {

                String query = "SELECT cd.itemCode, cd.quantity, p.name, p.unitPrice, p.description, p.image " +
                        "FROM cart_details cd " +
                        "JOIN product p ON cd.itemCode = p.itemCode " +
                        "JOIN cart c ON cd.cartId = c.id " +
                        "WHERE c.customerId = ?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setInt(1, customerId);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        while (resultSet.next()) {
                            CartDetailDTO cartItem = new CartDetailDTO();
                            ProductDTO product = new ProductDTO();

                            product.setItemCode(resultSet.getInt("itemCode"));
                            product.setName(resultSet.getString("name"));
                            product.setUnitPrice(resultSet.getDouble("unitPrice"));
                            product.setDescription(resultSet.getString("description"));
                            product.setImageBase64(resultSet.getString("image")); // Assuming image is stored as Base64

                            cartItem.setItemCode(resultSet.getInt("itemCode"));
                            cartItem.setQuantity(resultSet.getInt("quantity"));
                            cartItem.setProduct(product);

                            cartItems.add(cartItem);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        double subTotal = cartItems.stream()
                .mapToDouble(item -> item.getProduct().getUnitPrice() * item.getQuantity())
                .sum();
        double deliveryCharges = 350.00;
        double total = subTotal + deliveryCharges;

        cartDTO.setCartDetails(cartItems);
        cartDTO.setSubTotal(subTotal);
        cartDTO.setDeliveryCharges(deliveryCharges);
        cartDTO.setTotal(total);

        return cartDTO;
    }
}