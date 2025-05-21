package com.autorent.controllers;

import com.autorent.model.ContactMessage;
import com.autorent.utils.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/contact-messages/*")
public class ContactMessageController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all messages
                listMessages(request, response);
            } else {
                // Get specific message or handle delete
                String[] splits = pathInfo.split("/");
                if (splits.length == 3 && splits[1].equals("delete")) {
                    // Handle delete
                    int messageId = Integer.parseInt(splits[2]);
                    deleteMessage(request, response, messageId);
                } else if (splits.length == 2) {
                    // View specific message
                    int messageId = Integer.parseInt(splits[1]);
                    viewMessage(request, response, messageId);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void listMessages(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<ContactMessage> messages = new ArrayList<>();
        
        String sql = "SELECT * FROM contact_messages ORDER BY message_id DESC";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                ContactMessage message = new ContactMessage();
                message.setMessageId(rs.getInt("message_id"));
                message.setUserId(rs.getInt("user_id"));
                message.setName(rs.getString("name"));
                message.setEmail(rs.getString("email"));
                message.setSubject(rs.getString("subject"));
                message.setMessageBody(rs.getString("message_body"));
                messages.add(message);
            }
        }
        
        request.setAttribute("contactMessages", messages);
        request.getRequestDispatcher("/WEB-INF/admin/contact-message.jsp")
               .forward(request, response);
    }

    private void viewMessage(HttpServletRequest request, HttpServletResponse response, int messageId) 
            throws SQLException, ServletException, IOException {
        
        String sql = "SELECT * FROM contact_messages WHERE message_id = ?";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, messageId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ContactMessage message = new ContactMessage();
                    message.setMessageId(rs.getInt("message_id"));
                    message.setUserId(rs.getInt("user_id"));
                    message.setName(rs.getString("name"));
                    message.setEmail(rs.getString("email"));
                    message.setSubject(rs.getString("subject"));
                    message.setMessageBody(rs.getString("message_body"));
                    
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("/WEB-INF/admin/view-message.jsp")
                           .forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        }
    }

    private void deleteMessage(HttpServletRequest request, HttpServletResponse response, int messageId) 
            throws SQLException, IOException {
        String sql = "DELETE FROM contact_messages WHERE message_id = ?";
        
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, messageId);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect(request.getContextPath() + "/admin/contact-messages");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }
} 