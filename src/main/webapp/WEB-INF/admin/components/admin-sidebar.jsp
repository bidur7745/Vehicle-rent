<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="fixed inset-y-0 left-0 w-64 bg-gray-800">
    <div class="flex items-center justify-center h-16 bg-gray-900">
        <span class="text-white text-xl font-semibold">AutoRent Admin</span>
    </div>
    <nav class="mt-5">
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white">
            <i class="fas fa-tachometer-alt mr-3"></i>
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/vehicles" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white">
            <i class="fas fa-car mr-3"></i>
            Vehicles
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white">
            <i class="fas fa-calendar-alt mr-3"></i>
            Bookings
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white">
            <i class="fas fa-users mr-3"></i>
            Users
        </a>
    </nav>
</div> 