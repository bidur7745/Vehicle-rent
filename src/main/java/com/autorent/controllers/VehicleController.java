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

@WebServlet("/admin/vehicles/*")
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
        } else if ("/edit".equals(pathInfo)) {
            handleEditVehicle(request, response);
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

    private void handleEditVehicle(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();

        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            Vehicle vehicle = new Vehicle();
            vehicle.setVehicleId(vehicleId);
            vehicle.setName(request.getParameter("name"));
            vehicle.setType(request.getParameter("type"));
            vehicle.setRentPerDay(new BigDecimal(request.getParameter("rent_per_day")).doubleValue());
            vehicle.setAvailabilityStatus(request.getParameter("availability_status"));
            vehicle.setFuelType(request.getParameter("fuel_type"));
            vehicle.setNoOfAirbags(Integer.parseInt(request.getParameter("no_of_airbags")));
            vehicle.setSeatingCapacity(Integer.parseInt(request.getParameter("seating_capacity")));
            vehicle.setVehicleType(request.getParameter("vehicle_type"));
            vehicle.setColor(request.getParameter("color"));

            // Handle image file upload if provided
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileContent = filePart.getInputStream();
                byte[] imageBytes = fileContent.readAllBytes();
                vehicle.setImage(imageBytes);
            }

            boolean success = vehicleService.updateVehicle(vehicle);

            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Vehicle updated successfully");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Failed to update vehicle");
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
        System.out.println("GET request received");
        System.out.println("PathInfo: " + pathInfo);
        System.out.println("QueryString: " + request.getQueryString());
        System.out.println("Request URI: " + request.getRequestURI());

        try {
            // Handle root vehicle management page
            if (pathInfo == null || "/".equals(pathInfo)) {
                System.out.println("Handling list vehicles request");
                handleListVehicles(request, response);
            } 
            // Handle get vehicle for editing with ID in path
            else if (pathInfo.matches("/edit/\\d+")) {
                System.out.println("Handling edit vehicle request with ID in path");
                // Extract ID from path - format is /edit/{id}
                String idStr = pathInfo.substring("/edit/".length());
                int vehicleId = Integer.parseInt(idStr);
                handleGetVehicleById(vehicleId, response);
            }
            // Handle edit endpoint without ID
            else if ("/edit".equals(pathInfo)) {
                System.out.println("Handling edit request without ID in path, checking for query param");
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    int vehicleId = Integer.parseInt(idStr);
                    handleGetVehicleById(vehicleId, response);
                } else {
                    System.out.println("No ID provided in either path or query parameter");
                    response.setContentType("application/json");
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Vehicle ID is required");
                    response.getWriter().write(jsonResponse.toString());
                }
            } else {
                System.out.println("Unrecognized path, forwarding to list view");
                handleListVehicles(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid vehicle ID format: " + e.getMessage());
            response.setContentType("application/json");
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid vehicle ID format: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            System.out.println("Exception in doGet: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("application/json");
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error processing request: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
        }
    }

    private void handleGetVehicleById(int vehicleId, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("Getting vehicle with ID: " + vehicleId);
        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();
        
        try {
            Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
            
            if (vehicle != null) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("vehicleId", vehicle.getVehicleId());
                jsonResponse.addProperty("name", vehicle.getName());
                jsonResponse.addProperty("type", vehicle.getType());
                jsonResponse.addProperty("rentPerDay", vehicle.getRentPerDay());
                jsonResponse.addProperty("availabilityStatus", vehicle.getAvailabilityStatus());
                jsonResponse.addProperty("fuelType", vehicle.getFuelType());
                jsonResponse.addProperty("noOfAirbags", vehicle.getNoOfAirbags());
                jsonResponse.addProperty("seatingCapacity", vehicle.getSeatingCapacity());
                jsonResponse.addProperty("vehicleType", vehicle.getVehicleType());
                jsonResponse.addProperty("color", vehicle.getColor());
                
                // Log all properties to assist with debugging
                System.out.println("Vehicle found with ID: " + vehicleId);
                System.out.println("Name: " + vehicle.getName());
                System.out.println("Type: " + vehicle.getType());
                System.out.println("Rent per day: " + vehicle.getRentPerDay());
                System.out.println("Availability status: " + vehicle.getAvailabilityStatus());
                System.out.println("Fuel type: " + vehicle.getFuelType());
                System.out.println("Number of airbags: " + vehicle.getNoOfAirbags());
                System.out.println("Seating capacity: " + vehicle.getSeatingCapacity());
                System.out.println("Vehicle type: " + vehicle.getVehicleType());
                System.out.println("Color: " + vehicle.getColor());
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Vehicle not found");
                System.out.println("Vehicle not found with ID: " + vehicleId);
            }
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error retrieving vehicle: " + e.getMessage());
            System.out.println("Error retrieving vehicle: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("Sending response: " + jsonResponse.toString());
        response.getWriter().write(jsonResponse.toString());
    }

    private void handleListVehicles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            request.setAttribute("vehicles", vehicleService.getAllVehicles());
            request.getRequestDispatcher("/WEB-INF/admin/vehicles-management.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in VehicleController.handleListVehicles: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading vehicles");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();

        try {
            System.out.println("Delete request received");
            System.out.println("PathInfo: " + pathInfo);
            System.out.println("QueryString: " + request.getQueryString());
            System.out.println("Request URI: " + request.getRequestURI());
            
            if (pathInfo != null && pathInfo.matches("/delete/\\d+")) {
                String idStr = pathInfo.substring("/delete/".length());
                System.out.println("Extracted ID from path: " + idStr);
                
                int vehicleId = Integer.parseInt(idStr);
                boolean success = vehicleService.deleteVehicle(vehicleId);
                
                jsonResponse.addProperty("success", success);
                jsonResponse.addProperty("message", success ? "Vehicle deleted successfully" : "Failed to delete vehicle");
                System.out.println("Delete operation result: " + (success ? "success" : "failed"));
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Invalid delete request: path must be /delete/{id} with a numeric ID");
                System.out.println("Invalid delete path format");
            }
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid vehicle ID format: " + e.getMessage());
            System.out.println("NumberFormatException: " + e.getMessage());
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error: " + e.getMessage());
            System.out.println("Exception in doDelete: " + e.getMessage());
            e.printStackTrace();
        }

        response.getWriter().write(jsonResponse.toString());
        System.out.println("Response sent: " + jsonResponse.toString());
    }
} 