<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
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
        <h2>Update Product</h2>
        <form action="addProductServlet" method="post" enctype="multipart/form-data">
            <!-- Product name -->
            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" disabled>
            </div>
            <!-- Category -->
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category" disabled>
                    <option value="Laptop";">Laptop</option>
                    <option value="Desktop">Desktop</option>
                    <option value="Accessories">Accessories</option>
                    <!-- Add more categories as needed -->
                </select>
            </div>
            <!-- Price -->
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" min="0" step="0.01">
            </div>
            <!-- Upload Thumbnail -->
            
            <!-- Product Description -->
            <div class="form-group">
                <label for="description">Product Description:</label>
                <textarea id="description" name="description" rows="4"></textarea>
            </div>
            <!-- Stock Quantity -->
            <div class="form-group">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" min="0">
            </div>
            <!-- Submit Button -->
            <button style="margin-left:370px;background-color: #e85d04;">Back</button>
            <button type="submit" style="margin-left:20px;">Edit Product</button>
            
            
        </form>
       
        
</body>
</html>
