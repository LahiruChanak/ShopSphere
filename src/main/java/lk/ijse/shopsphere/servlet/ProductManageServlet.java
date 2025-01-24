package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;

@WebServlet({"/ProductManage", "/products"})
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class ProductManageServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }

        switch (action) {
            case "save":
                saveProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String description = request.getParameter("description");
        int qtyOnHand = Integer.parseInt(request.getParameter("qtyOnHand"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Part imagePart = request.getPart("image");

        if (name == null || name.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product name is required");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "INSERT INTO product (name, unitPrice, description, qtyOnHand, image, categoryId) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setDouble(2, unitPrice);
                ps.setString(3, description);
                ps.setInt(4, qtyOnHand);

                InputStream imageInputStream = null;

                if (imagePart != null) {
                    imageInputStream = imagePart.getInputStream();
                }

                if (imageInputStream != null) {
                    ps.setBlob(5, imageInputStream);
                } else {
                    ps.setNull(5, Types.BLOB);
                }

                ps.setInt(6, categoryId);
                ps.executeUpdate();
            }

            response.sendRedirect("products");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while saving product", e);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemCode = Integer.parseInt(request.getParameter("itemCode"));
        String name = request.getParameter("name");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String description = request.getParameter("description");
        int qtyOnHand = Integer.parseInt(request.getParameter("qtyOnHand"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Part imagePart = request.getPart("image");

        if (itemCode <= 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql;
            PreparedStatement ps;

            if (imagePart != null && imagePart.getSize() > 0) {
                sql = "UPDATE product SET name = ?, unitPrice = ?, description = ?, qtyOnHand = ?, image = ?, categoryId = ? WHERE itemCode = ?";
                ps = connection.prepareStatement(sql);
                ps.setString(1, name);
                ps.setDouble(2, unitPrice);
                ps.setString(3, description);
                ps.setInt(4, qtyOnHand);
                ps.setBlob(5, imagePart.getInputStream());
                ps.setInt(6, categoryId);
                ps.setInt(7, itemCode);
            } else {
                sql = "UPDATE product SET name = ?, unitPrice = ?, description = ?, qtyOnHand = ?, categoryId = ? WHERE itemCode = ?";
                ps = connection.prepareStatement(sql);
                ps.setString(1, name);
                ps.setDouble(2, unitPrice);
                ps.setString(3, description);
                ps.setInt(4, qtyOnHand);
                ps.setInt(5, categoryId);
                ps.setInt(6, itemCode);
            }

            ps.executeUpdate();
            response.sendRedirect("products");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while updating product", e);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemCode = Integer.parseInt(request.getParameter("itemCode"));

        if (itemCode <= 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "DELETE FROM product WHERE itemCode = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, itemCode);
                ps.executeUpdate();
            }

            response.sendRedirect("products");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while deleting product", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ProductDTO> productList = new ArrayList<>();
        List<CategoryDTO> categoryList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String productSql = "SELECT itemCode, name, unitPrice, description, qtyOnHand, image, categoryId FROM product";
            try (PreparedStatement ps = connection.prepareStatement(productSql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int itemCode = rs.getInt("itemCode");
                    String name = rs.getString("name");
                    double unitPrice = rs.getDouble("unitPrice");
                    String description = rs.getString("description");
                    int qtyOnHand = rs.getInt("qtyOnHand");
                    byte[] imageData = rs.getBytes("image");
                    String imageBase64 = (imageData != null) ? Base64.getEncoder().encodeToString(imageData) : null;
                    int categoryId = rs.getInt("categoryId");

                    productList.add(new ProductDTO(itemCode, name, unitPrice, description, qtyOnHand, imageBase64, categoryId));
                }
            }

            String categorySql = "SELECT id, name FROM category";
            try (PreparedStatement ps = connection.prepareStatement(categorySql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");

                    categoryList.add(new CategoryDTO(String.valueOf(id), name, null, null, null));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while fetching data", e);
        }

        request.setAttribute("products", productList);
        request.setAttribute("categories", categoryList);
        request.getRequestDispatcher("/product-manage.jsp").forward(request, response);
    }
}