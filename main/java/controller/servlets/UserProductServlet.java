package controller.servlets;

import java.io.IOException;
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
import model.ProductModel;
import utils.PathUtils;
import utils.StringUtils;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/UserProductServlet")
public class UserProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public final DatabaseController databaseController; 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserProductServlet() {
    	this.databaseController = new DatabaseController();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if a category ID is provided in the request parameter
        String categoryIdParam = request.getParameter("categoryId");
        
        ArrayList<ProductModel> products;
        
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            // If a category ID is provided, filter products by category
            int categoryId = Integer.parseInt(categoryIdParam);
            products = getProductsByCategory(categoryId);
            request.setAttribute(StringUtils.PRODUCT_LIST, products);
        } 
        
        else {
            // If no category ID is provided, fetch all products
            products = getAllProductsInfo();
            request.setAttribute(StringUtils.PRODUCT_LIST, products);
        }

        request.getRequestDispatcher(PathUtils.PRODUCT_PAGE_URL).forward(request, response);
	}

	
	private ArrayList<ProductModel> getProductsByCategory(int categoryId) {
		 try {
	            PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.FILTER_PRODUCT_BY_CATEGORY_QUERY);
	            statement.setInt(1, categoryId);
	            ResultSet result = statement.executeQuery();
	            ArrayList<ProductModel> products = new ArrayList<ProductModel>();

	            while (result.next()) {
					ProductModel product = new ProductModel();
					
					product.setName(result.getString(StringUtils.PRODUCT_NAME));
					product.setDescription(result.getString(StringUtils.PRODUCT_DESCRIPTION));
					product.setPrice(result.getFloat(StringUtils.PRODUCT_PRICE));
//					product.setProductImageUrl(result.getString(StringUtils.PRODUCT_IMAGE_URL));
					product.setStockQuantity(result.getInt(StringUtils.PRODUCT_STOCK_QUANTITY));
					product.setCategoryId(result.getInt(StringUtils.PRODUCT_CATEGORY_ID));
				
					products.add(product);
				}
				return products;
		 } 
		 catch (SQLException | ClassNotFoundException ex) {
	            ex.printStackTrace();
	            return null;
	        }
	}

	public ArrayList<ProductModel> getAllProductsInfo() {
		try {
			PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.GET_ALL_PRODUCTS_QUERY);
			
			ResultSet result = statement.executeQuery();

			ArrayList<ProductModel> products = new ArrayList<ProductModel>();

			while (result.next()) {
				ProductModel product = new ProductModel();
				
				product.setName(result.getString(StringUtils.PRODUCT_NAME));
				product.setDescription(result.getString(StringUtils.PRODUCT_DESCRIPTION));
				product.setPrice(result.getFloat(StringUtils.PRODUCT_PRICE));
//				product.setProductImageUrl(result.getString(StringUtils.PRODUCT_IMAGE_URL));
				product.setStockQuantity(result.getInt(StringUtils.PRODUCT_STOCK_QUANTITY));
				product.setCategoryId(result.getInt(StringUtils.PRODUCT_CATEGORY_ID));
			
				products.add(product);
			}
			return products;
			
		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
}
