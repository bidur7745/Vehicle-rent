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
