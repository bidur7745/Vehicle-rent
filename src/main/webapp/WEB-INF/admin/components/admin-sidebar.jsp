<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 250px;
        height: 100%;
        background-color: #1f2937;
        z-index: 10;
    }

    .sidebar-header {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 64px;
        background-color: #111827;
    }

    .sidebar-title {
        color: white;
        font-size: 1.25rem;
        font-weight: 600;
    }

    .sidebar-nav {
        margin-top: 1.25rem;
        padding: 0.5rem;
    }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 0.75rem 1rem;
        color: #9ca3af;
        text-decoration: none;
        border-radius: 0.375rem;
        margin-bottom: 0.25rem;
        transition: all 0.2s;
    }

    .nav-link:hover {
        background-color: #374151;
        color: white;
    }

    .nav-link i {
        width: 1.5rem;
        margin-right: 0.75rem;
    }

    .nav-link.active {
        background-color: #374151;
        color: white;
    }

    .nav-divider {
        height: 1px;
        background-color: #374151;
        margin: 1rem 0;
    }

    .nav-link.danger {
        color: #fca5a5;
    }

    .nav-link.danger:hover {
        background-color: #991b1b;
        color: white;
    }
</style>

<div class="sidebar">
    <div class="sidebar-header">
        <span class="sidebar-title">AutoRent Admin</span>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="nav-link ${pageContext.request.servletPath.endsWith('/dashboard.jsp') ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/vehicles"
           class="nav-link ${pageContext.request.servletPath.contains('/vehicles') ? 'active' : ''}">
            <i class="fas fa-car"></i>
            Vehicles
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings"
           class="nav-link ${pageContext.request.servletPath.contains('/bookings') ? 'active' : ''}">
            <i class="fas fa-calendar-alt"></i>
            Bookings
        </a>
        <a href="${pageContext.request.contextPath}/admin/users"
           class="nav-link ${pageContext.request.servletPath.contains('/users') ? 'active' : ''}">
            <i class="fas fa-users"></i>
            Users
        </a>

        <a href="${pageContext.request.contextPath}/admin/contact-messages"
           class="nav-link ${pageContext.request.servletPath.contains('/contact-messages') ? 'active' : ''}">
            <i class="fas fa-envelope"></i>
            Contact Messages
        </a>

        <div class="nav-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="nav-link danger">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </nav>
</div> 