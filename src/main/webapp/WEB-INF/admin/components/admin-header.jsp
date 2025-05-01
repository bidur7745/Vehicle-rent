<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .header {
        background-color: white;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        border-bottom: 1px solid #e5e7eb;
    }

    .header-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1rem 1.5rem;
    }

    .page-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: #111827;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .welcome-text {
        font-size: 0.875rem;
        color: #6b7280;
    }

    .user-avatar {
        width: 2rem;
        height: 2rem;
        border-radius: 9999px;
    }
</style>

<header class="header">
    <div class="header-content">
        <h1 class="page-title">${pageTitle}</h1>
        <div class="user-info">
            <span class="welcome-text">Welcome, Admin</span>
            <img class="user-avatar"
                 src="https://ui-avatars.com/api/?name=Admin&background=6366f1&color=fff"
                 alt="Admin">
        </div>
    </div>
</header> 