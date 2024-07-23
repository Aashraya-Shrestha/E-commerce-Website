package model;

public class CartProductModel{
	private int cart_id;
	private int product_id;
	private int product_quantity;
	private float product_total;
	
	public CartProductModel(int cart_id, int product_id, int product_quantity, float product_total) {
		this.cart_id = cart_id;
		this.product_id = product_id;
		this.product_quantity = product_quantity;
		this.product_total = product_total;
	}
	
	public int getCartId() {
		return cart_id;
	}
	
	public void setCartId(int cart_id) {
		this.cart_id = cart_id;
	}
	
	public int getProductId() {
		return product_id;
	}
	
	public void setProductId(int product_id) {
		this.product_id = product_id;
	}
	
	public int getProductQuantity() {
		return product_quantity;
	}
	
	public void setProductQuantities(int product_quantity) {
		this.product_quantity = product_quantity;
	}
	
	public float getProductTotal() {
		return product_total;
	}
	
	public void setProductTotal(float product_total) {
		this.product_total = product_total;
	}
	
}