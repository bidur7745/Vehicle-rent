package com.autorent.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.autorent.utils.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/uploadVehicleImage")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // Max 5MB file
public class UploadVehicleImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        Part filePart = request.getPart("image"); // Get image part

        InputStream inputStream = null;
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

        try (Connection conn = DbConnection.getConnection()) {
            String sql = "UPDATE vehicles SET image = ? WHERE vehicle_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            if (inputStream != null) {
                stmt.setBlob(1, inputStream);
            }
            stmt.setInt(2, vehicleId);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.getWriter().println("✅ Image uploaded successfully for vehicle ID: " + vehicleId);
            } else {
                response.getWriter().println("❌ Vehicle not found or update failed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("SQL error: " + e.getMessage());
        }
    }
}
