package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.ProductModel;
import controller.database.DatabaseController;
import utils.MessageUtils;
import utils.PathUtils;
import utils.StringUtils;
import utils.ValidationUtils;

/**
 * Servlet implementation class AddNewProductServlet
 */
@WebServlet(urlPatterns=PathUtils.ADMIN_ADD_PRODUCT_SERVLET_URL)
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddNewProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewProductServlet() {
        this.databaseController = new DatabaseController();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Add new product servlet hit.");
        
        String username = (String) request.getSession().getAttribute("username");

     // Extracting product details from the request parameters
        String name = request.getParameter(StringUtils.PRODUCT_NAME);
        String description = request.getParameter(StringUtils.PRODUCT_DESCRIPTION);
        String price = request.getParameter(StringUtils.PRODUCT_PRICE);
        Part imagePart = request.getPart("image"); // Use request.getPart("image") instead of request.getParameter("image")
        String stockQuantity = request.getParameter(StringUtils.PRODUCT_STOCK_QUANTITY);
        String categoryId = request.getParameter(StringUtils.PRODUCT_CATEGORY_ID);

//        // Validate product details
//        if (!ValidationUtils.hasNoSpecialCharacters(name) ||
//            !ValidationUtils.isNumeric(price) ||
//            !ValidationUtils.isNumbersOnly(stockQuantity) ||
//            !ValidationUtils.isNumbersOnly(categoryId)) {
//            request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
//            request.getRequestDispatcher("/add_product.jsp").forward(request, response);
//            return;
//        }

        System.out.println(name);System.out.println(description);System.out.println(price);
        System.out.println(stockQuantity);System.out.println(categoryId);
        
        // Create a new product object
        ProductModel newProduct = new ProductModel(name, description, Float.parseFloat(price), imagePart, Integer.parseInt(stockQuantity), Integer.parseInt(categoryId));

        // Save the new product to the database
        boolean success = addProduct(newProduct);
        
        System.out.println("Adding Product: "+ success);
        
        if (success) {
        	String filename = newProduct.getProductImageUrl();
        	if (!filename.isEmpty() && filename != null) {
        		String savepath = PathUtils.IMAGE_DIR_PRODUCT;
        		imagePart.write(savepath + filename);
        	}
        	
        	
            // Redirect to the product list page or display a success message
            response.sendRedirect(request.getContextPath() + PathUtils.ADMIN_PRODUCT_SERVLET_URL);
        } else {
            // Display an error message
            request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.PRODUCT_ADD_FAILED);
            request.getRequestDispatcher("/add_product.jsp").forward(request, response);
        }
    }
    
    public boolean addProduct(ProductModel product) {
        boolean success = false;

        try {
            // Get a connection to the database
            Connection connection = databaseController.getConnection();

            // Prepare the SQL statement to insert the new product
            PreparedStatement statement = connection.prepareStatement(StringUtils.INSERT_INTO_PRODUCTS);

            // Set the values for the SQL statement
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setFloat(3, product.getPrice());
            statement.setString(4, product.getProductImageUrl());
            statement.setInt(5, product.getStockQuantity());
            statement.setInt(6, product.getCategoryId());

            // Execute the SQL statement
            int rowsAffected = statement.executeUpdate();

            // Check if the product was added successfully
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Handle any SQL exceptions
            e.printStackTrace();
        } 

        return success;
    }
}