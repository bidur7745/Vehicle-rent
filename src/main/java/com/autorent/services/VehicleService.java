package com.autorent.services;

import com.autorent.model.Vehicle;
import com.autorent.DAO.VehicleDAO;

import java.sql.SQLException;
import java.util.List;

public class VehicleService {
    private final VehicleDAO vehicleDAO;

    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
    }

    public boolean addVehicle(Vehicle vehicle) {
        try {
            return vehicleDAO.insert(vehicle) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Vehicle> getAllVehicles() {
        try {
            return vehicleDAO.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
            return List.of();
        }
    }

    public boolean deleteVehicle(int vehicleId) {
        try {
            return vehicleDAO.delete(vehicleId) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Vehicle getVehicleById(int vehicleId) {
        try {
            return vehicleDAO.findById(vehicleId);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean updateVehicle(Vehicle vehicle) {
        try {
            return vehicleDAO.update(vehicle) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 