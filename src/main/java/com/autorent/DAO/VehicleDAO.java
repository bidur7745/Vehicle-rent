package com.autorent.DAO;

import com.autorent.model.Vehicle;
import com.autorent.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class VehicleDAO {
    
    public int insert(Vehicle vehicle) throws SQLException {
        String sql = "INSERT INTO vehicles (name, type, rent_per_day, availability_status, " +
                    "fuel_type, no_of_airbags, seating_capacity, vehicle_type, color, image) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, vehicle.getName());
            stmt.setString(2, vehicle.getType());
            stmt.setBigDecimal(3, BigDecimal.valueOf(vehicle.getRentPerDay()));
            stmt.setString(4, vehicle.getAvailabilityStatus());
            stmt.setString(5, vehicle.getFuelType());
            stmt.setInt(6, vehicle.getNoOfAirbags());
            stmt.setInt(7, vehicle.getSeatingCapacity());
            stmt.setString(8, vehicle.getVehicleType());
            stmt.setString(9, vehicle.getColor());
            stmt.setBytes(10, vehicle.getImage());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        }
        return 0;
    }
    
    public List<Vehicle> findAll() throws SQLException {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicles ORDER BY created_at DESC";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Vehicle vehicle = mapResultSetToVehicle(rs);
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }
    
    public Vehicle findById(int id) throws SQLException {
        String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVehicle(rs);
                }
            }
        }
        return null;
    }
    
    public int delete(int id) throws SQLException {
        String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate();
        }
    }
    
    private Vehicle mapResultSetToVehicle(ResultSet rs) throws SQLException {
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicleId(rs.getInt("vehicle_id"));
        vehicle.setName(rs.getString("name"));
        vehicle.setType(rs.getString("type"));
        vehicle.setRentPerDay(rs.getBigDecimal("rent_per_day").doubleValue());
        vehicle.setAvailabilityStatus(rs.getString("availability_status"));
        vehicle.setFuelType(rs.getString("fuel_type"));
        vehicle.setNoOfAirbags(rs.getInt("no_of_airbags"));
        vehicle.setSeatingCapacity(rs.getInt("seating_capacity"));
        vehicle.setVehicleType(rs.getString("vehicle_type"));
        vehicle.setColor(rs.getString("color"));
        vehicle.setImage(rs.getBytes("image"));
        return vehicle;
    }
} 