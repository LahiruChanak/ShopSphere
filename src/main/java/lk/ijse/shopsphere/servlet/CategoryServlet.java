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

@WebServlet({"/saveCategory", "/categories"}) // Map both URLs to this servlet
@MultipartConfig(maxFileSize = 16177215)
public class CategoryServlet extends HttpServlet {

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
        // ... (Existing doPost code remains unchanged)
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        Part imagePart = request.getPart("icon");

        if (name == null || name.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category name is required");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "INSERT INTO category (name, description, status, icon) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setString(3, status);

                InputStream imageInputStream = null;

                if (imagePart != null) {
                    imageInputStream = imagePart.getInputStream();
                }

                if (imageInputStream != null) {
                    ps.setBlob(4, imageInputStream);
                }else {
                    ps.setNull(4, Types.BLOB);
                }

                ps.executeUpdate();
            }

            response.sendRedirect("categories"); // Redirect to the categories list
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while saving category", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CategoryDTO> categoryList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, name, description, status, icon FROM category";
            try (PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    byte[] iconData = rs.getBytes("icon");
                    String iconBase64 = (iconData != null) ? Base64.getEncoder().encodeToString(iconData) : null;

                    categoryList.add(new CategoryDTO(String.valueOf(id), name, description, status, iconBase64));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while fetching categories", e);
        }

        request.setAttribute("categories", categoryList);
        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }
}