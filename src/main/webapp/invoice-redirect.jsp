<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.autorent.model.Booking" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation - AutoRent</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .container {
            background: white;
            max-width: 600px;
            width: 100%;
            margin: 2rem auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        h1 {
            color: #1877F2;
        }
        
        .info {
            margin-top: 20px;
            padding: 15px;
            background: #e8f4ff;
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

        .success-icon {
            font-size: 60px;
            color: #28a745;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />
    
    <%
        System.out.println("invoice-redirect.jsp: Starting debug page");
        
        // Get booking and payment information from session
        Booking booking = (Booking) session.getAttribute("tempBooking");
        Vehicle vehicle = (Vehicle) session.getAttribute("bookingVehicle");
        String paymentId = (String) session.getAttribute("paymentId");
        String paymentMethod = (String) session.getAttribute("paymentMethod");
        Integer bookingId = (Integer) session.getAttribute("bookingId");
        
        // Debug output
        System.out.println("invoice-redirect.jsp: tempBooking: " + (booking != null ? "exists" : "null"));
        System.out.println("invoice-redirect.jsp: bookingVehicle: " + (vehicle != null ? "exists" : "null"));
        System.out.println("invoice-redirect.jsp: paymentId: " + paymentId);
        System.out.println("invoice-redirect.jsp: paymentMethod: " + paymentMethod);
        System.out.println("invoice-redirect.jsp: bookingId: " + bookingId);
        
        if (booking != null) {
            System.out.println("invoice-redirect.jsp: Booking total price: " + booking.getTotalPrice());
        }
        
        if (vehicle != null) {
            System.out.println("invoice-redirect.jsp: Vehicle name: " + vehicle.getName());
        }
    %>
    
    <div class="container">
        <div class="success-icon">✓</div>
        <h1>Your Booking is Confirmed!</h1>
        <p>Thank you for choosing AutoRent. Your booking has been successfully processed.</p>
        
        <div class="info">
            <h3>Booking Summary</h3>
            <% if (booking != null && vehicle != null) { %>
                <p><strong>Booking ID:</strong> <%= bookingId %></p>
                <p><strong>Vehicle:</strong> <%= vehicle.getName() %></p>
                <p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
                <p><strong>Pickup Date:</strong> <%= booking.getStartDateTime().split(" ")[0] %></p>
                <p><strong>Return Date:</strong> <%= booking.getEndDateTime().split(" ")[0] %></p>
                <p><strong>Total Amount:</strong> Rs<%= booking.getTotalPrice() %></p>
                <p><strong>Payment ID:</strong> <%= paymentId %></p>
                <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
            <% } else { %>
                <p>Booking information not available</p>
            <% } %>
        </div>
        
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn">Return to Home</a>
    </div>
    
    <jsp:include page="components/footer.jsp" />
</body>
</html> 