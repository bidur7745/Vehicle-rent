<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Message - AutoRent Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .content {
            margin-left: 250px;
            padding: 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1f2937;
        }

        .back-button {
            padding: 0.5rem 1rem;
            background-color: #6b7280;
            color: white;
            border-radius: 0.375rem;
            text-decoration: none;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }

        .back-button:hover {
            background-color: #4b5563;
        }

        .message-container {
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }

        .message-header {
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }

        .message-subject {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .message-meta {
            display: flex;
            gap: 2rem;
            color: #6b7280;
            font-size: 0.875rem;
        }

        .message-meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .message-body {
            color: #374151;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        .message-actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
        }

        .action-button {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            text-decoration: none;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }

        .reply-button {
            background-color: #3b82f6;
            color: white;
        }

        .reply-button:hover {
            background-color: #2563eb;
        }

        .delete-button {
            background-color: #ef4444;
            color: white;
        }

        .delete-button:hover {
            background-color: #dc2626;
        }
    </style>
</head>
<body>
    <jsp:include page="components/admin-sidebar.jsp"/>

    <div class="content">
        <div class="page-header">
            <h1 class="page-title">View Message</h1>
            <a href="${pageContext.request.contextPath}/admin/contact-messages" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Messages
            </a>
        </div>

        <div class="message-container">
            <div class="message-header">
                <h2 class="message-subject">${message.subject}</h2>
                <div class="message-meta">
                    <div class="message-meta-item">
                        <i class="fas fa-user"></i>
                        <span>${message.name}</span>
                    </div>
                    <div class="message-meta-item">
                        <i class="fas fa-envelope"></i>
                        <span>${message.email}</span>
                    </div>
                    <div class="message-meta-item">
                        <i class="fas fa-phone"></i>
                        <span>${message.phone}</span>
                    </div>
                    <div class="message-meta-item">
                        <i class="fas fa-clock"></i>
                        <span><fmt:formatDate value="${message.createdAt}" pattern="MMM dd, yyyy HH:mm"/></span>
                    </div>
                </div>
            </div>

            <div class="message-body">
                ${message.messageBody}
            </div>

            <div class="message-actions">
                <a href="mailto:${message.email}?subject=Re: ${message.subject}" class="action-button reply-button">
                    <i class="fas fa-reply"></i> Reply
                </a>
                <a href="${pageContext.request.contextPath}/admin/contact-messages/delete/${message.messageId}" 
                   class="action-button delete-button"
                   onclick="return confirm('Are you sure you want to delete this message?')">
                    <i class="fas fa-trash"></i> Delete
                </a>
            </div>
        </div>
    </div>
</body>
</html> 