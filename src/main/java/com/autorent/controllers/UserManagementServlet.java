package com.autorent.controllers;

import com.autorent.DAO.UserDao;
import com.autorent.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/users/*")
public class UserManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all users
            try {
                List<User> users = UserDao.getAllUsers();
                request.setAttribute("users", users);
                request.getRequestDispatcher("/WEB-INF/admin/users-management.jsp").forward(request, response);
            } catch (SQLException e) {
                request.setAttribute("error", "Error fetching users: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/admin/users-management.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/add")) {
            // Show add user form
            request.getRequestDispatcher("/WEB-INF/admin/users-add.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Show edit user form
            request.getRequestDispatcher("/WEB-INF/admin/users-edit.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Handle user creation
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            
            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setRole(User.Role.user); // All new users are regular users
            user.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()).toString());
            
            try {
                int userId = UserDao.registerUser(user);
                if (userId > 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                } else {
                    request.setAttribute("error", "Failed to create user");
                    request.getRequestDispatcher("/WEB-INF/admin/users-add.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error creating user: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/admin/users-add.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/delete")) {
            // Handle user deletion
            String userId = request.getParameter("id");
            if (userId != null) {
                try {
                    if (UserDao.deleteUser(Integer.parseInt(userId))) {
                        response.sendRedirect(request.getContextPath() + "/admin/users");
                    } else {
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete user");
                    }
                } catch (SQLException e) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting user");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
            }
        }
    }
} 