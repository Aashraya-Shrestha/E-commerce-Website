package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.database.DatabaseController;
import model.ProductModel;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class UpdateProductServlet
 */
@WebServlet(urlPatterns = PathUtils.UPDATE_PRODUCT_SERVLET_URL, asyncSupported = true)
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProductServlet() {
        this.databaseController = new DatabaseController();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    	String username = (String) request.getSession().getAttribute("username");
    	// Get the product ID from the request parameter
        int productId = Integer.parseInt(request.getParameter("product_id"));


        System.out.println("Product Id: " + productId);
        // Fetch the product details from the database
        ProductModel product = null;
		try {
			product = getProductById(productId);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Set the product details as request attributes
        request.setAttribute("product", product);

        // Forward the request to the "Update Product" JSP
        request.getRequestDispatcher(PathUtils.UPDATE_PRODUCT_PAGE_URL).forward(request, response);
    }

    
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Update product servlet hit");
        
        String username = (String) request.getSession().getAttribute("username");
        
        int productId = Integer.parseInt(request.getParameter("product_id"));
        
        System.out.println("Product Id:...... " + productId);
        String productDescription = request.getParameter("description");
        String priceParam = request.getParameter("price");
        float productPrice = 0.0f;
        if (priceParam != null && !priceParam.trim().isEmpty()) {
            productPrice = Float.parseFloat(priceParam);
        }
        
        System.out.println("Product Description: "+ productDescription);
        System.out.println("Product Stock: "+ request.getParameter("stock_quantity"));
        int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));

        ProductModel updatedProduct = new ProductModel(productId, productDescription, productPrice, stockQuantity);

        // Update the product in the database
        boolean updateSuccess = updateProduct(updatedProduct);

        if (updateSuccess) {
            // Redirect the user to the product details page or the admin dashboard
            response.sendRedirect(request.getContextPath() + PathUtils.UPDATE_PRODUCT_PAGE_URL);
        } else {
            // Handle the case when the update fails
            response.sendRedirect(request.getContextPath() + PathUtils.ADMIN_DASHBOARD_PAGE_URL);
        }
    }
    
    
    public boolean updateProduct(ProductModel product) {
        try (Connection connection = databaseController.getConnection();
             PreparedStatement statement = connection.prepareStatement(StringUtils.UPDATE_PRODUCT_QUERY)) {
            statement.setString(1, product.getDescription());
            statement.setFloat(2, product.getPrice());
            statement.setInt(3, product.getStockQuantity());
            statement.setInt(4, product.getId());
            
            System.out.println(product.getDescription());
            System.out.println(product.getPrice());
            System.out.println(product.getStockQuantity());
            System.out.println(product.getId());

            
            int rowsAffected = statement.executeUpdate();
            
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public ProductModel getProductById(int productId) throws ClassNotFoundException {
        try (Connection connection = databaseController.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                 "SELECT * FROM Product WHERE product_id = ?")) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                float price = resultSet.getFloat("price");
                int stockQuantity = resultSet.getInt("stock_quantity");
                int categoryId = resultSet.getInt("category_id");

                return new ProductModel(productId, name, description, price, stockQuantity, categoryId);
            } else {
                return null;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    
}