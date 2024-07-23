package controller.servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.database.DatabaseController;
import model.DeliveryAddressModel;
import utils.MessageUtils;
import utils.PathUtils;
import utils.StringUtils;
import utils.ValidationUtils;

/**
 * Servlet implementation class DeliveryAddressServlet
 */
@WebServlet(urlPatterns=PathUtils.DELIVERY_SERVLET_URL, asyncSupported=true)
public class DeliveryAddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeliveryAddressServlet() {
    	this.databaseController = new DatabaseController();
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extracting delivery address details from the request parameters
        String country = request.getParameter(StringUtils.COUNTRY);
        String province = request.getParameter(StringUtils.PROVINCE);
        String city = request.getParameter(StringUtils.CITY);
        String streetAddress = request.getParameter(StringUtils.STREET_ADDRESS);
        
        String orderId = request.getParameter(StringUtils.ORDER_ID);
        // Validate delivery address details
        if (!ValidationUtils.hasNoSpecialCharacters(country) ||
            !ValidationUtils.hasNoSpecialCharacters(province) ||
            !ValidationUtils.hasNoSpecialCharacters(city) ||
            ValidationUtils.isNullOrEmpty(streetAddress)) {
            request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
            request.getRequestDispatcher(PathUtils.ORDER_CONFIRMATION_PAGE_URL).forward(request, response);
            return;
        }

        // Creating a DeliveryAddressModel object to hold delivery address details
        DeliveryAddressModel deliveryAddress = new DeliveryAddressModel();
        deliveryAddress.setCountry(country);
        deliveryAddress.setProvince(province);
        deliveryAddress.setCity(city);
        deliveryAddress.setStreetAddress(streetAddress);

        // Attempt to add the delivery address
        int result = addDeliveryAddress(deliveryAddress);

        if (result == 1) {
            request.setAttribute("order_id", orderId); // Pass the order ID to the InvoiceServlet
            request.getRequestDispatcher(PathUtils.INVOICE_SERVLET_URL).forward(request, response);
        } else {
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.ADD_DELIVERY_ADDRESS_FAILED);
            request.getRequestDispatcher(PathUtils.ORDER_CONFIRMATION_PAGE_URL).forward(request, response);
        }
    }

    /**
     * Method to add a delivery address to the database.
     *
     * @param deliveryAddress The DeliveryAddressModel object containing the delivery address details.
     * @return An integer representing the result of the operation:
     *         1 if successful, 0 if failed, -1 if an error occurred.
     */
    public int addDeliveryAddress(DeliveryAddressModel deliveryAddress) {
        try {
			PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.INSERT_DELIVERY_ADDRESS_QUERY);

            statement.setString(1, deliveryAddress.getCountry());
            statement.setString(2, deliveryAddress.getProvince());
            statement.setString(3, deliveryAddress.getCity());
            statement.setString(4, deliveryAddress.getStreetAddress());


            int result = statement.executeUpdate();
            
            if (result > 0) {
                return 1; // Delivery address added successfully
            } else {
                return 0; // Adding delivery address failed
            }

        } catch (SQLException ex) {
            // Log the error with the SQL query and error message
            System.err.println("Error executing SQL query: " + StringUtils.INSERT_DELIVERY_ADDRESS_QUERY);
            System.err.println("Error message: " + ex.getMessage());
            return -1;
        } catch (ClassNotFoundException ex) {
            return -1; // Error connecting to the database
        }
    }
}
