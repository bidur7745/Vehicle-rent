package com.autorent.controllers;

import com.autorent.model.Vehicle;
import com.autorent.services.VehicleService;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Base64;


@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class VehicleController extends HttpServlet {
    private VehicleService vehicleService;

    @Override
    public void init() throws ServletException {
        vehicleService = new VehicleService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if ("/add".equals(pathInfo)) {
            handleAddVehicle(request, response);
        }
    }

    private void handleAddVehicle(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();

        try {
            // Create Vehicle object from form data
            Vehicle vehicle = new Vehicle();
            vehicle.setName(request.getParameter("name"));
            vehicle.setType(request.getParameter("type"));
            vehicle.setRentPerDay(new BigDecimal(request.getParameter("rent_per_day")).doubleValue());
            vehicle.setAvailabilityStatus(request.getParameter("availability_status"));
            vehicle.setFuelType(request.getParameter("fuel_type"));
            vehicle.setNoOfAirbags(Integer.parseInt(request.getParameter("no_of_airbags")));
            vehicle.setSeatingCapacity(Integer.parseInt(request.getParameter("seating_capacity")));
            vehicle.setVehicleType(request.getParameter("vehicle_type"));
            vehicle.setColor(request.getParameter("color"));

            // Handle image file upload
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileContent = filePart.getInputStream();
                byte[] imageBytes = fileContent.readAllBytes();
                vehicle.setImage(imageBytes);
            }

            // Save vehicle to database
            boolean success = vehicleService.addVehicle(vehicle);

            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Vehicle added successfully");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Failed to add vehicle");
            }

        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error: " + e.getMessage());
        }

        response.getWriter().write(jsonResponse.toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println("VehicleController doGet called");

        // Handle both /admin/vehicles and /admin/vehicles/
        if (pathInfo == null || "/".equals(pathInfo) || "".equals(pathInfo)) {
            // List all vehicles
            request.setAttribute("vehicles", vehicleService.getAllVehicles());
            request.getRequestDispatcher("/WEB-INF/admin/vehicles-management.jsp")
                  .forward(request, response);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.startsWith("/delete/")) {
            int vehicleId = Integer.parseInt(pathInfo.substring("/delete/".length()));
            boolean success = vehicleService.deleteVehicle(vehicleId);
            
            response.setContentType("application/json");
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", success);
            response.getWriter().write(jsonResponse.toString());
        }
    }
} 