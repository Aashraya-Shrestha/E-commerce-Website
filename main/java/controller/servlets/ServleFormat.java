package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServleFormat
 */
@WebServlet("/ServleFormat")
public class ServleFormat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServleFormat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#getServletConfig()
	 */
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see Servlet#getServletInfo()
	 */
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null; 
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doHead(HttpServletRequest, HttpServletResponse)
	 */
	protected void doHead(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doOptions(HttpServletRequest, HttpServletResponse)
	 */
	protected void doOptions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doTrace(HttpServletRequest, HttpServletResponse)
	 */
	protected void doTrace(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}


//protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    String categoryIdParam = request.getParameter("categoryId");
//    String sortParam = request.getParameter("sort");
//
//    ArrayList<ProductModel> products;
//
//    if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
//        // If a category ID is provided, filter products by category
//        int categoryId = Integer.parseInt(categoryIdParam);
//        products = getProductsByCategory(categoryId);
//        
//        // Apply sorting if sortParam is provided
//        if (sortParam != null && !sortParam.isEmpty()) {
//            sortProducts(products, sortParam);
//        }
//    } else {
//        // If no category ID is provided, fetch all products
//        products = getAllProductsInfo();
//        
//        // Apply sorting if sortParam is provided
//        if (sortParam != null && !sortParam.isEmpty()) {
//            sortProducts(products, sortParam);
//        }
//    }
//
//    request.setAttribute(StringUtils.PRODUCT_LIST, products);
//    request.getRequestDispatcher(PathUtils.ADMIN_PRODUCT_PAGE_URL).forward(request, response);
//}
//
//private void sortProducts(ArrayList<ProductModel> products, String sortParam) {
//    if (sortParam.equals("low_to_high")) {
//        products.sort(Comparator.comparing(ProductModel::getPrice));
//    } else if (sortParam.equals("high_to_low")) {
//        products.sort(Comparator.comparing(ProductModel::getPrice).reversed());
//    }
//}

