<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/admin.css" />

    <style>
        /* CSS styles go here */
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <ul>
                <li><a href="<%=request.getContextPath() + PathUtils.ADMIN_DASHBOARD_SERVLET_URL%>" class="brand">
                    <img src="<%= contextPath %>/images/logo.png">
                    <span class="nav-item">Admin</span>
                </a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.ADMIN_DASHBOARD_SERVLET_URL%>" class="nav-link"> 
                    <img src="<%= contextPath %>/images/dashboard.png" alt="Dashboard">
                    <span class="nav-item">Dashboard</span>
                </a></li>
                <li><a href="<%=request.getContextPath() + PathUtils.ADMIN_PRODUCT_SERVLET_URL%>" class="nav-link">
                    <img src="<%= contextPath %>/images/product.png" alt="Product">
                    <span class="nav-item">Product</span>
                </a></li>
                <li><a href="#" class="nav-link logout">
                    <img src="<%= contextPath %>/images/logout.png" alt="Logout">
                    <span class="nav-item">Logout</span>
                </a></li>
            </ul>
        </div>

        <section class="main">
            <div class="main-top">
                <h1>Dashboard</h1>
                <img class="main-image" src="<%= contextPath %>/images/dashboard.png">
            </div>
            <div class="items">
                <div class="card">
                    <img src="<%= contextPath %>/images/users.png">
                    <h4>Total Users</h4>
                    <h4 style="margin-top:10px;font-weight:bold;">${totalUsers}</h4>
                </div>
                <div class="card">
                    <img src="<%= contextPath %>/images/products.png">
                    <h4>Total Products</h4>
                    <h4 style="margin-top:10px;font-weight:bold;">${totalProducts}</h4>
                </div>
                <div class="card">
                    <img src="<%= contextPath %>/images/sales.png">
                    <h4>Total Sales</h4>
                    <h4 style="margin-top:10px;font-weight:bold;">${totalSales}</h4>
                </div>
                <div class="card">
                    <img src="<%= contextPath %>/images/orders.png">
                    <h4>Total Orders</h4>
                    <h4 style="margin-top:10px;font-weight:bold;">${totalOrders}</h4>
                </div>
            </div>

            <table class="table" id="orderTable">
                <tr>
                    <th style="background-color:rgb(95, 195, 221)">Order ID</th>
                    <th style="background-color:rgb(95, 195, 221)">Username</th>
                    <th style="background-color:rgb(95, 195, 221)">Contact Number</th>
                    <th style="background-color:rgb(95, 195, 221)">Product Quantity</th>
                    <th style="background-color:rgb(95, 195, 221)">Billing Price</th>
                    <th style="background-color:rgb(95, 195, 221)">Ordered Date </th>
                    <th style="background-color:rgb(95, 195, 221)">Order Status</th>
                    <th style="background-color:rgb(95, 195, 221)">Order Details</th>
                </tr>
                <c:forEach items="${OrderContents}" var="order">
                    <tr class="pending">
                        <td class="customer_id">${order.orderId}</td>
                        <td class="customer-details">
                            <p class="customer_name">${order.customerName }</p>
                        </td>
                        <td class="customer_number">${order.customerContact}</td>
                        <td class="product_quantity">${order.totalQuantity}</td>
                        <td class="order_price">${order.totalPrice}</td>
                        <td class=" ordered-date">${order.orderDate}</td>
                        <td class="status">${order.status}</td>
                        <td><button>View</button></td>
                    </tr>
                </c:forEach>
            </table>
        </section>
    </div>

    <script>
        function filterOrders(status) {
            const rows = document.querySelectorAll("#orderTable tr:not(:first-child)");
            if (status === "all") {
                rows.forEach((row) => {
                    row.style.display = "table-row";
                });
            } else {
                rows.forEach((row) => {
                    const rowStatus = row.querySelector(".status").innerText.toLowerCase();
                    if (rowStatus === status.toLowerCase()) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                });
            }
        }
    </script>
</body>
</html>