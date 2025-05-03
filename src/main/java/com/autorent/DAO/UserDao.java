package com.autorent.DAO;

import com.autorent.model.User;
import com.autorent.utils.DbConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public static final String INSERT_USER = "INSERT INTO users(First_name,last_name,email,password, role,phone,createdAt) VALUES(?,?,?,?,?,?,?)";

    public static final String SELECT_USER_BY_EMAIL_PASSWORD = "SELECT * FROM users WHERE email = ? AND password = ?";
    public static final String SELECT_USER_BY_EMAIL = "SELECT * FROM users WHERE email = ?";
    public static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE userId = ?";
    public static final String SELECT_USER_BY_NAME = "SELECT * FROM users WHERE first_name = ? AND last_name = ?";
    public static final String SELECT_USER_BY_PHONE = "SELECT * FROM users WHERE phone = ?";
    public static final String SELECT_ALL_USERS = "SELECT * FROM users ORDER BY createdAt DESC";
    public static final String DELETE_USER = "DELETE FROM users WHERE userId = ?";


    public static int registerUser(User user) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER, PreparedStatement.RETURN_GENERATED_KEYS);) {
            // Set parameters for the prepared statement
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            // Hash the password before storing
            ps.setString(4, BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
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
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {
            ps.setString(1, user.getEmail());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String hashed = rs.getString("password");
                // Check hashed password
                if (org.mindrot.jbcrypt.BCrypt.checkpw(user.getPassword(), hashed)) {
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
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

    public static boolean emailExists(String email) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean phoneExists(String phone) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_PHONE)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean nameExists(String firstName, String lastName) {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_NAME)) {
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ALL_USERS);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setCreatedAt(rs.getString("createdAt"));
                users.add(user);
            }
        }
        return users;
    }

    public static int countAllUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public static boolean deleteUser(int userId) throws SQLException {
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_USER)) {
            
            ps.setInt(1, userId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

}