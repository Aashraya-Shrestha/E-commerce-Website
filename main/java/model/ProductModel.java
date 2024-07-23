package model;

import java.io.File;

import javax.servlet.http.Part;

import utils.PathUtils;

public class ProductModel {
    private int id;
    private String name;
    private String description;
    private float price;
    private String product_image_url;
    private int stock_quantity;
    private int category_id;


    public ProductModel(int id, String name, String description, float price, Part imagePart, int stock_quantity, int category_id) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.category_id = category_id;
        this.product_image_url = getImageUrl(imagePart);
    }
    
    public ProductModel(String name, String description, float price, Part imagePart, int stock_quantity, int category_id) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.category_id = category_id;
        this.product_image_url = getImageUrl(imagePart);
    }
    

    public ProductModel(int id, String name, String description, float price, String product_image_url, int stock_quantity, int category_id) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.category_id = category_id;
        this.product_image_url = product_image_url;
    }
    
    
    // Constructor without id
    public ProductModel(String name, String description, float price, String product_image_url, int stock_quantity, int category_id) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.product_image_url = product_image_url;
        this.stock_quantity = stock_quantity;
        this.category_id = category_id;
    }

    public ProductModel(int productID, String description, float price, int stock_quantity) {
    	this.id = productID;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
    }
    
    public ProductModel(int productId, String name, String description, float price, int stockQuantity, int category_id) {
    	this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stockQuantity;
        this.category_id = category_id;
    }
    
    public ProductModel() {}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public float getPrice() {
		return price;
	}
	
	public void setPrice(float price) {
		this.price = price;
	}
	
	public int getStockQuantity() {
		return stock_quantity;
	}
	
	public void setStockQuantity(int stock_quantity) {
		this.stock_quantity = stock_quantity;
	}
	
	public int getCategoryId() {
		return category_id;
	}
	
	public void setCategoryId(int category_id) {
		this.category_id = category_id;
	}
	
	public String getProductImageUrl() {
		return product_image_url;
	}
	
	public void setProductImageUrl(Part part) {
		this.product_image_url = getImageUrl(part);
	}

	public void setImageUrlFromDB(String imageUrl) {
		this.product_image_url = imageUrl;
	}
	
	/**
	 * This method extracts the image file name from the request part containing the uploaded image.
	 * 
	 * @param part The request part containing the uploaded image data.
	 * @return The extracted image file name, or "download.jpg" if no file name is found.
	 * @throws IOException If an error occurs while accessing the part data.
	 */
	private String getImageUrl(Part part) {
		// Define the directory path to store uploaded user images. This path should be configured elsewhere in the application.
	    String savePath = PathUtils.IMAGE_DIR_PRODUCT;

	    // Create a File object representing the directory to store uploaded images.
	    File fileSaveDir = new File(savePath);

	    // Initialize the variable to store the extracted image file name.
	    String imageUrlFromPart = null;

	    // Check if the directory to store uploaded images already exists.
	    if (!fileSaveDir.exists()) {
	        // If the directory doesn't exist, create it.
	    	// user mkdirs() method to create multiple or nested folder
	        fileSaveDir.mkdir();
	    }

	    // Get the Content-Disposition header from the request part. This header contains information about the uploaded file, including its filename.
	    String contentDisp = part.getHeader("content-disposition");

	    // Split the Content-Disposition header into individual parts based on semicolons.
	    String[] items = contentDisp.split(";");
	    
	 // Iterate through each part of the Content-Disposition header.
	    for (String s : items) {
	        // Check if the current part starts with "filename" (case-insensitive trim is used).
	        if (s.trim().startsWith("filename")) {
	            // Extract the filename from the current part.
	            // The filename is assumed to be enclosed in double quotes (").
	            // This part removes everything before the equal sign (=) and the double quotes surrounding the filename.
	            imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length() - 1);
	            break; // Exit the loop after finding the filename
	        }
	    }

	    // If no filename was extracted from the Content-Disposition header, set a default filename.
	    if (imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
	        imageUrlFromPart = "default_user.jpg";
	    }

	    // Return the extracted or default image file name.
	    return imageUrlFromPart;
	}
	
}