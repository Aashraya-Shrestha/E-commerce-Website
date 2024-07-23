<%@ page import="utils.PathUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="utils.StringUtils" %>

<%
     String contextPath = request.getContextPath();

String username = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals(StringUtils.USER)) {
            username = cookie.getValue();
            break;
        }
    }
}	
 %>
 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Page</title>
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">
    
    <style>
    


    *{
      box-sizing:border-box;
      font-family:Arial, Helvetica, sans-serif;
    }
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    .container {
      display: flex;
      flex-direction: column;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      background-color: #f4f4f4;
    }
    
    .search-bar {
      width: 300px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      margin-right: 20px;
      background-color: #f9f9f9;
      position: relative;
    }

    .search-bar input[type="text"] {
      width: calc(100% - 30px);
      box-sizing: border-box;
      border: none;
      outline: none;
      font-size: 16px;
    }

    .search-bar button {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      cursor: pointer;
    }

    .sort-by select {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
      cursor: pointer;
    }

    .sidebar-container {
      display: flex;
      align-items: flex-start;
      margin-top:110px;
      padding-left:100px;
    }

    .sidebar {
      width: 200px;
      /* background: #f4f4f4; */
      padding: 20px;
      /* margin-top:100px; */
     
    }

    

    .content {
      flex: 1;
      padding: 20px;
    }

    .filter-section h3 {
      margin-top: 0;
    }

    .filter-list {
      list-style: none;
      padding: 0;
      display:flex;
      flex-direction:column;
    }

    .filter-list li {
      margin-bottom: 10px;
    }

    .price-range {
      margin-top: 20px;
    }

    .right-container {
      background-color: #f9f9f9;
      padding: 20px;
      padding-right:70px;
      margin-left: 20px;
      /* Adjusted margin */
      flex: 1;
      /* Ensure it covers the remaining space */
    }



    .right-container1 {
      flex: 1;
      /* background-color: #f9f9f9; */
      padding: 20px;
      display: flex;
      justify-content: space-between;
      /* gap:500px; */
      align-items: center;
      flex-direction: row;
      /* padding-right: 20px; */
      border-bottom: rgb(205, 136, 34);
      border-bottom-width: 2px;
      border-bottom-style: solid;
      /* margin-left:10px; */
      /* margin-right:70px; */

    }

    .right-container .search-bar {
      width: auto;
      margin-bottom: 0;
      /* Reset margin */
    }

    .right-container .sort-by {
      margin-left: auto;
      /* margin-right:50px; */
    }

    /* Style for search container */
    .search-container {
      display: flex;
      align-items: center;
      width: 500px;
      border: 1px solid #ccc;
      border-radius: 20px;
      overflow: hidden;
    }

    /* Style for search input */
    .search-input {
      flex: 1;
      border: none;
      padding: 10px;
      font-size: 16px;
      width: 400px;
      outline: none;
    }

    /* Style for search icon */
    .search-icon {
      padding: 10px;
      padding-left:30px;
      padding-right:30px;
      background-color: #ccc;
      border-left: 1px solid #ccc;
      border-radius: 0 20px 20px 0;
      cursor: pointer;
      transition: background-color 0.3s;
      /* Added transition effect */
    }

    /* Style for icon image */
    .search-icon img {
      width: 20px;
      height: 20px;
    }

    /* Hover effect for search icon */
    .search-icon:hover {
      background-color: #bbb;
      /* Darker shade on hover */
    }

    /* Styling for Featured Products */
    .featured-products {
      margin-top: 10px;
      padding: 20px;
      padding-left: 10px;
      padding-top: 10px;
      background-color: #f9f9f9;
      border-radius: 5px;
    }

    .featured-products h2 {
      font-size: 24px;
      margin-bottom: 10px;
    }


    /* body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        } */

        .container1 {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: 20px;
        }

        .product {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: box-shadow 0.3s, transform 0.3s;
            overflow: hidden;
        }

        .product:hover {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            transform: translateY(-5px);
        }

        .image {
            width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .name {
            font-weight: bold;
            margin-top: 10px;
        }

        .price {
            margin-top: 5px;
        }

        .discount {
            text-decoration: line-through;
            color: #888;
        }

        .add-to-cart {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            background-color: #ff7f0e;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-to-cart:hover {
            background-color: #ff6b00;
        }
        
        .specs{
        margin-top:20px;
        margin-bottom:20px;
        }
  </style>
</head>
<body>
    <%-- 
    <h1>This is Product Page.</h1>
        <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>">Product</a></li>
            <li><a href="userProfile.jsp">User Profile</a></li>
            <li><a href="about_us.jsp">About Us</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="signup.jsp">Signup</a></li>
            <li><a href="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>">Cart</a></li>
        </ul>
    </nav>
    --%>
    
    
    <div>
        <nav class="navbar">
            <div>
                <img src="<%= contextPath %>/images/scam1.png" alt="Logo" class="logo">
            </div>
            <ul class="nav-links">
                <li><a href="<%=request.getContextPath() + PathUtils.HOME_PAGE_URL%>" class="nav1"><span>Home</span></a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>" class="nav1" style="color: #e85d04;"><span>Products</span></a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.ABOUT_US_PAGE_URL%>" class="nav1"><span>About Us</span></a></li>
                <div class="login_signup">
                    <% if( username != null && !username.isEmpty()){%>                    
                    	<li>
                        	<a href="<%= contextPath%>/userprofile">
	                            <img src="<%= contextPath %>/images/user (1).png" class="navicon">
	                            <span style="margin-left:10px;">My Profile</span>
                        	</a>
                    	</li>
                    	<li class="seperation">|</li>
                    	<li><a href="<%=contextPath %>/logout" class="nav1"><span>Log Out</span></a></li>
                    <%} else {%>
                    	<li>
                        <a href="<%=request.getContextPath() + PathUtils.LOGIN_PAGE_URL%>">
                            <img src="<%= contextPath %>/images/user.png" class="navicon">
                            <span style="margin-left:10px;">Login</span>
                        </a>
                    	</li>

	                    <li class="seperation">|</li>
	                    <li><a href="<%=request.getContextPath() + PathUtils.REGISTER_PAGE_URL%>" class="nav1"><span>Sign Up</span></a></li>
               		<%} %>
                </div>
                <li><a href="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>"><img src="<%= contextPath %>/images/shopping-cart.png" class="navicon1"></a></li>
            </ul>
        </nav>
       </div>
    
    
    
<%--  <h1>Product List</h1>

    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Image</th>
                <th>Stock Quantity</th>
                <th>Category ID</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${productlist}">
                <tr>
                    <td>${product.name}</td>
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td><img src="${product.productImageUrl}" alt="${product.name}"></td>
                    <td>${product.stockQuantity}</td>
                    <td>${product.categoryId}</td>
                     <td>
            			<form action="<%=request.getContextPath() + PathUtils.CART_PRODUCT_SERVLET_URL%>" method="post">
               				<input type="hidden" name="product_id" value="${product.id}">
               				<button type="submit">Add to Cart</button>
            			</form>
        			</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>  --%> 
    
    <div class="sidebar-container">
    <div class="sidebar">
      <div class="filter-section">
        <h2>Filters</h2>
        <h3>Category</h3>
        <ul class="filter-list">
          <li><label><input type="checkbox" name="brand" value="Brand 1"> Laptop</label></li>
          <li><label><input type="checkbox" name="brand" value="Brand 2"> Desktop</label></li>
          <li><label><input type="checkbox" name="brand" value="Brand 3"> Accesories</label></li>
          <!-- Add more brand options as needed -->
        </ul>
      </div>
      <div class="price-range">
        <h3>Price</h3>
        <ul class="filter-list">
          <li><label><input type="checkbox" name="price" value="Below 5000"> Below 5000</label></li>
          <li><label><input type="checkbox" name="price" value="5000 - 10000"> 5000 - 10000</label></li>
          <li><label><input type="checkbox" name="price" value="10000 - 15000"> 10000 - 15000</label></li>
          <li><label><input type="checkbox" name="price" value="10000 - 15000"> Above 15000</label></li>
          <!-- Add more price ranges as needed -->
        </ul>
      </div>
    </div>
    <!-- <div class="right-container"> -->
    <!-- Search container -->
    <div class="right-container">
      <div class="right-container1">
        <form>
        <div class="search-container">
          <!-- Search input -->
          <input type="text" class="search-input" placeholder="Search...">
          <!-- Search icon -->
          <div class="search-icon">
            <img src="<%= contextPath %>/images/search.png" alt="Search">
          </div>
        </div>
        </form>
        <div class="sort-by">
          <label for="sort">Sort by:</label>
          <select id="sort">
            <option value="lowToHigh">Low to High</option>
            <option value="highToLow">High to Low</option>
          </select>
        </div>
      </div>
      <!-- </div> -->
      <div class="featured-products">
        <h2>Featured Products</h2>
 
        

    <div class="container1">
    <c:forEach var="product" items="${productlist}">
    
        <div class="product">
            <img class="image" src="${product.productImageUrl}" alt="${product.name}">
            <div class="name">${product.name}</div>
            <div class="specs">
            RAM: 8GB<br>
            Storage: 256GB SSD<br>
            CPU: Intel Core i5
        </div>
            <div class="price">
                <span class="discount">$50</span> ${product.price}
            </div>
            
            <form action="<%=request.getContextPath() + PathUtils.CART_PRODUCT_SERVLET_URL%>" method="post">
            <input type="hidden" name="product_id" value="${product.id}">
            <button class="add-to-cart">Add to Cart</button>
            </form>
        </div>
        </c:forEach>
        
        
       <%--   <c:forEach var="product" items="${productlist}">
                <tr>
                    <td>${product.name}</td>
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td><img src="${product.productImageUrl}" alt="${product.name}"></td>
                    <td>${product.stockQuantity}</td>
                    <td>${product.categoryId}</td>
                     <td>
            			<form action="<%=request.getContextPath() + PathUtils.CART_PRODUCT_SERVLET_URL%>" method="post">
               				<input type="hidden" name="product_id" value="${product.id}">
               				<button type="submit">Add to Cart</button>
            			</form>
        			</td>
                </tr>
            </c:forEach>
       <%--  <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 2">
            <div class="name">Product Name 2</div>
            <div class="price">
                <span class="discount">$60</span> $45
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>
        <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 3">
            <div class="name">Product Name 3</div>
            <div class="price">
                <span class="discount">$70</span> $55
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>
        <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 3">
            <div class="name">Product Name 3</div>
            <div class="price">
                <span class="discount">$70</span> $55
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>
        <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 1">
            <div class="name">Product Name 1</div>
            <div class="price">
                <span class="discount">$50</span> $40
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>
        <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 2">
            <div class="name">Product Name 2</div>
            <div class="price">
                <span class="discount">$60</span> $45
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>
        <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 3">
            <div class="name">Product Name 3</div>
            <div class="price">
                <span class="discount">$70</span> $55
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>
        <div class="product">
            <img class="image" src="../images/instagram.png" alt="Product 3">
            <div class="name">Product Name 3</div>
            <div class="price">
                <span class="discount">$70</span> $55
            </div>
            <button class="add-to-cart">Add to Cart</button>
        </div>  --%> 
        <!-- Add more products as needed -->
    </div>

        <!-- Add your featured products here -->
      </div>
    </div>
  </div>

  <footer>
    <div class="flex-container" style="margin-left:130px">
        <div class="flex-item1">Useful Links</div>
        <div class="flex-item" style="opacity:0.7"><a href="<%=request.getContextPath() + PathUtils.HOME_PAGE_URL%>" style="color:inherit;">Home</a></div>
        <div class="flex-item" style="opacity:0.7"><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>" style="color:inherit;">Product</a></div>
        <div class="flex-item" style="opacity:0.7"><a href="<%=request.getContextPath() + PathUtils.ABOUT_US_PAGE_URL%>" style="color:inherit;">About Us</a></div>
    </div>
    <div class="flex-container">
        <div class="flex-item1">Other</div>
        <div class="flex-item" style="opacity:0.7"><a href="<%=request.getContextPath() + PathUtils.REGISTER_PAGE_URL%>" style="color:inherit;">Sign Up</a></div>
        <div class="flex-item" style="opacity:0.7"><a href="<%=request.getContextPath() + PathUtils.LOGIN_PAGE_URL%>" style="color:inherit;">Login</a></div>
    </div>
    <div class="flex-container">
        <div class="flex-item1">Contact Details</div>
        <div class="flex-item" style="opacity:0.7"><img src="<%= contextPath %>/images/placeholder.png"> Bagbazar, Kathmandu</div>
        <div class="flex-item" style="opacity:0.7"><img src="<%= contextPath %>/images/telephone.png" alt="Phone"> 9869036629</div>
        <div class="flex-item" style="opacity:0.7"><img src="<%= contextPath %>/images/mail.png" alt="Email"> lamichhanepower@gmail.com</div>
    </div>
    <div class="flex-container">
        <div class="flex-item1">Social Media</div>
        <div class="social-media-icons">
            <img src="<%= contextPath %>/images/facebook.png" alt="Facebook">
            <img src="<%= contextPath %>/images/linkedin.png" alt="LinkedIn">
            <img src="<%= contextPath %>/images/instagram.png" alt="Instagram">
        </div>
    </div>
    <div class="copyright">© 2023 All Rights Reserved.</div>
</footer>
    
    
</body>
</html>

			