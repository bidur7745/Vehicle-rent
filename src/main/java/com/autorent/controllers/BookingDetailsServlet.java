package com.autorent.controllers;

import com.autorent.model.Booking;
import com.autorent.model.Vehicle;
import com.autorent.services.BookingService;
import com.autorent.services.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;



@WebServlet("/get-booking-details")
public class BookingDetailsServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    private final VehicleService vehicleService = new VehicleService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("BookingDetailsServlet: Processing request");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String bookingIdStr = request.getParameter("bookingId");
            System.out.println("BookingDetailsServlet: Received bookingId: " + bookingIdStr);
            
            if (bookingIdStr == null || bookingIdStr.isEmpty()) {
                System.out.println("BookingDetailsServlet: No booking ID provided");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Booking ID is required\"}");
                return;
            }

            int bookingId = Integer.parseInt(bookingIdStr);
            System.out.println("BookingDetailsServlet: Looking up booking with ID: " + bookingId);
            
            Booking booking = bookingService.getBookingById(bookingId);
            
            if (booking == null) {
                System.out.println("BookingDetailsServlet: Booking not found for ID: " + bookingId);
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Booking not found\"}");
                return;
            }

            System.out.println("BookingDetailsServlet: Found booking, looking up vehicle with ID: " + booking.getVehicleId());
            
            // Get vehicle details
            Vehicle vehicle = vehicleService.getVehicleById(booking.getVehicleId());
            if (vehicle == null) {
                System.out.println("BookingDetailsServlet: Vehicle not found for ID: " + booking.getVehicleId());
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Vehicle not found\"}");
                return;
            }

            System.out.println("BookingDetailsServlet: Building JSON response");
            
            // Build JSON response
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"vehicleName\":\"").append(escapeJsonString(vehicle.getName())).append("\",");
            json.append("\"vehicleType\":\"").append(escapeJsonString(vehicle.getType())).append("\",");
            json.append("\"pickupLocation\":\"").append(escapeJsonString(booking.getPickupLocation())).append("\",");
            json.append("\"pickupDate\":\"").append(booking.getStartDateTime().split(" ")[0]).append("\",");
            json.append("\"pickupTime\":\"").append(booking.getPickupTime()).append("\",");
            json.append("\"dropLocation\":\"").append(escapeJsonString(booking.getDropLocation())).append("\",");
            json.append("\"dropDate\":\"").append(booking.getEndDateTime().split(" ")[0]).append("\",");
            json.append("\"dropTime\":\"").append(booking.getDropTime()).append("\",");
            json.append("\"totalPrice\":").append(booking.getTotalPrice()).append(",");
            json.append("\"paymentStatus\":\"").append(escapeJsonString(booking.getStatus())).append("\"");
            json.append("}");

            String jsonResponse = json.toString();
            System.out.println("BookingDetailsServlet: Sending response: " + jsonResponse);
            
            out.print(jsonResponse);

        } catch (NumberFormatException e) {
            System.out.println("BookingDetailsServlet: Invalid booking ID format: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid booking ID format\"}");
        } catch (Exception e) {
            System.out.println("BookingDetailsServlet: Error processing request: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"An error occurred while processing your request: " + escapeJsonString(e.getMessage()) + "\"}");
        }
    }

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