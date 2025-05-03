package com.autorent.model;

import java.util.Arrays;

public class Vehicle {
    private int vehicleId;
    private String name;
    private String type;
    private double rentPerDay;
    private String availabilityStatus;
    private String fuelType;
    private int noOfAirbags;
    private int seatingCapacity;
    private String vehicleType;
    private String color;
    private byte[] image; // <-- Changed from String to byte[]
    private String createdAt;

    public Vehicle() {
    }

    public Vehicle(int vehicleId, String name, String type, double rentPerDay, String availabilityStatus,
                   String fuelType, int noOfAirbags, int seatingCapacity, String vehicleType,
                   String color, byte[] image, String createdAt) {
        this.vehicleId = vehicleId;
        this.name = name;
        this.type = type;
        this.rentPerDay = rentPerDay;
        this.availabilityStatus = availabilityStatus;
        this.fuelType = fuelType;
        this.noOfAirbags = noOfAirbags;
        this.seatingCapacity = seatingCapacity;
        this.vehicleType = vehicleType;
        this.color = color;
        this.image = image;
        this.createdAt = createdAt;
    }

    // Getters & Setters

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getRentPerDay() {
        return rentPerDay;
    }

    public void setRentPerDay(double rentPerDay) {
        this.rentPerDay = rentPerDay;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public int getNoOfAirbags() {
        return noOfAirbags;
    }

    public void setNoOfAirbags(int noOfAirbags) {
        this.noOfAirbags = noOfAirbags;
    }

    public int getSeatingCapacity() {
        return seatingCapacity;
    }

    public void setSeatingCapacity(int seatingCapacity) {
        this.seatingCapacity = seatingCapacity;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image= image;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "vehicleId=" + vehicleId +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", rentPerDay=" + rentPerDay +
                ", availabilityStatus='" + availabilityStatus + '\'' +
                ", fuelType='" + fuelType + '\'' +
                ", noOfAirbags=" + noOfAirbags +
                ", seatingCapacity=" + seatingCapacity +
                ", vehicleType='" + vehicleType + '\'' +
                ", color='" + color + '\'' +
                ", imageData=" + Arrays.toString(image) +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
