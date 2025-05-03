<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management - AutoRent</title>
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
    <c:set var="pageTitle" value="Vehicle Management" scope="request"/>
    <div class="admin-container">
        <%@ include file="components/admin-sidebar.jsp" %>
        
        <div class="main-content">
            <%@ include file="components/admin-header.jsp" %>
            
            <main class="content">
                <!-- Page Header -->
                <div class="header-actions">
                    <h2 class="page-title">Vehicles</h2>
                    <button onclick="openModal()" class="add-button">
                        <i class="fas fa-plus"></i> Add New Vehicle
                    </button>
                </div>

                <!-- Modal Form -->
                <div id="addVehicleModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Add New Vehicle</h2>
                            <button onclick="closeModal()" class="close-button">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/vehicles/add/" 
                              method="POST" 
                              class="admin-form" 
                              enctype="multipart/form-data"
                              id="addVehicleForm">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="name">Vehicle Name</label>
                                    <input type="text" id="name" name="name" required class="form-input" placeholder="Enter vehicle name">
                                </div>

                                <div class="form-group">
                                    <label for="type">Vehicle Category</label>
                                    <input type="text" id="type" name="type" required class="form-input" placeholder="e.g. SUV, Sedan">
                                </div>

                                <div class="form-group">
                                    <label for="rent_per_day">Rent Per Day</label>
                                    <input type="number" id="rent_per_day" name="rent_per_day" required class="form-input" step="0.01" min="0" placeholder="Enter daily rent amount">
                                </div>

                                <div class="form-group">
                                    <label for="availability_status">Availability Status</label>
                                    <select id="availability_status" name="availability_status" required class="form-select">
                                        <option value="available">Available</option>
                                        <option value="rented">Rented</option>
                                        <option value="maintenance">Maintenance</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="fuel_type">Fuel Type</label>
                                    <select id="fuel_type" name="fuel_type" required class="form-select">
                                        <option value="petrol">Petrol</option>
                                        <option value="diesel">Diesel</option>
                                        <option value="electric">Electric</option>
                                        <option value="hybrid">Hybrid</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="no_of_airbags">Number of Airbags</label>
                                    <input type="number" id="no_of_airbags" name="no_of_airbags" required class="form-input" min="0" placeholder="Enter number of airbags">
                                </div>

                                <div class="form-group">
                                    <label for="seating_capacity">Seating Capacity</label>
                                    <input type="number" id="seating_capacity" name="seating_capacity" required class="form-input" min="1" placeholder="Enter seating capacity">
                                </div>

                                <div class="form-group">
                                    <label for="vehicle_type">Transmission</label>
                                    <select id="vehicle_type" name="vehicle_type" required class="form-select">
                                        <option value="manual">Manual</option>
                                        <option value="automatic">Automatic</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="color">Color</label>
                                    <input type="text" id="color" name="color" required class="form-input" placeholder="Enter vehicle color">
                                </div>

                                <div class="form-group full-width">
                                    <label for="image">Vehicle Image</label>
                                    <input type="file" id="image" name="image" required class="form-input file-input" accept="image/*" onchange="previewImage(this)">
                                    <div id="imagePreview" class="image-preview"></div>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" onclick="closeModal()" class="cancel-button">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                                <button type="submit" class="submit-button">
                                    <i class="fas fa-plus"></i> Add Vehicle
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Vehicles Table -->
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Vehicle</th>
                                <th>Type</th>
                                <th>Rent/Day</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${vehicles}" var="vehicle">
                                <tr class="table-row">
                                    <td>
                                        <div class="item-row">
                                            <img class="item-image" src="${vehicle.image}" alt="${vehicle.name}">
                                            <div class="item-details">
                                                <span class="item-primary">${vehicle.name}</span>
                                                <span class="item-secondary">
                                                    <i class="fas fa-palette"></i> ${vehicle.color}
                                                </span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <i class="fas fa-car-side"></i> ${vehicle.type}
                                    </td>
                                    <td>
                                        <p>RS</p></i> ${vehicle.rentPerDay}
                                    </td>
                                    <td>
                                        <span class="status-badge ${vehicle.availabilityStatus == 'Available' ? 'status-confirmed' : 
                                                                   vehicle.availabilityStatus == 'Booked' ? 'status-cancelled' : 
                                                                   'status-pending'}">
                                            <i class="fas ${vehicle.availabilityStatus == 'Available' ? 'fa-check-circle' : 
                                                          vehicle.availabilityStatus == 'Booked' ? 'fa-clock' : 
                                                          'fa-exclamation-circle'}"></i>
                                            ${vehicle.availabilityStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/vehicles/edit?id=${vehicle.vehicleId}" 
                                           class="action-link action-edit">
                                           <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="#" onclick="confirmDelete(${vehicle.vehicleId})"
                                           class="action-link action-delete">
                                           <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="table-footer">
                        <div class="results-info">
                            Showing ${(currentPage - 1) * itemsPerPage + 1} to ${Math.min(currentPage * itemsPerPage, totalItems)} of ${totalItems} results
                        </div>
                        <div class="pagination">
                            <a href="?page=${currentPage - 1}" 
                               class="pagination-link ${currentPage == 1 ? 'disabled' : ''}">
                                <i class="fas fa-chevron-left"></i>
                                Previous
                            </a>
                            
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <a href="?page=${page}" 
                                   class="pagination-link ${currentPage == page ? 'active' : ''}">
                                    ${page}
                                </a>
                            </c:forEach>

                            <a href="?page=${currentPage + 1}"
                               class="pagination-link ${currentPage == totalPages ? 'disabled' : ''}">
                                Next
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        function confirmDelete(vehicleId) {
            if (confirm('Are you sure you want to delete this vehicle?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/vehicles/delete?id=' + vehicleId;
            }
        }

        function openModal() {
            document.getElementById('addVehicleModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('addVehicleModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('addVehicleModal');
            if (event.target === modal) {
                closeModal();
            }
        }

        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const file = input.files[0];
            
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.innerHTML = `<img src="${e.target.result}" class="preview-img">`;
                }
                reader.readAsDataURL(file);
            } else {
                preview.innerHTML = '';
            }
        }

        document.getElementById('addVehicleForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            
            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    closeModal();
                    window.location.reload();
                } else {
                    alert('Error adding vehicle: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error adding vehicle. Please try again.');
            });
        });
    </script>
</body>
</html> 