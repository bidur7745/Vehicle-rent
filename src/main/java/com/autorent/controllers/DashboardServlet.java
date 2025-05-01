package com.autorent.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")  // Simplified URL pattern
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DashboardServlet: Received request");  // Debug log
        
        // Add some basic attributes for testing
        request.setAttribute("totalVehicles", 0);
        request.setAttribute("activeBookings", 0);
        request.setAttribute("totalUsers", 0);
        request.setAttribute("totalRevenue", 0);
        
        String jspPath = "/WEB-INF/admin/dashboard.jsp";
        System.out.println("DashboardServlet: Forwarding to " + jspPath);  // Debug log
        
        try {
            request.getRequestDispatcher(jspPath).forward(request, response);
            System.out.println("DashboardServlet: Forward successful");  // Debug log
        } catch (Exception e) {
            System.out.println("DashboardServlet Error: " + e.getMessage());  // Debug log
            e.printStackTrace();
            throw e;
        }
    }
}
