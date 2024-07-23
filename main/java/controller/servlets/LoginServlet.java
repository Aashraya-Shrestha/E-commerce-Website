package controller.servlets;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.database.DatabaseController;
import model.LoginModel;
import utils.MessageUtils;
import utils.StringUtils;
import utils.PathUtils;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = PathUtils.LOGIN_SERVLET_URL, asyncSupported = true)
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DatabaseController databaseController;

    public LoginServlet() {
        this.databaseController = new DatabaseController();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter(StringUtils.USERNAME);
        String password = request.getParameter(StringUtils.PASSWORD);

        LoginModel loginModel = new LoginModel(username, password);
        int login = getUserLogin(loginModel);

        if (login == 1) {
            if (isAdmin(username)) {
                // Redirect admin to the dashboard page
                HttpSession userSession = request.getSession();
                userSession.setAttribute(StringUtils.USERNAME, username);
                userSession.setMaxInactiveInterval(30 * 60);

                Cookie userCookie = new Cookie(StringUtils.PRIVILEGED_USER, username);
                userCookie.setMaxAge(30 * 60);
                response.addCookie(userCookie);

                request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.LOGIN_SUCCESS);
                response.sendRedirect(request.getContextPath() + PathUtils.ADMIN_DASHBOARD_SERVLET_URL);
            } else {
                // Redirect user to the home page
                HttpSession userSession = request.getSession();
                userSession.setAttribute(StringUtils.USERNAME, username);
                userSession.setMaxInactiveInterval(30 * 60);

                Cookie userCookie = new Cookie(StringUtils.USER, username);
                userCookie.setMaxAge(30 * 60);
                response.addCookie(userCookie);

                request.setAttribute(MessageUtils.SUCCESS_MESSAGE, MessageUtils.LOGIN_SUCCESS);
                response.sendRedirect(request.getContextPath() + PathUtils.HOME_PAGE_URL);
            }
        } else if (login == 0) {
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.USERNAME_PASSWORD_MISMATCH);
            request.setAttribute(StringUtils.USERNAME, username);
            request.getRequestDispatcher(PathUtils.LOGIN_PAGE_URL).forward(request, response);
        } else if (login == -1) {
            request.setAttribute(MessageUtils.FAILED_MESSAGE, MessageUtils.INCORRECT_USERNAME);
            request.setAttribute(StringUtils.USERNAME, username);
            request.getRequestDispatcher(PathUtils.LOGIN_PAGE_URL).forward(request, response);
        } else {
            request.setAttribute(MessageUtils.ERROR_MESSAGE, MessageUtils.SERVER_ERROR);
            request.getRequestDispatcher(PathUtils.LOGIN_PAGE_URL).forward(request, response);
        }
    }

    public int getUserLogin(LoginModel loginModel) {
        try {
            // Check if the username matches the admin pattern
            if (isAdmin(loginModel.getUsername())) {
                // Prepare a statement to check the admin user in the privilegedUser table
                PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.VERIFY_ADMIN_QUERY);
                statement.setString(1, loginModel.getUsername());
                ResultSet result = statement.executeQuery();

                if (result.next()) {
                    String user = result.getString(StringUtils.USERNAME);
                    String userPassword = result.getString(StringUtils.PASSWORD);

                    if (user.equals(loginModel.getUsername()) && userPassword.equals(loginModel.getPassword())) {
                        return 1; // login successful
                    } else {
                        return 0; // Username and password did not match
                    }
                } else {
                    return -1; // Username not found in the system
                }
            } else {
                // Prepare a statement to check the regular user in the user table
                PreparedStatement statement = databaseController.getConnection().prepareStatement(StringUtils.VERIFY_USER_QUERY);
                statement.setString(1, loginModel.getUsername());
                ResultSet result = statement.executeQuery();

                if (result.next()) {
                    String user = result.getString(StringUtils.USERNAME);
                    String userPassword = result.getString(StringUtils.PASSWORD);

                    if (user.equals(loginModel.getUsername()) && userPassword.equals(loginModel.getPassword())) {
                        return 1; // login successful
                    } else {
                        return 0; // Username and password did not match
                    }
                } else {
                    return -1; // Username not found in the system
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            return -2; // internal server error
        }
    }

    private boolean isAdmin(String username) {
        // Check if the username matches the admin pattern
        return username.startsWith("@");
    }
}