package com.autorent.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/bookings/*")
public class BookingManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all bookings
            request.getRequestDispatcher("/WEB-INF/admin/bookings-management.jsp").forward(request, response);
        } else if (pathInfo.equals("/create")) {
            // Show create booking form
            request.getRequestDispatcher("/WEB-INF/admin/bookings-create.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // Show booking details
            request.getRequestDispatcher("/WEB-INF/admin/bookings-view.jsp").forward(request, response);
        }
    }
} 