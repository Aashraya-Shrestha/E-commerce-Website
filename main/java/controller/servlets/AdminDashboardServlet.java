package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
import model.CustomerOrder;
import model.DashboardSummaryModel;
import model.DeliveryAddressModel;
import model.OrderModel;
import model.OrderedProductModel;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class AdminDashboardServlet
 */
@WebServlet(urlPatterns=PathUtils.ADMIN_DASHBOARD_SERVLET_URL, asyncSupported=true)
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboardServlet() {
    	this.databaseController = new DatabaseController();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Admin Dashboard doget method hit.");
//        String username = (String) request.getSession().getAttribute("username");
        DashboardSummaryModel summary = getDashboardSummary();

        // Set the summary data as request attributes
        request.setAttribute("totalUsers", summary.getTotalUsers());
        request.setAttribute("totalProducts", summary.getTotalProducts());
        request.setAttribute("totalSales", summary.getTotalSales());
        request.setAttribute("totalOrders", summary.getTotalOrders());

        ArrayList<OrderModel> orderContents = getOrderContents();
        System.out.println(orderContents.size());
        ArrayList<OrderedProductModel> orderProductContents = getOrderedProductContents();

        
        // Set cart contents as request attributes
        request.setAttribute("OrderContents", orderContents);
        request.setAttribute("OrderProductContents", orderProductContents);
        
        // Forward to cart page
        request.getRequestDispatcher(PathUtils.ADMIN_DASHBOARD_PAGE_URL).forward(request, response);
    }
	
	
	private ArrayList<OrderModel> getOrderContents() {
	    ArrayList<OrderModel> orderContents = new ArrayList<>();

	    try {
	        Connection conn = databaseController.getConnection();
	        String query = StringUtils.GET_ALL_ORDERS_WITH_CUSTOMER_DETAILS_QUERY;
	        PreparedStatement statement = conn.prepareStatement(query);
	        ResultSet resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            int orderId = resultSet.getInt("order_id");
	            int addressId = resultSet.getInt("address_id");
	            int cartId = resultSet.getInt("cart_id");
	            Date orderDate = resultSet.getDate("order_date");
	            float totalPrice = resultSet.getFloat("total_price");
	            int totalQuantity = resultSet.getInt("total_quantity");
	            String status = resultSet.getString("status");
	            String customerName = resultSet.getString("customer_name");
	            String customerContact = resultSet.getString("customer_contact");

	            OrderModel order = new OrderModel(orderId, addressId, cartId, orderDate, totalPrice, totalQuantity, status, customerName, customerContact);
	            orderContents.add(order);
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
	
	
//    private ArrayList<OrderModel> getOrderContents() {
//        ArrayList<OrderModel> orderContents = new ArrayList<OrderModel>();
//        
//        try {
//            Connection conn = databaseController.getConnection();
//            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_ALL_ORDERS_QUERY);
//            ResultSet resultSet = statement.executeQuery();
//
//            while (resultSet.next()) {
//            	int orderId = resultSet.getInt("order_id");
//                int addressId = resultSet.getInt("address_id");
//                int cartId = resultSet.getInt("cart_id");
//                Date orderDate = resultSet.getDate("order_date");
//                float totalPrice = resultSet.getFloat("total_price");
//                int totalQuantity = resultSet.getInt("total_quantity");
//                String status = resultSet.getString("status");
//                OrderModel contents = new OrderModel(orderId, addressId, cartId, orderDate, totalPrice, totalQuantity, status);
//                orderContents.add(contents);
//            }
//
//            // Close resources
//            resultSet.close();
//            statement.close();
//            conn.close();
//        } catch (SQLException | ClassNotFoundException ex) {
//            ex.printStackTrace(); // Log the exception for debugging
//        }
//        System.out.println("Size: "+ orderContents.size());
//        return orderContents;
//    }
//    
    private ArrayList<OrderedProductModel> getOrderedProductContents() {
        ArrayList<OrderedProductModel> orderedProductContents = new ArrayList<>();
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_ALL_ORDER_PRODUCTS_QUERY);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	int orderId = resultSet.getInt("order_id");
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

    public DashboardSummaryModel getDashboardSummary() {
        DashboardSummaryModel dashboardSummary = null;

        try (Connection connection = databaseController.getConnection();
             PreparedStatement statement = connection.prepareStatement(StringUtils.GET_DASHBOARD_SUMMARY_QUERY);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                int totalUsers = resultSet.getInt("total_users");
                int totalProducts = resultSet.getInt("total_products");
                double totalSales = resultSet.getDouble("total_sales");
                int totalOrders = resultSet.getInt("total_orders");

                dashboardSummary = new DashboardSummaryModel(totalUsers, totalProducts, totalSales, totalOrders);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            // Handle the exception appropriately
            ex.printStackTrace();
        }

        return dashboardSummary;
    }
}
