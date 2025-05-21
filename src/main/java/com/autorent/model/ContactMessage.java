package com.autorent.model;

import java.sql.Timestamp;

public class ContactMessage {
    private int messageId;
    private int userId;
    private String name;
    private String email;
    private String phone;
    private String subject;
    private String messageBody;
    private Timestamp createdAt;
    private boolean read;

    // Constructors, Getters & Setters


    public ContactMessage() {
    }

    public ContactMessage(int messageId, int userId, String name, String email, String messageBody, String subject, String phone) {
        this.messageId = messageId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.messageBody = messageBody;
        this.subject = subject;
        this.phone=phone;
    }

   

    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessageBody() {
        return messageBody;
    }

    public void setMessageBody(String messageBody) {
        this.messageBody = messageBody;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }
}
