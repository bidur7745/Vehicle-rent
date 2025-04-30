package com.autorent.controllers;

import com.autorent.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "UserBookingsServlet", value = "/user/bookings")
public class UserBookingsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        // TODO: Fetch user's bookings from database
        // List<Booking> bookings = BookingService.getUserBookings(user.getUserId());
        // request.setAttribute("bookings", bookings);
        
        request.getRequestDispatcher("/WEB-INF/user/my-bookings.jsp").forward(request, response);
    }
} 