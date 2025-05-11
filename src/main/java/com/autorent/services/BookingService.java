package com.autorent.services;

import com.autorent.DAO.BookingDAO;
import com.autorent.DAO.VehicleDAO;
import com.autorent.model.Booking;
import com.autorent.model.Vehicle;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class BookingService {
    private final BookingDAO bookingDAO;
    private final VehicleDAO vehicleDAO;
    
    public BookingService() {
        this.bookingDAO = new BookingDAO();
        this.vehicleDAO = new VehicleDAO();
    }
    
    // Create a new booking
    public int createBooking(Booking booking) {
        // Set default status and created timestamp
        booking.setStatus("pending");
        booking.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        
        // Check if vehicle is available for the requested time period
        if (!isVehicleAvailable(booking.getVehicleId(), booking.getStartDateTime(), booking.getEndDateTime())) {
            return -1; // Vehicle not available
        }
        
        return bookingDAO.createBooking(booking);
    }
    
    // Check if a vehicle is available for a specific time period
    private boolean isVehicleAvailable(int vehicleId, String startDateTime, String endDateTime) {
        // Get all bookings for this vehicle
        List<Booking> bookings = bookingDAO.getBookingsByVehicleId(vehicleId);
        
        LocalDateTime requestStart = LocalDateTime.parse(startDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        LocalDateTime requestEnd = LocalDateTime.parse(endDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
        // Check if requested time overlaps with any existing booking
        for (Booking booking : bookings) {
            // Skip cancelled bookings
            if ("cancelled".equals(booking.getStatus())) {
                continue;
            }
            
            LocalDateTime bookingStart = LocalDateTime.parse(booking.getStartDateTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            LocalDateTime bookingEnd = LocalDateTime.parse(booking.getEndDateTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            // Check for overlap
            if (!(requestEnd.isBefore(bookingStart) || requestStart.isAfter(bookingEnd))) {
                return false; // There is an overlap, vehicle not available
            }
        }
        
        return true; // No overlaps found, vehicle is available
    }
    
    // Get all bookings for a user
    public List<Booking> getUserBookings(int userId) {
        List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);
        
        // Update bookings status based on dates
        updateBookingStatusesByDate(bookings);
        
        return bookings;
    }
    
    // Get all bookings (admin function)
    public List<Booking> getAllBookings() {
        List<Booking> bookings = bookingDAO.getAllBookings();
        
        // Update bookings status based on dates
        updateBookingStatusesByDate(bookings);
        
        return bookings;
    }
    
    // Update booking statuses based on current date
    private void updateBookingStatusesByDate(List<Booking> bookings) {
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        for (Booking booking : bookings) {
            try {
                // Skip bookings that are already cancelled or completed
                if ("cancelled".equals(booking.getStatus()) || "completed".equals(booking.getStatus())) {
                    continue;
                }
                
                LocalDateTime startDateTime = LocalDateTime.parse(booking.getStartDateTime(), formatter);
                LocalDateTime endDateTime = LocalDateTime.parse(booking.getEndDateTime(), formatter);
                
                // If current time is after end date, mark as completed
                if (currentDateTime.isAfter(endDateTime)) {
                    if (!"completed".equals(booking.getStatus())) {
                        updateBookingStatus(booking.getBookingId(), "completed");
                        booking.setStatus("completed"); // Update in-memory object too
                    }
                } 
                // If current time is after start date but before end date, mark as active
                else if (currentDateTime.isAfter(startDateTime) && currentDateTime.isBefore(endDateTime)) {
                    if ("pending".equals(booking.getStatus())) {
                        updateBookingStatus(booking.getBookingId(), "active");
                        booking.setStatus("active"); // Update in-memory object too
                    }
                }
            } catch (Exception e) {
                // Log and continue if there's an issue with a particular booking
                System.err.println("Error updating booking status for booking ID " + booking.getBookingId() + ": " + e.getMessage());
            }
        }
    }
    
    // Get a booking by ID
    public Booking getBookingById(int bookingId) {
        return bookingDAO.getBookingById(bookingId);
    }
    
    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) {
        return bookingDAO.updateBookingStatus(bookingId, status);
    }
    
    // Cancel a booking
    public boolean cancelBooking(int bookingId) {
        return bookingDAO.updateBookingStatus(bookingId, "cancelled");
    }
    
    // Delete a booking
    public boolean deleteBooking(int bookingId) {
        System.out.println("BookingService: Attempting to delete booking with ID " + bookingId);
        
        // First check if the booking exists and is in cancelled status
        Booking booking = bookingDAO.getBookingById(bookingId);
        if (booking == null) {
            System.out.println("BookingService: Booking with ID " + bookingId + " not found");
            return false;
        }
        
        System.out.println("BookingService: Booking status is " + booking.getStatus());
        
        // Only allow deletion of cancelled bookings
        if (!"cancelled".equals(booking.getStatus())) {
            System.out.println("BookingService: Cannot delete booking with status " + booking.getStatus());
            return false;
        }
        
        // Delete the booking
        boolean result = bookingDAO.deleteBooking(bookingId);
        System.out.println("BookingService: Delete operation returned " + result);
        return result;
    }
    
    // Calculate total price for a booking
    public double calculateTotalPrice(int vehicleId, String startDateTime, String endDateTime) {
        try {
            Vehicle vehicle = vehicleDAO.findById(vehicleId);
            if (vehicle == null) {
                return 0.0;
            }
            
            double dailyRate = vehicle.getRentPerDay();
            
            LocalDateTime start = LocalDateTime.parse(startDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            LocalDateTime end = LocalDateTime.parse(endDateTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            // Calculate days difference (rounded up)
            long days = java.time.Duration.between(start, end).toDays();
            if (java.time.Duration.between(start, end).toHours() % 24 > 0) {
                days += 1; // Add an extra day for partial days
            }
            
            return dailyRate * days;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0.0;
        }
    }
    
    // Update all bookings in the database based on current date
    public int updateAllBookingStatuses() {
        List<Booking> bookings = bookingDAO.getAllBookings();
        int updatedCount = 0;
        
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        for (Booking booking : bookings) {
            try {
                // Skip bookings that are already cancelled or completed
                if ("cancelled".equals(booking.getStatus()) || "completed".equals(booking.getStatus())) {
                    continue;
                }
                
                LocalDateTime startDateTime = LocalDateTime.parse(booking.getStartDateTime(), formatter);
                LocalDateTime endDateTime = LocalDateTime.parse(booking.getEndDateTime(), formatter);
                
                boolean updated = false;
                
                // If current time is after end date, mark as completed
                if (currentDateTime.isAfter(endDateTime)) {
                    if (!"completed".equals(booking.getStatus())) {
                        updated = updateBookingStatus(booking.getBookingId(), "completed");
                    }
                } 
                // If current time is after start date but before end date, mark as active
                else if (currentDateTime.isAfter(startDateTime) && currentDateTime.isBefore(endDateTime)) {
                    if ("pending".equals(booking.getStatus())) {
                        updated = updateBookingStatus(booking.getBookingId(), "active");
                    }
                }
                
                if (updated) {
                    updatedCount++;
                }
            } catch (Exception e) {
                // Log and continue if there's an issue with a particular booking
                System.err.println("Error updating status for booking ID " + booking.getBookingId() + ": " + e.getMessage());
            }
        }
        
        return updatedCount;
    }
} 