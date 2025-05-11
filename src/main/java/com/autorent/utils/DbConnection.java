package com.autorent.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DbConnection {
    private static final String URL;
    private static final String USER;
    private static final String PASS;

    static {
        try (InputStream is = DbConnection.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (is == null) {
                throw new RuntimeException("application.properties file not found in classpath");
            }

            Properties prop = new Properties();
            prop.load(is);

            // Database connection properties
            URL = prop.getProperty("db.url");
            USER = prop.getProperty("db.user");
            PASS = prop.getProperty("db.password");
            String driver = prop.getProperty("db.driver");
            Class.forName(driver);

            System.out.println("Database connection properties loaded successfully");
        } catch (IOException | ClassNotFoundException | NumberFormatException e) {
            System.err.println("Error loading database properties: " + e.getMessage());
            throw new RuntimeException("Failed to load database properties", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            System.out.println("DbConnection: Attempting to connect to database at " + URL);
            System.out.println("DbConnection: Using username: " + USER);
            Connection conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("DbConnection: Successfully connected to database");
            return conn;
        } catch (SQLException e) {
            System.err.println("DbConnection ERROR: Failed to connect to database");
            System.err.println("DbConnection ERROR Details: " + e.getMessage());
            System.err.println("DbConnection SQL State: " + e.getSQLState());
            System.err.println("DbConnection Error Code: " + e.getErrorCode());
            throw e;
        }
    }



}
