package model;

public class CategoryModel{
	private int category_id;
	private String category_name;
	private String category_description;
	
	public CategoryModel(String category_name, String category_description) {
		this.category_name = category_name;
		this.category_description = category_description;
	}

	public CategoryModel() {}

	public int getCategoryId() {
		return this.category_id;
	}
	
	public void setCategoryId(int category_id) {
		this.category_id = category_id;
	}

	public String getCategoryName() {
		return category_name;
	}
	
	public void setCategoryName(String category_name) {
		this.category_name = category_name;
	}
	
	public String getCategoryDescription() {
		return category_description;
	}
	
	public void setCategoryDescription(String category_description) {
		this.category_description = category_description;
	}
}