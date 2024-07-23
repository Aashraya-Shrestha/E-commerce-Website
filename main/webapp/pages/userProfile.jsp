<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="utils.PathUtils" %>
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
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Details</title>
  <link rel="stylesheet" href="<%=contextPath %>/stylesheets/header_footer.css">
  <style>

    *{
        box-sizing:border-box;
        font-family:Arial, Helvetica, sans-serif;
    }
    body {
      font-family: 'Open Sans', sans-serif;
      font-size: 16px;
      color: #525f7f;
      /* background-image: linear-gradient(90deg, rgba(206,247,227,1) 0%, rgba(111,238,237,1) 22%, rgba(92,240,238,1) 29%, rgba(33,235,219,1) 35%, rgba(71,216,217,1) 43%, rgba(54,199,213,1) 57%, rgba(12,188,201,1) 77%, rgba(7,176,210,1) 100%); */
      background-color: white;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 960px;
      margin: 0 auto;
      padding: 0 15px;
      margin-top:120px;
    }

    .profile-card {
      /* background-color: #f9deea; */
      background-color: #f0f0f0;

      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(213, 43, 43, 0.1);
      margin-top: 50px;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      transition: background-color 0.3s; /* Add transition for smoother color change */
    }

    .profile-card.edit-mode {
      background-color: #f0f0f0; /* Change background color in edit mode */
    }

    .profile-card img {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      margin-bottom: 20px;
      border: 4px solid;
      border-color: #f7f7f9;
      box-shadow: 4px 4px 9px rgba(247, 69, 69, 0.5);
    }

    .profile-card h2 {
      font-size: 2em;
      margin-bottom: 10px;
    }

    .profile-card h3 {
      font-size: 1.2em;
      color: #8898aa;
      margin-bottom: 30px;
    }

    .profile-card .form-group {
      margin-bottom: 20px;
      width: calc(50% - 10px);
    }

    .profile-card label {
      font-weight: bold;
    }

    .profile-card input[type="text"],
    .profile-card input[type="email"],
    .profile-card input[type="number"],
    .profile-card input[type="password"] {
      width: 400px;
      padding: 12px;
      border: 1px solid #cad1d7;
      border-radius: 5px;
      box-sizing: border-box;
      background-color: #ffffff;
    }

    .edit-profile-btn {
      background-color: #11cdef;
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 20px;
      text-transform: uppercase;
      font-weight: bold;
      text-decoration: none;
      display: inline-block;
      margin-bottom: 20px;
      transition: background-color 0.3s;
    }

    .edit-profile-btn:hover {
      background-color: #0c8af8;
    }

    /* Change background color of Edit Profile button when in edit mode */
    .profile-card.edit-mode .edit-profile-btn {
      background-color: #ff4d4d; /* Change to red */
    }

    .profile-card .btn-primary {
      background-color: #5e72e4;
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 20px;
      text-transform: uppercase;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s;
      margin-top: 20px;
    }

    .profile-card .btn-primary:hover {
      background-color: #4d51d8;
    }

    .edit-mode .profile-card input[type="text"],
    .edit-mode .profile-card input[type="email"],
    .edit-mode .profile-card input[type="number"],
    .edit-mode .profile-card input[type="password"] {
      pointer-events: auto;
      background-color: #fff;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    /* Additional styles for password change section */
    .change-password {
      margin-top: -10px;
    }

    .change-password a {
      text-decoration: underline;
      color: #5e72e4;
      font-weight: bold;
      transition: color 0.3s;
      border-bottom: 1px solid transparent;
     font-size: 15px;
    }

    .change-password a:hover {
      opacity:0.7;
      color:rgb(158, 57, 57);
    }

    .change-password a::after {
      content: '|';
      margin: 0 10px;
    }

    .change-password-fields {
      display: none;
      margin-top:20px;
      margin-bottom: 20px;
    }

    #old-password{
      margin-bottom:20px;
    }

    #new-password{
        margin-bottom:20px;

    }

    /* Style for the save password button */
    .save-password-btn {
      background-color: #5e72e4;
      color: #fff;
      border: none;
      padding: 15px 30px;
      border-radius: 20px;
      text-transform: uppercase;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s;
      margin-top: 20px;
      display: none; /* Initially hidden */
    }
    .save_changes {
      background-color: #5e72e4;
      color: #fff;
      border: none;
      padding: 15px 30px;
      border-radius: 20px;
      text-transform: uppercase;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s;
      margin-top: 20px;
      
    }

    .save-password-btn:hover {
      background-color: #4d51d8;
    }
    
    .delete-account{
      background-color: #5e72e4;
      color: #fff;
      border: none;
      padding: 15px 30px;
      border-radius: 20px;
      text-transform: uppercase;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s;
      margin-top: 20px;

    }
    
    .delete-account:hover{
    	opacity:0.9;
    	transition:1;
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
	                    <li><a href="<%=request.getContextPath() + PathUtils.REGISTER_PAGE_URL%>" class="nav1"><span>Sign Up</span></a></li>
               		<%} %>
                </div>
                <li><a href="<%=request.getContextPath() + PathUtils.CART_SERVLET_URL%>"><img src="<%= contextPath %>/images/shopping-cart.png" class="navicon1"></a></li>
    
                <!-- <li><a href="#" class="cart_icon"><img src="images/image.png" alt="Cart Icon"></a></li> -->
            </ul>
        </nav>
        </div>



  <!-- Profile Details -->
  <div class="container">
    <div class="profile-card">
      <div>
        <img src="<%= contextPath %>/images/user (1).png" alt="Profile Picture">
        <h2><%= request.getAttribute("firstname") +" "+ request.getAttribute("lastname")%></h2>
        <a href="#" class="edit-profile-btn">Edit Profile</a>
        <h2>Accounts</h2>
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" placeholder="Username" value=<%= request.getAttribute("username") %> readonly>
        </div>
        <!-- Change Password section -->
        <div class="change-password">
          <a href="#" id="change-password-link">Change Password</a>
        </div>
        <div class="form-group change-password-fields">
          <label for="old-password">Previous Password</label>
          <input type="password" id="old-password" placeholder="Old Password" disabled>
          <label for="new-password">New Password</label>
          <input type="password" id="new-password" placeholder="New Password" disabled>
          <label for="confirm-password">Confirm Password</label>
          <input type="password" id="confirm-password" placeholder="Confirm Password" disabled>
        </div>
      </div>
  
      <div>
        <h2>User Information</h2>
       <form action="<%=request.getContextPath() + PathUtils.USER_PROFILE_SERVLET_URL%>" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="username" value="<%= request.getAttribute("username") %>">
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" value="<%= request.getAttribute("email") %>" readonly>
          </div>
          <div class="form-group">
            <label for="first-name">First Name</label>
            <input type="text" id="first-name" placeholder="First Name" name="firstname" value="<%= request.getAttribute("firstname") %>" readonly>
          </div>
          <div class="form-group">
            <label for="last-name">Last Name</label>
            <input type="text" id="last-name" placeholder="Last Name" name="lastname" value="<%= request.getAttribute("lastname") %>" readonly>
          </div>
          <div class="form-group">
            <label for="phone-number">Phone Number</label>
            <input type="text" id="phone-number" placeholder="Phone Number" name="phone_number" value="<%= request.getAttribute("phone_number")%>" readonly>
          </div>
          
          <div>
          <button class="save_changes" type="submit">Save Changes</button>
          </div>
          </form>
          <button class="save_changes" type="submit" style="background-color:red;">Order History</button>
          
          <button class="save-password-btn" id="save-password-btn">Save Password</button>
          
          <form action="<%=request.getContextPath() + PathUtils.USER_PROFILE_SERVLET_URL%>" method="post">
              	<input type="hidden" name="action" value="delete">
              	 <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
          
          <button class="delete-account" type="submit" onclick="return confirm('Are you sure you want to delete your account?')">Delete Account</button>
       </form>
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
	

  <script>
    // Selecting elements
    const editProfileBtn = document.querySelector('.edit-profile-btn');
    const profileForm = document.querySelector('.profile-card form');
    const changePasswordLink = document.getElementById('change-password-link');
    const changePasswordFields = document.querySelector('.change-password-fields');
    const newPasswordField = document.getElementById('new-password');
    const confirmPasswordField = document.getElementById('confirm-password');
    const oldPasswordField = document.getElementById('old-password');
    const savePasswordBtn = document.getElementById('save-password-btn');

    // Function to enable password fields
    function enablePasswordFields() {
      newPasswordField.disabled = false;
      confirmPasswordField.disabled = false;
      oldPasswordField.disabled = false;
    }

    // Enabling password fields initially
    enablePasswordFields();

    // Adding event listener to the "Change Password" link
    changePasswordLink.addEventListener('click', function(e) {
      e.preventDefault();
      if (changePasswordFields.style.display === 'none') {
        changePasswordFields.style.display = 'block';
        savePasswordBtn.style.display = 'inline-block'; // Show Save Password button
      } else {
        changePasswordFields.style.display = 'none';
        savePasswordBtn.style.display = 'none'; // Hide Save Password button
      }
    });

    // Adding event listener to the "Save Password" button
    savePasswordBtn.addEventListener('click', function(e) {
      e.preventDefault();
      // Logic to save the password and then hide the password fields and the "Save Password" button
      changePasswordFields.style.display = 'none';
      savePasswordBtn.style.display = 'none';
    });

 // Adding event listener to the "Edit Profile" button
    editProfileBtn.addEventListener('click', function(e) {
      e.preventDefault();
      if (profileForm.classList.contains('edit-mode')) {
        // If in edit mode, make fields read-only and switch button text to "Cancel"
        const inputs = profileForm.querySelectorAll('input[type="text"], input[type="email"], input[type="number"]');
        inputs.forEach(input => {
          input.readOnly = true;
        });
        editProfileBtn.textContent = "Edit Profile";
        profileForm.classList.remove('edit-mode');

        // Disable password fields
        newPasswordField.disabled = true;
        confirmPasswordField.disabled = true;
        oldPasswordField.disabled = true;

        // Remove edit mode class to revert background color
        document.querySelector('.profile-card').classList.remove('edit-mode');
      } else {
        // If not in edit mode, make fields editable and switch button text to "Cancel"
        const inputs = profileForm.querySelectorAll('input[type="text"], input[type="email"], input[type="number"]');
        inputs.forEach(input => {
          input.readOnly = false;
        });
        editProfileBtn.textContent = "Cancel";
        profileForm.classList.add('edit-mode');

        // Enable password fields
        enablePasswordFields();

        // Add edit mode class to change background color
        document.querySelector('.profile-card').classList.add('edit-mode');
      }
    });

  </script>

</body>
</html>
