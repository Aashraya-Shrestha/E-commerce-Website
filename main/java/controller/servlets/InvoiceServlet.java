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
import model.OrderModel;
import model.OrderedProductModel;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class InvoiceServlet
 */
@WebServlet(urlPatterns = PathUtils.INVOICE_SERVLET_URL, asyncSupported = true)
public class InvoiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InvoiceServlet() {
        this.databaseController = new DatabaseController();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        
        OrderModel orderContents = getOrderContents(orderId);
        ArrayList<OrderedProductModel> orderProductContents = getOrderedProductContents(orderId);
        
        System.out.println("Invoice Order: "+ orderId);
        request.setAttribute("OrderId", orderId);
        request.setAttribute("OrderContents", orderContents);
        request.setAttribute("OrderProductContents", orderProductContents);
        request.getRequestDispatcher(PathUtils.INVOICE_PAGE_URL).forward(request, response);
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
                int quantity = resultSet.getInt("quantity");
                float total = resultSet.getFloat("total_price");
                OrderedProductModel orderProduct = new OrderedProductModel(orderId, productId, quantity, total);
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

}
