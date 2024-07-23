<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.PathUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductModel" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Product</title>
    <!-- Include CSS styling -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 70%;
            margin: 50px auto;
            padding: 20px;
            background-color: antiquewhite;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        textarea {
            height: 100px;
        }

        button {
            
            width: 30%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            opacity:0.9;
            transtion:1s;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Product</h2>
        <form action="<%= request.getContextPath() + PathUtils.ADMIN_ADD_PRODUCT_SERVLET_URL %>" method="post" enctype="multipart/form-data">
            <!-- Product name -->
            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="name" required>
            </div>
            <!-- Category -->
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category_id" required>
                    <option value="1">Laptop</option>
                    <option value="2">Desktop</option>
                    <option value="3">Accessories</option>
                    <!-- Add more categories as needed -->
                </select>
            </div>
            <!-- Price -->
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" min="0" step="0.01" required>
            </div>
            <!-- Upload Thumbnail -->
            <div class="form-group">
                <label for="thumbnail" style="margin-bottom:10px;">Upload Thumbnail:</label>
                <input type="file" id="thumbnail" name="image" accept="image/*" required>
            </div>
            <!-- Product Description -->
            <div class="form-group">
                <label for="description">Product Description:</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>
            <!-- Stock Quantity -->
            <div class="form-group">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" id="stockQuantity" name="stock_quantity" min="0" required>
            </div>
            <!-- Submit Button -->
            <button style="margin-left:370px;background-color: #e85d04;">Back</button>
            <button type="submit" style="margin-left:20px;">Add Product</button>
            
            
        </form>
       
        
</body>
</html>
