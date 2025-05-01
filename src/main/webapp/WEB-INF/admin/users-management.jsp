<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - AutoRent</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <c:set var="pageTitle" value="User Management" scope="request"/>
    <%@ include file="components/admin-sidebar.jsp" %>
    
    <div class="ml-64 min-h-screen">
        <%@ include file="components/admin-header.jsp" %>
        
        <main class="p-6">
            <!-- Page Header -->
            <div class="mb-8 flex justify-between items-center">
                <h2 class="text-2xl font-bold text-gray-900">Users</h2>
                <a href="${pageContext.request.contextPath}/admin/users/add" 
                   class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700">
                    <i class="fas fa-plus mr-2"></i> Add New User
                </a>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-lg shadow mb-6 p-4">
                <form action="${pageContext.request.contextPath}/admin/users" method="get" class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label for="role" class="block text-sm font-medium text-gray-700">Role</label>
                        <select id="role" name="role" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                            <option value="">All Roles</option>
                            <option value="user" ${param.role == 'user' ? 'selected' : ''}>User</option>
                            <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>
                    <div>
                        <label for="search" class="block text-sm font-medium text-gray-700">Search</label>
                        <input type="text" id="search" name="search" value="${param.search}"
                               class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                               placeholder="Search by name or email...">
                    </div>
                    <div class="flex items-end">
                        <button type="submit" class="w-full px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-gray-600 hover:bg-gray-700">
                            Apply Filters
                        </button>
                    </div>
                </form>
            </div>

            <!-- Users Table -->
            <div class="bg-white rounded-lg shadow overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Created At</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10">
                                            <div class="h-10 w-10 rounded-full bg-gray-300 flex items-center justify-center">
                                                <span class="text-xl font-medium text-white">
                                                    ${fn:toUpperCase(fn:substring(user.firstName, 0, 1))}
                                                </span>
                                            </div>
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900">${user.firstName} ${user.lastName}</div>
                                            <div class="text-sm text-gray-500">ID: ${user.userId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${user.email}</div>
                                    <div class="text-sm text-gray-500">${user.phone}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        ${user.role == 'admin' ? 'bg-purple-100 text-purple-800' : 'bg-green-100 text-green-800'}">
                                        ${user.role}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    ${user.createdAt}
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <div class="flex space-x-3">
                                        <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.userId}" 
                                           class="text-indigo-600 hover:text-indigo-900">Edit</a>
                                        <c:if test="${sessionScope.user.userId != user.userId}">
                                            <a href="#" onclick="confirmDelete(${user.userId})"
                                               class="text-red-600 hover:text-red-900">Delete</a>
                                        </c:if>
                                        <c:if test="${user.role == 'user'}">
                                            <a href="#" onclick="updateRole(${user.userId}, 'admin')"
                                               class="text-purple-600 hover:text-purple-900">Make Admin</a>
                                        </c:if>
                                        <c:if test="${user.role == 'admin' && sessionScope.user.userId != user.userId}">
                                            <a href="#" onclick="updateRole(${user.userId}, 'user')"
                                               class="text-green-600 hover:text-green-900">Remove Admin</a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                    <div class="flex-1 flex justify-between sm:hidden">
                        <a href="?page=${currentPage - 1}" 
                           class="${currentPage == 1 ? 'invisible' : ''} relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            Previous
                        </a>
                        <a href="?page=${currentPage + 1}"
                           class="${currentPage == totalPages ? 'invisible' : ''} relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            Next
                        </a>
                    </div>
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">
                                Showing <span class="font-medium">${(currentPage - 1) * itemsPerPage + 1}</span> to 
                                <span class="font-medium">${Math.min(currentPage * itemsPerPage, totalItems)}</span> of 
                                <span class="font-medium">${totalItems}</span> results
                            </p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <a href="?page=${page}" 
                                       class="${currentPage == page ? 'z-10 bg-indigo-50 border-indigo-500 text-indigo-600' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'} relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                        ${page}
                                    </a>
                                </c:forEach>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        function confirmDelete(userId) {
            if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/users/delete?id=' + userId;
            }
        }

        function updateRole(userId, newRole) {
            if (confirm('Are you sure you want to change this user\'s role to ' + newRole + '?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/users/update-role?id=' + userId + '&role=' + newRole;
            }
        }
    </script>
</body>
</html> 