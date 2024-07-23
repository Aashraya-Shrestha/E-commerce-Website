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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">
<style>

.PoweredBy {
    text-align: center;
    font-size: 30px;
    color: blue;
}


    *{
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }
    body {
      background-color: white;
      margin: 0;
      padding: 0;
    }

    .container {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      padding: 20px;
      margin-top: 100px;
      margin-bottom: 50px;
    }

    .form-container {
      background-color: #f5f5f5;
      background-color: antiquewhite;
      width: 50%;
      padding: 40px;
      padding-left:70px;
      padding-right:70px;
      border: none;
      box-shadow: none;
      border-radius: 0;
      margin-right:90px;
    }

    h1 {
      text-align: center;
      color:rgb(95, 95, 156);
      margin-bottom: 40px;
    }

    label {
      color: #333;
      margin-bottom: 10px;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="tel"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: none;
      border-radius: 4px;
      background-color: #fff;
      margin-top:10px;
    }

    button {
      width: 100%;
      padding: 10px;
      background-color: #ff8c00;
      color: #fff;
      border: none;
      border-radius: 4px;
      margin-top:20px;
      cursor: pointer;
    }

    button:hover {
      background-color: rgb(196, 128, 3);
    }

    .login-link {
      text-align: center;
      margin-top: 20px;
    }

    .login-link a {
      color: rgb(72, 72, 187);
      text-decoration: none;
    }

    .login-link a:hover {
      text-decoration: underline;
    }

    .image-container {
    margin-right: 20px;
    width: 50%;
}

.image-container img {
    max-width: 100%;
    height: auto;
    border-radius: 4px;
}

.form-container {
    background-color: #f5f5f5;
    background-color: antiquewhite;
    width: 50%;
    padding: 40px;
    padding-left:70px;
    padding-right:70px;
    border: none;
    box-shadow: none;
    border-radius: 0;
    margin-right:90px;
}

.image-container img {
    max-height: 1500px; /* Increase the maximum height of the left image */
}

    .password-container {
      position: relative;
    }

    .toggle-password {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
    }
  </style>
</head>

<body>
	<%-- <div class="container">
		<h1>Registration Form</h1>
		<form action="<%= contextPath + PathUtils.REGISTER_SERVLET_URL %>"
			method="post">
			<div class="row">
				<div class="col">
					<label for="firstname">First Name:</label> <input type="text"
						id="firstname" name="firstname" required>
				</div>
				<div class="col">
					<label for="lastname">Last Name:</label> <input type="text"
						id="lastname" name="lastname" required>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="username">Username:</label> <input type="text"
						id="username" name="username" required>
				</div>
			</div>
			
			<div class="col">
				<label for="email">Email:</label> <input type="email" id="email"
					name="email" required>
			</div>
		
			<div class="row">
				<div class="col">
					<label for="phone_number">Phone Number:</label> <input type="tel"
						id="phone_number" name="phone_number" required>
				</div>

			</div>
			<div class="row">
				<div class="col">
					<label for="password">Password:</label> <input type="password"
						id="password" name="password" required>
				</div>
				<div class="col">
					<label for="retypePassword">Retype Password:</label> <input
						type="password" id="retypePassword" name="retypePassword" required>
				</div>
			</div>
			<button type="submit">Submit</button>
		</form>
	</div>
	--%>
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
                    	<li><a href="<%=contextPath %>/logout" class="nav1"><span>Log Out</span></a></li>
                    <%} else {%>
                    	<li>
                        <a href="<%=request.getContextPath() + PathUtils.LOGIN_PAGE_URL%>">
                            <img src="<%= contextPath %>/images/user.png" class="navicon">
                            <span style="margin-left:10px;">Login</span>
                        </a>
                    	</li>

	                    <li class="seperation">|</li>
	                    <li><a href="<%=request.getContextPath() + PathUtils.REGISTER_PAGE_URL%>" class="nav1" style="color: #e85d04;"><span>Sign Up</span></a></li>
               		<%} %>
                </div>
                <li><a href="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>"><img src="<%= contextPath %>/images/shopping-cart.png" class="navicon1"></a></li>

            </ul>
        </nav>
       </div>
    
	
	
	<div class="container">
    <div class="image-container">
      <img src="<%= contextPath %>/images/loginphoto.jpg" alt="Image">
    </div>
    <div class="form-container">
     <form action="<%= contextPath + PathUtils.REGISTER_SERVLET_URL %>"
			method="post">
        <h1>Sign Up</h1>
        <label for="firstname">First Name</label>
        <input type="text" id="firstname" name="firstname" required>
        
        <label for="lastname">Last Name</label>
        <input type="text" id="lastname" name="lastname" required>

        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>

        <label for="phonenumber">Phone Number</label>
        <input type="tel" id="phonenumber" name="phone_number" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
        
        <label for="password">Password</label>
        <div class="password-container">
          <input type="password" id="password" name="password" required>
          <!-- <span class="toggle-password" onclick="togglePasswordVisibility('password')">&#128065;</span> -->
        </div>

        <label for="confirm_password">Confirm Password</label>
        <div class="password-container">
          <input type="password" id="confirm_password" name="retypePassword" required>
          <!-- <span class="toggle-password" onclick="togglePasswordVisibility('confirm_password')">&#128065;</span> -->
        </div>

        

        
        
        <button type="submit">Sign Up</button>
        
        <div class="login-link">
          <p>Already have an account? <a href="#" style="color: rgb(72, 72, 187);">Login</a></p>
        </div>
      </form>
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