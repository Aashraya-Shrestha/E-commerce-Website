package model;
import java.sql.Date;

public class OrderModel {
    private int address_id;
    private int cart_id;
    private Date order_date;
    private float total_price;
    private int total_quantity;
    private String status;
    private int order_id;
    private String customerName;
    private String customerContact;

    public OrderModel(int address_id, int cart_id, Date order_date, float total_price, int total_quantity, String status) {
        this.address_id = address_id;
        this.cart_id = cart_id;
        this.order_date = order_date;
        this.total_price = total_price;
        this.total_quantity = total_quantity;
        this.status = status;
    }

    public OrderModel(int order_id, int address_id, int cart_id, Date order_date, float total_price, int total_quantity, String status) {
        this.address_id = address_id;
        this.cart_id = cart_id;
        this.order_date = order_date;
        this.total_price = total_price;
        this.total_quantity = total_quantity;
        this.status = status;
        this.order_id = order_id;
    }

    public OrderModel(int orderId, int addressId, int cartId, Date orderDate, float totalPrice, int totalQuantity, String status, String customerName, String customerContact) {
        this.order_id = orderId;
        this.address_id = addressId;
        this.cart_id = cartId;
        this.order_date = orderDate;
        this.total_price = totalPrice;
        this.total_quantity = totalQuantity;
        this.status = status;
        this.customerName = customerName;
        this.customerContact = customerContact;
    }

    public OrderModel() {
    }

    // Getters and setters for all fields, including customerName and customerContact
    
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerContact() {
        return customerContact;
    }

    public void setCustomerContact(String customerContact) {
        this.customerContact = customerContact;
    }
	
	public int getAddressId() {
		return address_id;
	}
	
	public void setAddressId(int address_id) {
		this.address_id = address_id;
	}
	
	public int getCartId() {
		return cart_id;
	}
	
	public void setCartId(int cart_id) {
		this.cart_id = cart_id;
	}
	
	public int getOrderId() {
		return order_id;
	}
	
	public void setOrderId(int order_id) {
		this.order_id = order_id;
	}
	
	public Date getOrderDate() {
		return order_date;
	}
	
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	
	public float getTotalPrice() {
		return total_price;
	}
	
	public void setTotalPrice(float total_price) {
		this.total_price = total_price;
	}
	
	public int getTotalQuantity() {
		return total_quantity;
	}
	
	public void setTotalQuantity(int total_quantity) {
		this.total_quantity = total_quantity;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}

}