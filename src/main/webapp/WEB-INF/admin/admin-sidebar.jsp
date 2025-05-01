<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="bg-gray-800 h-full min-h-screen w-64 fixed left-0 top-0">
    <div class="px-4 py-5">
        <div class="flex items-center">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="AutoRent Logo" class="h-8 w-auto">
            <span class="ml-2 text-white text-xl font-semibold">AutoRent Admin</span>
        </div>
    </div>
    <div class="mt-5">
        <div class="space-y-1">
            <!-- Dashboard -->
            <a href="${pageContext.request.contextPath}/admin/dashboard" 
               class="flex items-center px-4 py-2 text-sm font-medium ${pageContext.request.servletPath == '/admin/dashboard.jsp' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'}">
                <svg class="mr-3 h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                </svg>
                Dashboard
            </a>

            <!-- Vehicles Management -->
            <a href="${pageContext.request.contextPath}/admin/vehicles" 
               class="flex items-center px-4 py-2 text-sm font-medium ${pageContext.request.servletPath == '/admin/vehicles-management.jsp' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'}">
                <svg class="mr-3 h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                </svg>
                Vehicles
            </a>

            <!-- Bookings Management -->
            <a href="${pageContext.request.contextPath}/admin/bookings" 
               class="flex items-center px-4 py-2 text-sm font-medium ${pageContext.request.servletPath == '/admin/bookings-management.jsp' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'}">
                <svg class="mr-3 h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
                Bookings
            </a>

            <!-- Users Management -->
            <a href="${pageContext.request.contextPath}/admin/users" 
               class="flex items-center px-4 py-2 text-sm font-medium ${pageContext.request.servletPath == '/admin/users-management.jsp' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'}">
                <svg class="mr-3 h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                </svg>
                Users
            </a>
        </div>
    </div>
</nav> 