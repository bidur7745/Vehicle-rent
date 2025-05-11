<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.autorent.model.Booking" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="com.autorent.model.User" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


    <title>Booking Invoice - AutoRent</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .invoice-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 12px;
        }
        
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .company-info {
            display: flex;
            flex-direction: column;
        }
        
        .company-info h1 {
            color: #1877F2;
            margin: 0 0 0.5rem 0;
            font-size: 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .company-address {
            color: #666;
            font-size: 0.9rem;
        }
        
        .invoice-details {
            text-align: right;
        }
        
        .invoice-details h2 {
            margin: 0 0 0.5rem 0;
            color: #333;
        }
        
        .invoice-details .invoice-id {
            font-size: 1.2rem;
            color: #1877F2;
            margin-bottom: 0.5rem;
        }
        
        .invoice-date, .payment-method {
            color: #666;
            margin-bottom: 0.25rem;
        }
        
        .payment-status {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.9rem;
            font-weight: bold;
            background-color: #e6f4ea;
            color: #137333;
            margin-top: 0.5rem;
        }
        
        .payment-status.pending {
            background-color: #fff8e1;
            color: #f9a825;
        }
        
        .customer-details, .vehicle-details, .booking-details {
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #eee;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        
        .detail-item {
            margin-bottom: 0.5rem;
        }
        
        .detail-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .detail-value {
            font-weight: bold;
            color: #333;
        }
        
        .price-summary {
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 2px solid #eee;
        }
        
        .price-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            color: #666;
        }
        
        .total-price {
            display: flex;
            justify-content: space-between;
            font-size: 1.5rem;
            font-weight: bold;
            color: #1877F2;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        
        .invoice-footer {
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            font-size: 0.9rem;
            color: #666;
            text-align: center;
        }
        
        .invoice-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: #1877F2;
            color: white;
            border: none;
        }
        
        .btn-outline {
            background-color: transparent;
            color: #1877F2;
            border: 2px solid #1877F2;
        }
        
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        .success-icon {
            display: flex;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .success-icon i {
            font-size: 5rem;
            color: #28a745;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <%
        System.out.println("Invoice.jsp: Starting to process invoice page");
        
        // Get booking and payment information from session
        Booking booking = (Booking) session.getAttribute("tempBooking");
        Vehicle vehicle = (Vehicle) session.getAttribute("bookingVehicle");
        User user = (User) session.getAttribute("user");
        String paymentId = (String) session.getAttribute("paymentId");
        String paymentMethod = (String) session.getAttribute("paymentMethod");
        Integer bookingId = (Integer) session.getAttribute("bookingId");
        
        System.out.println("Invoice.jsp: paymentId: " + paymentId);
        System.out.println("Invoice.jsp: paymentMethod: " + paymentMethod);
        System.out.println("Invoice.jsp: bookingId: " + bookingId);
        
        // Format current date
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
        String currentDate = LocalDateTime.now().format(formatter);
        
        // Determine payment status
        String paymentStatus = "paid";
        if (paymentMethod != null && paymentMethod.equals("pay-on-pickup")) {
            paymentStatus = "pending-payment";
        }
    %>

    <div class="invoice-container">
        <div class="success-icon">
            <i>✓</i>
        </div>
        
        <div class="invoice-header">
            <div class="company-info">
                <h1>AutoRent</h1>
                <div class="company-address">
                    Dulari Chowk, Automobile Street Morang, Nepal<br>
                    info@autorent.com | +977 021-555555
                </div>
            </div>
            
            <div class="invoice-details">
                <h2>INVOICE</h2>
                <div class="invoice-id">#<%= bookingId != null ? bookingId : "N/A" %></div>
                <div class="invoice-date">Date: <%= currentDate %></div>
                <div class="payment-method">Method: <%= paymentMethod != null ? paymentMethod : "N/A" %></div>
                <div class="payment-status <%= paymentStatus.equals("pending-payment") ? "pending" : "" %>">
                    <%= paymentStatus.equals("pending-payment") ? "Payment Pending" : "Paid" %>
                </div>
            </div>
        </div>
        
        <% if (booking != null && vehicle != null && user != null) { %>
            <div class="customer-details">
                <div class="section-title">Customer Information</div>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">Name</div>
                        <div class="detail-value"><%= user.getFirstName() %> <%= user.getLastName() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Email</div>
                        <div class="detail-value"><%= user.getEmail() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Phone</div>
                        <div class="detail-value"><%= user.getPhone() %></div>
                    </div>
                </div>
            </div>
            
            <div class="vehicle-details">
                <div class="section-title">Vehicle Information</div>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">Vehicle</div>
                        <div class="detail-value"><%= vehicle.getName() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Type</div>
                        <div class="detail-value"><%= vehicle.getType() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Daily Rate</div>
                        <div class="detail-value">Rs<%= vehicle.getRentPerDay() %></div>
                    </div>
                </div>
            </div>
            
            <div class="booking-details">
                <div class="section-title">Booking Details</div>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">Pickup Location</div>
                        <div class="detail-value"><%= booking.getPickupLocation() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Pickup Date</div>
                        <div class="detail-value"><%= booking.getStartDateTime().split(" ")[0] %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Return Date</div>
                        <div class="detail-value"><%= booking.getEndDateTime().split(" ")[0] %></div>
                    </div>
                </div>
            </div>
            
            <div class="price-summary">
                <div class="section-title">Price Summary</div>
                <div class="price-item">
                    <span>Daily Rate</span>
                    <span>Rs<%= vehicle.getRentPerDay() %></span>
                </div>
                <div class="price-item">
                    <span>Service Charge</span>
                    <span>Rs500</span>
                </div>
                <div class="price-item">
                    <span>Number of Days</span>
                    <span>
                        <% 
                            String startDateString = booking.getStartDateTime().split(" ")[0];
                            String endDateString = booking.getEndDateTime().split(" ")[0];
                            LocalDate start = LocalDate.parse(startDateString);
                            LocalDate end = LocalDate.parse(endDateString);
                            long days = ChronoUnit.DAYS.between(start, end) + 1;
                            out.print(days);
                        %>
                    </span>
                </div>
                
                <div class="total-price">
                    <span>Total</span>
                    <span>Rs<%= booking.getTotalPrice() %></span>
                </div>
            </div>
        <% } else { %>
            <div class="section-title">Booking Information</div>
            <p>Booking information not available. Please contact customer support.</p>
        <% } %>
        
        <div class="invoice-footer">
            <p>Thank you for choosing AutoRent for your vehicle rental needs!</p>
        </div>
        
        <div class="invoice-actions">
            <button class="btn btn-primary" onclick="window.print()">Print Invoice</button>
            <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline">Return to Home</a>
        </div>
    </div>
    
    <jsp:include page="components/footer.jsp" />
</body>
</html> 