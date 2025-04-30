<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />

    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) session.getAttribute("successMessage");
        session.removeAttribute("successMessage");
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

        <% if (request.getAttribute("bookings") == null || ((java.util.List)request.getAttribute("bookings")).isEmpty()) { %>
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
                <!-- Example booking card - Replace with actual data -->
                <div class="booking-card">
                    <div class="booking-image">
                        <img src="${pageContext.request.contextPath}/assets/images/cars/car1.jpg" alt="Car">
                        <span class="booking-status status-active">Active</span>
                    </div>
                    <div class="booking-details">
                        <h3>Toyota Camry 2023</h3>
                        <div class="booking-info">
                            <div class="booking-info-item">
                                <i class="fas fa-calendar"></i>
                                <span>15 Mar 2024 - 20 Mar 2024</span>
                            </div>
                            <div class="booking-info-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>New York City</span>
                            </div>
                            <div class="booking-info-item">
                                <i class="fas fa-money-bill-wave"></i>
                                <span>$350.00</span>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <button class="action-btn view-btn" onclick="viewBooking(1)">
                                <i class="fas fa-eye"></i>
                                View Details
                            </button>
                            <button class="action-btn cancel-btn" onclick="cancelBooking(1)">
                                <i class="fas fa-times"></i>
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <jsp:include page="/components/footer.jsp" />

    <script>
        function filterBookings() {
            const statusFilter = document.getElementById('statusFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;
            // TODO: Implement filtering logic
            console.log('Filtering bookings:', { status: statusFilter, date: dateFilter });
        }

        function viewBooking(bookingId) {
            // TODO: Implement view booking details
            console.log('Viewing booking:', bookingId);
        }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                // TODO: Implement booking cancellation
                console.log('Cancelling booking:', bookingId);
            }
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