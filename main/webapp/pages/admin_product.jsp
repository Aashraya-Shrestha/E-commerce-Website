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
    <title>Admin Product Page</title>
    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/admin.css" />
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

      .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.2);
        padding-top: 60px;
        box-shadow: 2px 20px 35px rgba(0, 0, 0, 0.1);
      }

      .modal-content {
        background-color: #9bdded;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #074b59;
        width: 80%; 
      }

      .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
      }

      .close:hover,
      .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        font-weight: bold;
      }

      .form-control {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
      }

      .form-control:disabled {
        background-color: #f2f2f2;
      }

      .text-danger {
        color: #dc3545;
      }

      .btn {
        cursor: pointer;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        color: #fff;
      }

      .btn-primary {
        background-color: #ea8847;
        border: 1px solid #ef986c;
        color: #ffffff;
      }

      .btn-success {
        background-color: #28a745;
      }

      .btn-danger {
        background: transparent;
        border: 1px solid #ef986c;
        color: #ea8847;
      }
    </style>

    <link rel="stylesheet" href="<%= contextPath %>/stylesheets/admin.css" />
  </head>

  <body>
    <div class="container">
      <div class="sidebar">
        <ul>
          <li>
            <a href="<%=request.getContextPath() + PathUtils.ADMIN_DASHBOARD_SERVLET_URL%>" class="brand">
              <img src="<%= contextPath %>/images/logo.png" />
              <span class="nav-item">Admin</span>
            </a>
          </li>
          <li>
            <a href="<%=request.getContextPath() + PathUtils.ADMIN_DASHBOARD_SERVLET_URL%>" class="nav-link">
              <img src="<%= contextPath %>/images/dashboard.png" alt="Dashboard" />
              <span class="nav-item">Dashboard</span>
            </a>
          </li>
          <li>
            <a href="<%=request.getContextPath() + PathUtils.ADMIN_PRODUCT_SERVLET_URL%>" class="nav-link" style="background: #57606f;">
              <img src="<%= contextPath %>/images/product.png" alt="Product" />
              <span class="nav-item">Product</span>
            </a>
          </li>
          
          <li>
            <a href="#" class="nav-link logout">
              <img src="<%= contextPath %>/images/logout.png" alt="Logout" />
              <span class="nav-item">Logout</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="container-table">
        <section class="category-section">
          <div class="main-top">
            <h1>All Products</h1>
            <img class="main-image" src="<%= contextPath %>/images/products.png" />
          </div>

          
          
           <form action="<%=request.getContextPath() + PathUtils.ADMIN_PRODUCT_SERVLET_URL%>" method="post">
    	<input type="hidden" name="action" value="POST">
        <button class="btn btn-primary add_product" type="submit">Add new Product +</button>
    </form>
          

          <!-- product form start here -->
          
          <!-- product form end -->

          <table>
            <tr>
              <th>ID</th>
              <th>Thumbnail</th>
              <th>Product Name</th>
              <th>Category Name</th>
              <th>Price</th>
              <th>Stock Quantity</th>
              <th>Edit</th>
              <th>Delete</th>
            </tr>
            
            <c:forEach items="${productlist}" var="product">
            
            <tr>
              <td>1</td>
              <td>
               <%-- <img
                  height="70px"
                  src="${product.imageUrl}"
                  alt="Product Thumbnail"
                />--%> 
              </td>
              <td>
                <p class="prodcut_title mb-0 font-weight-bold">${product.name}</p>
                
              </td>
              <td>${product.categoryId}</td>
              <td>$${product.price}</td>
              <td>${product.stockQuantity}</td>
              <td>
              
              <form action="<%=request.getContextPath() + PathUtils.UPDATE_PRODUCT_SERVLET_URL%>" method="get">
              <input type="hidden" name="action" value="PUT">
              <input type="hidden" name="product_id" value="${product.id}">
              
                <button class="btn btn-primary edit-product" type="submit">Edit</button>
                </form>
              </td>
              <td>
              <form action="<%=request.getContextPath() + PathUtils.ADMIN_PRODUCT_SERVLET_URL%>" method="post">
              <input type="hidden" name="action" value="DELETE">
                            <input type="hidden" name="product_id" value="${product.id}">
                <button
                  class="btn btn-danger delete-product"
                  type="submit"
                >
                  Delete
                </button>
                </form>
              </td>
            </tr>
            
            </c:forEach>

            
          </table>
        </section>
      </div>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const addProductButton = document.querySelector(".add_product");
        const productModal = document.getElementById("productModal");
        const closeButton = document.querySelector(".close");
        const saveButton = document.querySelector(".btn.btn-primary.save");
        const table = document.querySelector("table");

        addProductButton.addEventListener("click", function () {
          productModal.style.display = "block";
          document.getElementById("product_form").reset(); // Reset form fields
          document.getElementById("form_type").value = "add"; // Set form type to add
        });

        closeButton.addEventListener("click", function () {
          productModal.style.display = "none";
        });

        saveButton.addEventListener("click", function () {
          const productForm = document.getElementById("product_form");
          const formType = document.getElementById("form_type").value;
          let newRow;

          if (formType === "edit") {
            // If form type is edit, get the edited row
            newRow = table.querySelector(`tr[data-edit-row="true"]`);
          } else {
            // Clone an existing row
            newRow = table.rows[table.rows.length - 1].cloneNode(true);
            // Increment the ID in the first cell
            const id = parseInt(table.rows[table.rows.length - 1].cells[0].innerText) + 1;
            newRow.cells[0].innerText = id;
          }

          // Update or set row data with form data
          newRow.cells[2].querySelector(".prodcut_title").innerText = productForm.elements["product_title"].value;
          newRow.cells[3].innerText = productForm.elements["category_name"].value;
          newRow.cells[4].innerText = productForm.elements["price"].value;
          newRow.cells[5].innerText = productForm.elements["stock_quantity"].value;

          // Add or remove data-edit-row attribute based on form type
          if (formType === "edit") {
            newRow.removeAttribute("data-edit-row");
          } else {
            newRow.setAttribute("data-edit-row", "true");
          }

          // Append the new or edited row to the table
          if (formType === "edit") {
            productModal.style.display = "none"; // Close the modal only if it's an edit operation
          } else {
            table.appendChild(newRow);
            productForm.reset(); // Reset form fields after adding a new product
          }
        });

        const productTable = document.getElementById("productTable");

        // Edit product
        productTable.addEventListener("click", function (event) {
          if (event.target.classList.contains("edit-product")) {
            const row = event.target.closest("tr");
            const productName = row.querySelector(".prodcut_title").innerText;
            const categoryName = row.cells[3].innerText;
            const price = row.cells[4].innerText;
            const stockQuantity = row.cells[5].innerText;

            // Populate modal fields with row data
            document.getElementById("prodcuct_title").value = productName;
            document.getElementById("category_name").value = categoryName;
            document.getElementById("price").value = price;
            document.getElementById("stock_quantity").value = stockQuantity;

            // Set form type to edit
            document.getElementById("form_type").value = "edit";
            // Show modal
            productModal.style.display = "block";
          }
        });

        // Delete product
        productTable.addEventListener("click", function (event) {
          if (event.target.classList.contains("delete-product")) {
            const row = event.target.closest("tr");
            const productId = row.querySelector("td:first-child").innerText;
            if (confirm("Are you sure you want to delete this product?")) {
              // You can write your code here to delete the product with the productId
              console.log("Delete product with ID:", productId);
              // After deletion, remove the row from the table
              row.remove();
            }
          }
        });
      });
    </script>
  </body>
</html>
