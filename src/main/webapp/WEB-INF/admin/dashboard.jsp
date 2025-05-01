<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - AutoRent</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Custom styles -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f3f4f6;
            font-family: Arial, sans-serif;
        }

        .content-wrapper {
            margin-left: 250px;
            min-height: 100vh;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            padding: 1.5rem;
        }

        .stat-card {
            background: white;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .stat-card .icon-wrapper {
            padding: 0.75rem;
            border-radius: 9999px;
            width: fit-content;
            margin-bottom: 1rem;
        }

        .stat-card .icon-wrapper.blue {
            background-color: rgba(59, 130, 246, 0.1);
        }

        .stat-card .icon-wrapper.green {
            background-color: rgba(16, 185, 129, 0.1);
        }

        .stat-card .icon-wrapper.purple {
            background-color: rgba(139, 92, 246, 0.1);
        }

        .stat-card .icon-wrapper.yellow {
            background-color: rgba(245, 158, 11, 0.1);
        }

        .stat-card i {
            font-size: 1.5rem;
        }

        .stat-card i.blue {
            color: #3b82f6;
        }

        .stat-card i.green {
            color: #10b981;
        }

        .stat-card i.purple {
            color: #8b5cf6;
        }

        .stat-card i.yellow {
            color: #f59e0b;
        }

        .stat-card .label {
            color: #6b7280;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .stat-card .value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #111827;
        }

        .card {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .card-header h2 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #111827;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #f9fafb;
            padding: 0.75rem 1.5rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 500;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        td {
            padding: 1rem 1.5rem;
            color: #111827;
            font-size: 0.875rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .status-confirmed {
            background-color: #dcfce7;
            color: #166534;
        }

        .status-pending {
            background-color: #fef9c3;
            color: #854d0e;
        }

        .status-cancelled {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .action-buttons {
            display: grid;
            gap: 1rem;
            padding: 1.5rem;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 0.5rem 1rem;
            text-align: center;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .btn-primary {
            background-color: #4f46e5;
            color: white;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        .btn-success {
            background-color: #10b981;
            color: white;
        }

        .btn-success:hover {
            background-color: #059669;
        }

        .btn-purple {
            background-color: #8b5cf6;
            color: white;
        }

        .btn-purple:hover {
            background-color: #7c3aed;
        }

        .view-link {
            color: #4f46e5;
            text-decoration: none;
        }

        .view-link:hover {
            color: #4338ca;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<%@ include file="components/admin-sidebar.jsp" %>

<div class="content-wrapper">
    <%@ include file="components/admin-header.jsp" %>

    <main>
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <!-- Total Vehicles -->
            <div class="stat-card">
                <div class="icon-wrapper blue">
                    <i class="fas fa-car blue"></i>
                </div>
                <div class="label">Total Vehicles</div>
                <div class="value">${totalVehicles}</div>
            </div>

            <!-- Active Bookings -->
            <div class="stat-card">
                <div class="icon-wrapper green">
                    <i class="fas fa-calendar-check green"></i>
                </div>
                <div class="label">Active Bookings</div>
                <div class="value">${activeBookings}</div>
            </div>

            <!-- Total Users -->
            <div class="stat-card">
                <div class="icon-wrapper purple">
                    <i class="fas fa-users purple"></i>
                </div>
                <div class="label">Total Users</div>
                <div class="value">${totalUsers}</div>
            </div>

            <!-- Total Revenue -->
            <div class="stat-card">
                <div class="icon-wrapper yellow">
                    <i class="fas fa-dollar-sign yellow"></i>
                </div>
                <div class="label">Total Revenue</div>
                <div class="value">$${totalRevenue}</div>
            </div>
        </div>

        <!-- Recent Bookings -->
        <div class="card">
            <div class="card-header">
                <h2>Recent Bookings</h2>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>User</th>
                        <th>Vehicle</th>
                        <th>Start Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${recentBookings}" var="booking">
                        <tr>
                            <td>#${booking.bookingId}</td>
                            <td>${booking.userName}</td>
                            <td>${booking.vehicleName}</td>
                            <td>${booking.startDateTime}</td>
                            <td>
                                        <span class="status-badge ${booking.status == 'CONFIRMED' ? 'status-confirmed' :
                                                                   booking.status == 'PENDING' ? 'status-pending' :
                                                                   'status-cancelled'}">
                                                ${booking.status}
                                        </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/bookings/view?id=${booking.bookingId}"
                                   class="view-link">View Details</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <div class="card-header">
                <h2>Quick Actions</h2>
            </div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/vehicles/add"
                   class="btn btn-primary">
                    Add New Vehicle
                </a>
                <a href="${pageContext.request.contextPath}/admin/bookings/create"
                   class="btn btn-success">
                    Create New Booking
                </a>
                <a href="${pageContext.request.contextPath}/admin/users/add"
                   class="btn btn-purple">
                    Add New User
                </a>
            </div>
        </div>
    </main>
</div>
</body>
</html> 