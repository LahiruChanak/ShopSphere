package lk.ijse.shopsphere.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.shopsphere.dto.CategoryDTO;
import lk.ijse.shopsphere.dto.ProductDTO;
import lk.ijse.shopsphere.util.ProductService;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/product-view")
public class ProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        try {
            DataSource dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/ecommerce");
            productService = new ProductService(dataSource);
        } catch (NamingException e) {
            throw new ServletException("DataSource lookup failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int productId = Integer.parseInt(req.getParameter("id"));

        ProductDTO product = productService.getProductById(productId);

        if (product != null) {
            CategoryDTO category = productService.getCategoryById(product.getCategoryId());

            req.setAttribute("product", product);
            req.setAttribute("category", category);
        }

        req.getRequestDispatcher("product.jsp").forward(req, resp);
    }
}