package com.autorent.DAO;

import com.autorent.model.Booking;
import com.autorent.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    
    // Create a new booking
    public int createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, vehicle_id, start_date_time, end_date_time, pickup_location, " +
                "drop_location, pickup_time, drop_time, total_price, status, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("BookingDAO: Attempting to create booking with SQL: " + sql);
        System.out.println("BookingDAO: Booking details - " +
                "userId: " + booking.getUserId() + 
                ", vehicleId: " + booking.getVehicleId() + 
                ", startDateTime: " + booking.getStartDateTime() + 
                ", endDateTime: " + booking.getEndDateTime() + 
                ", totalPrice: " + booking.getTotalPrice() + 
                ", status: " + booking.getStatus());
        
        try (Connection conn = DbConnection.getConnection()) {
            System.out.println("BookingDAO: Database connection obtained successfully");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, booking.getUserId());
                pstmt.setInt(2, booking.getVehicleId());
                pstmt.setString(3, booking.getStartDateTime());
                pstmt.setString(4, booking.getEndDateTime());
                pstmt.setString(5, booking.getPickupLocation());
                pstmt.setString(6, booking.getDropLocation());
                pstmt.setString(7, booking.getPickupTime());
                pstmt.setString(8, booking.getDropTime());
                pstmt.setDouble(9, booking.getTotalPrice());
                pstmt.setString(10, booking.getStatus());
                pstmt.setString(11, booking.getCreatedAt());
                
                System.out.println("BookingDAO: Executing SQL with parameters set");
                int affectedRows = pstmt.executeUpdate();
                System.out.println("BookingDAO: SQL executed, affected rows: " + affectedRows);
                
                if (affectedRows > 0) {
                    try (ResultSet rs = pstmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            int id = rs.getInt(1);
                            System.out.println("BookingDAO: Successfully created booking with ID: " + id);
                            return id;
                        } else {
                            System.out.println("BookingDAO: No generated keys returned");
                        }
                    }
                } else {
                    System.out.println("BookingDAO: No rows affected by insert");
                }
            }
        } catch (SQLException e) {
            System.out.println("BookingDAO: SQLException occurred: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("BookingDAO: Unexpected exception: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("BookingDAO: Failed to create booking, returning -1");
        return -1;
    }
    
    // Get a booking by ID
    public Booking getBookingById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookingId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all bookings for a user
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Get all bookings for a vehicle
    public List<Booking> getBookingsByVehicleId(int vehicleId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE vehicle_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, vehicleId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY created_at DESC";
        
        System.out.println("BookingDAO: Attempting to execute query: " + sql);
        
        try (Connection conn = DbConnection.getConnection()) {
            System.out.println("BookingDAO: Connection to database successful");
            
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                
                System.out.println("BookingDAO: Query executed successfully");
                
                if (!rs.isBeforeFirst()) {
                    System.out.println("BookingDAO: No bookings found in database");
                    return bookings; // Empty list
                }
                
                System.out.println("BookingDAO: Mapping result set to bookings");
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
                
                System.out.println("BookingDAO: Retrieved " + bookings.size() + " bookings");
            }
        } catch (SQLException e) {
            System.err.println("BookingDAO ERROR: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("BookingDAO Unexpected ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        
        return bookings;
    }
    
    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, bookingId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete a booking
    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        System.out.println("BookingDAO: Attempting to delete booking with ID " + bookingId);
        
        try (Connection conn = DbConnection.getConnection()) {
            System.out.println("BookingDAO: Database connection successful for deleteBooking");
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, bookingId);
                System.out.println("BookingDAO: Executing SQL: " + sql + " with bookingId=" + bookingId);
                
                int affectedRows = pstmt.executeUpdate();
                System.out.println("BookingDAO: Delete operation affected " + affectedRows + " rows");
                
                return affectedRows > 0;
            }
        } catch (SQLException e) {
            System.err.println("BookingDAO ERROR in deleteBooking: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("BookingDAO Unexpected ERROR in deleteBooking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to map ResultSet to Booking object
    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setVehicleId(rs.getInt("vehicle_id"));
        booking.setStartDateTime(rs.getString("start_date_time"));
        booking.setEndDateTime(rs.getString("end_date_time"));
        booking.setPickupLocation(rs.getString("pickup_location"));
        booking.setDropLocation(rs.getString("drop_location"));
        booking.setPickupTime(rs.getString("pickup_time"));
        booking.setDropTime(rs.getString("drop_time"));
        booking.setTotalPrice(rs.getDouble("total_price"));
        booking.setStatus(rs.getString("status"));
        booking.setCreatedAt(rs.getString("created_at"));
        return booking;
    }
} 