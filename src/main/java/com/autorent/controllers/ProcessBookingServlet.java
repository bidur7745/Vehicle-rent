package com.autorent.controllers;

import com.autorent.model.Booking;
import com.autorent.model.User;
import com.autorent.model.Vehicle;
import com.autorent.services.BookingService;
import com.autorent.services.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@WebServlet("/process-booking")
public class ProcessBookingServlet extends HttpServlet {
    private final VehicleService vehicleService = new VehicleService();
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            System.out.println("ProcessBookingServlet: Processing booking form submission");
            
            // Get parameters from the form
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String pickupTime = request.getParameter("pickupTime");
            String dropTime = request.getParameter("dropTime");
            
            // Get and validate total price
            String totalPriceParam = request.getParameter("totalPrice");
            System.out.println("ProcessBookingServlet: Raw totalPrice parameter: " + totalPriceParam);
            
            double totalPrice = 0.0;
            try {
                totalPrice = Double.parseDouble(totalPriceParam);
            } catch (NumberFormatException e) {
                System.out.println("ProcessBookingServlet: Error parsing totalPrice: " + e.getMessage());
            }
            
            // If price is zero, calculate it manually
            if (totalPrice <= 0.0) {
                System.out.println("ProcessBookingServlet: Total price is zero or negative, calculating manually");
                Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
                
                if (vehicle != null) {
                    // Calculate days
                    LocalDate start = LocalDate.parse(startDate);
                    LocalDate end = LocalDate.parse(endDate);
                    long days = ChronoUnit.DAYS.between(start, end) + 1; // Include both start and end days
                    
                    // Calculate price
                    double dailyRate = vehicle.getRentPerDay();
                    double serviceCharge = 500;
                    totalPrice = (dailyRate + serviceCharge) * days;
                    
                    System.out.println("ProcessBookingServlet: Manually calculated price: " + 
                                       dailyRate + " (daily rate) + " + 
                                       serviceCharge + " (service charge) * " + 
                                       days + " (days) = " + totalPrice);
                }
            }
            
            System.out.println("ProcessBookingServlet: Final total price: " + totalPrice);
            
            // Create temporary booking object and store in session
            Booking tempBooking = new Booking();
            tempBooking.setVehicleId(vehicleId);
            tempBooking.setPickupLocation(pickupLocation);
            tempBooking.setDropLocation(dropLocation);
            tempBooking.setStartDateTime(startDate + " " + pickupTime + ":00");
            tempBooking.setEndDateTime(endDate + " " + dropTime + ":00");
            tempBooking.setPickupTime(pickupTime);
            tempBooking.setDropTime(dropTime);
            tempBooking.setTotalPrice(totalPrice);
            
            // Store temp booking in session
            session.setAttribute("tempBooking", tempBooking);
            
            // Store vehicle info for payment page
            Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
            session.setAttribute("bookingVehicle", vehicle);
            
            // Redirect to payment page
            System.out.println("ProcessBookingServlet: Redirecting to payment page");
            response.sendRedirect(request.getContextPath() + "/payment.jsp");
            
        } catch (Exception e) {
            System.out.println("ProcessBookingServlet: Error processing booking: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your booking: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
} 