package controller.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.ProductModel;
import model.UserModel;
import utils.StringUtils;

public class DatabaseController{
	public Connection getConnection() throws SQLException, ClassNotFoundException{
		Class.forName(StringUtils.DRIVER_NAME);
		
		System.out.println("Database Connection");
		
		Class.forName("com.mysql.cj.jdbc.Driver");		
		String URL = "jdbc:mysql://localhost:3306/digital_dynasty";
        String USER = "root";
        String PASSWORD = "";
        return DriverManager.getConnection(URL, USER, PASSWORD);
        
//		return DriverManager.getConnection(StringUtils.MYSQL_URL, StringUtils.MYSQL_USERNAME,
//                StringUtils.MYSQL_PASSWORD);
	}	
	
	public int getUserIdFromUsername(String username) {
	    try {
	        Connection conn = getConnection();
	        PreparedStatement statement = conn.prepareStatement(StringUtils.GET_USER_ID_BY_USERNAME_QUERY);
	        statement.setString(1, username);
	        ResultSet resultSet = statement.executeQuery();

	        if (resultSet.next()) {
	            return resultSet.getInt("user_id");
	        }
	    } catch (SQLException | ClassNotFoundException ex) {
	        ex.printStackTrace(); // Log the exception for debugging
	    }

	    return -1; // Return a default value or throw an exception if the user ID is not found
	}
	
	public int getCartIdByUsername(String username) {
        try {
            Connection conn = getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_CART_ID_BY_USERNAME);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("cart_id");
            } else {
                return -1;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            return -1;
        }
    }
	
	
	private UserModel getUserDetails(String username) throws SQLException, ClassNotFoundException {
	    try (PreparedStatement statement = getConnection().prepareStatement(StringUtils.GET_USER_DETAILS_BY_USERNAME_QUERY)) {
	        statement.setString(1, username);
	        ResultSet resultSet = statement.executeQuery();

	        if (resultSet.next()) {
	            String firstname = resultSet.getString(StringUtils.FIRSTNAME);
	            String lastname = resultSet.getString(StringUtils.LASTNAME);
	            String email = resultSet.getString(StringUtils.EMAIL);
	            String phoneNumber = resultSet.getString(StringUtils.PHONE_NUMBER);

	            return new UserModel(firstname, lastname, username, null, phoneNumber, email);
	        }
	    }

	    // If no user is found, return a default UserModel object
	    return new UserModel();
	}
	
	public ArrayList<ProductModel> getAllProductsInfo() {
		try {
			PreparedStatement statement = getConnection().prepareStatement(StringUtils.GET_ALL_PRODUCTS_QUERY);
			
			ResultSet result = statement.executeQuery();

			ArrayList<ProductModel> products = new ArrayList<ProductModel>();
			
			while (result.next()) {
				ProductModel product = new ProductModel();
				
				product.setId(result.getInt(StringUtils.PRODUCT_ID));
				product.setName(result.getString(StringUtils.PRODUCT_NAME));
				product.setDescription(result.getString(StringUtils.PRODUCT_DESCRIPTION));
				product.setPrice(result.getFloat(StringUtils.PRODUCT_PRICE));
				
				
				
				
				
				// setting the image
				product.setImageUrlFromDB(result.getString(StringUtils.PRODUCT_IMAGE_URL));
				
				System.out.println(result.getString(StringUtils.PRODUCT_IMAGE_URL));
				
				product.setStockQuantity(result.getInt(StringUtils.PRODUCT_STOCK_QUANTITY));
				product.setCategoryId(result.getInt(StringUtils.PRODUCT_CATEGORY_ID));
			
				products.add(product);
			}
			System.out.println("Arraylist returned");
			return products;
			
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
}