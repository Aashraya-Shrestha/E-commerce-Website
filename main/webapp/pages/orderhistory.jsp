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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">
    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
            margin-top:120px;
        }

        .order-history {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .order-history h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        th, td {
            padding: 15px;
            text-align: center; /* Center align all table cells */
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        td {
            color: #666;
        }

        td.order-total {
            font-weight: bold;
            color: #333;
        }

        .order-item-name {
            font-size: 16px;
            color: #333;
            margin: 0;
        }

        .order-item-quantity {
            font-size: 14px;
            color: #666;
            margin: 0;
        }

        .view-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .view-btn:hover {
            background-color: #0056b3;
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
        <div class="order-history">
            <h1>Order History</h1>

            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Placed On</th>
                        <th>Delivery Address</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>123456</td>
                        <td>May 9, 2023</td>
                        <td>
                            <p class="order-item-name">202 Street,Chitwan,Nepal</p>
                        </td>
                        <td>
                            <p class="order-item-quantity">2</p>
                        </td>
                        <td class="order-total"><span>RS.</span>12500</td>
                        <td>
                            <button class="view-btn">View</button>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>123456</td>
                        <td>May 9, 2023</td>
                        <td>
                            <p class="order-item-name">202 Street,Chitwan,Nepal</p>
                        </td>
                        <td>
                            <p class="order-item-quantity">2</p>
                        </td>
                        <td class="order-total"><span>RS.</span>12500</td>
                        <td>
                            <button class="view-btn">View</button>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>123456</td>
                        <td>May 9, 2023</td>
                        <td>
                            <p class="order-item-name">202 Street,Chitwan,Nepal</p>
                        </td>
                        <td>
                            <p class="order-item-quantity">2</p>
                        </td>
                        <td class="order-total"><span>RS.</span>12500</td>
                        <td>
                            <button class="view-btn">View</button>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>123456</td>
                        <td>May 9, 2023</td>
                        <td>
                            <p class="order-item-name">202 Street,Chitwan,Nepal</p>
                        </td>
                        <td>
                            <p class="order-item-quantity">2</p>
                        </td>
                        <td class="order-total"><span>RS.</span>12500</td>
                        <td>
                            <button class="view-btn">View</button>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>123456</td>
                        <td>May 9, 2023</td>
                        <td>
                            <p class="order-item-name">202 Street,Chitwan,Nepal</p>
                        </td>
                        <td>
                            <p class="order-item-quantity">2</p>
                        </td>
                        <td class="order-total"><span>RS.</span>12500</td>
                        <td>
                            <button class="view-btn">View</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <footer>
    <div class="flex-container" style="margin-left:130px">
        <div class="flex-item1">Useful Links</div>
        <div class="flex-item" style="opacity:0.7">Home</div>
        <div class="flex-item" style="opacity:0.7">Product</div>
        <div class="flex-item" style="opacity:0.7">About Us</div>
    </div>
    <div class="flex-container">
        <div class="flex-item1">Other</div>
        <div class="flex-item" style="opacity:0.7">Sign Up</div>
        <div class="flex-item" style="opacity:0.7">Login</div>
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