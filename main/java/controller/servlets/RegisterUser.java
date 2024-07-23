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

import utils.StringUtils;
import utils.ValidationUtils;
import controller.database.DatabaseController;
import model.UserModel;
import utils.MessageUtils;
import utils.PathUtils;
/**
 * Servlet implementation class RegisterUser
 */
@WebServlet(urlPatterns = PathUtils.REGISTER_SERVLET_URL, asyncSupported = true)
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUser() {
    	this.databaseController = new DatabaseController();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Extracting username and password from the request parameters
        String userName = request.getParameter(StringUtils.USERNAME);
        String password = request.getParameter(StringUtils.PASSWORD);
        String firstName = request.getParameter(StringUtils.FIRSTNAME);
        String lastName = request.getParameter(StringUtils.LASTNAME);
        String email = request.getParameter(StringUtils.EMAIL);
        String phoneNumber = request.getParameter(StringUtils.PHONE_NUMBER);
        
        System.out.println("First Name: "+ firstName);
        System.out.println("Last Name: "+ lastName);
        System.out.println("Username: "+ userName);
        System.out.println("Password: "+ password);
        System.out.println("Email: "+ email);
        System.out.println("Phone Number: "+ phoneNumber);

        // Creating a LoginModel object to hold user credentials
        UserModel user = new UserModel(firstName, lastName, userName, password, phoneNumber, email);
        
        if(!ValidationUtils.isTextOnly(firstName) ||
				!ValidationUtils.isTextOnly(lastName) ||
				!ValidationUtils.isAlphanumeric(userName) ||
				!ValidationUtils.isEmail(email) ||
				!ValidationUtils.isNumbersOnly(phoneNumber)){
			request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
			request.getRequestDispatcher(PathUtils.REGISTER_PAGE_URL).forward(request, response);
		}

		System.out.println("calling register user");
        int registration = registerUser(user);
       
        // if registration is successful
        if (registration == 1) {
        	request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.REGISTER_SUCCESS);
  			response.sendRedirect(request.getContextPath() + PathUtils.LOGIN_PAGE_URL + "?success=true");
        }
        // problem with registration
        else if (registration == 0) {
        	request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
            request.getRequestDispatcher(PathUtils.REGISTER_PAGE_URL).forward(request, response);
        }
        // internal server error
        else {
        	request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.SERVER_ERROR);
        	request.getRequestDispatcher(PathUtils.REGISTER_PAGE_URL).forward(request, response);
        }
        
	}

	public int registerUser(UserModel user) {
	    try {
	        PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.INSERT_USER_QUERY, PreparedStatement.RETURN_GENERATED_KEYS);
	        statement.setString(1, user.getFirstname());
	        statement.setString(2, user.getLastname());
	        statement.setString(3, user.getUsername());
	        statement.setString(4, user.getPassword());
	        statement.setString(5, user.getEmail());
	        statement.setString(6, user.getPhoneNumber());

	        int result = statement.executeUpdate();
	        if (result > 0) {
	            // Retrieve the generated user ID
	            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
	                if (generatedKeys.next()) {
	                    int userId = generatedKeys.getInt(1);
	                    int cartId = createCartForUser(userId);
	                    if (cartId != -1) {
	                        return 1; // registration successful
	                    } else {
	                        return 0; // cart creation failed
	                    }
	                } else {
	                    return 0; // user registration failed
	                }
	            }
	        } else {
	            return 0; // registration failed
	        }
	    } catch (SQLException | ClassNotFoundException ex) {
	        ex.printStackTrace();
	        return -1;
	    }
	}
	
	private int createCartForUser(int userId) {
	    try {
	        Connection conn = databaseController.getConnection();
	        PreparedStatement statement = conn.prepareStatement(StringUtils.INSERT_CART_QUERY);
	        statement.setInt(1, userId);
	        int result = statement.executeUpdate();
//	        if (result > 0) {
//	            return getCartIdByUserId(userId);
//	        } else {
//	            return -1;
//	        }
	        return result;
	    } catch (SQLException | ClassNotFoundException ex) {
	        ex.printStackTrace();
	        return -1;
	    }
	}
//	private int createCartForUser(int userId) {
//	    try {
//	        Connection conn = databaseController.getConnection();
//	        PreparedStatement statement = conn.prepareStatement(StringUtils.INSERT_CART_QUERY);
//	        statement.setInt(1, userId);
//	        int result = statement.executeUpdate();
//	        if (result > 0) {
//	            return getCartIdByUserId(userId);
//	        } else {
//	            return -1;
//	        }
//	    } catch (SQLException | ClassNotFoundException ex) {
//	        ex.printStackTrace();
//	        return -1;
//	    }
//	}
}
