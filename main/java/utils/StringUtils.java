package utils;

public class StringUtils{
	
	// database connection - locally
	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String MYSQL_URL = "jdbc:mysql://localhost:3306/digital_dynasty";
	public static final String MYSQL_USERNAME = "root";
	public static final String MYSQL_PASSWORD = "";
	
	
	public static final String PRIVILEGED_USER= "privileged_user";
	
	// queries 
	public static final String VERIFY_USER_QUERY = "SELECT * FROM `User` WHERE username = ?";
	public static final String INSERT_USER_QUERY = "INSERT INTO `User` " +
            "(firstname, lastname, username, password, email, phone_number)" +
            "VALUES (?,?,?,?,?,?)";
	public static final String DELETE_USER_QUERY = "DELETE FROM User WHERE user_id = ?";

	public static final String UPDATE_USER_DETAILS_QUERY = 
    		"UPDATE User SET firstname = ?, lastname = ?, email = ?, phone_number = ? WHERE user_id = ?";
	
	

	// admin 
	public static final String VERIFY_ADMIN_QUERY = "SELECT * FROM Privileged_User WHERE username = ?";
	
	
	
	
	// Admin Product queries
	public static final String INSERT_PRODUCT_QUERY = "INSERT INTO `Product` " +
			"name, description, price, product_image_url, stock_quantity, category_id"+ 
			"VALUES (?,?,?,?,?,?)";

	public static final String GET_ALL_PRODUCTS_QUERY = "SELECT * FROM `Product`";
	public static final String DELETE_PRODUCT_QUERY = "DELETE FROM `Product` WHERE product_id = ?";

	public static final String FIND_PRODUCT_QUERY = "SELECT COUNT(*) FROM Products WHERE product_id = ?";
	
	public static final String UPDATE_PRODUCT_QUERY = "UPDATE Product SET description = ?, price = ?, stock_quantity = ?"
			+ " WHERE product_id = ? "; 

    public static final String FILTER_PRODUCT_BY_CATEGORY_QUERY = "SELECT * FROM `Products` " +
    		"JOIN 'Category` on `Category`.category_id = `Product.category_id` " +
    		"WHERE category_id = ?";
    
//    public static final String FILTER_BY_CATEGORY = "SELECT * FROM Products " +
//            "JOIN Category ON Category.category_id = Products.category_id " +
//            "WHERE Products.category_id = ?";

    
    
    public static final String INSERT_DELIVERY_ADDRESS_QUERY = "INSERT INTO `Delivery_Address` " +
            "(country, province, city, street_address) " +
            "VALUES (?, ?, ?, ?)";
    
	public static final String SEARCH_QUERY = "SELECT * FROM products WHERE product_name LIKE ? OR product_description LIKE ?";
	
	
	
	
	// add to cart query
	public static final String ADD_TO_CART_QUERY = "INSERT INTO Cart_Product (cart_id, product_id, product_quantity, product_total) VALUES (?, ?, ?, ?)";
	// update cart quantity query
//	public static final String UPDATE_CART_QUANTITY_QUERY = "UPDATE Cart " +
//			"SET product_quantity = product_quantity + ? " +
//			"WHERE cart_id = ? AND product_id = ? ";
	
	public static final String UPDATE_CART_PRODUCT_QUERY = "UPDATE Cart_Product "
			+ "SET product_quantity = ?, product_total = ? " 
			+ "WHERE cart_id = ? AND product_id = ?";
	
	// remove product from cart query
//	public static final String REMOVE_FROM_CART_QUERY = " DELETE FROM Cart " +
//			"WHERE cart_id = ? AND product_id = ?";
	
	
	public static final String REMOVE_FROM_CART_QUERY = "DELETE FROM Cart_Product WHERE cart_id = ? AND product_id = ?";
	// transfer contents from cartProduct to cart
//	public static final String TRANSFER_CONTENT_QUERY = "INSERT INTO Cart (cart_id, product_id, product_quantity, product_total) "
//			+ "SELECT cart_id, product_id, product_quantity, product_total "
//			+ "FROM Cart_Product WHERE cart_id = ?";
	
	public static final String TRANSFER_CONTENT_QUERY = "INSERT INTO cart (user_id, total_product_quantity, total_price) "
			+ "SELECT cp.cart_id,"
			+ "SUM(cp.product_quantity) AS total_product_quantity, "
			+ "SUM(cp.product_total) AS total_price "
			+ "FROM Cart_Product "
			+ "GROUP BY cp.cart_id";

	
	
	public static final String RETRIEVE_PRODUCT_QUANTITY_FROM_CART = "SELECT * FROM Cart_Product "
			+ "WHERE cart_id = ? AND product_id = ?";
	
	
	
	
	
	// get all cart products
	public static final String GET_CART_CONTENTS_QUERY = "SELECT * FROM Cart WHERE cart_id = ?";
	
	public static final String GET_PRODUCT_BY_ID_QUERY = "SELECT * FROM Product WHERE product_id = ?";
	
	public static final String GET_CART_PRODUCT_BY_PRODUCT_ID_AND_CART_ID_QUERY = "SELECT cart_id, product_id, product_quantity, product_total "
			+ "FROM Cart_Product "
			+ "WHERE product_id = ? AND cart_id = ?";
	
	public static final String INSERT_INTO_CART_QUERY = "UPDATE Cart SET total_product_quantity = ?, total_price = ? WHERE cart_id = ?";
	
	public static final String RETRIEVE_CART_PRODUCT_QUERY = "SELECT * FROM Cart_Product WHERE cart_id = ?";
    
	
	
	
	
	
	
	
	
	// order product
	public static final String GET_LATEST_ORDER_ID_QUERY =
	        "SELECT id " +
	        "FROM `Order` " +
	        "ORDER BY id DESC " +
	        "LIMIT 1";
	
	
    public static final String INSERT_INTO_ORDERED_PRODUCT_QUERY =
            "INSERT INTO ordered_product (order_id, product_id, quantity, total_price) " +
            "VALUES (?, ?, ?, ?)";
	
//    public static final String INSERT_INTO_ORDER_QUERY = "INSERT INTO `Order` "
//    		+ "address_id, cart_id, order_date, total_price, total_quantity, status "
//    		+ "VALUES (?, ?, ?, ?, ?, ?) ";
    
    public static final String INSERT_INTO_ORDER_QUERY =
    	    "INSERT INTO `'Order'` (address_id, cart_id, order_date, total_price, total_quantity, status) "
    	    + "VALUES (?, ?, ?, ?, ?, ?)";
    
    
    // clear cart
	public static final String CLEAR_CART_QUERY = "UPDATE CART "
			+ "SET total_product_quantity = 0, total_price = 0 "
			+ "WHERE cart_id = ?";
	
	public static final String GET_ORDER_CONTENTS_QUERY = "SELECT * FROM `'Order'` WHERE order_id = ?";
	
	public static final String GET_ORDERED_PRODUCT_CONTENTS_QUERY = "SELECT * FROM ordered_product "
			+ "WHERE order_id = ?";
	public static final String CLEAR_CART_PRODUCT_QUERY = "DELETE FROM Cart_Product WHERE cart_id = ?";
	
	
	public static final String USER = "user";
	public static final String USERNAME = "username";
	public static final String PASSWORD = "password";
	public static final String FIRSTNAME = "firstname"; 
	public static final String LASTNAME = "lastname";
	public static final String EMAIL = "email";
	public static final String PHONE_NUMBER = "phone_number";
	
//	public static final String GENDER = "gender";

	public static final String DELETE_USER= "deleteId";
	public static final String UPDATE_USER= "updateId";
	
	
	
	public static final String PRODUCT_ID = "product_id";
	public static final String PRODUCT_NAME = "name";
	public static final String PRODUCT_DESCRIPTION = "description";
	public static final String PRODUCT_PRICE = "price";
	public static final String PRODUCT_IMAGE_URL = "product_image_url";
	public static final String PRODUCT_STOCK_QUANTITY = "stock_quantity";
	public static final String PRODUCT_CATEGORY_ID = "category_id";
	
	
	public static final String PRODUCT_QUANTITY = "product_quantity";
	public static final String PRODUCT_TOTAL = "product_total";
	
	public static final String CART_ID = "cart_id";
	
	
	public static final String ORDER_ID = "order_id";
	
	public static final String PRODUCT_LIST = "productlist";
	public static final String DELETE_PRODUCT= "deleteId";
	public static final String UPDATE_PRODUCT= "updateId";
	
	
	public static final String COUNTRY = "country";
	public static final String PROVINCE = "province";
	public static final String CITY = "city";
	public static final String STREET_ADDRESS = "street_address";
	
	
	
	public static final String GET_USER_ID_BY_USERNAME_QUERY = "SELECT user_id FROM User WHERE username= ?";
	public static final String INSERT_CART_QUERY = "INSERT INTO CART (user_id, total_product_quantity, total_price) "
			+ "VALUES (?, 0, 0)";
	
	public static final String GET_CART_ID_BY_USERNAME = "SELECT cart_id FROM Cart " 
			+ " JOIN User ON User.user_id = Cart.user_id " 
			+ " WHERE username = ? ";

	public static final String GET_USER_DETAILS_QUERY = "SELECT * FROM User WHERE user_id = ? ";
	public static final String GET_USER_DETAILS_BY_USERNAME_QUERY = "SELECT * FROM User WHERE username = ? ";
	
	
	public static final String IMAGE = "image";
	
	
	public static final String DELETE_CART_QUERY = "DELETE FROM Cart WHERE user_id = ? ";
	
	public static final String GET_ALL_ORDERS_QUERY = "SELECT * FROM `'Order'`";
	public static final String GET_ALL_ORDER_PRODUCTS_QUERY = "SELECT * FROM ordered_product ";
	
	public static final String GET_DASHBOARD_SUMMARY_QUERY = "SELECT " +
            "  (SELECT COUNT(*) FROM User) AS total_users, " +
            "  (SELECT COUNT(*) FROM Product) AS total_products, " +
            "  (SELECT SUM(total_price) FROM `'Order'`) AS total_sales, " +
            "  (SELECT COUNT(*) FROM `'Order'`) AS total_orders ";
	
	public static final String GET_TOTAL_USERS_QUERY = "SELECT * FROM User";
	
	
	public static final String INSERT_INTO_PRODUCTS = "INSERT INTO Product (name, description, price, product_image_url, stock_quantity, category_id) " 
			+ "VALUES (?, ?, ?, ?, ?, ?) ";

	
	
	public static final String GET_ALL_ORDERS_WITH_CUSTOMER_DETAILS_QUERY = "SELECT o.order_id, o.address_id, o.cart_id, o.order_date, o.total_price, "
			+ "o.total_quantity, o.status, u.username AS customer_name, u.phone_number AS customer_contact "
			+ "FROM `'order'` o "
			+ "JOIN cart ca ON o.cart_id = ca.cart_id "
			+ "JOIN user u ON ca.user_id = u.user_id ";
	
	
    public static final String GET_ORDER_HISTORY_QUERY = "SELECT o.order_id, o.order_date, "
    		+ "       CONCAT(a.country, ', ', a.province, ', ', a.city, ', ', a.street_address) AS address, "
    		+ "       o.total_quantity, o.total_price "
    		+ "FROM `'Order'` o "
    		+ "JOIN `Delivery_Address` a ON o.address_id = a.address_id "
    		+ "JOIN `Cart` c ON o.cart_id = c.cart_id "
    		+ "JOIN `User` u ON c.user_id = u.user_id "
    		+ "WHERE u.user_id = ?";
}