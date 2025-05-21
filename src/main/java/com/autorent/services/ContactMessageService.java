package com.autorent.services;

import com.autorent.model.ContactMessage;
import com.autorent.DAO.ContactMessageDAO;

public class ContactMessageService {

    private final ContactMessageDAO contactMessageDAO = new ContactMessageDAO();

    public boolean saveContactMessage(ContactMessage message) {
        System.out.println("Attempting to save contact message to database:");
        System.out.println("Name: " + message.getName());
        System.out.println("Email: " + message.getEmail());
        System.out.println("Phone: " + message.getPhone());
        System.out.println("Subject: " + message.getSubject());
        System.out.println("Message Body: " + message.getMessageBody());
        System.out.println("User ID: " + message.getUserId());

        boolean success = contactMessageDAO.insertContactMessage(message);

        if (success) {
            System.out.println("Contact message successfully saved to database.");
        } else {
            System.err.println("Failed to save contact message to database.");
        }
        
        return success;
    }
} 