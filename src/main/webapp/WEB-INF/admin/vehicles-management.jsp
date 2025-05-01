<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management - AutoRent</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <c:set var="pageTitle" value="Vehicle Management" scope="request"/>
    <%@ include file="components/admin-sidebar.jsp" %>
    
    <div class="ml-64 min-h-screen">
        <%@ include file="components/admin-header.jsp" %>
        
        <main class="p-6">
            <!-- Page Header -->
            <div class="mb-8 flex justify-between items-center">
                <h2 class="text-2xl font-bold text-gray-900">Vehicles</h2>
                <a href="${pageContext.request.contextPath}/admin/vehicles/add" 
                   class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700">
                    <i class="fas fa-plus mr-2"></i> Add New Vehicle
                </a>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-lg shadow mb-6 p-4">
                <form action="${pageContext.request.contextPath}/admin/vehicles" method="get" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label for="type" class="block text-sm font-medium text-gray-700">Vehicle Type</label>
                        <select id="type" name="type" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                            <option value="">All Types</option>
                            <option value="SUV" ${param.type == 'SUV' ? 'selected' : ''}>SUV</option>
                            <option value="Sedan" ${param.type == 'Sedan' ? 'selected' : ''}>Sedan</option>
                            <option value="Hatchback" ${param.type == 'Hatchback' ? 'selected' : ''}>Hatchback</option>
                        </select>
                    </div>
                    <div>
                        <label for="status" class="block text-sm font-medium text-gray-700">Status</label>
                        <select id="status" name="status" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                            <option value="">All Status</option>
                            <option value="Available" ${param.status == 'Available' ? 'selected' : ''}>Available</option>
                            <option value="Booked" ${param.status == 'Booked' ? 'selected' : ''}>Booked</option>
                            <option value="Maintenance" ${param.status == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
                        </select>
                    </div>
                    <div class="flex items-end">
                        <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700">
                            <i class="fas fa-filter mr-2"></i> Filter
                        </button>
                    </div>
                </form>
            </div>

            <!-- Vehicles Table -->
            <div class="bg-white rounded-lg shadow overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Vehicle</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rent/Day</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${vehicles}" var="vehicle">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="h-10 w-10 flex-shrink-0">
                                            <img class="h-10 w-10 rounded-full" src="${vehicle.imageUrl}" alt="${vehicle.name}">
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900">${vehicle.name}</div>
                                            <div class="text-sm text-gray-500">${vehicle.color}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${vehicle.type}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">$${vehicle.rentPerDay}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        ${vehicle.availabilityStatus == 'Available' ? 'bg-green-100 text-green-800' : 
                                          vehicle.availabilityStatus == 'Booked' ? 'bg-red-100 text-red-800' : 
                                          'bg-yellow-100 text-yellow-800'}">
                                        ${vehicle.availabilityStatus}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/admin/vehicles/edit?id=${vehicle.vehicleId}" 
                                       class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</a>
                                    <a href="#" onclick="confirmDelete(${vehicle.vehicleId})"
                                       class="text-red-600 hover:text-red-900">Delete</a>
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
                                <a href="?page=${currentPage - 1}" 
                                   class="${currentPage == 1 ? 'invisible' : ''} relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">Previous</span>
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                                
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <a href="?page=${page}" 
                                       class="${currentPage == page ? 'z-10 bg-indigo-50 border-indigo-500 text-indigo-600' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'} relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                        ${page}
                                    </a>
                                </c:forEach>

                                <a href="?page=${currentPage + 1}"
                                   class="${currentPage == totalPages ? 'invisible' : ''} relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <span class="sr-only">Next</span>
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        function confirmDelete(vehicleId) {
            if (confirm('Are you sure you want to delete this vehicle?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/vehicles/delete?id=' + vehicleId;
            }
        }
    </script>
</body>
</html> 