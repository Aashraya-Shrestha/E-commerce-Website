package controller.servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.database.DatabaseController;
import model.UserModel;
import utils.MessageUtils;
import utils.PathUtils;
import utils.StringUtils;
import utils.ValidationUtils;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet(urlPatterns= {PathUtils.USER_PROFILE_SERVLET_URL}, asyncSupported=true)
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
    	this.databaseController = new DatabaseController();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 /// Retrieve the username from the request attributes
    	String username = (String) request.getSession().getAttribute("username");

    	int userId = databaseController.getUserIdFromUsername(username);
    
    	
    	System.out.println("*****************\n*****************");
        System.out.println(username + " : " +  userId);
        System.out.println("*****************\n*****************");
        
    	 
    	 userId = databaseController.getUserIdFromUsername(username);        
         
         try {
             // Get the user details from the database
             UserModel userDetails = getUserDetails(userId);

             // Set the user details as attributes in the request
             request.setAttribute(StringUtils.USERNAME, userDetails.getUsername());
             request.setAttribute(StringUtils.FIRSTNAME, userDetails.getFirstname());
             request.setAttribute(StringUtils.LASTNAME, userDetails.getLastname());
             request.setAttribute(StringUtils.PASSWORD, userDetails.getPassword());
             request.setAttribute(StringUtils.EMAIL, userDetails.getEmail());
             request.setAttribute(StringUtils.PHONE_NUMBER, userDetails.getPhoneNumber());

             // Forward the request to the user profile JSP page
             request.getRequestDispatcher(PathUtils.USER_PROFILE_PAGE_URL).forward(request, response);
         } catch (SQLException | ClassNotFoundException ex) {
             // Handle the exception and set an error message in the request
             request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.SERVER_ERROR);
             request.getRequestDispatcher(PathUtils.ERROR_PAGE_URL).forward(request, response);
         }
    }
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the username from the request attributes
        String username = (String) request.getSession().getAttribute("username");

        int userId = databaseController.getUserIdFromUsername(username);

        System.out.println("*****************\n*****************");
        System.out.println(username + " : " + userId);
        System.out.println("*****************\n*****************");

        String action = request.getParameter("action");

        if (action != null && action.equals("update")) {
            // Extracting user details from the request parameters
            String firstname = request.getParameter(StringUtils.FIRSTNAME);
            String lastname = request.getParameter(StringUtils.LASTNAME);
            String phoneNumber = request.getParameter(StringUtils.PHONE_NUMBER);
            String email = request.getParameter(StringUtils.EMAIL);


            System.out.println(firstname + " : " +lastname+ " : " +email + " : " + phoneNumber);
            // Validate user details
            if (!ValidationUtils.hasNoSpecialCharacters(firstname) ||
                !ValidationUtils.hasNoSpecialCharacters(lastname) ||
                !ValidationUtils.isValidPhoneNumber(phoneNumber) ||
                !ValidationUtils.isEmail(email)) {
                request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
                response.sendRedirect(request.getContextPath() + PathUtils.USER_PROFILE_PAGE_URL);
                return;
            }

            System.out.println(firstname + " : " +lastname+ " : " +phoneNumber);

            System.out.println("Update user servlet hit.");
            // Creating a UserModel object to hold user details
            UserModel user = new UserModel();
            user.setFirstname(firstname);
            user.setLastname(lastname);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);

            System.out.println(user.getEmail() + " : " + user.getLastname()+ " : " + user.getPhoneNumber());

            // Attempt to update the user details
            int result = updateUserDetails(user, userId);

            // Handle the result of updating user details
            if (result == 1) {
                request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.UPDATE_USER_SUCCESS);
//                response.sendRedirect(request.getContextPath() + PathUtils.USER_PROFILE_PAGE_URL + "?success=true");
                doGet(request, response); // Call the doGet() method

            } else {
                request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.UPDATE_USER_FAILED);
                response.sendRedirect(request.getContextPath() + PathUtils.USER_PROFILE_PAGE_URL);
            }
        }
        
        else if (action != null && action.equals("delete")) {
            System.out.println("Delete user servlet hit.");

            // 1. Clear existing cookies
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    // set max age of the cookie to delete the cookie.
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }

            // 2. Invalidate user session (if it exists)
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            int deletedCart = deleteCart(userId);
            
            // 3. Remove account from the database
            int deleteResult = removeAccount(userId);

            // 4. Redirect based on delete result
            if (deleteResult == 1) {
                request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.DELETE_SUCCESS);
                response.sendRedirect(request.getContextPath() + PathUtils.HOME_PAGE_URL);
            } else {
                request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.SERVER_ERROR);
                response.sendRedirect(request.getContextPath() + PathUtils.ERROR_PAGE_URL);
            }
        } else {
            try {
                // Get the user details from the database
                UserModel userDetails = getUserDetails(userId);

                // Set the user details as attributes in the request
                request.setAttribute(StringUtils.USERNAME, userDetails.getUsername());
                request.setAttribute(StringUtils.FIRSTNAME, userDetails.getFirstname());
                request.setAttribute(StringUtils.LASTNAME, userDetails.getLastname());
                request.setAttribute(StringUtils.PASSWORD, userDetails.getPassword());
                request.setAttribute(StringUtils.EMAIL, userDetails.getEmail());
                request.setAttribute(StringUtils.PHONE_NUMBER, userDetails.getPhoneNumber());

                // Forward the request to the user profile JSP page
                request.getRequestDispatcher(PathUtils.USER_PROFILE_PAGE_URL).forward(request, response);
            } catch (SQLException | ClassNotFoundException ex) {
                // Handle the exception and set an error message in the request
                request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.SERVER_ERROR);
                request.getRequestDispatcher(PathUtils.ERROR_PAGE_URL).forward(request, response);
            }
        }
    }

    
    public int deleteCart(int userId) {
    	try {
			PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.DELETE_CART_QUERY);
			statement.setInt(1, userId);
			return statement.executeUpdate();
			
		} catch (SQLException | ClassNotFoundException ex) {
			return -1;
		}
    }
    	    
	public int removeAccount(int userId) {
		try {
			PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.DELETE_USER_QUERY);
			statement.setInt(1, userId);
			return statement.executeUpdate();
			
		} catch (SQLException | ClassNotFoundException ex) {
			return -1;
		}
	}
	
    
    
	/**
	 * Method to update user details in the database.
	 *
	 * @param user The UserModel object containing the user details.
	 * @return An integer representing the result of the operation:
	 *         1 if successful, 0 if failed, -1 if an error occurred.
	 */
	public int updateUserDetails(UserModel user, int userId) {
	    try {
	        PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.UPDATE_USER_DETAILS_QUERY);

	        statement.setString(1, user.getFirstname());
	        statement.setString(2, user.getLastname());
	        statement.setString(4, user.getEmail());
	        statement.setString(3, user.getPhoneNumber());
	        statement.setInt(5, userId);
	        
	        int result = statement.executeUpdate();

	        if (result > 0) {
	            return 1; // User details updated successfully
	        } else {
	            return 0; // Updating user details failed
	        }
	    } catch (SQLException ex) {
	        // Log the error with the SQL query and error message
	        System.err.println("Error executing SQL query: " + StringUtils.UPDATE_USER_DETAILS_QUERY);
	        System.err.println("Error message: " + ex.getMessage());
	        return -1;
	    } catch (ClassNotFoundException ex) {
	        return -1; // Error connecting to the database
	    }

	}
	
	/**
	 * Method to retrieve user details from the database.
	 *
	 * @param userId The ID of the user.
	 * @return The UserModel object containing the user details.
	 * @throws SQLException          If there is an error executing the SQL query.
	 * @throws ClassNotFoundException If the database driver is not found.
	 */
	private UserModel getUserDetails(int userId) throws SQLException, ClassNotFoundException {
	    try (PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.GET_USER_DETAILS_QUERY)) {
	        statement.setInt(1, userId);
	        ResultSet resultSet = statement.executeQuery();

	        if (resultSet.next()) {
	            String username = resultSet.getString(StringUtils.USERNAME);
	            String firstname = resultSet.getString(StringUtils.FIRSTNAME);
	            String lastname = resultSet.getString(StringUtils.LASTNAME);
	            String password = resultSet.getString(StringUtils.PASSWORD);

	            String email = resultSet.getString(StringUtils.EMAIL);
	            String phoneNumber = resultSet.getString(StringUtils.PHONE_NUMBER);

	            return new UserModel(firstname, lastname, username, password, phoneNumber, email);
	        }
	    }

	    // If no user is found, return a default UserModel object
	    return new UserModel();
	}
}
