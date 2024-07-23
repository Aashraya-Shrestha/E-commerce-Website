package model;

public class CartModel{
	private int cart_id;
	private int user_id;
	private int total_product_quantity;
	private float total_price;
	
	public CartModel(int user_id, int total_product_quantity, float total_price) {
		this.user_id = user_id;
		this.total_product_quantity = total_product_quantity;
		this.total_price = total_price;
	}
	
	public CartModel() {}
	
	public int getCartId() {
		return cart_id;
	}
	
	public void setCartId(int cart_id) {
		this.cart_id = cart_id;
	}
	
	public int getUserId() {
		return user_id;
	}
	
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
	
	public int getTotalProductQuantity() {
		return total_product_quantity;
	}
	
	public void setTotalProductQuantity(int total_product_quantity) {
		this.total_product_quantity = total_product_quantity;
	}
	
	public float getTotalPrice() {
		return total_price;
	}
	
	public void setTotalPrice(float total_price) {
		this.total_price = total_price;
	}
	

}