package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.database.DatabaseController;
import model.ProductModel;
import utils.MessageUtils;
import utils.PathUtils;
import utils.StringUtils;
import utils.ValidationUtils;

/**
 * Servlet implementation class AdminProductServlet
 */
@WebServlet(urlPatterns=PathUtils.ADMIN_PRODUCT_SERVLET_URL, asyncSupported=true)
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)

public class AdminProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	    private final DatabaseController databaseController;

	    /**
	     * @see HttpServlet#HttpServlet()
	     */
	    public AdminProductServlet() {
	        this.databaseController = new DatabaseController();
	    }

	    
	    
		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			ArrayList<ProductModel> products = getAllProductsInfo();
			request.setAttribute(StringUtils.PRODUCT_LIST, products);
			request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
		}
		
		
	
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    String action = request.getParameter("action");

		    // Retrieve the username from the request attributes
	        String username = (String) request.getSession().getAttribute("username");

	        int userId = databaseController.getUserIdFromUsername(username);

	        System.out.println("*****************\n*****************");
	        System.out.println(username + " : " + userId);
	        System.out.println("*****************\n*****************");

	        if (action != null && action.equals("PUT")) {
	        	System.out.println("Product UPDATE method is hit.");
	        	request.getRequestDispatcher(PathUtils.UPDATE_PRODUCT_SERVLET_URL).forward(request, response);

	        	// update products
	        	
	        }
	        else if (action != null && action.equals("DELETE")) {
	        	System.out.println("Product DELETE method is hit.");
	        	
	        	// delete product
	        }
	        else if ((action != null && action.equals("POST"))) {
	        	
	        	System.out.println("Product add method is hit.");
	        	request.getRequestDispatcher(PathUtils.ADMIN_ADD_PRODUCT_PAGE_URL).forward(request, response);
	        	
	        	

	        }
	        else {
	        	System.out.println("Admin product default method is hit.");
	        	// else other condition
	        }
		}

		public ArrayList<ProductModel> getAllProductsInfo() {
			try {
				PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.GET_ALL_PRODUCTS_QUERY);
				
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
		
		
//		private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		    // Extracting product details from the request parameters
//		    String name = request.getParameter(StringUtils.PRODUCT_NAME);
//		    String description = request.getParameter(StringUtils.PRODUCT_DESCRIPTION);
//		    String price = request.getParameter(StringUtils.PRODUCT_PRICE);
//		    String imageUrl = request.getParameter(StringUtils.PRODUCT_IMAGE_URL);
//		    String stockQuantity = request.getParameter(StringUtils.PRODUCT_STOCK_QUANTITY);
//		    String categoryId = request.getParameter(StringUtils.PRODUCT_CATEGORY_ID);
//		    Part imagePart = request.getPart("image");
//
//		    // Validate product details
//		    if (!ValidationUtils.hasNoSpecialCharacters(name) ||
//		        !ValidationUtils.isNumeric(price) ||
//		        !ValidationUtils.isNumbersOnly(stockQuantity) ||
//		        !ValidationUtils.isNumbersOnly(categoryId)) {
//		        request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
//		        request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//		        return;
//		    }
//
//		    // parsing the values, so that it matches the value in the model
//		    float newPrice = Float.parseFloat(price);
//		    int newStockQuantity = Integer.parseInt(stockQuantity);
//		    int newCategoryId = Integer.parseInt(categoryId);
//
//		    // Creating a ProductModel object to hold product details
//		    ProductModel product = new ProductModel(name, description, newPrice, imageUrl, newStockQuantity, newCategoryId);
//
//		    // Attempt to add the product
//		    int result = addProduct(product);
//
//		    // Handle the result of adding the product
//		    if (result == 1) {
//		        request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.ADD_PRODUCT_SUCCESS);
//		        response.sendRedirect(request.getContextPath() + PathUtils.ADMIN_PRODUCT_PAGE_URL + "?success=true");
//		    } else {
//		        request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.ADD_PRODUCT_FAILED);
//		        request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//		    }
//		}
//
//		private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		    // Extracting product details from the request parameters
//		    String productId = request.getParameter(StringUtils.PRODUCT_ID); // request URL
//		    String name = request.getParameter(StringUtils.PRODUCT_NAME);
//		    String description = request.getParameter(StringUtils.PRODUCT_DESCRIPTION);
//		    String price = request.getParameter(StringUtils.PRODUCT_PRICE);
//		    String imageUrl = request.getParameter(StringUtils.PRODUCT_IMAGE_URL);
//		    String stockQuantity = request.getParameter(StringUtils.PRODUCT_STOCK_QUANTITY);
//		    String categoryId = request.getParameter(StringUtils.PRODUCT_CATEGORY_ID);
//		    
//		    if (!ValidationUtils.isNumbersOnly(productId)) {
//		        request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
//		        request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//		        return;
//		    }
//
//		    if (!ValidationUtils.isNumeric(productId) ||
//		        !ValidationUtils.hasNoSpecialCharacters(name) ||
//		        !ValidationUtils.isNumeric(price) ||
//		        !ValidationUtils.isNumbersOnly(stockQuantity) ||
//		        !ValidationUtils.isNumbersOnly(categoryId)) {
//		        request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INCORRECT_FORM_DATA);
//		        request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//		        return;
//		    }
//
//		    // parsing the values, so that it matches the value in the model
//		    float newPrice = Float.parseFloat(price);
//		    int newStockQuantity = Integer.parseInt(stockQuantity);
//		    int newCategoryId = Integer.parseInt(categoryId);
//
//		    int newProductId = Integer.parseInt(productId);
//
//		    // Creating a ProductModel object to hold product details
//		    ProductModel product = new ProductModel(name, description, newPrice, imageUrl, newStockQuantity, newCategoryId);
//
//		    // Attempt to update the product
//		    int result = updateProduct(newProductId, product);
//
//		    // Handle the result of updating the product
//		    if (result == 1) {
//		        request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.UPDATE_PRODUCT_SUCCESS);
//		        response.sendRedirect(request.getContextPath() + PathUtils.ADMIN_PRODUCT_PAGE_URL + "?success=true");
//		    } else {
//		        request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.UPDATE_PRODUCT_FAILED);
//		        request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//		    }
//		}
//
//		private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		    System.out.println("delete triggered");
//		    int productId = Integer.parseInt(request.getParameter(StringUtils.DELETE_PRODUCT));
//
//		    int result = deleteProduct(productId);
//
//		    if (result == 1) {
//		        request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.DELETE_SUCCESS);
//		        response.sendRedirect(request.getContextPath() + PathUtils.HOME_PAGE_URL);
//		    } else {
//		        request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.SERVER_ERROR);
//		        response.sendRedirect(request.getContextPath() + PathUtils.ERROR_PAGE_URL);
//		    }
//		}
//
//		private void handleInvalidAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		    request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.INVALID_ACTION);
//		    request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//		}

}
