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
<title>Insert title here</title>
<link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">

<style>


    * {
      box-sizing:border-box;
      font-family:Arial, Helvetica, sans-serif;
    }
    body {
      background-color: white;
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    .container {
      display: flex;
      justify-content: flex-start;
      align-items: center;
      margin-top: 90px; /* Added margin-top for the container */
      margin-left: 50px; 
    }

    .form-container {
      background-color: antiquewhite;
      width: 50%;
      padding: 40px;
      padding-left:70px;
      padding-right:70px;
      border: none;
      box-shadow: none;
      border-radius: 0;
      margin-bottom: 20px;
      margin-top: 20px; /* Added margin-top for the form */
      margin-left:50px;
    }

    h1 {
      text-align: center;
      color:rgb(95, 95, 156);
      margin-bottom: 40px;
    }

    label {
      color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="tel"] { /* Added input type for phone number */
      width: 100%;
      padding: 10px;
      margin-bottom: 20px; /* Updated margin-bottom value for text fields */
      border: none;
      border-radius: 4px;
      background-color: #fff;
      position: relative; /* Added */
      margin-top:10px;
    }

    .password-container {
      position: relative;
    }

    input[type="password"] {
      padding-right: 40px;
    }

    .toggle-password {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
    }

    button {
      width: 100%;
      padding: 10px;
      background-color: #ff8c00; /* Updated background color to orange */
      color: #fff; /* Updated font color to white */
      border: none;
      border-radius: 4px;
      margin-top:20px;
      cursor: pointer;
    }

    button:hover {
      background-color: rgb(196, 128, 3); /* Darker shade of orange on hover */
    }

    .login-link {
      text-align: center;
      margin-top: 20px; /* Added margin-top for the login link */
    }

    .login-link a {
      color: rgb(72, 72, 187); /* Updated link color to blue */
      text-decoration: none;
    }

    .login-link a:hover {
      text-decoration: underline;
    }

    .image-container {
      margin-left: 20px;
      width:50%;
    }

    .image-container img {
      max-width: 100%;
      height: auto;
      border-radius: 4px; /* Add border radius for image */
      max-height: 600px; /* Set a maximum height for the image */
    }
  </style>
</head>
<body>
	<%-- <div class="login-box">
		<h2>Login</h2>
		<form action="<%=contextPath + PathUtils.LOGIN_SERVLET_URL%>"
			method="post">
			<div class="row">
				<div class="col">
					<label for="username">Username:</label> <input type="text"
						id="username" name="username" required>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="password">Password:</label> <input type="password"
						id="password" name="password" required>
				</div>
			</div>
			<button type="submit" class="login-button">Login</button>
		</form>
	</div> --%>
	
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
	                            <span style="margin-left:10px; color: #e85d04;">My Profile</span>
                        	</a>
                    	</li>
                    	<li class="seperation">|</li>
                    	<li><a href="<%=contextPath %>/logout" class="nav1" style="color: #e85d04;"><span>Log Out</span></a></li>
                    <%} else {%>
                    	<li>
                        <a href="<%=request.getContextPath() + PathUtils.LOGIN_PAGE_URL%>">
                            <img src="<%= contextPath %>/images/user.png" class="navicon">
                            <span style="margin-left:10px; color: #e85d04;">Login</span>
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
    <div class="form-container">
      <form action="<%=contextPath + PathUtils.LOGIN_SERVLET_URL%>"
			method="post">
        <h1>Login</h1>
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>
        
        <label for="password">Password</label>
        <div class="password-container">
          <input type="password" id="password" name="password" required>
        </div>
        
        <button type="submit">Login</button>
        
        <div class="login-link">
          <p>Don't have an account? <a href="#" style="color: rgb(72, 72, 187);">Sign Up</a></p>
        </div>
      </form>
    </div>
    <div class="image-container">
      <img src="<%= contextPath %>/images/loginphoto.jpg" alt="Image">
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