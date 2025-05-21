package com.autorent.DAO;

import com.autorent.model.ContactMessage;
import com.autorent.utils.DbConnection; // Assuming your DB connection utility is here

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactMessageDAO {

    public boolean insertContactMessage(ContactMessage message) {
        String sql = "INSERT INTO contact_messages (user_id, name, email, subject, message_body, phone) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Set parameters for the prepared statement
            stmt.setInt(1, message.getUserId());
            stmt.setString(2, message.getName());
            stmt.setString(3, message.getEmail());
            stmt.setString(4, message.getSubject());
            stmt.setString(5, message.getMessageBody());
            stmt.setString(6, message.getPhone());
            
            // Execute the update (insert) and check if a row was affected
            int rowsAffected = stmt.executeUpdate();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            // Log the exception for debugging
            System.err.println("Error inserting contact message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
} 