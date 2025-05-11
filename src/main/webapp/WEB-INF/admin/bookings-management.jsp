<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.autorent.model.Booking" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>
<%
    // Debugging information
    System.out.println("bookings-management.jsp: Page is being rendered");
    
    // Check if bookings attribute exists
    Object bookingsObj = request.getAttribute("bookings");
    if (bookingsObj == null) {
        System.out.println("bookings-management.jsp: 'bookings' attribute is null");
    } else {
        List<?> bookings = (List<?>) bookingsObj;
        System.out.println("bookings-management.jsp: Found " + bookings.size() + " bookings");
        
        // Check first booking if available
        if (!bookings.isEmpty()) {
            Object firstBooking = bookings.get(0);
            System.out.println("bookings-management.jsp: First booking class: " + firstBooking.getClass().getName());
            if (firstBooking instanceof Booking) {
                Booking booking = (Booking) firstBooking;
                System.out.println("bookings-management.jsp: First booking ID: " + booking.getBookingId());
                System.out.println("bookings-management.jsp: First booking status: " + booking.getStatus());
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <c:set var="pageTitle" value="Booking Management" scope="request"/>
    <div class="admin-container">
        <%@ include file="components/admin-sidebar.jsp" %>
        
        <div class="main-content">
            <%@ include file="components/admin-header.jsp" %>
            
            <main class="content">
                <!-- Page Header -->
                <div class="header-actions">
                    <h2 class="page-title">Bookings</h2>
                    <a href="${pageContext.request.contextPath}/admin/bookings/refresh-statuses" 
                       class="btn btn-secondary refresh-button">
                        <i class="fas fa-sync-alt"></i> Update Statuses
                    </a>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success">
                        <p>${sessionScope.message}</p>
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>
                
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-error">
                        <p>${sessionScope.error}</p>
                    </div>
                    <c:remove var="error" scope="session" />
                </c:if>

                <!-- Booking Status Filters -->
                <div class="booking-filters">
                    <button class="filter-tab active" data-status="all">
                        All Bookings
                        <span class="count" id="count-all">0</span>
                    </button>
                    <button class="filter-tab" data-status="pending">
                        Pending
                        <span class="count" id="count-pending">0</span>
                    </button>
                    <button class="filter-tab" data-status="active">
                        Active
                        <span class="count" id="count-active">0</span>
                    </button>
                    <button class="filter-tab" data-status="completed">
                        Completed
                        <span class="count" id="count-completed">0</span>
                    </button>
                    <button class="filter-tab" data-status="cancelled">
                        Cancelled
                        <span class="count" id="count-cancelled">0</span>
                    </button>
                </div>

                <!-- Bookings Table -->
                <table class="booking-table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>User</th>
                            <th>Vehicle</th>
                            <th>Dates</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="booking">
                            <tr class="booking-row" data-status="${booking.status}">
                                <td class="booking-id-cell">#${booking.bookingId}</td>
                                <td class="booking-user-cell">User #${booking.userId}</td>
                                <td class="booking-vehicle-cell">Vehicle #${booking.vehicleId}</td>
                                <td class="booking-dates-cell">
                                    <div class="date-range">
                                        <span>${booking.startDateTime.split(" ")[0]}</span>
                                        <span class="date-separator">→</span>
                                        <span>${booking.endDateTime.split(" ")[0]}</span>
                                    </div>
                                </td>
                                <td class="booking-price-cell">RS ${booking.totalPrice}</td>
                                <td class="booking-status-cell">
                                    <span class="status-badge ${booking.status eq 'active' ? 'status-active' : 
                                                               booking.status eq 'pending' ? 'status-pending' : 
                                                               booking.status eq 'completed' ? 'status-completed' : 
                                                               'status-cancelled'}">
                                        ${booking.status}
                                    </span>
                                </td>
                                <td class="booking-actions-cell">
                                    <div class="action-buttons">
                                        <a href="javascript:void(0)" 
                                           class="btn btn-icon btn-secondary"
                                           title="View Details"
                                           onclick="viewBookingDetails('${booking.bookingId}')">
                                           <i class="fas fa-eye"></i>
                                        </a>
                                        
                                        <c:if test="${booking.status eq 'pending' || booking.status eq 'active'}">
                                            <a href="javascript:void(0)" 
                                               class="btn btn-icon btn-danger"
                                               title="Cancel Booking"
                                               onclick="confirmCancel('${booking.bookingId}')">
                                               <i class="fas fa-times"></i>
                                            </a>
                                        </c:if>
                                        
                                        <c:if test="${booking.status eq 'cancelled'}">
                                            <a href="javascript:void(0)" 
                                               class="btn btn-icon btn-danger"
                                               title="Delete Booking"
                                               onclick="confirmDelete('${booking.bookingId}')">
                                               <i class="fas fa-trash"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- No Bookings State (will be shown/hidden by JS) -->
                <div class="no-bookings" style="display: none;">
                    <i class="far fa-calendar-times"></i>
                    <h3>No bookings found</h3>
                    <p>There are no bookings matching the current filter criteria.</p>
                </div>
            </main>
        </div>
    </div>

    <!-- Booking Details Modal -->
    <div id="bookingModal" class="modal-overlay">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">Booking Details</h3>
                <button class="modal-close" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body" id="modalContent">
                <!-- Content will be loaded dynamically -->
                <div class="loading-spinner">Loading...</div>
            </div>
            <div class="modal-footer">
                <button class="modal-btn btn-secondary" onclick="closeModal()">Close</button>
                <button id="cancelBookingBtn" class="modal-btn btn-danger" style="display:none;">Cancel Booking</button>
            </div>
        </div>
    </div>

    <script>
        function confirmCancel(bookingId) {
            bookingId = parseInt(bookingId);
            if (confirm('Are you sure you want to cancel this booking?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/bookings/cancel?id=' + bookingId;
            }
        }
        
        function confirmDelete(bookingId) {
            bookingId = parseInt(bookingId);
            console.log("confirmDelete called with ID:", bookingId);
            
            if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
                const url = '${pageContext.request.contextPath}/admin/bookings/delete?id=' + bookingId;
                console.log("Redirecting to:", url);
                window.location.href = url;
            }
        }
        
        function closeModal() {
            document.getElementById('bookingModal').style.display = 'none';
        }
        
        // Filter bookings based on status
        document.addEventListener('DOMContentLoaded', function() {
            const filterTabs = document.querySelectorAll('.filter-tab');
            const bookingRows = document.querySelectorAll('.booking-row');
            const noBookingsMessage = document.querySelector('.no-bookings');
            
            // Count bookings by status and update tabs
            const counts = {
                all: bookingRows.length,
                pending: 0,
                active: 0,
                completed: 0,
                cancelled: 0
            };
            
            bookingRows.forEach(row => {
                const status = row.getAttribute('data-status');
                counts[status]++;
            });
            
            // Update count badges
            document.getElementById('count-all').textContent = counts.all;
            document.getElementById('count-pending').textContent = counts.pending;
            document.getElementById('count-active').textContent = counts.active;
            document.getElementById('count-completed').textContent = counts.completed;
            document.getElementById('count-cancelled').textContent = counts.cancelled;
            
            // Handle tab clicks
            filterTabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    // Update active tab
                    filterTabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    
                    const selectedStatus = this.getAttribute('data-status');
                    let visibleCount = 0;
                    
                    // Filter rows
                    bookingRows.forEach(row => {
                        const rowStatus = row.getAttribute('data-status');
                        if (selectedStatus === 'all' || selectedStatus === rowStatus) {
                            row.style.display = '';
                            visibleCount++;
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    
                    // Show/hide empty state message
                    if (visibleCount === 0) {
                        noBookingsMessage.style.display = 'flex';
                    } else {
                        noBookingsMessage.style.display = 'none';
                    }
                });
            });
        });
        
        function viewBookingDetails(bookingId) {
            bookingId = parseInt(bookingId);
            // Show modal
            document.getElementById('bookingModal').style.display = 'flex';
            
            // Set loading state
            document.getElementById('modalContent').innerHTML = '<div class="loading-spinner">Loading booking details...</div>';
            
            // Fetch booking details via AJAX - using component format 
            fetch('${pageContext.request.contextPath}/admin/bookings/view?id=' + bookingId + '&format=component')
                .then(response => {
                    console.log("Response status:", response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text();
                })
                .then(html => {
                    console.log("Received booking component HTML");
                    document.getElementById('modalContent').innerHTML = html;
                    
                    // Fetch JSON data just for the cancel button functionality
                    return fetch('${pageContext.request.contextPath}/admin/bookings/view?id=' + bookingId + '&format=json')
                        .then(response => response.json());
                })
                .then(data => {
                    // Show cancel button only for active or pending bookings
                    const cancelBtn = document.getElementById('cancelBookingBtn');
                    if (data.status === 'pending' || data.status === 'active') {
                        cancelBtn.style.display = 'block';
                        cancelBtn.onclick = function() {
                            confirmCancel(data.bookingId);
                        };
                    } else {
                        cancelBtn.style.display = 'none';
                    }
                })
                .catch(error => {
                    console.error('Error fetching booking details:', error);
                    document.getElementById('modalContent').innerHTML = 
                        '<div class="error-message">Error loading booking details: ' + error.message + '</div>';
                });
        }
        
        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('bookingModal');
            if (event.target === modal) {
                closeModal();
            }
        });
    </script>
</body>
</html> 