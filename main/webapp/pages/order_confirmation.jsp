<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="utils.PathUtils" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">
    
    <!-- Custom CSS -->
    <style>
        * {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            outline: none;
            border: none;
            text-transform: capitalize;
            transition: all .2s linear;
        }
        body {
            background-color: smoke;
        }
        .container {
            display: flex;
            justify-content: center;
            padding: 25px;
            margin-top: 130px;
            padding-right:90px;
            padding-left:100px;
        }
        .container .image-container {
            margin-right: 20px;
            width: 50%;
   
        }
        .container .image-container img {
            max-width: 100%;
            border-radius: 4px;
            height:auto;
            margin-top:0px;
        }
        .container form {
            padding: 20px;
            padding-top:40px;
            padding-bottom:40px;
            width: 50%;
            background-color: antiquewhite;
            box-shadow: 0 5px 10px rgba(0,0,0,.1);
           
        }
        .container form .row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .container form .row .col {
            flex: 1 1 100%;
        }
        .container form .row .col .title {
            font-size: 30px;
            color: #333;
            padding-bottom: 5px;
            text-transform: uppercase;
        }
        .container form .row .col .inputBox {
            margin: 15px 0;
        }
        .container form .row .col .inputBox span {
            margin-bottom: 10px;
            display: block;
        }
        .container form .row .col .inputBox input {
            width: 100%;
            border: 1px solid #ccc;
            padding: 10px 15px;
            font-size: 15px;
            text-transform: none;
        }
        .container form .row .col .inputBox input:focus {
            border: 1px solid #000;
        }
        .container form .row .col .flex {
            display: flex;
            flex-direction: column; /* Changed to column */
            gap: 15px;
        }
        .container form .row .col .flex .inputBox {
            margin-top: 5px;
        }
        .container form .row .col .inputBox img {
            height: 34px;
            margin-top: 5px;
            filter: drop-shadow(0 0 1px #000);
        }
        .container form .submit-btn {
            width: 100%;
            padding: 12px;
            font-size: 17px;
            background: rgb(169, 95, 69);
            color: #fff;
            margin-top: 5px;
            cursor: pointer;
        }
        .container form .submit-btn:hover {
            opacity: 0.9;
            transition: 1;
        }
        
        
        
        .container1 {
            max-width: 100%;
            height: auto;
            margin: 50px auto;
            margin-top:120px;
            padding: 30px;
            background-color:antiquewhite;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-style:solid;
            color:rgb(67, 67, 92);
            font-weight:bolder;
            text-decoration:underline;
            text-align: center;
            margin-bottom: 20px;
        }

        h2 {
            color: #333;
            margin-top: 20px;
            text-align:center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            padding:10px;
        }

        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        button#confirmButton {
            display: block;
            margin: 30px auto 0;
            padding: 10px 20px;
            background-color: #e85d04;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button#confirmButton:hover {
            opacity:0.9;
            transition:1;
        }
        p{
            
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
                <li><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>" class="nav1"><span>Products</span></a></li>
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
<div class="container">
    <div class="image-container">
        <div class="container1" style="margin-top:0px;">
   
    <div class="order-details">
        <h2 style="text-align:left;text-decoration:underline; margin-left:30px;">Your Order Details:</h2>
        <div class="information" style="margin-top:10px; line-height:25px; margin-left:30px">

        <!-- Example information -->
        <p><span style="font-weight:bold;">Order ID:</span> <span>${OrderId}</span></p>
        <p><span style="font-weight:bold;">Order Date:</span> <span> ${OrderContents.orderDate}</span></p>
        <p><span style="font-weight:bold;">Total Price:</span> <span>${OrderContents.totalPrice} </span></p>
        <p><span style="font-weight:bold;">Total Quantity:</span> <span> ${OrderContents.totalQuantity}</span></p>
    </div>
    <h2 style="text-align:left;margin-top:30px; margin-left:30px; margin-bottom: 10px; text-decoration:underline;"> Ordered Products:</h2>
        <table>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total</th>
            </tr>
            <!-- Example order details -->
            <c:forEach var="orderedProduct" items="${OrderProductContents}">
            <tr>
                <td>${orderedProduct.productId}</td>
                <td>${orderedProduct.quantity}</td>
                <td>500</td>
                <td>${orderedProduct.totalPrice}</td>
            </tr>
            </c:forEach>
            
             
            <!-- Add more rows if needed -->
        </table>
        
    </div>
    
</div>
        
       
    </div>
    <form action="<%=request.getContextPath() + PathUtils.DELIVERY_SERVLET_URL%>" method="post">
    
    <div class="row">
            <div class="col">
            <h3 class="title" style="text-align:center; text-decoration:underline;">Order Confirmation</h3>
                <h3 class="title" style="margin-top:10px;  font-size:20px; ">Address:</h3>
             
                <div class="inputBox">
                    <span>Country:</span>
                    <input type="text" placeholder="" name="country" required>
                </div>
                <div class="flex">
                    <div class="inputBox">
                        <span>Province:</span>
                        <input type="text" placeholder="" name="province" required>
                    </div>
                </div>
                
                <div class="inputBox">
                    <span>City:</span>
                    <input type="text" placeholder="" name="city" required>
                </div>
                
                <div class="flex">
                    <div class="inputBox">
                        <span>Steet Address:</span>
                        <input type="text" placeholder="" name="street_address" required>
                        <input type="hidden" name="order_id" value="${OrderId}">
                    </div>
                </div>
            </div>
        </div>
        <input type="submit" value="Confirm Order" class="submit-btn">
        
      
       
        <div class="row">
            <div class="col" style="">
                
                <h2 class="title" style=" font-size:20px; text-align:left;">Payment:</h2>
                <div class="inputBox">
                    <span>Account No:</span>
                    <input type="text" placeholder="Account No" disabled>
                </div>
                <div class="inputBox">
                    <span>Amount:</span>
                    <input type="text" placeholder="Amount" disabled>
                </div>
                <input type="submit" value="Pay" class="submit-btn" disabled>
            </div>

        </div>
        
    </form>
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
