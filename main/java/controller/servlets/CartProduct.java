package controller.servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.database.DatabaseController;
import model.CartProductModel;
import model.ProductModel;
import utils.MessageUtils;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class CartProduct
 */
@WebServlet(urlPatterns = PathUtils.CART_PRODUCT_SERVLET_URL, asyncSupported = true)
public class CartProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;

    private ProductServlet productServlet = new ProductServlet();

    private ArrayList<ProductModel> getAllProductsInfo() {
        return productServlet.getAllProductsInfo();
    }
    
    public CartProduct() {
        this.databaseController = new DatabaseController();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve product ID from the request
        String productIdParam = request.getParameter("product_id");
        if (productIdParam == null || productIdParam.isEmpty()) {
            // Handle the case where the product ID is not present in the request
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.ADD_TO_CART_FAILED);
            request.getRequestDispatcher(PathUtils.PRODUCT_PAGE_URL).forward(request, response);
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            // Handle the case where the product ID is not a valid integer
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.ADD_TO_CART_FAILED);
            request.getRequestDispatcher(PathUtils.PRODUCT_PAGE_URL).forward(request, response);
            return;
        }

        System.out.println("Product Id: " + productId);

        // Retrieve the product details from the database
        ProductModel product = getProductDetails(productId);
        if (product == null) {
            // Handle the case where the product is not found
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.ADD_TO_CART_FAILED);
            request.getRequestDispatcher(PathUtils.PRODUCT_PAGE_URL).forward(request, response);
            return;
        }

      /// Retrieve the username from the request attributes
    	String username = (String) request.getSession().getAttribute("username");


        System.out.println("Cart Servlet hit.");


        System.out.println("Cart Servlet hit.");

        int cartId = databaseController.getCartIdByUsername(username);        
        System.out.println("*****************\n***************** Cart Product");
        System.out.println(username + " : " +  cartId);
        System.out.println("*****************\n*****************");
        

        // Create a CartProductModel instance with the retrieved information
        CartProductModel cartProduct = new CartProductModel(cartId, productId, 1, product.getPrice());

        // Attempt to add the product to the cart
        int result = addToCart(cartProduct);

        // Handle the result of adding the product to the cart
        if (result == 1) {
            // Product was successfully added to the cart
            System.out.println("Product successfully added.");
            request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.ADD_TO_CART_SUCCESS);
        } else if (result == 2) {
            // Product was already in the cart, display a message
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.PRODUCT_ALREADY_IN_CART);
        } else {
            // Failed to add the product to the cart
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.ADD_TO_CART_FAILED);
        }

        // Retrieve the updated list of products
        ArrayList<ProductModel> products = getAllProductsInfo();
        request.setAttribute(StringUtils.PRODUCT_LIST, products);

        // Forward the request back to the product page
        request.getRequestDispatcher(PathUtils.PRODUCT_PAGE_URL).forward(request, response);
    }

    private int addToCart(CartProductModel cartProduct) {
        try {
            // Check if the product is already in the cart
            CartProductModel existingCartProduct = getCartProductByProductId(cartProduct.getProductId(), cartProduct.getCartId());
            if (existingCartProduct != null) {
                // Product is already in the cart, do not add it again
                return 2; // Product was already in the cart
            } else {
                // Add the new product to the cart
                insertCartProduct(cartProduct);
                return 1; // Product was successfully added to the cart
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            return 0; // Failed to add the product to the cart
        }
    }

    private CartProductModel getCartProductByProductId(int productId, int cartId) throws SQLException, ClassNotFoundException {
        try {
            PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.GET_CART_PRODUCT_BY_PRODUCT_ID_AND_CART_ID_QUERY);
            statement.setInt(1, productId);
            statement.setInt(2, cartId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int retrievedCartId = resultSet.getInt("cart_id");
                int retrievedProductId = resultSet.getInt("product_id");
                int quantity = resultSet.getInt("product_quantity");
                float total = resultSet.getFloat("product_total");

                return new CartProductModel(retrievedCartId, retrievedProductId, quantity, total);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            throw ex;
        }
        return null;
    }
    
    private void insertCartProduct(CartProductModel cartProduct) throws SQLException, ClassNotFoundException {
        // Insert the new cart product in the database
        PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.ADD_TO_CART_QUERY);
        statement.setInt(1, cartProduct.getCartId());
        statement.setInt(2, cartProduct.getProductId());
        statement.setInt(3, cartProduct.getProductQuantity());
        statement.setFloat(4, cartProduct.getProductTotal());
        statement.executeUpdate();
    }
    
    
    private ProductModel getProductDetails(int productId) {
        try {
            PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.GET_PRODUCT_BY_ID_QUERY);
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString(StringUtils.PRODUCT_NAME);
                String description = resultSet.getString(StringUtils.PRODUCT_DESCRIPTION);
                float price = resultSet.getFloat(StringUtils.PRODUCT_PRICE);
                
                
                String imageUrl = resultSet.getString(StringUtils.PRODUCT_IMAGE_URL);
                
                
                int stockQuantity = resultSet.getInt(StringUtils.PRODUCT_STOCK_QUANTITY);
                int categoryId = resultSet.getInt(StringUtils.PRODUCT_CATEGORY_ID);
                
                return new ProductModel(productId, name, description, price, imageUrl, stockQuantity, categoryId);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
}