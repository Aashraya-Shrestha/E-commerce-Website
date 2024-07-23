<%@ page import="utils.PathUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="utils.StringUtils" %>
<%
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
	
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart Page</title>
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">
    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }
        

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top:120px;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            vertical-align: middle; /* Center align content vertically */
            height: 100%; /* Ensure all cells have the same height */
        }

        th {
            background-color: #f2f2f2;
        }
 
        .total {
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            text-align: right;
        }

        .subtotal,
        .discount,
        .grand-total,
        .checkout-btn {
            text-align: left;
        }

        .subtotal,
        .discount,
        .grand-total {
            margin-top: 10px;
            margin-left:40px;
        }

        .grand-total {
            font-size: 24px;
            color: #e85d04;
        }

        .checkout-btn {
            display: block;
            padding: 10px;
            margin-left:35px;
            margin-top: 20px;
            width:20%;
            background-color: #e85d04;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .checkout-btn:hover {
            background-color: #d34d00;
        }


        .quantity input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 0 5px; /* Adjust margin to center the input between buttons */
        }

        .quantity button {
            padding: 5px 10px;
            background-color: #e85d04;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .quantity button:hover {
            background-color: #d34d00;
        }

        .remove-btn {
    background-color: #e85d04; /* Red background color */
    color: #fff; /* White text color */
    border: none; /* Remove border */
    font-size: 14px;
    cursor: pointer;
    transition: opacity 0.3s; /* Smooth transition for opacity */
    padding: 8px 15px; /* Add padding for better appearance */
    border-radius: 5px; /* Add border radius for rounded corners */
    outline: none; /* Remove default focus outline */
    opacity: 1; /* Initially set opacity to 1 */
}

.remove-btn:hover {
    opacity: 0.8; /* Reduce opacity on hover */
}



        .cart-icon {
            width: 80px;
            height: 80px;
        }

        .order-summary {
    background-color: #f2f2f2; /* Light gray background */
    padding: 20px; /* Add padding for spacing */
    border-radius: 10px; /* Add border radius for rounded corners */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add box shadow for depth */
    max-width: 400px; /* Limit width for smaller box */
    margin: 0 auto; /* Center horizontally */
    margin-right:10px;
    
}

.order-summary h2 {
    margin-top: 0; /* Remove top margin for h2 */
    margin-bottom: 20px; /* Add bottom margin for spacing */
    border-bottom-style: solid;
    border-bottom-width:2px;
    border-bottom-color:black;
}

.order-summary .subtotal,
.order-summary .discount,
.order-summary .grand-total {
    margin-top: 10px; /* Add top margin for spacing */
    

}

.order-summary .checkout-btn {
    display: block; /* Make button a block element */
    margin-top: 20px; /* Add top margin for spacing */
    padding: 10px; /* Add padding for button */
    width:80%;
    font-style:solid;
    font-size:20px;
    cursor:pointer;
    border:none;
     /* Make button full width */
}

.quantity {
    text-align: center;
}

.quantity .quantity-controls {
    display: flex;
    align-items: center;
    justify-content: center;
}

.quantity .quantity-input {
    width: 40px;
    text-align: center;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin: 0 5px; /* Adjust margin to center the input between buttons */
}

.quantity .quantity-controls button {
    padding: 5px 10px;
    background-color: #e85d04;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.quantity .quantity-controls button:hover {
    background-color: #d34d00;
}


    </style>
    
</head>
<body>
    <div>
        <nav class="navbar">
            <div>
                <img src="<%= contextPath %>/images/scam1.png" alt="Logo" class="logo">
            </div>
            <ul class="nav-links">
                <li><a href="<%=request.getContextPath() + PathUtils.HOME_PAGE_URL%>" class="nav1"><span>Home</span></a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>" class="nav1" ><span>Products</span></a></li>
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
                <li><a href="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>"><img src="<%= contextPath %>/images/shopping-cart.png" class="navicon1" style="color: #e85d04;"></a></li>

            </ul>
        </nav>
       </div>
    
	
    
    <%-- 
    <!--<table border="1">
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cartProduct" items="${cartProductContents}">
                <tr>
                    <td>${cartProduct.productId}</td>             
					<td>${cartProduct.getProductQuantity()}</td>
                    <td>${cartProduct.getProductTotal()}</td>
                    <td>
                        <form action="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>" method="post">
                            <input type="hidden" name="_method" value="PUT">
						    <input type="hidden" name="cart_id" value="${cartProduct.cartId}">
						    <input type="hidden" name="product_id" value="${cartProduct.productId}">
						    <input type="hidden" name="quantity_change" value="-1">
						    <button type="submit"> - </button>
						</form>
						<form action="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>" method="post">
							<input type="hidden" name="_method" value="PUT">
						    <input type="hidden" name="cart_id" value="${cartProduct.cartId}">
						    <input type="hidden" name="product_id" value="${cartProduct.productId}">
						    <input type="hidden" name="quantity_change" value="1">
						    <button type="submit"> + </button>
						</form>
                        <form action="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>" method="post">
                            <input type="hidden" name="_method" value="DELETE">
                            <input type="hidden" name="cart_id" value="${cartProduct.cartId}">
                            <input type="hidden" name="product_id" value="${cartProduct.productId}">
                            <button type="submit">Remove</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table> -->
    --%>
    
    <div class="container">
        <h1>Shopping Cart(5)</h1>
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th></th> <!-- Empty column for Remove buttons -->
                </tr>
            </thead>
            
            <tbody>
    <c:forEach var="cartProduct" items="${cartProductContents}">
    <tr>
        <td>cart img</td>
        <td>${cartProduct.productId}</td>
        <td class="quantity">
            <div class="quantity-controls">
                <form action="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>" method="post">
                    <input type="hidden" name="_method" value="PUT">
                    <input type="hidden" name="cart_id" value="${cartProduct.cartId}">
                    <input type="hidden" name="product_id" value="${cartProduct.productId}">
                    <input type="hidden" name="quantity_change" value="-1">
                    <button type="submit" class="decrement">-</button>
                </form>
                <input type="text" class="quantity-input" value="${cartProduct.getProductQuantity()}" readonly>
                <form action="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>" method="post">
                    <input type="hidden" name="_method" value="PUT">
                    <input type="hidden" name="cart_id" value="${cartProduct.cartId}">
                    <input type="hidden" name="product_id" value="${cartProduct.productId}">
                    <input type="hidden" name="quantity_change" value="1">
                    <button type="submit" class="increment">+</button>
                </form>
            </div>
        </td>
        <td>${cartProduct.getProductTotal()}</td>
        <td>
            <form action="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>" method="post">
                <input type="hidden" name="_method" value="DELETE">
                <input type="hidden" name="cart_id" value="${cartProduct.cartId}">
                <input type="hidden" name="product_id" value="${cartProduct.productId}">
                <button type="submit" class="remove-btn">Remove</button>
            </form>
        </td>
    </tr>
</c:forEach>

</tbody>

            
  
        </table>
        <div class="order-summary">
            <h2 style="text-align: center;">Order Summary</h2>
            <div class="subtotal">Subtotal: $69.97</div>
            <div class="discount">Discount Given: $0.00</div>
            <div class="grand-total">Total: $69.97</div>
            <form action="<%=request.getContextPath() + PathUtils.ORDER_SERVLET_URL%>" method="post">
            <button type="submit" class="checkout-btn">Proceed to Checkout</button>
            </form>
        </div>
        
    </div>
    
    
    <%-- 
    
     <form action="<%=request.getContextPath() + PathUtils.ORDER_SERVLET_URL%>" method="post">
    <button type="submit">Checkout</button>
</form>  --%>

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
	
    
	<%-- <p>Total Product Quantity: ${cartProductContents.getProductQuantity()}</p>
	<p>Total Price: ${cartContents.getProductTotal()}</p> --%>
	<%-- <p>Total Product Quantity: ${cartProductContents.get(0).getProductQuantity()}</p>
	<p>Total Price: ${cartContents.get(0).getProductTotal()}</p> --%>
</body>
</html>
