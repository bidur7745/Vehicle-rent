CREATE DATABASE IF NOT EXISTS vehicle_commerce;

-- Use the database
USE vehicle_commerce;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    phone varchar(100) NOT NULL ,
    createdAt TIMESTAMP NOT NULL
    );
-- Vehicle Table
CREATE TABLE vehicles (
                          vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100),
                          type VARCHAR(50),
                          rent_per_day DECIMAL(10, 2),
                          availability_status ENUM('available', 'rented', 'maintenance') DEFAULT 'available',
                          fuel_type ENUM('petrol', 'diesel', 'electric', 'hybrid'),
                          no_of_airbags INT,
                          seating_capacity INT,
                          vehicle_type ENUM('manual', 'automatic'),
                          color VARCHAR(50),
                          image LONGBLOB,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Booking Table
CREATE TABLE bookings (
                          booking_id INT PRIMARY KEY AUTO_INCREMENT,
                          user_id INT,
                          vehicle_id INT,
                          start_date_time DATETIME,
                          end_date_time DATETIME,
                          pickup_location VARCHAR(255),
                          drop_location VARCHAR(255),
                          pickup_time TIME,
                          drop_time TIME,
                          total_price DECIMAL(10, 2),
                          status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (user_id) REFERENCES users(userId),
                          FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- Contact Message Table
CREATE TABLE contact_messages (
                                  message_id INT PRIMARY KEY AUTO_INCREMENT,
                                  user_id INT,
                                  name VARCHAR(100),
                                  email VARCHAR(100),
                                  subject VARCHAR(255),
                                  message_body TEXT,
                                  FOREIGN KEY (user_id) REFERENCES users(userId)

);
