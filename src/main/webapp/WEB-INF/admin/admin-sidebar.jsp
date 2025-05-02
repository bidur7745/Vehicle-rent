<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .admin-nav {
        background-color: #1f2937;
        height: 100%;
        min-height: 100vh;
        width: 256px;
        position: fixed;
        left: 0;
        top: 0;
    }

    .nav-header {
        padding: 1rem;
    }

    .logo-container {
        display: flex;
        align-items: center;
    }

    .logo-image {
        height: 2rem;
        width: auto;
    }

    .logo-text {
        margin-left: 0.5rem;
        color: white;
        font-size: 1.25rem;
        font-weight: 600;
    }

    .nav-links {
        margin-top: 1.25rem;
    }

    .nav-item {
        display: flex;
        align-items: center;
        padding: 0.5rem 1rem;
        font-size: 0.875rem;
        font-weight: 500;
        text-decoration: none;
        transition: background-color 0.2s;
    }

    .nav-item svg {
        margin-right: 0.75rem;
        height: 1.5rem;
        width: 1.5rem;
    }

    .nav-item.active {
        background-color: #111827;
        color: white;
    }

    .nav-item:not(.active) {
        color: #d1d5db;
    }

    .nav-item:not(.active):hover {
        background-color: #374151;
        color: white;
    }
</style>

<nav class="admin-nav">
    <div class="nav-header">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="AutoRent Logo" class="logo-image">
            <span class="logo-text">AutoRent Admin</span>
        </div>
    </div>
    <div class="nav-links">
        <!-- Dashboard -->
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="nav-item ${pageContext.request.servletPath == '/admin/dashboard.jsp' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            Dashboard
        </a>

        <!-- Vehicles Management -->
        <a href="${pageContext.request.contextPath}/admin/vehicles" 
           class="nav-item ${pageContext.request.servletPath == '/admin/vehicles-management.jsp' ? 'active' : ''}">
            <i class="fas fa-car"></i>
            Vehicles
        </a>

        <!-- Bookings Management -->
        <a href="${pageContext.request.contextPath}/admin/bookings" 
           class="nav-item ${pageContext.request.servletPath == '/admin/bookings-management.jsp' ? 'active' : ''}">
            <i class="fas fa-calendar-alt"></i>
            Bookings
        </a>

        <!-- Users Management -->
        <a href="${pageContext.request.contextPath}/admin/users" 
           class="nav-item ${pageContext.request.servletPath == '/admin/users-management.jsp' ? 'active' : ''}">
            <i class="fas fa-users"></i>
            Users
        </a>
    </div>
</nav> 