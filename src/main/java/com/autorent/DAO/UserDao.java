package com.autorent.DAO;

import com.autorent.model.User;
import com.autorent.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    public static final String INSERT_USER = "INSERT INTO users(First_name,last_name,email,password, role,phone,createdAt) VALUES(?,?,?,?,?,?,?)";

    public static final String SELECT_USER_BY_EMAIL_PASSWORD = "SELECT * FROM users WHERE email = ? AND password = ?";
    public static final String SELECT_USER_BY_EMAIL = "SELECT * FROM users WHERE email = ?";
    public static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE id = ?";


    public static int registerUser(User user) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER, PreparedStatement.RETURN_GENERATED_KEYS);) {
            // Set parameters for the prepared statement
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail()); // In production, this should be hashed
            ps.setString(4, user.getPassword());
            ps.setString(5, String.valueOf(user.getRole()));
            ps.setString(6, user.getPhone());
            ps.setString(7, user.getCreatedAt());

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

    public static User getUserById(int id) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_ID);) {
            ps.setInt(1, id);

        }
        catch (SQLException e) {
            // Log the exception details for debugging
            System.err.println("Error retrieving user by ID: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }



    public static User loginUser(User user) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL_PASSWORD);) {
            // Set parameters for the prepared statement
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword()); // In production, use password hashing

            // Execute the query
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User newuser = new User();
                newuser.setUserId(rs.getInt("userid"));
                newuser.setFirstName(rs.getString("first_name"));
                newuser.setLastName(rs.getString("last_name"));
                newuser.setEmail(rs.getString("email"));
                newuser.setPassword(rs.getString("password"));
                newuser.setPhone(rs.getString("phone"));
                newuser.setRole(User.Role.valueOf(rs.getString("role")));
                return newuser;


            }

        }
        catch (SQLException e) {
            // Log the exception details for debugging
            System.err.println("Error authenticating user: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }

}