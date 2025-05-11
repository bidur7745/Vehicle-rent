-- SQL script to check if bookings table exists and create it if needed

-- Check if table exists
SELECT COUNT(*)
FROM information_schema.tables 
WHERE table_schema = 'vehicle_commerce' 
AND table_name = 'bookings';

-- Create bookings table if it doesn't exist
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date_time VARCHAR(255) NOT NULL,
    end_date_time VARCHAR(255) NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    drop_location VARCHAR(255),
    pickup_time VARCHAR(255),
    drop_time VARCHAR(255),
    total_price DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(userId),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicleid)
); 