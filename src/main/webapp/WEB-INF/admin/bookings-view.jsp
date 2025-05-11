<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.autorent.model.Booking" %>
<%@ page import="com.autorent.model.User" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="com.autorent.services.UserService" %>
<%@ page import="com.autorent.services.VehicleService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .booking-details-container {
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.08);
            padding: 32px;
            margin-top: 24px;
            position: relative;
            overflow: hidden;
        }
        
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 24px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .booking-title {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        
        .booking-id {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            position: relative;
        }
        
        .booking-id:after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 40px;
            height: 3px;
            background: linear-gradient(to right, #4481eb, #04befe);
            border-radius: 3px;
        }
        
        .booking-actions {
            display: flex;
            gap: 12px;
        }
        
        .section-row {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            margin-bottom: 24px;
        }
        
        .section-col {
            flex: 1;
            min-width: 300px;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: #4481eb;
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            background-color: #eef2ff;
            border: 1px solid #e0e7ff;
        }
        
        .back-link:hover {
            background-color: #dbeafe;
            color: #2563eb;
            transform: translateY(-2px);
        }
        
        .page-title {
            font-size: 28px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }
        
        .page-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(to right, #4481eb, #04befe);
            border-radius: 2px;
        }
        
        .btn {
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .btn-danger {
            background-color: #ef4444;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #dc2626;
        }
        
        @media (max-width: 768px) {
            .booking-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
            
            .booking-details-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <c:set var="pageTitle" value="Booking Details" scope="request"/>
    <div class="admin-container">
        <!-- <%@ include file="components/admin-sidebar.jsp" %> -->
        
        <div class="main-content">
            <!-- <%@ include file="components/admin-header.jsp" %> -->
            
            <main class="content">
                <a href="${pageContext.request.contextPath}/admin/bookings" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Bookings
                </a>

                <!-- Page Header -->
                <div class="header-actions">
                    <h2 class="page-title">Booking Details</h2>
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

                <!-- Booking Details Container -->
                <div class="booking-details-container">
                    <div class="booking-header">
                        <div class="booking-title">
                            <span class="booking-id">Booking #${booking.bookingId}</span>
                            <span class="status-badge ${booking.status eq 'active' ? 'status-active' : 
                                                       booking.status eq 'pending' ? 'status-pending' : 
                                                       booking.status eq 'completed' ? 'status-completed' : 
                                                       'status-cancelled'}">
                                ${booking.status}
                            </span>
                        </div>
                        <div class="booking-actions">
                            <c:if test="${booking.status eq 'pending' || booking.status eq 'active'}">
                                <a href="javascript:void(0)" 
                                   class="btn btn-danger"
                                   onclick="confirmCancel('${booking.bookingId}')">
                                   <i class="fas fa-times"></i> Cancel Booking
                                </a>
                            </c:if>
                            
                            <c:if test="${booking.status eq 'cancelled'}">
                                <a href="javascript:void(0)" 
                                   class="btn btn-danger"
                                   onclick="confirmDelete('${booking.bookingId}')">
                                   <i class="fas fa-trash"></i> Delete Booking
                                </a>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="section-row">
                        <div class="section-col">
                            <%-- Include the booking details component --%>
                            <jsp:include page="components/booking-details.jsp" />
                        </div>
                    </div>
                </div>
            </main>
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
            if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/bookings/delete?id=' + bookingId;
            }
        }
    </script>
</body>
</html> 