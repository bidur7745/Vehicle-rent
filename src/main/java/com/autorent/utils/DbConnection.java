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
        return DriverManager.getConnection(URL, USER, PASS);
    }



}
