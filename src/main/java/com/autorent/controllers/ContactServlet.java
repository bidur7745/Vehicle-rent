package com.autorent.controllers;

import com.autorent.model.ContactMessage;
import com.autorent.model.User; // Assuming User model exists for getting user ID
import com.autorent.services.ContactMessageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/contact")
@MultipartConfig
public class ContactServlet extends HttpServlet {
    private final ContactMessageService contactMessageService = new ContactMessageService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ContactServlet: Received POST request");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone"); // Assuming phone might be added to ContactMessage model later
            String subject = request.getParameter("subject");
            String messageBody = request.getParameter("message");

            System.out.println("ContactServlet: Received parameters - Name: " + name + ", Email: " + email + ", Subject: " + subject);

            // Get logged-in user ID from session
            HttpSession session = request.getSession(false); // Don't create new session if one doesn't exist
            User user = (session != null) ? (User) session.getAttribute("user") : null;
            int userId = (user != null) ? user.getUserId() : 0; // Use 0 or a special value for guest users
            System.out.println("ContactServlet: User ID: " + userId);

            // Validate required fields (basic check)
            if (name == null || name.isEmpty() || email == null || email.isEmpty() || subject == null || subject.isEmpty() || messageBody == null || messageBody.isEmpty()) {
                System.out.println("ContactServlet: Validation failed - Required fields missing");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Please fill in all required fields.\"}");
                return;
            }

            // Create ContactMessage object
            ContactMessage contactMessage = new ContactMessage();
            contactMessage.setUserId(userId); // Set user ID (0 for guest)
            contactMessage.setName(name);
            contactMessage.setEmail(email);
            contactMessage.setPhone(phone); // This line should be uncommented
            contactMessage.setSubject(subject);
            contactMessage.setMessageBody(messageBody);

            System.out.println("ContactServlet: Created ContactMessage object");

            // Save the message using the service
            System.out.println("ContactServlet: Calling ContactMessageService...");
            boolean success = contactMessageService.saveContactMessage(contactMessage);
            System.out.println("ContactServlet: ContactMessageService returned: " + success);

            if (success) {
                System.out.println("ContactServlet: Message saved successfully (simulated)");
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\": true, \"message\": \"Your message has been sent successfully!\"}");
            } else {
                // If saving failed (e.g., database error when implemented)
                System.out.println("ContactServlet: Message saving failed (simulated)");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"message\": \"Failed to send your message. Please try again later.\"}");
            }

        } catch (Exception e) {
            System.err.println("ContactServlet ERROR: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            // Escape the error message for JSON
            String errorMessage = escapeJsonString(e.getMessage());
            out.print("{\"success\": false, \"message\": \"An internal error occurred: " + errorMessage + "\"}");
        } finally {
            System.out.println("ContactServlet: Request processing finished.");
            out.flush();
        }
    }
    
    // Helper method to escape JSON strings (already present in BookingDetailsServlet, reusing)
    private String escapeJsonString(String input) {
        if (input == null) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);
            switch (ch) {
                case '"':
                    sb.append("\\\"");
                    break;
                case '\\':
                    sb.append("\\\\");
                    break;
                case '\b':
                    sb.append("\\b");
                    break;
                case '\f':
                    sb.append("\\f");
                    break;
                case '\n':
                    sb.append("\\n");
                    break;
                case '\r':
                    sb.append("\\r");
                    break;
                case '\t':
                    sb.append("\\t");
                    break;
                default:
                    if (ch < ' ') {
                        String hex = Integer.toHexString(ch);
                        sb.append("\\u");
                        for (int j = 0; j < 4 - hex.length(); j++) {
                            sb.append('0');
                        }
                        sb.append(hex);
                    } else {
                        sb.append(ch);
                    }
            }
        }
        return sb.toString();
    }
}
