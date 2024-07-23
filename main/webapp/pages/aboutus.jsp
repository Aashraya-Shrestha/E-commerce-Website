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
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>About Us</title>
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
      background:url("../images/blue.jpg");
    }

      .container {
        /* background-image: url("images/background.jpeg"); */
        background-size: cover;
        background-size: 300vh;
        background-repeat: no-repeat;
         margin-top: 4rem;
        width: 100%;
        height: 100%;
        font-family: sans-serif;
      }

      /* Form Styles/Contact us Section */
      .form-container {
        display: flex;
        width:90%;
        justify-content: center;
        margin-left:100px;
        
        /* margin-top:150px; */
      }

      .form {
    background-color: antiquewhite;
    box-sizing: border-box;
    border: 1px solid rgb(235, 227, 227);
    border-radius: 3rem;
    padding: 1rem;
    width: 70%;
    min-height: 100%;
    margin-top: 6rem;
   margin-bottom: 6rem;
   
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Adjust values as needed */
}

      .form-data {
        margin-bottom: 2.5rem;
        margin-left: 5rem;
        margin-right: 5rem;
      }

      .form label {
        font-size: 0.7cm;
        font-weight: 500;
        color: #090b09;
      }

      .form input[type="text"],
      .form textarea {
        display: flex;
        box-sizing: border-box;
        justify-content: flex-end;
        width: 100%;
        border: 1px solid;
        border-radius: 0.375rem;
        border-color: #b2b5b9;
        background-color: #ffffff;
        border-radius: 0.5rem;
        padding: 1.1rem;
        font-size: 1.4rem;
        margin-top: 0.5rem;
        margin-bottom: 1.5rem;
      }

      .form button {
        color: #ffffff;
        background-color: #ff8c00;
        /* background-color: rgb(128, 93, 80); */
        border: none;
        font-size: 1.4rem;
        border-radius: 1.8rem;
        width: 40%;
        padding: 1.2rem;
        display: block;
        margin: 0 auto;
      }

      .form button:hover {
        opacity:0.9;
        transition:1;
      }

      .form-info {
        text-align: center;
      }

      .form-info h1 {
        font-size: 2.5rem;
        margin-bottom: 1rem;
        color: #090b09;
      }
    </style>
  </head>

  <!-- <div class="">
    <span class="">&nbsp;📍</span>
    <p class="">Pokhara 13, Gandaki, Nepal</p>
</div>
<div class="">
    <span class="">&nbsp;📞</span>
    <p class="">9843291155</p>
</div>
<div class="">
    <span class="">&nbsp;✉️</span>
    <p class="">contact@us.com</p>
</div> -->

  <body>
  
  <div>
        <nav class="navbar">
            <div>
                <img src="<%= contextPath %>/images/scam1.png" alt="Logo" class="logo">
            </div>
            <ul class="nav-links">
                <li><a href="<%=request.getContextPath() + PathUtils.HOME_PAGE_URL%>" class="nav1"><span>Home</span></a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>" class="nav1" ><span>Products</span></a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.ABOUT_US_PAGE_URL%>" class="nav1" style="color: #e85d04;"><span>About Us</span></a></li>
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
   
    
    
      <div class="form-container">
        <div class="form">
          <div class="form-info">
            <h1>Connect with us</h1>
          </div>
          <div class="form-data">
            <label for="full_name" class="">Full name</label>
            <input
              type="text"
              id="full_name"
              name="full_name"
              placeholder="Enter your full name"
            />
          </div>
          <div class="form-data">
            <label for="email" class="">Email</label>
            <input
              type="text"
              id="email"
              name="email"
              placeholder="example@gmail.com"
            />
          </div>
          <div class="form-data">
            <label for="phone" class="">Phone number</label>
            <input
              type="text"
              id="phone"
              name="phone"
              placeholder="Enter your contact number"
            />
          </div>
          <div class="form-data">
            <label for="message" class="">Message</label>
            <textarea
              id="message"
              name="message"
              rows="6"
              placeholder="Your message here ......."
            ></textarea>
          </div>
          <div class="">
            <button type="submit">Contact</button>
          </div>
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
