<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .main-content {
            margin-left: 256px;
            padding: 20px;
            min-height: 100vh;
            background-color: #f3f4f6;
        }

        .content {
            padding: 20px;
            max-width: 1280px;
            margin: 0 auto;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <c:set var="pageTitle" value="User Management" scope="request"/>
    <div class="admin-container">
        <%@ include file="components/admin-sidebar.jsp" %>
        
        <div class="main-content">
            <%@ include file="components/admin-header.jsp" %>
            
            <main class="content">
                <!-- Page Header -->
                <div class="header-actions">
                    <h2 class="page-title">Users</h2>

                </div>

                <!-- Users Table -->
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user">
                                <tr class="table-row">
                                    <td>
                                        <div class="item-row">
                                            <img class="item-image" 
                                                 src="https://ui-avatars.com/api/?name=${user.firstName}+${user.lastName}" 
                                                 alt="${user.firstName} ${user.lastName}">
                                            <div class="item-details">
                                                <span class="item-primary">${user.firstName} ${user.lastName}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <span class="status-badge ${user.role == 'admin' ? 'status-confirmed' : 'status-pending'}">
                                            <i class="fas ${user.role == 'admin' ? 'fa-shield-alt' : 'fa-user'}"></i> ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.userId}" 
                                           class="action-link action-edit">
                                           <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="#" onclick="confirmDelete(${user.userId})"
                                           class="action-link action-delete">
                                           <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>

    <script>
        function confirmDelete(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/users/delete?id=' + userId;
            }
        }
    </script>
</body>
</html> 