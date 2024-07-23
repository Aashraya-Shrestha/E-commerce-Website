package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.database.DatabaseController;
import model.CartProductModel;
import model.OrderedProductModel;
import utils.PathUtils;
import utils.StringUtils;

@WebServlet(urlPatterns = PathUtils.ORDER_PRODUCT_SERVLET_URL, asyncSupported = true)
public class OrderedProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;

    public OrderedProductServlet() {
        this.databaseController = new DatabaseController();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve cart id from session or request parameter
        int cartId = Integer.parseInt(request.getParameter("cart_id"));

        // Get cart product contents
        CartProductModel[] cartProductContents = getCartProductModels(cartId);

        // Get the recently created order id
        int orderId = getRecentOrderId();

        // Insert the ordered products into the database
        insertOrderedProducts(orderId, cartProductContents);

        // Redirect to the order confirmation page
        response.sendRedirect(request.getContextPath() + PathUtils.INVOICE_PAGE_URL);
    }

    private CartProductModel[] getCartProductModels(int cartId) {
        CartProductModel[] cartProducts = null;
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.RETRIEVE_CART_PRODUCT_QUERY);
            statement.setInt(1, cartId);
            ResultSet resultSet = statement.executeQuery();

            // Count the number of rows
            int rowCount = 0;
            while (resultSet.next()) {
                rowCount++;
            }

            // Recreate the result set and populate the CartProductModel array
            resultSet = statement.executeQuery();
            cartProducts = new CartProductModel[rowCount];
            int index = 0;
            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                int quantity = resultSet.getInt("product_quantity");
                float total = resultSet.getFloat("product_total");
                cartProducts[index++] = new CartProductModel(cartId, productId, quantity, total);
            }

            // Close resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
        return cartProducts;
    }

    private int getRecentOrderId() {
        int orderId = -1;
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.GET_LATEST_ORDER_ID_QUERY);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                orderId = resultSet.getInt("id");
            }

            // Close resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
        return orderId;
    }

    private void insertOrderedProducts(int orderId, CartProductModel[] cartProducts) {
        try {
            Connection conn = databaseController.getConnection();
            PreparedStatement statement = conn.prepareStatement(StringUtils.INSERT_INTO_ORDERED_PRODUCT_QUERY);

            for (CartProductModel cartProduct : cartProducts) {
                statement.setInt(1, orderId);
                statement.setInt(2, cartProduct.getProductId());
                statement.setInt(3, cartProduct.getProductQuantity());
                statement.setFloat(4, cartProduct.getProductTotal());
                statement.executeUpdate();
            }

            // Close resources
            statement.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
    }
}