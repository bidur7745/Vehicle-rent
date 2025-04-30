package com.autorent.filters;

import com.autorent.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthFilter implements Filter {
    
    // List of paths that don't require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/login.jsp",
        "/register.jsp",
        "/",
        "/index.jsp",
        "/about.jsp",
        "/vehicles.jsp",
        "/contact.jsp",
        "/LoginServlet",
        "/RegisterServlet",
        "/logout"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Allow access to public paths
        if (isPublicPath(path)) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        // Allow access to static resources
        if (isStaticResource(path)) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        HttpSession session = req.getSession(false);
        
        // Check if user is not logged in
        if (session == null || session.getAttribute("user") == null) {
            // If AJAX request, send 401 status
            if ("XMLHttpRequest".equals(req.getHeader("X-Requested-With"))) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            // For regular requests, redirect to login
            resp.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // User is logged in, check role-based access
        User.Role role = (User.Role) session.getAttribute("role");
        
        // Handle null role
        if (role == null) {
            session.invalidate();
            resp.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // Check admin access
        if (path.startsWith("/admin/") && !role.equals(User.Role.admin)) {
            resp.sendRedirect(contextPath + "/index.jsp");
            return;
        }

        // If all checks pass, continue with the request
        filterChain.doFilter(servletRequest, servletResponse);
    }

    private boolean isPublicPath(String path) {
        return PUBLIC_PATHS.stream().anyMatch(path::endsWith);
    }

    private boolean isStaticResource(String path) {
        return path.contains("/assets/") || 
               path.contains("/css/") || 
               path.contains("/js/") || 
               path.contains("/images/") || 
               path.endsWith(".css") || 
               path.endsWith(".js") || 
               path.endsWith(".png") || 
               path.endsWith(".jpg") || 
               path.endsWith(".jpeg") || 
               path.endsWith(".webp");
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
