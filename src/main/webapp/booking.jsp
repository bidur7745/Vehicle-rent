<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.autorent.services.VehicleService" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vehicle - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .booking-hero {
            background-color: #f8f9fa;
            padding: 3rem 0;
            text-align: center;
            margin-bottom: 2rem;
        }

        .booking-hero h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .booking-hero p {
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        .booking-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            padding: 2rem 0;
        }
        
        .vehicle-summary {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .vehicle-summary img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .vehicle-summary h3 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .vehicle-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #666;
        }

        .feature-item i {
            color: #1877F2;
        }
        
        .booking-details {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .booking-details h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        
        .price-summary {
            margin-top: 2rem;
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .price-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: #666;
        }
        
        .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1877F2;
            border-top: 2px solid #dee2e6;
            padding-top: 1rem;
            margin-top: 1rem;
        }

        .booking-notice {
            margin-top: 1.5rem;
            padding: 1rem;
            background: #e8f4ff;
            border-radius: 8px;
            color: #1877F2;
        }

        .booking-notice i {
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .booking-container {
                grid-template-columns: 1fr;
            }

            .vehicle-features {
                grid-template-columns: 1fr;
            }

            .booking-hero h1 {
                font-size: 2rem;
            }
        }

        .site-footer {
            background-color: #1a1a1a;
            color: #ffffff;
            padding: 60px 0 20px;
            margin-top: 60px;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }

        .footer-brand h3 {
            color: #1877F2;
            font-size: 1.8rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-brand p {
            color: #b3b3b3;
            margin-bottom: 20px;
        }

        .social-links {
            display: flex;
            gap: 15px;
        }

        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: #2a2a2a;
            border-radius: 50%;
            color: #ffffff;
            transition: all 0.3s ease;
        }

        .social-link:hover {
            background: #1877F2;
            transform: translateY(-3px);
        }

        .footer-links h4,
        .footer-contact h4,
        .footer-newsletter h4 {
            color: #ffffff;
            font-size: 1.2rem;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-links h4::after,
        .footer-contact h4::after,
        .footer-newsletter h4::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 40px;
            height: 2px;
            background: #1877F2;
        }

        .footer-links ul,
        .footer-contact ul {
            list-style: none;
            padding: 0;
        }

        .footer-links li,
        .footer-contact li {
            margin-bottom: 12px;
        }

        .footer-links a,
        .footer-contact a {
            color: #b3b3b3;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .footer-links a:hover,
        .footer-contact a:hover {
            color: #1877F2;
            padding-left: 5px;
        }

        .footer-contact li {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #b3b3b3;
        }

        .footer-contact i {
            color: #1877F2;
        }

        .footer-newsletter p {
            color: #b3b3b3;
            margin-bottom: 20px;
        }

        .newsletter-form {
            display: flex;
            gap: 10px;
        }

        .newsletter-form input {
            flex: 1;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background: #2a2a2a;
            color: #ffffff;
        }

        .btn-subscribe {
            padding: 10px 20px;
            background: #1877F2;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-subscribe:hover {
            background: #1464d8;
        }

        .footer-bottom {
            border-top: 1px solid #2a2a2a;
            padding-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .footer-bottom p {
            color: #b3b3b3;
            margin: 0;
        }

        .footer-bottom span {
            color: #1877F2;
        }

        .footer-legal {
            display: flex;
            gap: 20px;
        }

        .footer-legal a {
            color: #b3b3b3;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-legal a:hover {
            color: #1877F2;
        }

        @media (max-width: 768px) {
            .footer-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }

            .footer-legal {
                justify-content: center;
            }

            .newsletter-form {
                flex-direction: column;
            }
        }

        /* Add red border for validation errors */
        .form-control.error {
            border: 1px solid #dc3545;
        }
        
        .error-message {
            color: #dc3545;
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <%
        // Get vehicle ID from URL parameter
        String vehicleIdParam = request.getParameter("id");
        int vehicleId = 0;
        Vehicle vehicle = null;
        String imageBase64 = "";
        
        try {
            if (vehicleIdParam != null && !vehicleIdParam.isEmpty()) {
                vehicleId = Integer.parseInt(vehicleIdParam);
                VehicleService vehicleService = new VehicleService();
                vehicle = vehicleService.getVehicleById(vehicleId);
                
                if (vehicle != null && vehicle.getImage() != null && vehicle.getImage().length > 0) {
                    imageBase64 = Base64.getEncoder().encodeToString(vehicle.getImage());
                }
            }
        } catch (NumberFormatException e) {
            // Invalid ID format, leave vehicle as null
        }
        
        if (vehicle == null) {
            // Redirect to vehicles page if vehicle not found
            response.sendRedirect("vehicles.jsp");
            return;
        }
        
        // Check if user is logged in - you might want to redirect to login page if not
        // For now we'll allow bookings without login for demonstration
    %>

    <main>
        <section class="booking-hero">
            <div class="container">
                <h1>Book Your Vehicle</h1>
                <p>Complete your booking in just a few simple steps</p>
            </div>
        </section>

        <section class="container">
            <div class="booking-container">
                <div class="vehicle-summary">
                    <% if (imageBase64 != null && !imageBase64.isEmpty()) { %>
                        <img src="data:image/jpeg;base64,<%= imageBase64 %>" alt="<%= vehicle.getName() %>" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/BMW-X7-model-card.webp';">
                    <% } else { %>
                        <img src="${pageContext.request.contextPath}/assets/images/BMW-X7-model-card.webp" alt="<%= vehicle.getName() %>">
                    <% } %>
                    <h3><%= vehicle.getName() %></h3>
                    <div class="vehicle-features">
                        <div class="feature-item">
                            <i class="fas fa-users"></i>
                            <span><%= vehicle.getSeatingCapacity() %> Seats</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-cog"></i>
                            <span><%= vehicle.getType() %></span>
                        </div>
                        <% if (vehicle.getFuelType() != null && !vehicle.getFuelType().isEmpty()) { %>
                        <div class="feature-item">
                            <i class="fas fa-gas-pump"></i>
                            <span><%= vehicle.getFuelType() %></span>
                        </div>
                        <% } %>
                        <div class="feature-item">
                            <i class="fas fa-car"></i>
                            <span><%= vehicle.getVehicleType() %></span>
                        </div>
                    </div>
                    <div class="price-item">
                        <span>Base Rate:</span>
                        <span>Rs<%= vehicle.getRentPerDay() %>/day</span>
                    </div>
                    <div class="booking-notice">
                        <i class="fas fa-info-circle"></i>
                        <span>Free cancellation up to 24 hours before pickup</span><br>
                        <i class="fas fa-exclamation-triangle"></i>
                        <span> In case of vehicle damage, you are liable for repair costs. </span><br>
                        <i class="fas fa-id-card"></i> 
                        <span>A valid driving license and minimum age of 18+ are mandatory to book a vehicle.</span>
                    </div>
                </div>

                <div class="booking-details">
                    <h3>Booking Details</h3>
                    <form id="bookingForm" action="process-booking" method="post">
                        <!-- Add hidden fields -->
                        <input type="hidden" name="vehicleId" value="<%= vehicle.getVehicleId() %>">
                        <input type="hidden" name="userId" value="${sessionScope.userId}">
                        <input type="hidden" name="totalPrice" id="hiddenTotalPrice" value="0">
                        
                        <div class="form-group">
                            <label for="pickupLocation">Pickup Location</label>
                            <input type="text" id="pickupLocation" name="pickupLocation" class="form-control" placeholder="Enter pickup location" required>
                            <div class="error-message" id="pickupLocation-error"></div>
                        </div>
                        
                        <div class="form-group">
                            <label for="dropLocation">Drop Location</label>
                            <input type="text" id="dropLocation" name="dropLocation" class="form-control" placeholder="Enter drop location" required>
                            <div class="error-message" id="dropLocation-error"></div>
                        </div>

                        <div class="form-row" style="display: flex; gap: 1rem;">
                            <div class="form-group" style="flex: 1;">
                                <label for="startDate">Pickup Date</label>
                                <input type="date" id="startDate" name="startDate" class="form-control" required>
                                <div class="error-message" id="startDate-error"></div>
                            </div>

                            <div class="form-group" style="flex: 1;">
                                <label for="pickupTime">Pickup Time</label>
                                <input type="time" id="pickupTime" name="pickupTime" class="form-control" required>
                                <div class="error-message" id="pickupTime-error"></div>
                            </div>
                        </div>

                        <div class="form-row" style="display: flex; gap: 1rem;">
                            <div class="form-group" style="flex: 1;">
                                <label for="endDate">Return Date</label>
                                <input type="date" id="endDate" name="endDate" class="form-control" required>
                                <div class="error-message" id="endDate-error"></div>
                            </div>

                            <div class="form-group" style="flex: 1;">
                                <label for="dropTime">Return Time</label>
                                <input type="time" id="dropTime" name="dropTime" class="form-control" required>
                                <div class="error-message" id="dropTime-error"></div>
                            </div>
                        </div>

                        <div class="price-summary">
                            <div class="price-item">
                                <span>Daily Rate:</span>
                                <span>Rs<%= vehicle.getRentPerDay() %></span>
                            </div>
                            <div class="price-item">
                                <span>Number of Days:</span>
                                <span id="daysCount">0</span>
                            </div>
                            <div class="price-item">
                                <span>Service Charge:</span>
                                <span>Rs500/day</span>
                            </div>
                            <div class="price-item total-price">
                                <span>Total Price:</span>
                                <span id="totalPrice">Rs0</span>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1.5rem;">
                            <i class="fas fa-check-circle"></i> Confirm Booking
                        </button>
                    </form>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="components/footer.jsp" />

   
    <!-- <script>
        // Mobile menu functionality
        const mobileMenuBtn = document.querySelector('.mobile-menu');
        const navContainer = document.querySelector('.nav-container');
        
        mobileMenuBtn.addEventListener('click', () => {
            navContainer.classList.toggle('active');
            mobileMenuBtn.innerHTML = navContainer.classList.contains('active') 
                ? '<i class="fas fa-times"></i>' 
                : '<i class="fas fa-bars"></i>';
        });

        document.addEventListener('click', (e) => {
            if (!navContainer.contains(e.target) && navContainer.classList.contains('active')) {
                navContainer.classList.remove('active');
                mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
            }
        });

        // Booking form validation and calculations
        document.addEventListener('DOMContentLoaded', function() {
            const bookingForm = document.getElementById('bookingForm');
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            const pickupTime = document.getElementById('pickupTime');
            const dropTime = document.getElementById('dropTime');
            const daysCount = document.getElementById('daysCount');
            const totalPriceDisplay = document.getElementById('totalPrice');
            const hiddenTotalPrice = document.getElementById('hiddenTotalPrice');
            
            // Get the vehicle's daily rate directly from JSP - debug line
            console.log("Raw rent per day value: <%= vehicle.getRentPerDay() %>");
            const dailyRate = parseInt('<%= vehicle.getRentPerDay() %>');
            console.log("Parsed daily rate:", dailyRate);
            const serviceCharge = 500;
            
            console.log('Initial daily rate:', dailyRate);

            // Set today's date as minimum for pickup date
            const today = new Date().toISOString().split('T')[0];
            startDate.min = today;
            endDate.min = today;
            
            // Initialize pickup date to today
            startDate.value = today;
            
            // Initialize return date to tomorrow
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            endDate.value = tomorrow.toISOString().split('T')[0];
            
            // Set default pickup and return times
            pickupTime.value = "10:00";
            dropTime.value = "10:00";
            
            // Calculate price immediately
            calculatePrice();

            function calculatePrice() {
                if (startDate.value && endDate.value) {
                    try {
                        const start = new Date(startDate.value);
                        const end = new Date(endDate.value);
                        
                        console.log("Start date:", start);
                        console.log("End date:", end);
                        
                        // Ensure end date is not before start date
                        if (end < start) {
                            endDate.classList.add('error');
                            document.getElementById('endDate-error').textContent = 'Return date cannot be before pickup date';
                            return;
                        } else {
                            endDate.classList.remove('error');
                            document.getElementById('endDate-error').textContent = '';
                        }
                        
                        // Calculate number of days (inclusive of start and end dates)
                        const diffTime = Math.abs(end - start);
                        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                        
                        // Ensure at least 1 day
                        const rentalDays = Math.max(1, diffDays);
                        
                        console.log('Calculated days:', rentalDays);
                        daysCount.textContent = rentalDays;
                        
                        // Calculate total price
                        const total = (dailyRate + serviceCharge) * rentalDays;
                        console.log('Calculation breakdown:', dailyRate, '+', serviceCharge, '*', rentalDays, '=', total);
                        
                        totalPriceDisplay.textContent = 'Rs' + total.toFixed(2);
                        hiddenTotalPrice.value = total.toFixed(2);
                    } catch (error) {
                        console.error('Error calculating price:', error);
                    }
                }
            }

            // Add event listeners for date and time fields
            startDate.addEventListener('change', calculatePrice);
            endDate.addEventListener('change', calculatePrice);
            pickupTime.addEventListener('change', calculatePrice);
            dropTime.addEventListener('change', calculatePrice);
            
            // Validate end date is after start date
            startDate.addEventListener('change', function() {
                // Make sure end date is at least the same as start date
                if (new Date(endDate.value) < new Date(startDate.value)) {
                    endDate.value = startDate.value;
                }
                endDate.min = startDate.value;
            calculatePrice();
            });
            
            // Explicitly prevent end date from being before start date
            endDate.addEventListener('change', function() {
                const start = new Date(startDate.value);
                const end = new Date(endDate.value);
                
                if (end < start) {
                    alert('Return date cannot be before pickup date');
                    endDate.value = startDate.value;
                }
                calculatePrice();
            });
            
            // Form validation
            bookingForm.addEventListener('submit', function(event) {
                let isValid = true;
                
                // Validate pickup location
                const pickupLocation = document.getElementById('pickupLocation');
                if (!pickupLocation.value) {
                    pickupLocation.classList.add('error');
                    document.getElementById('pickupLocation-error').textContent = 'Please enter a pickup location';
                    isValid = false;
                } else {
                    pickupLocation.classList.remove('error');
                    document.getElementById('pickupLocation-error').textContent = '';
                }
                
                // Validate drop location
                const dropLocation = document.getElementById('dropLocation');
                if (!dropLocation.value) {
                    dropLocation.classList.add('error');
                    document.getElementById('dropLocation-error').textContent = 'Please enter a drop location';
                    isValid = false;
                } else {
                    dropLocation.classList.remove('error');
                    document.getElementById('dropLocation-error').textContent = '';
                }
                
                // Validate start date
                if (!startDate.value) {
                    startDate.classList.add('error');
                    document.getElementById('startDate-error').textContent = 'Please select a pickup date';
                    isValid = false;
                } else {
                    startDate.classList.remove('error');
                    document.getElementById('startDate-error').textContent = '';
                }
                
                // Validate end date
                if (!endDate.value) {
                    endDate.classList.add('error');
                    document.getElementById('endDate-error').textContent = 'Please select a return date';
                    isValid = false;
                } else {
                    // Check that end date is not before start date
                    const start = new Date(startDate.value);
                    const end = new Date(endDate.value);
                    if (end < start) {
                        endDate.classList.add('error');
                        document.getElementById('endDate-error').textContent = 'Return date cannot be before pickup date';
                        isValid = false;
                    } else {
                        endDate.classList.remove('error');
                        document.getElementById('endDate-error').textContent = '';
                    }
                }
                
                // Validate pickup time
                if (!pickupTime.value) {
                    pickupTime.classList.add('error');
                    document.getElementById('pickupTime-error').textContent = 'Please select a pickup time';
                    isValid = false;
                } else {
                    pickupTime.classList.remove('error');
                    document.getElementById('pickupTime-error').textContent = '';
                }
                
                // Validate drop time
                if (!dropTime.value) {
                    dropTime.classList.add('error');
                    document.getElementById('dropTime-error').textContent = 'Please select a return time';
                    isValid = false;
                } else {
                    dropTime.classList.remove('error');
                    document.getElementById('dropTime-error').textContent = '';
                }
                
                // Force recalculate price to ensure it's correct before submitting
                calculatePrice();
                
                if (!isValid) {
                    event.preventDefault();
                } else {
                    // Double check the total price is set correctly
                    const calculatedTotal = (dailyRate + serviceCharge) * parseInt(daysCount.textContent);
                    console.log("Final submission price:", calculatedTotal.toFixed(2));
                    hiddenTotalPrice.value = calculatedTotal.toFixed(2);

                    // Additional check to ensure price is not zero
                    if (parseFloat(hiddenTotalPrice.value) <= 0) {
                        console.error("Error: Total price is zero or negative!");
                        alert("There was an error calculating the price. Please try again.");
                        event.preventDefault();
                        return;
                    }
                    
                    console.log("Submitting form with total price: " + hiddenTotalPrice.value);
                }
            });
        });
    </script> -->



    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const bookingForm = document.getElementById('bookingForm');
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            const pickupTime = document.getElementById('pickupTime');
            const dropTime = document.getElementById('dropTime');
            const pickupLocation = document.getElementById('pickupLocation');
            const dropLocation = document.getElementById('dropLocation');
        
            const daysCount = document.getElementById('daysCount');
            const totalPriceDisplay = document.getElementById('totalPrice');
            const hiddenTotalPrice = document.getElementById('hiddenTotalPrice');
        
            const dailyRate = parseFloat('<%= vehicle.getRentPerDay() %>') || 0;
            const serviceCharge = 500;
        
            // Set today's date and tomorrow for initial inputs
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
        
            startDate.value = today.toISOString().split('T')[0];
            endDate.value = tomorrow.toISOString().split('T')[0];
            startDate.min = today.toISOString().split('T')[0];
            endDate.min = today.toISOString().split('T')[0];
        
            pickupTime.value = "10:00";
            dropTime.value = "10:00";
        
            calculatePrice();
        
            function calculatePrice() {
                const start = new Date(startDate.value);
                const end = new Date(endDate.value);
        
                if (!startDate.value || !endDate.value || isNaN(start) || isNaN(end)) {
                    return;
                }
        
                if (end < start) {
                    daysCount.textContent = '0';
                    totalPriceDisplay.textContent = 'Rs0.00';
                    hiddenTotalPrice.value = '0';
                    document.getElementById('endDate-error').textContent = 'Return date cannot be before pickup date';
                    return;
                } else {
                    document.getElementById('endDate-error').textContent = '';
                }
        
                const timeDiff = Math.abs(end - start);
                const rentalDays = Math.max(1, Math.ceil(timeDiff / (1000 * 60 * 60 * 24)));
                const total = (dailyRate + serviceCharge) * rentalDays;
        
                daysCount.textContent = rentalDays;
                totalPriceDisplay.textContent = 'Rs' + total.toFixed(2);
                hiddenTotalPrice.value = total.toFixed(2);
            }
        
            // Auto-correct end date if before start date
            startDate.addEventListener('change', () => {
                if (new Date(endDate.value) < new Date(startDate.value)) {
                    endDate.value = startDate.value;
                }
                endDate.min = startDate.value;
                calculatePrice();
            });
        
            endDate.addEventListener('change', () => {
                const start = new Date(startDate.value);
                const end = new Date(endDate.value);
                if (end < start) {
                    alert('Return date cannot be before pickup date. It has been corrected.');
                    endDate.value = startDate.value;
                }
                calculatePrice();
            });
        
            pickupTime.addEventListener('change', calculatePrice);
            dropTime.addEventListener('change', calculatePrice);
        
            // Validate and handle form submission
            bookingForm.addEventListener('submit', function (e) {
                let isValid = true;
        
                // Clear previous errors
                const clearError = (input, id) => {
                    input.classList.remove('error');
                    document.getElementById(id).textContent = '';
                };
        
                const showError = (input, id, msg) => {
                    input.classList.add('error');
                    document.getElementById(id).textContent = msg;
                    isValid = false;
                };
        
                if (!pickupLocation.value.trim()) {
                    showError(pickupLocation, 'pickupLocation-error', 'Please enter a pickup location');
                } else {
                    clearError(pickupLocation, 'pickupLocation-error');
                }
        
                if (!dropLocation.value.trim()) {
                    showError(dropLocation, 'dropLocation-error', 'Please enter a drop location');
                } else {
                    clearError(dropLocation, 'dropLocation-error');
                }
        
                if (!startDate.value) {
                    showError(startDate, 'startDate-error', 'Please select a pickup date');
                } else {
                    clearError(startDate, 'startDate-error');
                }
        
                if (!endDate.value) {
                    showError(endDate, 'endDate-error', 'Please select a return date');
                } else {
                    clearError(endDate, 'endDate-error');
                }
        
                if (!pickupTime.value) {
                    showError(pickupTime, 'pickupTime-error', 'Please select a pickup time');
                } else {
                    clearError(pickupTime, 'pickupTime-error');
                }
        
                if (!dropTime.value) {
                    showError(dropTime, 'dropTime-error', 'Please select a return time');
                } else {
                    clearError(dropTime, 'dropTime-error');
                }
        
                // Force recalculate and final check
                calculatePrice();
        
                const total = parseFloat(hiddenTotalPrice.value);
                if (isNaN(total) || total <= 0) {
                    alert('Invalid total price. Please recheck dates.');
                    isValid = false;
                }
        
                if (!isValid) {
                    e.preventDefault();
                }
            });
        });
        </script>
        


















</body>
</html> 