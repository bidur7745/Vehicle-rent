<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .admin-header {
        background-color: white;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .header-container {
        max-width: 1280px;
        margin: 0 auto;
        padding: 1rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .page-title {
        font-size: 1.5rem;
        font-weight: bold;
        color: #111827;
    }

    .user-section {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .welcome-text {
        font-size: 0.875rem;
        color: #374151;
    }

    .user-name {
        font-weight: 600;
    }

    .logout-form {
        display: inline;
    }

    .logout-button {
        display: inline-flex;
        align-items: center;
        padding: 0.5rem 0.75rem;
        border: none;
        border-radius: 0.375rem;
        font-size: 0.875rem;
        font-weight: 500;
        color: white;
        background-color: #dc2626;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .logout-button:hover {
        background-color: #b91c1c;
    }

    .logout-button:focus {
        outline: none;
        box-shadow: 0 0 0 2px #fff, 0 0 0 4px #dc2626;
    }
</style>

<header class="admin-header">
    <div class="header-container">
        <h1 class="page-title">
            <c:out value="${pageTitle}" default="Dashboard"/>
        </h1>
        <div class="user-section">
            <div class="welcome-text">
                Welcome, <span class="user-name">${sessionScope.user.firstName}</span>
            </div>
            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</header> 