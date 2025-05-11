package com.autorent.controllers;

import com.autorent.model.Booking;
import com.autorent.model.User;
import com.autorent.model.Vehicle;
import com.autorent.services.BookingService;
import com.autorent.DAO.VehicleDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "BookingController", urlPatterns = {"/booking/*"})
public class BookingController extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all bookings (admin)
            showBookingsList(request, response);
        } else if (pathInfo.equals("/create")) {
            // Show booking form
            showBookingForm(request, response);
        } else if (pathInfo.equals("/my-bookings")) {
            // Show user's bookings
            showUserBookings(request, response);
        } else if (pathInfo.startsWith("/details/")) {
            // Show booking details
            showBookingDetails(request, response);
        } else if (pathInfo.equals("/calculate-price")) {
            // Calculate price
            calculatePrice(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/create")) {
            // Create new booking
            createBooking(request, response);
        } else if (pathInfo.equals("/cancel")) {
            // Cancel booking
            cancelBooking(request, response);
        } else if (pathInfo.equals("/update-status")) {
            // Update booking status (admin)
            updateBookingStatus(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void showBookingsList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        List<Booking> bookings = bookingService.getAllBookings();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/admin/bookings-list.jsp").forward(request, response);
    }
    
    private void showBookingForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get vehicle ID from query parameter
        String vehicleIdStr = request.getParameter("vehicleId");
        if (vehicleIdStr == null || vehicleIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/vehicles");
            return;
        }
        
        try {
            int vehicleId = Integer.parseInt(vehicleIdStr);
            Vehicle vehicle = vehicleDAO.findById(vehicleId);
            
            if (vehicle == null) {
                response.sendRedirect(request.getContextPath() + "/vehicles");
                return;
            }
            
            request.setAttribute("vehicle", vehicle);
            request.getRequestDispatcher("/WEB-INF/booking/booking-form.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vehicles");
        }
    }
    
    private void showUserBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        List<Booking> bookings = bookingService.getUserBookings(user.getUserId());
        
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/user/my-bookings.jsp").forward(request, response);
    }
    
    private void showBookingDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String bookingIdStr = request.getPathInfo().substring("/details/".length());
        
        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            Booking booking = bookingService.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/booking/my-bookings");
                return;
            }
            
            // Check if the booking belongs to the user or user is admin
            if (booking.getUserId() != user.getUserId() && !"admin".equals(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            
            // Get vehicle details
            try {
                Vehicle vehicle = vehicleDAO.findById(booking.getVehicleId());
                request.setAttribute("vehicle", vehicle);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/booking/booking-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/booking/my-bookings");
        }
    }
    
    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        try {
            // Get form parameters
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String pickupDate = request.getParameter("pickupDate");
            String pickupTime = request.getParameter("pickupTime");
            String dropDate = request.getParameter("dropDate");
            String dropTime = request.getParameter("dropTime");
            
            // Validate inputs
            if (pickupLocation == null || pickupLocation.isEmpty() ||
                dropLocation == null || dropLocation.isEmpty() ||
                pickupDate == null || pickupDate.isEmpty() ||
                pickupTime == null || pickupTime.isEmpty() ||
                dropDate == null || dropDate.isEmpty() ||
                dropTime == null || dropTime.isEmpty()) {
                
                request.setAttribute("error", "All fields are required");
                Vehicle vehicle = vehicleDAO.findById(vehicleId);
                request.setAttribute("vehicle", vehicle);
                request.getRequestDispatcher("/WEB-INF/booking/booking-form.jsp").forward(request, response);
                return;
            }
            
            // Format dates for database
            String startDateTime = pickupDate + " " + pickupTime + ":00";
            String endDateTime = dropDate + " " + dropTime + ":00";
            
            // Calculate total price
            double totalPrice = bookingService.calculateTotalPrice(vehicleId, startDateTime, endDateTime);
            
            // Create booking object
            Booking booking = new Booking();
            booking.setUserId(user.getUserId());
            booking.setVehicleId(vehicleId);
            booking.setStartDateTime(startDateTime);
            booking.setEndDateTime(endDateTime);
            booking.setPickupLocation(pickupLocation);
            booking.setDropLocation(dropLocation);
            booking.setPickupTime(pickupTime);
            booking.setDropTime(dropTime);
            booking.setTotalPrice(totalPrice);
            
            // Save booking
            int bookingId = bookingService.createBooking(booking);
            
            if (bookingId > 0) {
                // Booking successful
                response.sendRedirect(request.getContextPath() + "/booking/details/" + bookingId);
            } else {
                // Booking failed
                request.setAttribute("error", "Vehicle is not available for the selected dates");
                Vehicle vehicle = vehicleDAO.findById(vehicleId);
                request.setAttribute("vehicle", vehicle);
                request.getRequestDispatcher("/WEB-INF/booking/booking-form.jsp").forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vehicles");
        }
    }
    
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            Booking booking = bookingService.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/booking/my-bookings");
                return;
            }
            
            // Check if the booking belongs to the user or user is admin
            if (booking.getUserId() != user.getUserId() && !"admin".equals(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            
            // Cancel booking
            boolean success = bookingService.cancelBooking(bookingId);
            
            if (success) {
                request.setAttribute("message", "Booking cancelled successfully");
            } else {
                request.setAttribute("error", "Failed to cancel booking");
            }
            
            // Redirect based on user role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                response.sendRedirect(request.getContextPath() + "/booking/my-bookings");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/booking/my-bookings");
        }
    }
    
    private void updateBookingStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String status = request.getParameter("status");
            
            if (status == null || status.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/booking");
                return;
            }
            
            boolean success = bookingService.updateBookingStatus(bookingId, status);
            
            if (success) {
                request.setAttribute("message", "Booking status updated successfully");
            } else {
                request.setAttribute("error", "Failed to update booking status");
            }
            
            response.sendRedirect(request.getContextPath() + "/booking");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/booking");
        }
    }
    
    private void calculatePrice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            String startDateTime = request.getParameter("startDateTime");
            String endDateTime = request.getParameter("endDateTime");
            
            if (startDateTime == null || endDateTime == null || startDateTime.isEmpty() || endDateTime.isEmpty()) {
                response.getWriter().write("Invalid dates");
                return;
            }
            
            double totalPrice = bookingService.calculateTotalPrice(vehicleId, startDateTime, endDateTime);
            response.getWriter().write(String.valueOf(totalPrice));
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid vehicle ID");
        }
    }
} 