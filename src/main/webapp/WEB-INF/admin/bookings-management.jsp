<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .main-content {
            margin-left: 256px;
            padding: 20px;
            min-height: 100vh;
            background-color: #f3f4f6;
        }

        .content {
            padding: 20px;
            max-width: 1280px;
            margin: 0 auto;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
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

                </div>

                <!-- Bookings Table -->
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>User</th>
                                <th>Vehicle</th>
                                <th>Duration</th>
                                <th>Total Price</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${bookings}" var="booking">
                                <tr class="table-row">
                                    <td>#${booking.bookingId}</td>
                                    <td>
                                        <div class="item-details">
                                            <span class="item-primary">${booking.userName}</span>
                                            <span class="item-secondary">${booking.userEmail}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="item-details">
                                            <span class="item-primary">${booking.vehicleName}</span>
                                            <span class="item-secondary">${booking.vehicleType}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="item-details">
                                            <span class="item-primary">${booking.startDateTime}</span>
                                            <span class="item-secondary">to ${booking.endDateTime}</span>
                                        </div>
                                    </td>
                                    <td>$${booking.totalPrice}</td>
                                    <td>
                                        <span class="status-badge ${booking.status == 'CONFIRMED' ? 'status-confirmed' : 
                                                                   booking.status == 'PENDING' ? 'status-pending' : 
                                                                   booking.status == 'COMPLETED' ? 'status-completed' : 
                                                                   'status-cancelled'}">
                                            ${booking.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/bookings/view?id=${booking.bookingId}" 
                                           class="action-link action-edit">
                                           <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="#" onclick="confirmCancel(${booking.bookingId})"
                                           class="action-link action-delete">
                                           <i class="fas fa-times"></i> Cancel
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>

    <script>
        function confirmCancel(bookingId) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/bookings/cancel?id=' + bookingId;
            }
        }
    </script>
</body>
</html> 