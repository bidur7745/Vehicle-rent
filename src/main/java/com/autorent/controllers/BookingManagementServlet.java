package com.autorent.controllers;

import com.autorent.model.Booking;
import com.autorent.model.User;
import com.autorent.model.Vehicle;
import com.autorent.services.BookingService;
import com.autorent.services.VehicleService;
import com.autorent.services.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/bookings/*")
public class BookingManagementServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    private final VehicleService vehicleService = new VehicleService();
    
    @Override
    public void init() throws ServletException {
        System.out.println("BookingManagementServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Admin authentication is now handled by AdminAuthFilter
        System.out.println("BookingManagementServlet: doGet called - " + request.getRequestURI());
        
        String pathInfo = request.getPathInfo();
        System.out.println("BookingManagementServlet: pathInfo = " + pathInfo);
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all bookings
                System.out.println("BookingManagementServlet: Getting all bookings");
                List<Booking> bookings = bookingService.getAllBookings();
                System.out.println("BookingManagementServlet: Found " + bookings.size() + " bookings");
                
                // Set bookings as request attribute and forward to JSP
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/WEB-INF/admin/bookings-management.jsp").forward(request, response);
            } else if (pathInfo.equals("/view")) {
                // Show booking details
                String bookingIdStr = request.getParameter("id");
                String format = request.getParameter("format"); // Check if JSON format requested
                
                if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
                    try {
                        int bookingId = Integer.parseInt(bookingIdStr);
                        Booking booking = bookingService.getBookingById(bookingId);
                        
                        if (booking != null) {
                            // Check if JSON format is requested
                            if ("json".equals(format)) {
                                // Return booking details as JSON
                                response.setContentType("application/json");
                                response.setCharacterEncoding("UTF-8");
                                
                                PrintWriter out = response.getWriter();
                                
                                // Escape any special characters in string values
                                String pickupLocation = escapeJsonString(booking.getPickupLocation());
                                String dropLocation = booking.getDropLocation() != null ? escapeJsonString(booking.getDropLocation()) : "";
                                String pickupTime = booking.getPickupTime() != null ? escapeJsonString(booking.getPickupTime()) : "";
                                String dropTime = booking.getDropTime() != null ? escapeJsonString(booking.getDropTime()) : "";
                                String status = escapeJsonString(booking.getStatus());
                                String startDateTime = escapeJsonString(booking.getStartDateTime());
                                String endDateTime = escapeJsonString(booking.getEndDateTime());
                                String createdAt = escapeJsonString(booking.getCreatedAt());
                                
                                // Build simple JSON (no external library needed)
                                StringBuilder json = new StringBuilder();
                                json.append("{");
                                json.append("\"bookingId\":").append(booking.getBookingId()).append(",");
                                json.append("\"userId\":").append(booking.getUserId()).append(",");
                                json.append("\"vehicleId\":").append(booking.getVehicleId()).append(",");
                                json.append("\"startDateTime\":\"").append(startDateTime).append("\",");
                                json.append("\"endDateTime\":\"").append(endDateTime).append("\",");
                                json.append("\"pickupLocation\":\"").append(pickupLocation).append("\",");
                                json.append("\"dropLocation\":\"").append(dropLocation).append("\",");
                                json.append("\"pickupTime\":\"").append(pickupTime).append("\",");
                                json.append("\"dropTime\":\"").append(dropTime).append("\",");
                                json.append("\"totalPrice\":").append(booking.getTotalPrice()).append(",");
                                json.append("\"status\":\"").append(status).append("\",");
                                json.append("\"createdAt\":\"").append(createdAt).append("\"");
                                json.append("}");
                                
                                String jsonString = json.toString();
                                System.out.println("BookingManagementServlet: JSON response: " + jsonString);
                                
                                out.print(jsonString);
                                out.flush();
                                return;
                            } else if ("component".equals(format)) {
                                // Return only the booking details component for AJAX
                                request.setAttribute("booking", booking);
                                request.getRequestDispatcher("/WEB-INF/admin/components/booking-details.jsp").forward(request, response);
                                return;
                            } else {
                                // Regular view - forward to JSP
                                request.setAttribute("booking", booking);
                                request.getRequestDispatcher("/WEB-INF/admin/bookings-view.jsp").forward(request, response);
                                return;
                            }
                        }
                    } catch (NumberFormatException e) {
                        // Invalid booking ID
                        if ("json".equals(format)) {
                            response.setContentType("application/json");
                            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                            response.getWriter().print("{\"error\":\"Invalid booking ID\"}");
                            return;
                        } else if ("component".equals(format)) {
                            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                            response.getWriter().print("<div class='error-message'>Invalid booking ID</div>");
                            return;
                        }
                    }
                }
                
                // If we get here, there was an error
                if ("json".equals(format)) {
                    response.setContentType("application/json");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().print("{\"error\":\"Booking not found\"}");
                } else if ("component".equals(format)) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().print("<div class='error-message'>Booking not found</div>");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/bookings");
                }
            } else if (pathInfo.equals("/cancel")) {
                // Cancel booking
                String bookingIdStr = request.getParameter("id");
                if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
                    try {
                        int bookingId = Integer.parseInt(bookingIdStr);
                        boolean success = bookingService.cancelBooking(bookingId);
                        
                        if (success) {
                            request.getSession().setAttribute("message", "Booking cancelled successfully");
                        } else {
                            request.getSession().setAttribute("error", "Failed to cancel booking");
                        }
                    } catch (NumberFormatException e) {
                        request.getSession().setAttribute("error", "Invalid booking ID");
                    }
                }
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
            } else if (pathInfo.equals("/delete")) {
                // Delete booking
                System.out.println("BookingManagementServlet: Processing delete request");
                String bookingIdStr = request.getParameter("id");
                System.out.println("BookingManagementServlet: Delete request for booking ID: " + bookingIdStr);
                
                if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
                    try {
                        int bookingId = Integer.parseInt(bookingIdStr);
                        System.out.println("BookingManagementServlet: Calling bookingService.deleteBooking(" + bookingId + ")");
                        
                        // First check if booking exists and if it's cancelled
                        Booking booking = bookingService.getBookingById(bookingId);
                        if (booking == null) {
                            System.out.println("BookingManagementServlet: Booking with ID " + bookingId + " not found");
                            request.getSession().setAttribute("error", "Booking not found");
                            response.sendRedirect(request.getContextPath() + "/admin/bookings");
                            return;
                        }
                        
                        System.out.println("BookingManagementServlet: Booking status is " + booking.getStatus());
                        if (!"cancelled".equals(booking.getStatus())) {
                            System.out.println("BookingManagementServlet: Cannot delete booking with status " + booking.getStatus());
                            request.getSession().setAttribute("error", "Only cancelled bookings can be deleted. Current status: " + booking.getStatus());
                            response.sendRedirect(request.getContextPath() + "/admin/bookings");
                            return;
                        }
                        
                        boolean success = bookingService.deleteBooking(bookingId);
                        System.out.println("BookingManagementServlet: Delete operation returned " + success);
                        
                        if (success) {
                            request.getSession().setAttribute("message", "Booking deleted successfully");
                        } else {
                            request.getSession().setAttribute("error", "Failed to delete booking. Database operation failed.");
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("BookingManagementServlet: Invalid booking ID format: " + bookingIdStr);
                        request.getSession().setAttribute("error", "Invalid booking ID format");
                    }
                } else {
                    System.out.println("BookingManagementServlet: No booking ID provided for delete operation");
                    request.getSession().setAttribute("error", "No booking ID provided");
                }
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
            } else if (pathInfo.equals("/refresh-statuses")) {
                // Refresh all booking statuses based on current date
                System.out.println("BookingManagementServlet: Processing refresh-statuses request");
                
                int updatedCount = bookingService.updateAllBookingStatuses();
                System.out.println("BookingManagementServlet: Updated " + updatedCount + " booking statuses");
                
                if (updatedCount > 0) {
                    request.getSession().setAttribute("message", "Updated status for " + updatedCount + " bookings based on current date");
                } else {
                    request.getSession().setAttribute("message", "No booking statuses needed to be updated");
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
            }
        } catch (Exception e) {
            System.err.println("BookingManagementServlet ERROR: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/error/500.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Admin authentication is now handled by AdminAuthFilter
        System.out.println("BookingManagementServlet: doPost called");
        
        // Handle booking status update
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String bookingIdStr = request.getParameter("bookingId");
            String status = request.getParameter("status");
            
            if (bookingIdStr != null && !bookingIdStr.isEmpty() && status != null && !status.isEmpty()) {
                try {
                    int bookingId = Integer.parseInt(bookingIdStr);
                    boolean success = bookingService.updateBookingStatus(bookingId, status);
                    
                    if (success) {
                        request.setAttribute("message", "Booking status updated successfully");
                    } else {
                        request.setAttribute("error", "Failed to update booking status");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid booking ID");
                }
            } else {
                request.setAttribute("error", "Missing parameters");
            }
        }
        
        // Redirect back to booking list
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }

    /**
     * Escapes special characters in a string for JSON output
     */
    private String escapeJsonString(String input) {
        if (input == null) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);
            switch (ch) {
                case '"':
                    sb.append("\\\"");
                    break;
                case '\\':
                    sb.append("\\\\");
                    break;
                case '\b':
                    sb.append("\\b");
                    break;
                case '\f':
                    sb.append("\\f");
                    break;
                case '\n':
                    sb.append("\\n");
                    break;
                case '\r':
                    sb.append("\\r");
                    break;
                case '\t':
                    sb.append("\\t");
                    break;
                default:
                    // Check for other control characters
                    if (ch < ' ') {
                        String hex = Integer.toHexString(ch);
                        sb.append("\\u");
                        for (int j = 0; j < 4 - hex.length(); j++) {
                            sb.append('0');
                        }
                        sb.append(hex);
                    } else {
                        sb.append(ch);
                    }
            }
        }
        return sb.toString();
    }
} 