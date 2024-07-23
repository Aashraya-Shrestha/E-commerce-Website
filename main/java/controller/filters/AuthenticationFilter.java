package controller.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.database.DatabaseController;
import utils.PathUtils;
import utils.StringUtils;

public class AuthenticationFilter implements Filter{
	DatabaseController dbController = new DatabaseController();
	
	private boolean isAdmin(String username) {
        // Check if the username matches the admin pattern
        return username.startsWith("@");
    }
	
	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		String uri = req.getRequestURI();
		
		if (uri.endsWith(".css") || uri.endsWith(".png") || uri.endsWith(".jpg")) {
	        chain.doFilter(request, response);
	        return;
	    }
	    
	    // JSP // ALL THE JSP PAGES
		boolean isIndexPage = uri.endsWith(PathUtils.HOME_PAGE_URL);
	    boolean isAddProductPage = uri.endsWith(PathUtils.ADMIN_ADD_PRODUCT_PAGE_URL);
	    boolean isAdminPage = uri.endsWith(PathUtils.ADMIN_DASHBOARD_PAGE_URL);
	    boolean isCartPage = uri.endsWith(PathUtils.CART_PAGE_URL);
	    boolean isInvoicePage = uri.endsWith(PathUtils.INVOICE_PAGE_URL);
	    boolean isLoginPage = uri.endsWith(PathUtils.LOGIN_PAGE_URL);
	    boolean isOrderPage = uri.endsWith(PathUtils.ORDER_CONFIRMATION_PAGE_URL);
	    boolean isProfilePage = uri.endsWith(PathUtils.USER_PROFILE_PAGE_URL);
	    boolean isProductDetails = uri.endsWith(PathUtils.UPDATE_PRODUCT_PAGE_URL);
//	    boolean isUserPassword = uri.endsWith(PathUtils.USER_PASSWORD_URL);
//	    boolean isProductPage = uri.endsWith(PathUtils.VIEW_PRODUCT_URL);	    	 
	    boolean isRegisterPage = uri.endsWith(PathUtils.REGISTER_PAGE_URL);

	    // Servlet
	    /*
	    boolean isLoginServlet = uri.endsWith(StringUtils.LOGIN_SERVLET);
	    boolean isRegisterServlet = uri.endsWith(StringUtils.REGISTER_SERVLET);
	    boolean isLogOutServlet = uri.endsWith(StringUtils.LOGOUT_SERVLET);
	    boolean isUserUpdateServlet = uri.endsWith(StringUtils.USER_UPDATE_SERVLET);
	    boolean isUserPasswordServlet = uri.endsWith(StringUtils.FILTER_PRODUCT_SERVLET);
	    boolean isAddToCartServlet = uri.endsWith(StringUtils.ADD_NEW_PRODUCT_SERVLET);
	    boolean isDeleteCartItemsServlet = uri.endsWith(StringUtils.DELETE_CART_ITEMS_SERVLET);
	    boolean isUpdateQuantityServlet = uri.endsWith(StringUtils.UPDATE_QUANTITY_SERVLET);
	    boolean isOrderConfirmServlet = uri.endsWith(StringUtils.ORDER_CONFIRM_SERVLET);
	    boolean isAddNewProductServlet = uri.endsWith(StringUtils.ADD_NEW_PRODUCT_SERVLET);
	    boolean isGetProductDetailsServlet = uri.endsWith(StringUtils.UPDATE_PRODUCT_DETAILS_SERVLET);
	    boolean isRemoveProductServlet = uri.endsWith(StringUtils.REMOVE_PRODUCT_SERVLET);
	    boolean isUserPrivilegeServlet = uri.endsWith(StringUtils.USER_PRIVILEGE_SERVLET);
	    boolean isIndexCartServlet = uri.endsWith(StringUtils.INDEX_CART_SERVLET); */
	    
	    
    	HttpSession session = req.getSession(false); 
    	boolean isLoggedIn = session != null && session.getAttribute(StringUtils.USERNAME) != null;
    	
    	// Applying filter when user trying to access resources without logging
    	if(!isLoggedIn && (isAddProductPage || isAdminPage || isCartPage || isInvoicePage || isOrderPage || isProfilePage || isProductDetails
	    		)) {
	    	res.sendRedirect(req.getContextPath() + PathUtils.LOGIN_PAGE_URL);
	    	return;
	    }

    	//|| isUserPassword || isProductPage || isUserManagementPage
    	
    	
    	String cookieUsername = null;
    	Cookie[] cookies = req.getCookies();
    	if(cookies != null){
    		for(Cookie cookie: cookies){
    			if(cookie.getName().equals(StringUtils.USER)){
    				cookieUsername = cookie.getValue();
    				break;
    			}
    			if(cookie.getName().equals(StringUtils.PRIVILEGED_USER)){
    				cookieUsername = cookie.getValue();
    				break;
    			}
    		}
    	}
    	
//    	boolean isAdmin = false;
//    	System.out.println(cookieUsername);
//    	if (!cookieUsername.isEmpty() && cookieUsername != null) {
//    		isAdmin = isAdmin(cookieUsername);
//    	}
//    	
//    	if (isLoggedIn && isAdmin) {
//    		if(isCartPage || isInvoicePage || isLoginPage || isOrderPage || isProfilePage || isRegisterPage
//    				|| isIndexPage) {
//        		res.sendRedirect(req.getContextPath() + PathUtils.ADMIN_DASHBOARD_PAGE_URL);
//    			return;
//        	}
//    	}
//    	else {
//    		res.sendRedirect(req.getContextPath() + PathUtils.LOGIN_PAGE_URL);
//    	}
    	
    	
//    	String getPrivilegeType = null;
//    	if(cookieUsername != null && !cookieUsername.equals("admin")) {
//    		getPrivilegeType = cookieUsername;
//    	}
//    	
//        boolean isAdmin = (isLoggedIn && "Admin".equals(getPrivilegeType)) || "bikash200@gmail.com".equals(cookieUsername);
//
//    	// Filter for user
//    	if(isLoggedIn && !cookieUsername.equals("bikash200@gmail.com")) {
//    		
//    		if (isLoggedIn && (isLoginPage || isRegisterPage)) {
//    	    	res.sendRedirect(req.getContextPath() + PathUtils.HOME_PAGE_URL);
//    	    	return;
//    	    }
//    		if(isLoggedIn &&(isAdminPage || isProductDetails || isAddProductPage)) {
//    			res.sendRedirect(req.getContextPath() + PathUtils.HOME_PAGE_URL);
//    			return;
//        	}
//    		
//    	}
//    	// Filter for admin
//    	else {
//    		if(isLoggedIn && (isCartPage || isInvoicePage || isLoginPage || isOrderPage || isProfilePage || isRegisterPage
//    				|| isIndexPage)) {
//        		res.sendRedirect(req.getContextPath() + PathUtils.ADMIN_DASHBOARD_PAGE_URL);
//    			return;
//        	}
//    	}    
	    
        chain.doFilter(request, response);

	}
	
	@Override
	public void destroy() {
				
	}
	
	
}
