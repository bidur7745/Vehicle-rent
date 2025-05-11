package com.autorent.controllers;

import com.autorent.model.Booking;
import com.autorent.model.User;
import com.autorent.services.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserBookingsServlet", value = "/user/bookings")
public class UserBookingsServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // Handle booking cancellation
        String action = request.getParameter("action");
        if ("cancel".equals(action)) {
            String bookingIdStr = request.getParameter("bookingId");
            
            if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
                try {
                    int bookingId = Integer.parseInt(bookingIdStr);
                    
                    // Verify that the booking belongs to the user
                    Booking booking = bookingService.getBookingById(bookingId);
                    if (booking != null && booking.getUserId() == user.getUserId()) {
                        boolean success = bookingService.cancelBooking(bookingId);
                        
                        if (success) {
                            request.setAttribute("message", "Booking cancelled successfully");
                        } else {
                            request.setAttribute("error", "Failed to cancel booking");
                        }
                    } else {
                        request.setAttribute("error", "Invalid booking");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid booking ID");
                }
            }
        }
        
        // Redirect back to bookings page
        response.sendRedirect(request.getContextPath() + "/user/bookings");
    }
} 