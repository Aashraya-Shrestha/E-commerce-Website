package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.database.DatabaseController;
import model.CartModel;
import model.CartProductModel;
import model.OrderModel;
import model.OrderResult;
import model.OrderedProductModel;
import utils.MessageUtils;
import utils.PathUtils;
import utils.StringUtils;

@WebServlet(urlPatterns = PathUtils.ORDER_SERVLET_URL, asyncSupported = true)
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;

    public OrderServlet() {
        this.databaseController = new DatabaseController();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve cart id from session or request parameter
//        int cartId = Integer.parseInt(request.getParameter("cart_id"));
    	
    	String username = (String) request.getSession().getAttribute("username");

    	int cartId = databaseController.getCartIdByUsername(username);        
        System.out.println("*****************\n***************** Cart Product");
        System.out.println(username + " : " +  cartId);
        System.out.println("*****************\n*****************");
    	
        
        // Get cart contents
        CartModel cartContents = getCartContents(cartId);
        ArrayList<CartProductModel> cartProductContents = getCartProductModel(cartId);
        
        OrderResult orderPlaced = prepareOrder(cartContents, cartId);
        
        int orderId = orderPlaced.getOrderId();
        int isOrderPlaced = orderPlaced.getResult();
        
        int orderProductFilled = saveOrderProducts(cartProductContents, orderId);      
        
     // Clear the cart and cart product
        if (isOrderPlaced == 1 || orderProductFilled == 1) {
        	clearCart(cartId);
            clearCartProduct(cartId);
            
            // Retrieve updated cart contents and forward to the cart page
            OrderModel orderContents = getOrderContents(orderId);
            ArrayList<OrderedProductModel> orderProductContents = getOrderedProductContents(orderId);
            request.setAttribute("OrderId", orderId);
            request.setAttribute("OrderContents", orderContents);
        	request.setAttribute("OrderProductContents", orderProductContents);
        	request.getRequestDispatcher(PathUtils.ORDER_CONFIRMATION_PAGE_URL).forward(request, response);
        }
        else {
        	 // Handle the case where the cart is empty
            request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.EMPTY_CART);
            request.getRequestDispatcher(PathUtils.CART_PAGE_URL).forward(request, response);
        }
        
        
    }
    
    private OrderModel getOrderContents(int orderId) {
        OrderModel orderContents = null;
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_ORDER_CONTENTS_QUERY);
            statement.setInt(1, orderId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int addressId = resultSet.getInt("address_id");
                int cartId = resultSet.getInt("cart_id");
                Date orderDate = resultSet.getDate("order_date");
                float totalPrice = resultSet.getFloat("total_price");
                int totalQuantity = resultSet.getInt("total_quantity");
                String status = resultSet.getString("status");
                orderContents = new OrderModel(addressId, cartId, orderDate, totalPrice, totalQuantity, status);
            }

            // Close resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }

        return orderContents;
    }
    
    private ArrayList<OrderedProductModel> getOrderedProductContents(int orderId) {
        ArrayList<OrderedProductModel> orderedProductContents = new ArrayList<>();
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_ORDERED_PRODUCT_CONTENTS_QUERY);
            statement.setInt(1, orderId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                int totalQuantity = resultSet.getInt("quantity");
                float totalPrice = resultSet.getFloat("total_price");
                OrderedProductModel orderProduct = new OrderedProductModel(orderId, productId, totalQuantity, totalPrice);
                orderedProductContents.add(orderProduct);
            }

            // Close resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }

        return orderedProductContents;
    }

 // Method to retrieve cart contents
    private CartModel getCartContents(int cartId) {
        CartModel cart = null;
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_CART_CONTENTS_QUERY);
            statement.setInt(1, cartId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
            	int cartID = resultSet.getInt("cart_id");
                int totalQuantity = resultSet.getInt("total_product_quantity");
                float totalPrice = resultSet.getFloat("total_price");
                cart = new CartModel(cartID, totalQuantity, totalPrice);
            }

            // Close resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
        return cart;
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

    
    private OrderResult prepareOrder(CartModel cartContents, int cartId) {
    	int result = 0;
    	int orderId = -1; // Initialize orderId to -1
    	try {
    	    Connection conn = databaseController.getConnection();
    	    // get address input from user

    	    PreparedStatement statement = conn.prepareStatement(StringUtils.INSERT_INTO_ORDER_QUERY, PreparedStatement.RETURN_GENERATED_KEYS);
    	    statement.setInt(1, 1);
    	    System.out.println("Cart ID: " + cartId);
    	    statement.setInt(2, cartId);
    	    statement.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
    	    statement.setFloat(4, cartContents.getTotalPrice());
    	    statement.setInt(5, cartContents.getTotalProductQuantity());
    	    statement.setString(6, "Pending");

    	    result = statement.executeUpdate();

    	    // Get the generated order ID
    	    try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
    	        if (generatedKeys.next()) {
    	            orderId = generatedKeys.getInt(1);
    	            System.out.println("Order ID: " + orderId);
    	        }
    	    }

    	} catch (SQLException | ClassNotFoundException ex) {
    	    ex.printStackTrace(); // Log the exception for debugging
    	    return new OrderResult(-1, -1);
    	}
    	return new OrderResult(result, orderId);
    }
    
    
    private int saveOrderProducts(ArrayList<CartProductModel> cartProductContents, int orderId) {
    	int result = 0;
        try {
            Connection conn = databaseController.getConnection();
            for (CartProductModel cartProduct : cartProductContents) {
                PreparedStatement statement = conn.prepareStatement(StringUtils.INSERT_INTO_ORDERED_PRODUCT_QUERY);
                statement.setInt(1, orderId);
                statement.setInt(2, cartProduct.getProductId());
                statement.setInt(3, cartProduct.getProductQuantity());
                statement.setFloat(4, cartProduct.getProductTotal());
                result = statement.executeUpdate();
            }
            // Close resources
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
            return -1;
        }
        return result;
    }
    
    private void clearCart(int cartId) {
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.CLEAR_CART_QUERY);
            statement.setInt(1, cartId);
            int result = statement.executeUpdate();
            System.out.println("Cart cleared: " + result);
            // Close resources
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
    }
    
    private void clearCartProduct(int cartId) {
    	try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.CLEAR_CART_PRODUCT_QUERY);
            statement.setInt(1, cartId);
            int result = statement.executeUpdate();
            System.out.println("CART PRODUCT cleared: " + result);
            // Close resources
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
    }
    
}