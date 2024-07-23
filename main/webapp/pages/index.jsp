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
    <title>Home Page</title>
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/header_footer.css">
    <style>
    
    
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background-color: #D9FDFF/6*6;
            font-family:Arial, sans-serif;
        }

        .background-color {
            height: calc(100vh - 80px);
            /* height:700px; */
            background-color: rgb(140, 150, 139);
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            margin-top: 90px;
            padding-left: 30px;
        }

        .slideshow-container {
            position: relative;
            height: 100%;
            width: 50%;
        }

        .slideshow-image {
            height: 90%;
            width: 90%;
            position: absolute;
            padding-top: 100px;
            margin-left: 20px;
            top: 0;
            left: 0;
            opacity: 0;
            transition: opacity 0.8s ease-in-out;
        }

        .slideshow-image.active {
            opacity: 1;
        }

        .content-right {
            background-color: rgb(130, 144, 126);
            padding: 30px;
            padding-right:100px;
            padding-top:100px;
            border-width: 0;
            text-align: center;
            width: 50%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            height: 100%;
        
        }

        .content-right h2 {
            color: rgb(102 74 126);
            font-size: 50px;
            margin-bottom: 20px;
            text-transform: uppercase;
            font-weight: bold;
            line-height:70px;
        }

        .content-right p {
            color: #666;
            font-size: 24px;
            margin: 0;
        }

        .content-right .btn {
            display: inline-block;
            background-color: #e85d04;
            color: #fff;
            padding: 15px 30px;
            font-size: 30px;
            text-decoration: none;
            border-radius: 50px;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        .content-right .btn:hover {
            background-color: #d34d00;
            transform: scale(1.05);
        }

        .flexbox-container2 {
            display: flex;
            justify-content: space-between;
            padding: 0 100px;
        }

        .flex-item2 {
            flex: 1;
            padding: 20px;
            background-color: #f2f2f2;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: all 0.3s ease;
            position: relative;
            /* cursor: pointer; */
        }

        .flex-item2:not(:last-child) {
            margin-right: 20px;
        }

        .flex-item2 img {
            width: 100px;
            height: auto;
        }

        .fast-delivery {
            color: rgb(100, 100, 169);
            font-weight: bold;
            font-size: 20px;
            text-align: center;
            margin-bottom: 5px;
            line-height: 1.5;
        }

        .fast-delivery-description {
            text-align: center;
            line-height: 1.7;
            color: rgb(88, 71, 104);
            font-style: solid;
        }

        .choosingUs {
            color: rgb(100, 100, 169);
            text-align: center;
            font-style: solid;
            font-weight: bold;
            font-size: 40px;
            margin-top: 50px;
        }

        .supported{
            color: rgb(100, 100, 169);
            text-align: center;
            font-style: solid;
            font-weight: bold;
            font-size: 37px;
            margin-top: 50px;
        }

        .company-logo-container {
    flex: 1;
    padding: 20px;
    padding-left: 100px;
    padding-right:100px;
    background-color: #f2f2f2;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-around; /* Adjust the spacing between items */
    width: 100%; /* Set width to 100% */
    position: relative;
    /* cursor: pointer; */
}

        .company-logo {
    width: 150px; /* Change this value to adjust the size of the logos */
    margin: 0 20px;
    transition: all 0.3s ease;
}



        .company-logo:hover {
            transform: scale(1.1);
            filter: drop-shadow(0px 5px 5px rgba(0, 0, 0, 0.3));
        }

        /* Hover effect */
        .flex-item2:hover {
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: box-shadow 0.3s, transform 0.3s;
            transform: translateY(-5px); 
            overflow: hidden;
        }


        /* Search Bar Styles */
.search-form {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 20px;
}

.search-form input[type="text"] {
    padding: 10px;
    width: 70%;
    border: 1px solid #ccc;
    height:40px;
    border-radius: 5px 0 0px 5px;

    /* border-radius: 5px; */
    /* border-top-right-radius: none; */
    /* border-top-left-radius:none; */
}

.search-form button {
    background-color: #e85d04;
    color: #fff;
    border: none;
    padding: 10px 15px; /* Adjusted padding */
    border-radius: 0 5px 5px 0;
    cursor: pointer;
    transition: background-color 0.3s;
    height: 40px; /* Set the height of the search button */

}





.search-form button img {
    width: 20px; /* Adjusted size for the search icon */
    height: 20px; /* Adjusted size for the search icon */
}


.search-form button:hover {
    background-color: #d34d00;
}

/* Adjusted styles for the second paragraph */
.second-paragraph {
    color: #555; /* Adjust color as needed */
    font-size: 18px; /* Adjust font size as needed */
    line-height: 1.6; /* Increased line height */
    padding: 10px; /* Increased padding */
}

/* Contact Us Section Styles */
.contact-us {
    margin-top: 40px; /* Increased margin for separation */
}

.contact-us p {
    margin-bottom: 10px;
    font-weight: bold;
    font-size: 20px; /* Increased font size */
    color: #333; /* Adjust color as needed */
}

.social-icons a {
    display: inline-block;
    margin-right: 20px; /* Adjust spacing between icons */
    transition: transform 0.3s ease; /* Smooth transition */
}

.social-icons a:last-child {
    margin-right: 0; /* Remove margin for the last icon */
}

.social-icons img {
    width: 40px; /* Increased size for icons */
}

.social-icons a:hover img {
    transform: translateY(-3px); /* Translate upward on hover */
    transition: transform 0.3s ease; /* Smooth transition */
}

/* Shop Now Button Styles */
.search-button {
    background-color: #e85d04;
    color: #fff;
    border: none;
    padding: 15px 30px; /* Adjusted padding */
    font-size: 24px; /* Adjusted font size */
    border-radius: 50px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-top: 5px;
}

.search-button:hover {
    background-color: #d34d00;
    transform: scale(1.05);
}






    </style>


    <%-- <h1>This is Home Page.</h1>
    <nav>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>">Product</a></li>
            <li><a href="userProfile.jsp">User Profile</a></li>
            <li><a href="about_us.jsp">About Us</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="signup.jsp">Signup</a></li>
            <li><a href="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>">Cart</a></li>
        </ul>
    </nav> --%>
    
    <div>
        <nav class="navbar">
            <div>
                <img src="<%= contextPath %>/images/scam1.png" alt="Logo" class="logo">
            </div>
            <ul class="nav-links">
                <li><a href="<%=request.getContextPath() + PathUtils.HOME_PAGE_URL%>" class="nav1" style="color: #e85d04;"><span>Home</span></a></li>
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
    
    
    
    
    <div class="background-color">
            <div class="slideshow-container">
                <img class="slideshow-image active" src="<%= contextPath %>/images/monitor_1-removebg.png" alt="Slide 1">
                <img class="slideshow-image" src="<%= contextPath %>/images/Pc 4.png" alt="Slide 2">
                
            </div>

            <div class="content-right">
                <h2>Discover the Latest Technology</h2>
                <div style="margin-bottom: 20px;">
                    <p style="line-height:50px">Explore a world of possibilities with our latest collection of laptops, desktops, and accessories.</p>
                    
                </div>
                <!-- Search Bar -->
                <a href="<%=request.getContextPath() + PathUtils.PRODUCT_SERVLET_URL%>">
                <button class="search-button">
                Shop Now
            </button></a>
                <!-- Contact Us Section -->
                <div class="contact-us">
                    <p>Contact Us:</p>
                    <div class="social-icons">
                        <a href="#"><img src="<%= contextPath %>/images/facebook.png" alt="Facebook"></a>
                        <a href="#"><img src="<%= contextPath %>/images/instagram.png" alt="Instagram"></a>
                        <a href="#"><img src="<%= contextPath %>/images/linkedin.png" alt="LinkedIn"></a>
                    </div>
                </div>
            </div>
            


            
        </div>

        <p class="choosingUs">Why to choose us?</p>

        <div class="flexbox-container2">
            <div class="flex-item2">
                <img src="<%= contextPath %>/images/fast-delivery.png" alt="Fast Delivery Logo">
                <p class="fast-delivery">Fast Delivery</p>
                <p class="fast-delivery-description">Explore our wide range, delivered fast to you! Start shopping hassle-free!</p>
            </div>
            <div class="flex-item2">
                <img src="<%= contextPath %>/images/badge.png" alt="Quality Logo">
                <p class="fast-delivery">Quality Products</p>
                <p class="fast-delivery-description">Discover premium picks, tailored to you! Elevate your style effortlessly!</p>
            </div>
            <div class="flex-item2">
                <img src="<%= contextPath %>/images/help-desk.png" alt="Customer Support Logo">
                <p class="fast-delivery">24/7 Support</p>
                <p class="fast-delivery-description">Get expert help anytime you need! We've got you covered!</p>
            </div>
        </div>

        <p class="supported">Supported By</p>

        <div class="company-logo-container">
            <img src="<%= contextPath %>/images/asus (1).png" alt="Company Logo 1" class="company-logo">
            <img src="<%= contextPath %>/images/dell.png" alt="Company Logo 2" class="company-logo" style="height:100px;">
            <img src="<%= contextPath %>/images/hp.png" alt="Company Logo 3" class="company-logo" style="height:70px;">
            <img src="<%= contextPath %>/images/acer.png" alt="Company Logo 3" class="company-logo">
            <img src="<%= contextPath %>/images/lenovo.png" alt="Company Logo 3" class="company-logo">
            
                        

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
        <div class="flex-item" style="opacity:0.7"><a href="<%=request.getContextPath() + PathUtils.LOGIN_PAGE_URL%>" style="color:inherit;">>Login</a></div>
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

    <script>
        var images = document.querySelectorAll('.slideshow-image');
        var index = 0;

        function changeImage() {
            images[index].classList.remove('active');
            index = (index + 1) % images.length;
            images[index].classList.add('active');
        }

        setInterval(changeImage, 3000); // Change slide every 3 seconds
    </script>
    
</body>
</html>

			

    

