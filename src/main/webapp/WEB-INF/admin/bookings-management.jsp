<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - AutoRent</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <c:set var="pageTitle" value="Booking Management" scope="request"/>
    <%@ include file="components/admin-sidebar.jsp" %>
    
    <div class="ml-64 min-h-screen">
        <%@ include file="components/admin-header.jsp" %>
        
        <main class="p-6">
            <!-- Page Header -->
            <div class="mb-8 flex justify-between items-center">
                <h2 class="text-2xl font-bold text-gray-900">Bookings</h2>
                <a href="${pageContext.request.contextPath}/admin/bookings/create" 
                   class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700">
                    <i class="fas fa-plus mr-2"></i> Create New Booking
                </a>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-lg shadow mb-6 p-4">
                <form action="${pageContext.request.contextPath}/admin/bookings" method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label for="status" class="block text-sm font-medium text-gray-700">Booking Status</label>
                        <select id="status" name="status" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                            <option value="">All Status</option>
                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                            <option value="CONFIRMED" ${param.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                            <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                            <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        </select>
                    </div>
                    <div>
                        <label for="dateRange" class="block text-sm font-medium text-gray-700">Date Range</label>
                        <select id="dateRange" name="dateRange" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                            <option value="">All Time</option>
                            <option value="today" ${param.dateRange == 'today' ? 'selected' : ''}>Today</option>
                            <option value="week" ${param.dateRange == 'week' ? 'selected' : ''}>This Week</option>
                            <option value="month" ${param.dateRange == 'month' ? 'selected' : ''}>This Month</option>
                        </select>
                    </div>
                    <div class="flex items-end">
                        <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700">
                            <i class="fas fa-filter mr-2"></i> Filter
                        </button>
                    </div>
                </form>
            </div>

            <!-- Bookings Table -->
            <div class="bg-white rounded-lg shadow overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Vehicle</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Duration</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Price</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${bookings}" var="booking">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">#${booking.bookingId}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${booking.userName}</div>
                                    <div class="text-sm text-gray-500">${booking.userEmail}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${booking.vehicleName}</div>
                                    <div class="text-sm text-gray-500">${booking.vehicleType}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${booking.startDateTime}</div>
                                    <div class="text-sm text-gray-500">to ${booking.endDateTime}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    $${booking.totalPrice}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        ${booking.status == 'CONFIRMED' ? 'bg-green-100 text-green-800' : 
                                          booking.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' : 
                                          booking.status == 'COMPLETED' ? 'bg-blue-100 text-blue-800' : 
                                          'bg-red-100 text-red-800'}">
                                        ${booking.status}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/admin/bookings/view?id=${booking.bookingId}" 
                                       class="text-indigo-600 hover:text-indigo-900 mr-3">View</a>
                                    <a href="#" onclick="confirmCancel(${booking.bookingId})"
                                       class="text-red-600 hover:text-red-900">Cancel</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
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