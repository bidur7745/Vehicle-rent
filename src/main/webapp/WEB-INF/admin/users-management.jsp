<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
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
                                        <span class="action-link action-delete delete-user" data-userid="${user.userId}">
                                            <i class="fas fa-trash"></i> Delete
                                        </span>
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
        document.addEventListener('DOMContentLoaded', function() {
            // Add event listeners to all delete user buttons
            var deleteButtons = document.querySelectorAll('.delete-user');
            deleteButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    var userId = this.getAttribute('data-userid');
                    confirmDelete(userId);
                });
            });
            
            // Function to confirm and handle user deletion
            function confirmDelete(userId) {
                if (confirm('Are you sure you want to delete this user?')) {
                    // Create a form and submit it via POST
                    var form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/admin/users/delete';
                    
                    var input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'id';
                    input.value = userId;
                    
                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        });
    </script>
</body>
</html> 