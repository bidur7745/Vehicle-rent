package com.autorent.filters;

import com.autorent.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter to secure admin routes
 * This filter ensures that only users with admin role can access admin pages
 */
@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminAuthFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        System.out.println("AdminAuthFilter: Filtering request to " + httpRequest.getRequestURI());
        
        // Get the current session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("AdminAuthFilter: No session or user, redirecting to login");
            // Not logged in, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get the user from session
        User user = (User) session.getAttribute("user");
        System.out.println("AdminAuthFilter: User role is " + user.getRole());
        
        // Check if user has admin role
        if (user.getRole() == User.Role.admin) {
            // User is an admin, continue with the request
            System.out.println("AdminAuthFilter: User is admin, continuing request");
            chain.doFilter(request, response);
        } else {
            // Not an admin, send forbidden error
            System.out.println("AdminAuthFilter: User is not admin, sending forbidden");
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to access this resource");
        }
    }

    @Override
    public void destroy() {
        System.out.println("AdminAuthFilter destroyed");
    }
} 