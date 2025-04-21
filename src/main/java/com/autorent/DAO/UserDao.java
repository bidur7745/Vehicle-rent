package com.autorent.DAO;

import com.autorent.model.User;
import com.autorent.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {

    public static final String INSERT_USER = "INSERT INTO users(First_name,last_name,email,password, role,phone,createdAt) VALUES(?,?,?,?,?,?,?)";

    public static int registerUser(User user){
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER, PreparedStatement.RETURN_GENERATED_KEYS);) {
            // Set parameters for the prepared statement
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail()); // In production, this should be hashed
            ps.setString(4, user.getPassword());
            ps.setString(5,String.valueOf(user.getRole()));
            ps.setString(6, user.getPhone());
            ps.setString(7,user.getCreatedAt());

            // Execute the insert statement
            int rows = ps.executeUpdate();

            // If insertion was successful, get the generated user ID
            if (rows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }

    } catch (Exception e) {
        throw new RuntimeException(e);
    }



        return -1;
    }



}
