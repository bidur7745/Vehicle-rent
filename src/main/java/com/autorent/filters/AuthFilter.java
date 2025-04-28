package com.autorent.filters;

import com.autorent.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        String uri = req.getRequestURI();

        if(uri.endsWith("/login.jsp") || uri.endsWith("/register.jsp") || uri.endsWith("/") || uri.endsWith("/LoginServlet") || uri.endsWith("/RegisterServlet") )  {
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        // Allow unauthenticated access to static resources
        if (uri.contains("/assets/") || uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/") || uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg") || uri.endsWith(".webp")) {
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        HttpSession session = req.getSession(false);

        if(session==null){
            resp.sendRedirect(req.getContextPath()+"/login.jsp");
        }


        assert session != null;
        User.Role role = (User.Role) session.getAttribute("role");

        if(role.equals(User.Role.admin)) {
            resp.sendRedirect(req.getContextPath()+"/admin/admin-dashboard");
        }

        filterChain.doFilter(servletRequest,servletResponse);

    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
