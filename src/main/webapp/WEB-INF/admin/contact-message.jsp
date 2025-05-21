<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Messages - AutoRent Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
        }
        .content {
            margin-left: 250px;
            padding: 2rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #374151;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #1f2937;
        }

        .messages-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 1.5rem;
        }

        .message-card {
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            position: relative; /* Needed for absolute positioning of message-id */
        }

        .message-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
            position: relative; /* Needed for message-id positioning */
        }

        .message-id {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background-color: #e5e7eb;
            color: #4b5563;
            padding: 0.15rem 0.5rem;
            border-radius: 0.2rem;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .message-subject {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
            line-height: 1.3;
            padding-right: 3rem; /* Make space for ID */
        }

        .message-meta {
            display: grid;
            grid-template-columns: auto 1fr;
            gap: 0.5rem 1rem;
            color: #6b7280;
            font-size: 0.875rem;
            align-items: center;
        }

        .message-meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .message-meta-item i {
             color: #9ca3af;
             font-size: 0.9rem;
             width: 1.1rem; /* Fixed width for icon */
             text-align: center;
        }

        .message-body {
            padding: 1.5rem;
            color: #374151;
            line-height: 1.6;
            /* white-space: pre-wrap; */
            flex-grow: 1;
            border-bottom: 1px solid #e5e7eb;
        }

        .message-actions {
            padding: 1rem 1.5rem;
            display: flex;
            gap: 0.75rem;
            justify-content: flex-end;
            background-color: #f9fafb;
        }

        .action-button {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            transition: background-color 0.2s;
            display: inline-flex; /* Use inline-flex to wrap content */
            align-items: center;
            gap: 0.5rem;
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

        .no-messages {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
            font-size: 1.25rem;
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .no-messages i {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            color: #9ca3af;
        }
    </style>
</head>
<body>
    <jsp:include page="components/admin-sidebar.jsp"/>

    <div class="content">
        <div class="page-header">
            <h1 class="page-title">Contact Messages</h1>
        </div>

        <c:if test="${empty contactMessages}">
            <div class="no-messages">
                <i class="fas fa-inbox"></i>
                <p>No contact messages found.</p>
            </div>
        </c:if>

        <c:if test="${not empty contactMessages}">
            <div class="messages-grid">
                <c:forEach items="${contactMessages}" var="message">
                    <div class="message-card">
                        <div class="message-header">
                            <span class="message-id">#${message.messageId}</span>
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
                                    <i class="fas fa-id-card"></i>
                                    <span>User ID: ${message.userId}</span>
                                </div>
                            </div>
                        </div>
                        <div class="message-body">
                            ${message.messageBody}
                        </div>
                        <div class="message-actions">
                            <a href="mailto:${message.email}?subject=Re: ${message.subject}" 
                               class="action-button reply-button">
                                <i class="fas fa-reply"></i> Reply
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/contact-messages/delete/${message.messageId}" 
                               class="action-button delete-button"
                               onclick="return confirm('Are you sure you want to delete this message?')">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</body>
</html>
