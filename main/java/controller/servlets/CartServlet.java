package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
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
import model.CartModel;
import model.CartProductModel;
import model.ProductModel;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet(urlPatterns = PathUtils.CART_SERVLET_URL, asyncSupported = true)
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        this.databaseController = new DatabaseController();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /// Retrieve the username from the request attributes
    	String username = (String) request.getSession().getAttribute("username");


        System.out.println("Cart Servlet hit.");

        int cartId = databaseController.getCartIdByUsername(username);        
        System.out.println("*****************\n*****************");
        System.out.println(username + " : " +  cartId);
        System.out.println("*****************\n*****************");

        // Get cart contents based on cartId
        ArrayList<CartModel> cartContents = getCartContents(cartId);
        ArrayList<CartProductModel> cartProductContents = getCartProductModel(cartId);

        System.out.println(cartContents);
        System.out.println("Cart Servlet before retrieving data");

        // Transfer content from CartProduct to Cart table
        transferContentToCart(cartId);

        // Set cart contents as request attributes
        request.setAttribute("cartContents", cartContents);
        request.setAttribute("cartProductContents", cartProductContents);

        System.out.println("Cart Servlet before retrieving data");

        // Forward to cart page
        request.getRequestDispatcher(PathUtils.CART_PAGE_URL).forward(request, response);
    }
	

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String methodParam = request.getParameter("_method");
        int cartId = Integer.parseInt(request.getParameter("cart_id"));

        if (methodParam != null && methodParam.equalsIgnoreCase("PUT")) {
            System.out.println("Servlet hit for Update method");

            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantityChange = Integer.parseInt(request.getParameter("quantity_change"));

            if (quantityChange > 0) {
                // Increase the quantity
                System.out.println("Quantity is increasing.");
                int result = addProductQuantityInCart(cartId, productId);
                if (result == -1) {
                    // Display a message to the user
                    request.setAttribute("errorMessage", "You cannot order product more than stock amount.");
                }
            } else if (quantityChange < 0) {
                // Decrease the quantity
                System.out.println("Quantity is decreasing.");
                int result = removeProductQuantityFromCart(cartId, productId);
                if (result == -1) {
                    // Display a message to the user
                    request.setAttribute("errorMessage", "Product quantity cannot be lower than 1.");
                }
            }

            // Retrieve updated cart contents and forward to the cart page
            ArrayList<CartModel> cartContents = getCartContents(cartId);
            ArrayList<CartProductModel> cartProductContents = getCartProductModel(cartId);
            request.setAttribute("cartContents", cartContents);
            request.setAttribute("cartProductContents", cartProductContents);
            request.getRequestDispatcher(PathUtils.CART_PAGE_URL).forward(request, response);
        } else if (methodParam != null && methodParam.equalsIgnoreCase("DELETE")) {
            // Remove product
            System.out.println("Servlet hit for Delete method");
            int productId = Integer.parseInt(request.getParameter("product_id"));
            removeProductFromCart(cartId, productId);

            // Retrieve updated cart contents and forward to the cart page
            ArrayList<CartModel> cartContents = getCartContents(cartId);
            ArrayList<CartProductModel> cartProductContents = getCartProductModel(cartId);
            request.setAttribute("cartContents", cartContents);
            request.setAttribute("cartProductContents", cartProductContents);
            request.getRequestDispatcher(PathUtils.CART_PAGE_URL).forward(request, response);
        } else {
            // Handle other POST requests
        }
    }
	
    // Method to retrieve cart contents
	private ArrayList<CartModel> getCartContents(int cartId) {
	    ArrayList<CartModel> cartContents = new ArrayList<>();
	    try {
	        Connection conn = databaseController.getConnection();
	        PreparedStatement statement = conn.prepareStatement(StringUtils.GET_CART_CONTENTS_QUERY);
	        statement.setInt(1, cartId);
	        ResultSet resultSet = statement.executeQuery();
            System.out.println("This is before getCartContents");
	        while (resultSet.next()) {
	            int productId = resultSet.getInt("cart_id");
	            int quantity = resultSet.getInt("total_product_quantity");
	            float total = resultSet.getFloat("total_price");
	            CartModel cart = new CartModel(cartId, quantity, total);
	            cartContents.add(cart);
	        }
	        System.out.println("This is after getCartContents");
	        // Close resources
	        resultSet.close();
	        statement.close();
	        conn.close();
	    } catch (SQLException | ClassNotFoundException ex) {
	        ex.printStackTrace(); // Log the exception for debugging
	    }

	    return cartContents;
	}
    
    

	private int addProductQuantityInCart(int cartId, int productId) {
	    try {
	        Connection conn = databaseController.getConnection();

	        // Retrieve the existing cart product
	        PreparedStatement retrieveStatement = conn.prepareStatement(StringUtils.GET_CART_PRODUCT_BY_PRODUCT_ID_AND_CART_ID_QUERY);
	        retrieveStatement.setInt(1, cartId);
	        retrieveStatement.setInt(2, productId);
	        ResultSet resultSet = retrieveStatement.executeQuery();

	        int quantity = 0;
	        float total = 0.0f;

	        if (resultSet.next()) {
	            quantity = resultSet.getInt("product_quantity");
	            total = resultSet.getFloat("product_total");
	        }

	        // Increment the quantity and update the total price
	        float perProduct = total/quantity;
	        int newQuantity = 0;
	        
	        // get product stock from quantity
	        PreparedStatement retrieveProduct = conn.prepareStatement(StringUtils.GET_PRODUCT_BY_ID_QUERY);
	        retrieveProduct.setInt(1, productId);
	        
	        ResultSet product = retrieveProduct.executeQuery();
	        
	        int stockQuantity = 0;
	        if (product.next()) {
	        	stockQuantity = product.getInt("stock_quantity");
	        }
	        
	        System.out.println("Stock Quantity: " + stockQuantity);
	        // check for stock (if the quantity of product is available in stock)
	       
	        if (quantity < stockQuantity) {
	        newQuantity = quantity + 1;
	        }
	        else { // we shouldn't be able to remove quantity below or equal to 1
	        	return -1;
	        }
	        
	        float newTotal = newQuantity * perProduct;

	        
	        // Update the cart product
	        PreparedStatement updateStatement = conn.prepareStatement(StringUtils.UPDATE_CART_PRODUCT_QUERY);
	        if (!Float.isNaN(newTotal)) {
                updateStatement.setInt(1, newQuantity);
                updateStatement.setFloat(2, newTotal);
                updateStatement.setInt(3, cartId);
                updateStatement.setInt(4, productId);
                int result = updateStatement.executeUpdate();
                System.out.println("Cart product updated: New Result: " + result);
            } else {
                // Handle the case where newTotal is NaN
                System.out.println("Error: newTotal is NaN");
            }


	     // Transfer content from CartProduct to Cart table
	        transferContentToCart(cartId);
	        
	        // Close resources
	        resultSet.close();
	        retrieveStatement.close();
	        updateStatement.close();
	        conn.close();
	    } catch (SQLException | ClassNotFoundException ex) {
	        ex.printStackTrace(); // Log the exception for debugging
	    }
	    return 1;
	}
	
	private int removeProductQuantityFromCart(int cartId, int productId) {
	    try {
	        Connection conn = databaseController.getConnection();

	        // Retrieve the existing cart product
	        PreparedStatement retrieveStatement = conn.prepareStatement(StringUtils.GET_CART_PRODUCT_BY_PRODUCT_ID_AND_CART_ID_QUERY);
	        retrieveStatement.setInt(1, cartId);
	        retrieveStatement.setInt(2, productId);
	        ResultSet resultSet = retrieveStatement.executeQuery();

	        int quantity = 0;
	        float total = 0.0f;

	        if (resultSet.next()) {
	            quantity = resultSet.getInt("product_quantity");
	            total = resultSet.getFloat("product_total");
	        }

	        // Increment the quantity and update the total price
	        float perProduct = total/quantity;
	        
	        int newQuantity = 0;
	        if (quantity > 1) {
	            newQuantity = quantity - 1;
	        } else { // We shouldn't be able to remove quantity below or equal to 1
	            System.out.println("Product quantity cannot be lower than 1.");
	            return -1;
	        }
	        
	        float newTotal = newQuantity * perProduct;

	        // Update the cart product
	        PreparedStatement updateStatement = conn.prepareStatement(StringUtils.UPDATE_CART_PRODUCT_QUERY);
	        updateStatement.setInt(1, newQuantity);
	        updateStatement.setFloat(2, newTotal);
	        updateStatement.setInt(3, cartId);
	        updateStatement.setInt(4, productId);
	        int result = updateStatement.executeUpdate();

	        System.out.println("Cart product updated: New Result: " + result);

	     // Transfer content from CartProduct to Cart table
	        transferContentToCart(cartId);
	        
	        // Close resources
	        resultSet.close();
	        retrieveStatement.close();
	        updateStatement.close();
	        conn.close();
	    } catch (SQLException | ClassNotFoundException ex) {
	        ex.printStackTrace(); // Log the exception for debugging
	    }
		return productId;
	}

    private void removeProductFromCart(int cartId, int productId) {
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.REMOVE_FROM_CART_QUERY);

            statement.setInt(1, cartId);
            statement.setInt(2, productId);

            statement.executeUpdate();
            
            transferContentToCart(cartId);
            // Close resources
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
    }
    
    // Method to transfer content from CartProduct to Cart table
    private void transferContentToCart(int cartId) {
        ArrayList<CartProductModel> cartProductContents = getCartProductModel(cartId);

        try {
            Connection conn = databaseController.getConnection();
            
            System.out.println("Size: "+ cartProductContents.size());
            for (CartProductModel cartProduct : cartProductContents) {
                System.out.println("Product ID: " + cartProduct.getProductId());
                System.out.println("Quantity: " + cartProduct.getProductQuantity());
                System.out.println("Total: " + cartProduct.getProductTotal());
                System.out.println("------------------------");
            }
            
            // Calculate total product quantity and total price
            int totalProductQuantity = 0;
            float totalPrice = 0.0f;

            for (CartProductModel cartProduct : cartProductContents) {
                totalProductQuantity += cartProduct.getProductQuantity();
                totalPrice += cartProduct.getProductTotal();
            }
            
            PreparedStatement updateStatement = conn.prepareStatement(StringUtils.INSERT_INTO_CART_QUERY);
            updateStatement.setInt(1, totalProductQuantity);
            updateStatement.setFloat(2, totalPrice);
            updateStatement.setInt(3, cartId);
            int result = updateStatement.executeUpdate();

            // Close resources
            System.out.println("Transfer to cart done: " + result);
            updateStatement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
    }

    private ArrayList<CartProductModel> getCartProductModel(int cartId) {
        ArrayList<CartProductModel> cartProductContents = new ArrayList<>();
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.RETRIEVE_CART_PRODUCT_QUERY);
            statement.setInt(1, cartId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                int quantity = resultSet.getInt("product_quantity");
                float total = resultSet.getFloat("product_total");
                CartProductModel cartProduct = new CartProductModel(cartId, productId, quantity, total);
                cartProductContents.add(cartProduct);
            }
            

            // Close resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }

        return cartProductContents;
    }
    
    
}
