<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.autorent.model.Booking" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="com.autorent.services.VehicleService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .bookings-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            margin-top: 90px;
        }

        .bookings-header {
            margin-bottom: 30px;
        }

        .bookings-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .bookings-header p {
            color: #666;
        }

        .booking-filters {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-group label {
            color: #666;
            font-size: 14px;
        }

        .filter-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            color: #333;
        }

        .booking-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .booking-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .booking-image {
            height: 200px;
            background-color: #f8f9fa;
            position: relative;
        }

        .booking-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .booking-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 20px;
            color: white;
            font-size: 12px;
            font-weight: 500;
        }

        .status-active {
            background-color: #28a745;
        }

        .status-completed {
            background-color: #6c757d;
        }

        .status-cancelled {
            background-color: #dc3545;
        }

        .status-pending {
            background-color: #ffc107;
            color: #333;
        }

        .booking-details {
            padding: 20px;
        }

        .booking-details h3 {
            color: #333;
            margin: 0 0 10px 0;
            font-size: 18px;
        }

        .booking-info {
            margin-bottom: 15px;
        }

        .booking-info-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            color: #666;
            font-size: 14px;
        }

        .booking-info-item i {
            color: #1877F2;
            width: 16px;
        }

        .booking-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            flex: 1;
            padding: 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            transition: background-color 0.2s;
        }

        .view-btn {
            background-color: #1877F2;
            color: white;
        }

        .view-btn:hover {
            background-color: #1664d9;
        }

        .cancel-btn {
            background-color: #dc3545;
            color: white;
        }

        .cancel-btn:hover {
            background-color: #bb2d3b;
        }

        .no-bookings {
            text-align: center;
            padding: 40px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .no-bookings i {
            font-size: 48px;
            color: #666;
            margin-bottom: 20px;
        }

        .no-bookings h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .no-bookings p {
            color: #666;
            margin-bottom: 20px;
        }

        .browse-btn {
            display: inline-flex;
            align-items: center;
            /* gap: 8px; */
            background: #1877F2;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .browse-btn:hover {
            background: #1664d9;
            text-decoration: none;
            color: white;
        }

        /* Toast Messages */
        .toast {
            position: fixed;
            top: 30px;
            right: 30px;
            min-width: 250px;
            padding: 16px;
            border-radius: 4px;
            color: white;
            text-align: center;
            z-index: 9999;
            font-size: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            opacity: 0.95;
            animation: slideIn 0.5s, fadeOut 0.5s 3s;
        }

        .toast-success {
            background-color: #4CAF50;
        }

        .toast-error {
            background-color: #f44336;
        }

        @keyframes slideIn {
            from {transform: translateX(100%)}
            to {transform: translateX(0)}
        }

        @keyframes fadeOut {
            from {opacity: 0.95}
            to {opacity: 0}
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 0;
            border-radius: 8px;
            width: 80%;
            max-width: 800px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-100px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            padding: 1.5rem;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
            color: #333;
            font-size: 1.5rem;
        }

        .close-modal {
            color: #666;
            font-size: 1.8rem;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close-modal:hover {
            color: #333;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .booking-details-container {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .vehicle-info {
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
        }

        .vehicle-details h3 {
            margin: 0 0 0.5rem 0;
            color: #333;
            font-size: 1.5rem;
        }

        .vehicle-details p {
            margin: 0;
            color: #666;
            font-size: 1.1rem;
        }

        .info-section {
            margin-bottom: 1.5rem;
        }

        .info-section h4 {
            margin: 0 0 1rem 0;
            color: #333;
            font-size: 1.1rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .info-item .label {
            color: #666;
            font-size: 0.9rem;
        }

        .info-item .value {
            color: #333;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .modal-content {
                width: 95%;
                margin: 10% auto;
            }

            .vehicle-info {
                flex-direction: column;
            }

            .vehicle-image {
                width: 100%;
                height: 200px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />

    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) session.getAttribute("successMessage");
        session.removeAttribute("successMessage");
        
        // Set up VehicleService to get vehicle details
        VehicleService vehicleService = new VehicleService();
        
        // Format dates
        DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    %>

    <% if (errorMessage != null) { %>
        <div class="toast toast-error">
            <%= errorMessage %>
        </div>
    <% } %>

    <% if (successMessage != null) { %>
        <div class="toast toast-success">
            <%= successMessage %>
        </div>
    <% } %>

    <div class="bookings-container">
        <div class="bookings-header">
            <h1>My Bookings</h1>
            <p>View and manage your car rental bookings</p>
        </div>

        <div class="booking-filters">
            <div class="filter-group">
                <label for="statusFilter">Status:</label>
                <select id="statusFilter" onchange="filterBookings()">
                    <option value="all">All Bookings</option>
                    <option value="pending">Pending</option>
                    <option value="active">Active</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="dateFilter">Date:</label>
                <select id="dateFilter" onchange="filterBookings()">
                    <option value="all">All Time</option>
                    <option value="month">This Month</option>
                    <option value="year">This Year</option>
                </select>
            </div>
        </div>

        <% if (request.getAttribute("bookings") == null || ((List<Booking>)request.getAttribute("bookings")).isEmpty()) { %>
            <div class="no-bookings">
                <i class="fas fa-calendar-times"></i>
                <h2>No Bookings Found</h2>
                <p>You haven't made any car rental bookings yet.</p>
                <a href="${pageContext.request.contextPath}/vehicles.jsp" class="browse-btn">
                    Browse Cars
                </a>
            </div>
        <% } else { %>
            <div class="booking-cards">
                <% 
                    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                    for(Booking booking : bookings) {
                        try {
                            // Get vehicle details
                            Vehicle vehicle = vehicleService.getVehicleById(booking.getVehicleId());
                            
                            // Convert image to base64 if exists
                            String imageBase64 = "";
                            if (vehicle.getImage() != null) {
                                imageBase64 = Base64.getEncoder().encodeToString(vehicle.getImage());
                            }
                            
                            // Format dates for display
                            LocalDateTime startDate = LocalDateTime.parse(booking.getStartDateTime(), inputFormatter);
                            LocalDateTime endDate = LocalDateTime.parse(booking.getEndDateTime(), inputFormatter);
                            String formattedStartDate = startDate.format(displayFormatter);
                            String formattedEndDate = endDate.format(displayFormatter);
                            
                            // Determine booking status class
                            String statusClass = "";
                            switch(booking.getStatus().toLowerCase()) {
                                case "active":
                                    statusClass = "status-active";
                                    break;
                                case "completed":
                                    statusClass = "status-completed";
                                    break;
                                case "cancelled":
                                    statusClass = "status-cancelled";
                                    break;
                                default:
                                    statusClass = "status-pending";
                            }
                %>
                <div class="booking-card" data-status="<%= booking.getStatus().toLowerCase() %>" data-date="<%= booking.getCreatedAt() %>">
                    <div class="booking-image">
                        <% if(imageBase64 != null && !imageBase64.isEmpty()) { %>
                            <img src="data:image/jpeg;base64,<%= imageBase64 %>" alt="<%= vehicle.getName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/cars/car1.jpg';">
                        <% } else { %>
                            <img src="${pageContext.request.contextPath}/assets/images/cars/car1.jpg" alt="<%= vehicle.getName() %>">
                        <% } %>
                        <span class="booking-status <%= statusClass %>"><%= booking.getStatus() %></span>
                    </div>
                    <div class="booking-details">
                        <h3><%= vehicle.getName() %></h3>
                        <div class="booking-info">
                            <div class="booking-info-item">
                                <i class="fas fa-calendar"></i>
                                <span><%= formattedStartDate %> - <%= formattedEndDate %></span>
                            </div>
                            <div class="booking-info-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span><%= booking.getPickupLocation() %></span>
                            </div>
                            <div class="booking-info-item">
                                <i class="fas fa-money-bill-wave"></i>
                                <span>RS <%= String.format("%.2f", booking.getTotalPrice()) %></span>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn view-btn" onclick="viewBooking('<%= booking.getBookingId() %>')">
                                <i class="fas fa-eye"></i>
                                View Details
                            </button>
                            <% if (booking.getStatus().equalsIgnoreCase("pending") || booking.getStatus().equalsIgnoreCase("active")) { %>
                                <button class="action-btn cancel-btn" onclick="cancelBooking('<%= booking.getBookingId() %>')">
                                    <i class="fas fa-times"></i>
                                    Cancel
                                </button>
                            <% } else { %>
                                <button class="action-btn view-btn" onclick="rebook('<%= booking.getVehicleId() %>')">
                                    <i class="fas fa-redo"></i>
                                    Book Again
                                </button>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% 
                        } catch(Exception e) {
                            // Log any errors
                            System.out.println("Error displaying booking #" + booking.getBookingId() + ": " + e.getMessage());
                            e.printStackTrace();
                        }
                    } 
                %>
            </div>
        <% } %>
    </div>

    <!-- Booking Details Modal -->
    <div id="bookingDetailsModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Booking Details</h2>
                <span class="close-modal">&times;</span>
            </div>
            <div class="modal-body">
                <div class="booking-details-container">
                    <div class="vehicle-info">
                        <div class="vehicle-details">
                            <h3 id="modalVehicleName"></h3>
                            <p id="modalVehicleType"></p>
                        </div>
                    </div>
                    
                    <div class="booking-info">
                        <div class="info-section">
                            <h4>Pickup Information</h4>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="label">Location:</span>
                                    <span id="modalPickupLocation" class="value"></span>
                                </div>
                                <div class="info-item">
                                    <span class="label">Date:</span>
                                    <span id="modalPickupDate" class="value"></span>
                                </div>
                                <div class="info-item">
                                    <span class="label">Time:</span>
                                    <span id="modalPickupTime" class="value"></span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="info-section">
                            <h4>Return Information</h4>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="label">Location:</span>
                                    <span id="modalDropLocation" class="value"></span>
                                </div>
                                <div class="info-item">
                                    <span class="label">Date:</span>
                                    <span id="modalDropDate" class="value"></span>
                                </div>
                                <div class="info-item">
                                    <span class="label">Time:</span>
                                    <span id="modalDropTime" class="value"></span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="info-section">
                            <h4>Payment Information</h4>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="label">Total Amount:</span>
                                    <span id="modalTotalPrice" class="value"></span>
                                </div>
                                <div class="info-item">
                                    <span class="label">Payment Status:</span>
                                    <span id="modalPaymentStatus" class="value"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />

    <script>

        const contextPath = '${pageContext.request.contextPath}';  
        
        
        function filterBookings() {
            const statusFilter = document.getElementById('statusFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;
            const bookingCards = document.querySelectorAll('.booking-card');
            
            bookingCards.forEach(card => {
                let statusMatch = true;
                let dateMatch = true;
                
                // Status filtering
                if (statusFilter !== 'all') {
                    statusMatch = card.getAttribute('data-status') === statusFilter;
                }
                
                // Date filtering
                if (dateFilter !== 'all') {
                    const bookingDate = new Date(card.getAttribute('data-date'));
                    const currentDate = new Date();
                    
                    if (dateFilter === 'month') {
                        dateMatch = bookingDate.getMonth() === currentDate.getMonth() && 
                                   bookingDate.getFullYear() === currentDate.getFullYear();
                    } else if (dateFilter === 'year') {
                        dateMatch = bookingDate.getFullYear() === currentDate.getFullYear();
                    }
                }
                
                // Display or hide based on filters
                if (statusMatch && dateMatch) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Check if no visible bookings after filtering
            checkNoVisibleBookings();
        }
        
        function checkNoVisibleBookings() {
            const visibleBookings = document.querySelectorAll('.booking-card[style="display: block"]');
            const bookingCards = document.querySelector('.booking-cards');
            const noBookingsElement = document.querySelector('.no-bookings');
            
            if (visibleBookings.length === 0 && bookingCards && !noBookingsElement) {
                // Create no results message if all are filtered out
                const noResults = document.createElement('div');
                noResults.className = 'no-bookings';
                noResults.id = 'no-results';
                
                const icon = document.createElement('i');
                icon.className = 'fas fa-filter';
                
                const title = document.createElement('h2');
                title.textContent = 'No Bookings Match Your Filters';
                
                const message = document.createElement('p');
                message.textContent = 'Try changing your filter criteria to see more results.';
                
                noResults.appendChild(icon);
                noResults.appendChild(title);
                noResults.appendChild(message);
                
                bookingCards.appendChild(noResults);
            } else if (visibleBookings.length > 0) {
                // Remove no results message if there are visible bookings
                const noResults = document.getElementById('no-results');
                if (noResults) {
                    noResults.remove();
                }
            }
        }

        // Get modal elements
        const modal = document.getElementById('bookingDetailsModal');
        const closeBtn = document.querySelector('.close-modal');

        // Close modal when clicking the close button
        closeBtn.onclick = function() {
            modal.style.display = "none";
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function viewBooking(bookingId) {
            console.log('View booking called with ID:', bookingId);
            
            if (!bookingId) {
                console.error('No booking ID provided');
                alert('Error: No booking ID provided');
                return;
            }

            // Show loading state
            modal.style.display = "block";
            
            // Fetch booking details
            const url = `${pageContext.request.contextPath}/get-booking-details?bookingId=${bookingId}`;
            console.log('Fetching from URL:', url);
            
            fetch(url)
                .then(response => {
                    console.log('Response status:', response.status);
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Received data:', data);
                    
                    if (data.error) {
                        throw new Error(data.error);
                    }
                    
                    // Update modal content with booking details
                    document.getElementById('modalVehicleName').textContent = data.vehicleName || 'N/A';
                    document.getElementById('modalVehicleType').textContent = data.vehicleType || 'N/A';
                    document.getElementById('modalPickupLocation').textContent = data.pickupLocation || 'N/A';
                    document.getElementById('modalPickupDate').textContent = data.pickupDate || 'N/A';
                    document.getElementById('modalPickupTime').textContent = data.pickupTime || 'N/A';
                    document.getElementById('modalDropLocation').textContent = data.dropLocation || 'N/A';
                    document.getElementById('modalDropDate').textContent = data.dropDate || 'N/A';
                    document.getElementById('modalDropTime').textContent = data.dropTime || 'N/A';
                    document.getElementById('modalTotalPrice').textContent = data.totalPrice ? `Rs ${data.totalPrice}` : 'N/A';
                    document.getElementById('modalPaymentStatus').textContent = data.paymentStatus || 'N/A';
                })
                .catch(error => {
                    console.error('Error fetching booking details:', error);
                    alert('Error loading booking details: ' + error.message);
                    modal.style.display = "none";
                });
        }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking? This action cannot be undone.')) {
                // Submit form to cancel booking
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/user/bookings';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'cancel';
                
                const bookingIdInput = document.createElement('input');
                bookingIdInput.type = 'hidden';
                bookingIdInput.name = 'bookingId';
                bookingIdInput.value = bookingId;
                
                form.appendChild(actionInput);
                form.appendChild(bookingIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function rebook(vehicleId) {
            window.location.href = "${pageContext.request.contextPath}/booking.jsp?vehicleId=" + vehicleId;
        }

        // Auto-hide toast messages
        setTimeout(function() {
            const toasts = document.querySelectorAll('.toast');
            toasts.forEach(toast => {
                toast.style.display = 'none';
            });
        }, 3500);
    </script>
</body>
</html> 