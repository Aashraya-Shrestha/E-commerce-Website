<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.PathUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Admin Product Page</title>
    <style>
      .add_product {
        margin-bottom: 20px;
      }

      .category-section {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 20px 35px rgba(0, 0, 0, 0.1);
      }

      .container-table {
        display: flex;
        padding: 10px;
        margin: 10px auto;
        background: #fff;
        border-radius: 10px;
        box-shadow: 4px 20px 35px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .table {
        border-collapse: collapse;
        margin: 25px 0;
        font-size: 15px;
        min-width: 30%;
        overflow: hidden;
        border-radius: 5px 5px 0 0;
      }

      table th,
      table td {
        padding: 12px 44px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }

      table th {
        color: #fff;
        background: rgb(95, 195, 221);
        text-align: left;
        font-weight: bold;
      }

      .pending {
        color: orange;
      }

      .completed {
        color: green;
      }

      .ongoing {
        color: blue;
      }

      .filter-btn {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: rgb(95, 195, 221);
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

    .table button {
    padding: 6px 20px;
    border-radius: 10px;
    cursor: pointer;
    background: transparent;
    border: 1px solid #ef986c;
    color: #ea8847;
  }
  
  .table button:hover {
    background: #4ad489;
    color: #fff;
    transition: 0.5rem;
  }
    </style>

    <link rel="stylesheet" href="../stylesheets/admin.css" />
  </head>

  <body>
    <div class="container">
      <div class="sidebar">
        <ul>
          <li>
            <a href=""<%=request.getContextPath() + PathUtils.DASHBOARD_PAGE_URL%>"" class="brand">
              <img src="../images/logo.png" />
              <span class="nav-item">Admin</span>
            </a>
          </li>
          <li>
            <a href="<%=request.getContextPath() + PathUtils.DASHBOARD_PAGE_URL%>" class="nav-link">
              <img src="../images/dashboard.png" alt="Dashboard" />
              <span class="nav-item">Dashboard</span>
            </a>
          </li>
          <li>
            <a href="<%=request.getContextPath() + PathUtils.ADMIN_PRODUCT_PAGE_URL%>"  class="nav-link">
              <img src="../images/product.png" alt="Product" />
              <span class="nav-item">Product</span>
            </a>
          </li>
          <li>
            <a href="#" class="nav-link">
              <img src="../images/order.png" alt="Order" />
              <span class="nav-item">Order</span>
            </a>
          </li>

          <li>
            <a href="#" class="nav-link logout">
              <img src="../images/logout.png" alt="Logout" />
              <span class="nav-item">Logout</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="container-table">
        <section class="category-section">
          <div class="main-top">
            <h1>All Orders</h1>
            <img class="main-image" src="../images/orders.png" />
          </div>

          <button class="filter-btn" onclick="filterOrders('all')">
            All Orders
          </button>
          <button class="filter-btn" onclick="filterOrders('pending')">
            Pending Orders
          </button>
          <button class="filter-btn" onclick="filterOrders('completed')">
            Completed Orders
          </button>
          <button class="filter-btn" onclick="filterOrders('ongoing')">
            Ongoing Orders
          </button>

          <table class="table" id="orderTable">
            <tr>
              <th>Order ID</th>
              <th>Customer Name</th>
              <th>Contact Number</th>
              <th>Product Quantity</th>
              <th>Billing Price</th>
              <th>Location</th>
              <th>Ordered date </th>
              <th>Order Status</th>
              <th>Order Details</th>
            </tr>
            <tr class="pending">
              <td class="customer_id">1</td>
              <td class="customer-details">
                <p class="customer_name">Susan Pokharel</p>
                <small class="customer_email">susan@gmail.com</small>
              </td>
              <td class="customer_number">9840338600</td>
              <td class="product_quantity">20</td>
              <td class="order_price">Rs. 20,000</td>
              <td class="delivery_location">
                <p class="City">Kathmandu , Nepal</p>
                <small class="Street_adderess">lolangheight, balaju</small>
              </td>
              <td class=" ordered-date">01-04-2024</td>
              <td class="status">Pending</td>
              <td><button>View</button></td>
            </tr>

            <tr class="completed">
              <td class="customer_id">2</td>
              <td class="customer-details">
                <p class="customer_name">Nishan Pokharel</p>
                <small class="customer_email">nishan@gmail.com</small>
              </td>
              <td class="customer_number">9840000000</td>
              <td class="product_quantity">20</td>
              <td class="order_price">Rs. 50,000</td>
              <td class="delivery_location">
                <p class="City">Kathmandu , Nepal</p>
                <small class="Street_adderess">lolangheight, balaju</small>
              </td>
              <td class=" ordered-date">01-04-2024</td>
              <td class="status">Completed</td>
              <td><button>View</button></td>
            </tr>

            <tr class="ongoing">
              <td class="customer_id">3</td>
              <td class="customer-details">
                <p class="customer_name">Ramesh Shrestha</p>
                <small class="customer_email">ramesh@gmail.com</small>
              </td>
              <td class="customer_number">9840112233</td>
              <td class="product_quantity">15</td>
              <td class="order_price">Rs. 30,000</td>
              <td class="delivery_location">
                <p class="City">Bhaktapur , Nepal</p>
                <small class="Street_adderess">Kamalbinayak</small>
              </td>
              <td class=" ordered-date">01-04-2024</td>
              <td class="status">Ongoing</td>
              <td><button>View</button></td>
            </tr>
          </table>
        </section>
      </div>
    </div>

    <script>
      function filterOrders(status) {
        const rows = document.querySelectorAll(
          "#orderTable tr:not(:first-child)"
        );
        if (status === "all") {
          rows.forEach((row) => {
            row.style.display = "table-row";
          });
        } else {
          rows.forEach((row) => {
            const rowStatus = row
              .querySelector(".status")
              .innerText.toLowerCase();
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
