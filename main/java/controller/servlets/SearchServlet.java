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
import utils.StringUtils;
/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        this.databaseController = new DatabaseController();
        
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // Retrieve the search query from the request parameters
	    String searchQuery = request.getParameter("searchQuery");

	    // Perform the search using the DatabaseController
	    ArrayList<ProductModel> result = searchProducts(searchQuery);

	    // Forward the search result to a JSP page to display it
	    request.setAttribute("searchResult", result);
	    request.getRequestDispatcher("/searchResult.jsp").forward(request, response);
	}

	public ArrayList<ProductModel> searchProducts(String query) {
        

        try {
        	PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.SEARCH_QUERY);
        	statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
        	
        	ResultSet resultSet = statement.executeQuery();
        	
        	ArrayList<ProductModel> searchResult = new ArrayList<>();
        	
        	while (resultSet.next()) {
                ProductModel product = new ProductModel();
                product.setName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("product_description"));
                // Populate other attributes of the product if needed
                searchResult.add(product);
            }       
        return searchResult;
        }
        catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
}