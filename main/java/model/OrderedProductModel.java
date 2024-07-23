package model;

public class OrderedProductModel{
	private int order_id;
	private int product_id;
	private int quantity;
	private float total_price;
	
	public OrderedProductModel(int order_id, int product_id, int quantity, float total_price) {
		this.order_id = order_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.total_price = total_price;
	}
	
	public OrderedProductModel() {}
	
	public int getOrderId() {
		return order_id;
	}
	
	public void setOrderId(int order_id) {
		this.order_id = order_id;
	}
	
	public int getProductId() {
		return product_id;
	}
	
	public void setProductId(int product_id) {
		this.product_id = product_id;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public float getTotalPrice() {
		return total_price;
	}
	
	public void setTotalPrice(float total_price) {
		this.total_price = total_price;
	}
}