package com.autorent.controllers;

import com.autorent.DAO.UserDao;
import com.autorent.services.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")  // Simplified URL pattern
public class DashboardServlet extends HttpServlet {
    
    private VehicleService vehicleService;
    
    @Override
    public void init() throws ServletException {
        vehicleService = new VehicleService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DashboardServlet: Received request");  // Debug log
        
        try {
            // Get total vehicles count
            int totalVehicles = vehicleService.getVehicleCount();
            System.out.println("Total vehicles: " + totalVehicles);
            
            // Get total users count
            int totalUsers = UserDao.countAllUsers();
            System.out.println("Total users: " + totalUsers);
            
            // Set attributes for the dashboard
            request.setAttribute("totalVehicles", totalVehicles);
            request.setAttribute("totalUsers", totalUsers);
            
            // We don't have booking functionality yet, so keeping these as 0
            request.setAttribute("activeBookings", 0);
            request.setAttribute("totalRevenue", 0);
            
            String jspPath = "/WEB-INF/admin/dashboard.jsp";
            System.out.println("DashboardServlet: Forwarding to " + jspPath);  // Debug log
            
            request.getRequestDispatcher(jspPath).forward(request, response);
            System.out.println("DashboardServlet: Forward successful");  // Debug log
        } catch (SQLException e) {
            System.out.println("DashboardServlet Error: " + e.getMessage());  // Debug log
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard data");
        } catch (Exception e) {
            System.out.println("DashboardServlet Error: " + e.getMessage());  // Debug log
            e.printStackTrace();
            throw e;
        }
    }
}
