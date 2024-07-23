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
import model.OrderHistoryModel;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class OrderHistoryServlet
 */
@WebServlet(urlPatterns=PathUtils.ORDER_HISTORY_SERVLET_URL, asyncSupported=true)
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderHistoryServlet() {
        this.databaseController = new DatabaseController();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String username = (String) request.getSession().getAttribute("username");

    	int userId = databaseController.getUserIdFromUsername(username);
    	
    	
    	ArrayList<OrderHistoryModel> orderHistory = new ArrayList<OrderHistoryModel>();
        try {
        	
			orderHistory = getOrderHistory(userId);
			
			request.setAttribute("OrderHistory", orderHistory);
	        request.getRequestDispatcher(PathUtils.ORDER_HISTORY_PAGE_URL).forward(request, response);
		} 
        catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        
        
    }

    public ArrayList<OrderHistoryModel> getOrderHistory(int userId) throws ClassNotFoundException {
        ArrayList<OrderHistoryModel> orderHistory = new ArrayList<>();

        try (Connection conn = databaseController.getConnection();
             PreparedStatement stmt = conn.prepareStatement(StringUtils.GET_ORDER_HISTORY_QUERY)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    java.util.Date datePlaced = rs.getDate("order_date");
                    String deliveryAddress = rs.getString("address");
                    int totalQuantity = rs.getInt("total_quantity");
                    double totalPrice = rs.getDouble("total_price");

                    OrderHistoryModel order = new OrderHistoryModel(orderId, datePlaced, deliveryAddress, totalQuantity, totalPrice);
                    orderHistory.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderHistory;
    }
}