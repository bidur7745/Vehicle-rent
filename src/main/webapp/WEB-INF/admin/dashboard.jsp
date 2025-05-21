<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - AutoRent</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            margin-left: 256px;
            min-height: 100vh;
            padding: 1rem;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            margin-top: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .icon-wrapper {
            padding: 0.75rem;
            border-radius: 50%;
            width: fit-content;
            margin-bottom: 1rem;
        }

        .icon-wrapper.blue { background-color: rgba(59, 130, 246, 0.1); }
        .icon-wrapper.green { background-color: rgba(16, 185, 129, 0.1); }
        .icon-wrapper.purple { background-color: rgba(139, 92, 246, 0.1); }
        .icon-wrapper.yellow { background-color: rgba(245, 158, 11, 0.1); }

        .stat-card i {
            font-size: 1.5rem;
        }

        .stat-card i.blue { color: #3b82f6; }
        .stat-card i.green { color: #10b981; }
        .stat-card i.purple { color: #8b5cf6; }
        .stat-card i.yellow { color: #f59e0b; }

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

        /* Recent Bookings Card */
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

        /* Booking Cards Grid */
        .booking-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            padding: 1.5rem;
        }

        .booking-card {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 1.5rem;
            transition: transform 0.2s ease-in-out;
        }

        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .booking-id {
            font-size: 0.875rem;
            color: #6b7280;
        }

        .booking-status {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .booking-details {
            display: grid;
            gap: 1rem;
        }

        .booking-detail {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .booking-detail i {
            width: 1.25rem;
            color: #6b7280;
        }

        .booking-detail span {
            color: #111827;
            font-size: 0.875rem;
        }

        .booking-actions {
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }

        .view-link {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .view-link:hover {
            color: #4338ca;
            text-decoration: underline;
        }

        /* Status Badges */
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .content-wrapper {
                margin-left: 0;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .booking-cards {
                grid-template-columns: 1fr;
            }
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
                <div class="value">Rs${totalRevenue}</div>
            </div>
        </div>

        <!-- Recent Bookings -->
        <div class="card">
            <div class="card-header">
                <h2>Recent Bookings</h2>
            </div>
            <div class="booking-cards">
                <c:forEach items="${recentBookings}" var="booking">
                    <div class="booking-card">
                        <div class="booking-header">
                            <span class="booking-id">#${booking.bookingId}</span>
                            <span class="booking-status ${booking.status == 'CONFIRMED' ? 'status-confirmed' :
                                                       booking.status == 'PENDING' ? 'status-pending' :
                                                       'status-cancelled'}">
                                <i class="fas ${booking.status == 'CONFIRMED' ? 'fa-check-circle' :
                                              booking.status == 'PENDING' ? 'fa-clock' :
                                              'fa-times-circle'}"></i>
                                ${booking.status}
                            </span>
                        </div>
                        <div class="booking-details">
                            <div class="booking-detail">
                                <i class="fas fa-user"></i>
                                <span>${booking.userName}</span>
                            </div>
                            <div class="booking-detail">
                                <i class="fas fa-car"></i>
                                <span>${booking.vehicleName}</span>
                            </div>
                            <div class="booking-detail">
                                <i class="fas fa-calendar"></i>
                                <span>${booking.startDateTime}</span>
                            </div>
                        </div>
                        <div class="booking-actions">
                            <a href="${pageContext.request.contextPath}/admin/bookings/view?id=${booking.bookingId}"
                               class="view-link">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
</div>
</body>
</html> 