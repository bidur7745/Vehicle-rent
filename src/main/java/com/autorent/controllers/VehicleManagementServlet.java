package com.autorent.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/vehicles/*")
public class VehicleManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all vehicles
            request.getRequestDispatcher("/WEB-INF/admin/vehicles-management.jsp").forward(request, response);
        } else if (pathInfo.equals("/add")) {
            // Show add vehicle form
            request.getRequestDispatcher("/WEB-INF/admin/vehicles-add.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Show edit vehicle form
            request.getRequestDispatcher("/WEB-INF/admin/vehicles-edit.jsp").forward(request, response);
        }
    }
} 