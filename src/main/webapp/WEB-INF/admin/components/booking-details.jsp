<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.autorent.model.User" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="com.autorent.services.UserService" %>
<%@ page import="com.autorent.services.VehicleService" %>
<%@ page import="com.autorent.services.AuthService" %>

<%
    System.out.println("Booking details JSP: Starting to fetch related data");
    
    // Get additional user and vehicle information if not already provided
    if (request.getAttribute("customer") == null && request.getAttribute("booking") != null) {
        try {
            com.autorent.model.Booking booking = (com.autorent.model.Booking) request.getAttribute("booking");
            System.out.println("Booking details JSP: Booking ID = " + booking.getBookingId() + ", User ID = " + booking.getUserId());
            
            VehicleService vehicleService = new VehicleService();
            
            // Get customer details (the user who made the booking)
            System.out.println("Booking details JSP: Calling AuthService.getUserById with userId = " + booking.getUserId());
            User customer = AuthService.getUserById(booking.getUserId());
            
            if (customer != null) {
                request.setAttribute("customer", customer);
                System.out.println("Booking details JSP: Customer found and set: " + customer.getFirstName() + " " + customer.getLastName());
            } else {
                System.out.println("Booking details JSP: No customer found with ID: " + booking.getUserId());
            }
            
            // Get vehicle details
            Vehicle vehicle = vehicleService.getVehicleById(booking.getVehicleId());
            if (vehicle != null) {
                request.setAttribute("vehicle", vehicle);
                System.out.println("Booking details JSP: Vehicle attribute set");
            }
        } catch (Exception e) {
            System.err.println("Error fetching related data for booking details: " + e.getMessage());
            e.printStackTrace();
        }
    } else {
        System.out.println("Booking details JSP: Customer already set or booking not available");
    }
%>

<!-- Booking Details Modal Content -->
<div class="detail-section">
    <h3>Booking Information</h3>
    <div class="detail-grid">
        <div class="detail-item">
            <div class="detail-label">Booking ID</div>
            <div class="detail-value">#${booking.bookingId}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">Status</div>
            <div class="detail-value status-${booking.status}">${booking.status}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">Created At</div>
            <div class="detail-value">${booking.createdAt}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">Total Price</div>
            <div class="detail-value highlight-price">RS ${booking.totalPrice}</div>
        </div>
    </div>
</div>

<div class="detail-section">
    <h3>Customer Information</h3>
    <div class="detail-grid">
        <div class="detail-item">
            <div class="detail-label">Customer ID</div>
            <div class="detail-value">#${booking.userId}</div>
        </div>
        <c:if test="${customer != null}">
            <div class="detail-item">
                <div class="detail-label">Name</div>
                <div class="detail-value">${customer.firstName} ${customer.lastName}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Email</div>
                <div class="detail-value">${customer.email}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Phone</div>
                <div class="detail-value">${customer.phone}</div>
            </div>
        </c:if>
    </div>
</div>

<div class="detail-section">
    <h3>Vehicle Information</h3>
    <div class="detail-grid">
        <div class="detail-item">
            <div class="detail-label">Vehicle ID</div>
            <div class="detail-value">#${booking.vehicleId}</div>
        </div>
        <c:if test="${vehicle != null}">
            <div class="detail-item">
                <div class="detail-label">Name</div>
                <div class="detail-value">${vehicle.name}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Type</div>
                <div class="detail-value">${vehicle.type}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Vehicle Type</div>
                <div class="detail-value">${vehicle.vehicleType}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Fuel Type</div>
                <div class="detail-value">${vehicle.fuelType}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Color</div>
                <div class="detail-value">${vehicle.color}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Seating Capacity</div>
                <div class="detail-value">${vehicle.seatingCapacity} persons</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Airbags</div>
                <div class="detail-value">${vehicle.noOfAirbags}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Daily Rate</div>
                <div class="detail-value highlight-price">RS ${vehicle.rentPerDay}</div>
            </div>
            <div class="detail-item">
                <div class="detail-label">Availability Status</div>
                <div class="detail-value">${vehicle.availabilityStatus}</div>
            </div>
        </c:if>
    </div>
</div>

<div class="detail-section">
    <h3>Booking Dates</h3>
    <div class="detail-grid">
        <div class="detail-item">
            <div class="detail-label">Start Date</div>
            <div class="detail-value">${booking.startDateTime}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">End Date</div>
            <div class="detail-value">${booking.endDateTime}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">Pickup Location</div>
            <div class="detail-value">${booking.pickupLocation}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">Drop Location</div>
            <div class="detail-value">${booking.dropLocation != null ? booking.dropLocation : 'Not specified'}</div>
        </div>
        <c:if test="${booking.pickupTime != null && booking.pickupTime != ''}">
            <div class="detail-item">
                <div class="detail-label">Pickup Time</div>
                <div class="detail-value">${booking.pickupTime}</div>
            </div>
        </c:if>
        <c:if test="${booking.dropTime != null && booking.dropTime != ''}">
            <div class="detail-item">
                <div class="detail-label">Drop Time</div>
                <div class="detail-value">${booking.dropTime}</div>
            </div>
        </c:if>
    </div>
</div>

<c:if test="${booking.status != 'cancelled'}">
    <div class="detail-section">
        <h3>Rental Duration</h3>
        <div class="detail-grid">
            <%
                try {
                    com.autorent.model.Booking booking = (com.autorent.model.Booking) request.getAttribute("booking");
                    java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    java.time.LocalDateTime startDate = java.time.LocalDateTime.parse(booking.getStartDateTime(), formatter);
                    java.time.LocalDateTime endDate = java.time.LocalDateTime.parse(booking.getEndDateTime(), formatter);
                    
                    long days = java.time.Duration.between(startDate, endDate).toDays();
                    if (java.time.Duration.between(startDate, endDate).toHours() % 24 > 0) {
                        days += 1; // Add an extra day for partial days
                    }
                    
                    request.setAttribute("rentalDays", days);
                } catch (Exception e) {
                    System.err.println("Error calculating rental duration: " + e.getMessage());
                }
            %>
            <div class="detail-item">
                <div class="detail-label">Rental Days</div>
                <div class="detail-value">${rentalDays}</div>
            </div>
            <c:if test="${vehicle != null}">
                <div class="detail-item">
                    <div class="detail-label">Daily Rate</div>
                    <div class="detail-value highlight-price">RS ${vehicle.rentPerDay}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Calculation</div>
                    <div class="detail-value highlight-price">${rentalDays} days × RS ${vehicle.rentPerDay}</div>
                </div>
            </c:if>
        </div>
    </div>
</c:if> 