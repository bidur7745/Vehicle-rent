package com.autorent.controllers;

import com.autorent.DAO.UserDao;
import com.autorent.services.VehicleService;
import com.autorent.services.BookingService;
import com.autorent.model.Booking;
import com.autorent.model.User;
import com.autorent.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/dashboard")  // Simplified URL pattern
public class DashboardServlet extends HttpServlet {
    
    private VehicleService vehicleService;
    private BookingService bookingService;
    
    @Override
    public void init() throws ServletException {
        vehicleService = new VehicleService();
        bookingService = new BookingService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DashboardServlet: Received request");  // Debug log
        
        try {
            // Get total vehicles count
            int totalVehicles = vehicleService.getVehicleCount();
            System.out.println("Total vehicles: " + totalVehicles);
            
            // Get total users count
            int totalUsers = 0;
            try {
                totalUsers = UserDao.countAllUsers();
            } catch (SQLException e) {
                System.err.println("Error counting users: " + e.getMessage());
            }
            System.out.println("Total users: " + totalUsers);
            
            // Get all bookings
            List<Booking> allBookings = bookingService.getAllBookings();
            
            // Get all user IDs from bookings
            List<Integer> userIds = allBookings.stream()
                .map(Booking::getUserId)
                .distinct()
                .collect(Collectors.toList());
            
            // Get all vehicle IDs from bookings
            List<Integer> vehicleIds = allBookings.stream()
                .map(Booking::getVehicleId)
                .distinct()
                .collect(Collectors.toList());
            
            // Get user details for all bookings
            Map<Integer, User> userMap = userIds.stream()
                .collect(Collectors.toMap(
                    userId -> userId,
                    userId -> {
                        try {
                            return UserDao.getUserById(userId);
                        } catch (RuntimeException e) {
                            System.err.println("Error getting user by ID " + userId + ": " + e.getMessage());
                            return null;
                        }
                    }
                ));
            
            // Get vehicle details for all bookings
            Map<Integer, Vehicle> vehicleMap = vehicleIds.stream()
                .collect(Collectors.toMap(
                    vehicleId -> vehicleId,
                    vehicleService::getVehicleById
                ));
            
            // Calculate total revenue from completed bookings
            double totalRevenue = allBookings.stream()
                .filter(booking -> "completed".equals(booking.getStatus()))
                .mapToDouble(Booking::getTotalPrice)
                .sum();
            
            // Get active bookings count
            long activeBookings = allBookings.stream()
                .filter(booking -> "active".equals(booking.getStatus()))
                .count();
            
            // Get latest 2 bookings with user and vehicle details
            List<Booking> recentBookings = allBookings.stream()
                .limit(2)
                .peek(booking -> {
                    // Set user name
                    User user = userMap.get(booking.getUserId());
                    if (user != null) {
                        booking.setUserName(user.getFirstName() + " " + user.getLastName());
                    } else {
                        booking.setUserName("User not found");
                    }
                    
                    // Set vehicle name
                    Vehicle vehicle = vehicleMap.get(booking.getVehicleId());
                    if (vehicle != null) {
                        booking.setVehicleName(vehicle.getName());
                    } else {
                        booking.setVehicleName("Vehicle not found");
                    }
                })
                .collect(Collectors.toList());
            
            // Set attributes for the dashboard
            request.setAttribute("totalVehicles", totalVehicles);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("activeBookings", activeBookings);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("recentBookings", recentBookings);
            
            String jspPath = "/WEB-INF/admin/dashboard.jsp";
            System.out.println("DashboardServlet: Forwarding to " + jspPath);  // Debug log
            
            request.getRequestDispatcher(jspPath).forward(request, response);
            System.out.println("DashboardServlet: Forward successful");  // Debug log
        } catch (Exception e) {
            System.out.println("DashboardServlet Error: " + e.getMessage());  // Debug log
            e.printStackTrace();
            throw e;
        }
    }
}
