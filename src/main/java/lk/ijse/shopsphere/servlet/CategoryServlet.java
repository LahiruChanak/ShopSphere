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
import java.sql.Types;

@WebServlet("/saveCategory")
@MultipartConfig(maxFileSize = 16177215) // 16MB limit for file uploads
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

                // Safely handle InputStream for the icon
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

            response.sendRedirect("category.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error while saving category", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
