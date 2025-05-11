<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simple Invoice</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 2rem;
        }
        h1 {
            color: #1877F2;
        }
    </style>
</head>
<body>
    <h1>Invoice Page</h1>
    <p>This is a simple test invoice page to verify server configuration.</p>
    
    <p>Context Path: <%= request.getContextPath() %></p>
    <p>Servlet Path: <%= request.getServletPath() %></p>
    <p>Request URI: <%= request.getRequestURI() %></p>
    
    <a href="<%= request.getContextPath() %>/index.jsp">Return to Home</a>
</body>
</html> 