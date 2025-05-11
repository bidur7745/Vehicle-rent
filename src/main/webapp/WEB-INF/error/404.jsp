<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>404 - Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #f5f5f5;
        }
        
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        
        h1 {
            color: #e74c3c;
        }
        
        .error-info {
            margin-top: 20px;
            padding: 15px;
            background: #ffeeee;
            border-radius: 5px;
            text-align: left;
        }
        
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #1877F2;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%
        System.out.println("404.jsp: Handling 404 error");
        String requestedURI = (String) request.getAttribute("jakarta.servlet.error.request_uri");
        System.out.println("404.jsp: Requested URI: " + requestedURI);
    %>

    <div class="container">
        <h1>404 - Page Not Found</h1>
        <p>We're sorry, but the page you were looking for could not be found.</p>
        
        <div class="error-info">
            <h3>Error Details</h3>
            <p><strong>Requested URL:</strong> <%= requestedURI %></p>
            <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
        </div>
        
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn">Return to Home</a>
    </div>
</body>
</html> 