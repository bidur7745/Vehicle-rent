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

        .specs-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .specs-details span {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 0.9em;
        }
        
        .specs-details i {
            width: 16px;
            color: #444;
        }
        
        .price-details {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        
        .price-primary {
            font-size: 1.1em;
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        
        .item-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .item-primary {
            font-weight: 600;
            font-size: 1.1em;
            color: #2c3e50;
        }
        
        .item-secondary {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 0.9em;
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
                        <form action="${pageContext.request.contextPath}/admin/vehicles/add" 
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

                <!-- Edit Vehicle Modal -->
                <div id="editVehicleModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>Edit Vehicle</h2>
                            <button onclick="closeEditModal()" class="close-button">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <form id="editVehicleForm" class="admin-form" enctype="multipart/form-data">
                            <input type="hidden" id="edit_vehicle_id" name="vehicleId">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="edit_name">Vehicle Name</label>
                                    <input type="text" id="edit_name" name="name" required class="form-input" placeholder="Enter vehicle name">
                                </div>

                                <div class="form-group">
                                    <label for="edit_type">Vehicle Category</label>
                                    <input type="text" id="edit_type" name="type" required class="form-input" placeholder="e.g. SUV, Sedan">
                                </div>

                                <div class="form-group">
                                    <label for="edit_rent_per_day">Rent Per Day</label>
                                    <input type="number" id="edit_rent_per_day" name="rent_per_day" required class="form-input" step="0.01" min="0" placeholder="Enter daily rent amount">
                                </div>

                                <div class="form-group">
                                    <label for="edit_availability_status">Availability Status</label>
                                    <select id="edit_availability_status" name="availability_status" required class="form-select">
                                        <option value="Available">Available</option>
                                        <option value="Rented">Rented</option>
                                        <option value="Maintenance">Maintenance</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="edit_fuel_type">Fuel Type</label>
                                    <select id="edit_fuel_type" name="fuel_type" required class="form-select">
                                        <option value="Petrol">Petrol</option>
                                        <option value="Diesel">Diesel</option>
                                        <option value="Electric">Electric</option>
                                        <option value="Hybrid">Hybrid</option>
                                        <option value="petrol">petrol</option>
                                        <option value="diesel">diesel</option>
                                        <option value="electric">electric</option>
                                        <option value="hybrid">hybrid</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="edit_no_of_airbags">Number of Airbags</label>
                                    <input type="number" id="edit_no_of_airbags" name="no_of_airbags" required class="form-input" min="0" placeholder="Enter number of airbags">
                                </div>

                                <div class="form-group">
                                    <label for="edit_seating_capacity">Seating Capacity</label>
                                    <input type="number" id="edit_seating_capacity" name="seating_capacity" required class="form-input" min="1" placeholder="Enter seating capacity">
                                </div>

                                <div class="form-group">
                                    <label for="edit_vehicle_type">Transmission</label>
                                    <select id="edit_vehicle_type" name="vehicle_type" required class="form-select">
                                        <option value="Manual">Manual</option>
                                        <option value="Automatic">Automatic</option>
                                        <option value="manual">manual</option>
                                        <option value="automatic">automatic</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="edit_color">Color</label>
                                    <input type="text" id="edit_color" name="color" required class="form-input" placeholder="Enter vehicle color">
                                </div>

                                <div class="form-group full-width">
                                    <label for="edit_image">Vehicle Image (Optional)</label>
                                    <input type="file" id="edit_image" name="image" class="form-input file-input" accept="image/*" onchange="previewEditImage(this)">
                                    <div id="editImagePreview" class="image-preview"></div>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" onclick="closeEditModal()" class="cancel-button">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                                <button type="submit" class="submit-button">
                                    <i class="fas fa-save"></i> Save Changes
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
                                <th>Vehicle Details</th>
                                <th>Specifications</th>
                                <th>Pricing</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${vehicles}" var="vehicle">
                                <tr class="table-row">
                                    <td>
                                        <div class="item-details">
                                            <span class="item-primary">${vehicle.name}</span>
                                            <span class="item-secondary">
                                                <i class="fas fa-palette"></i> ${vehicle.color}
                                            </span>
                                            <span class="item-secondary">
                                                <i class="fas fa-car-side"></i> ${vehicle.type}
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="specs-details">
                                            <span><i class="fas fa-gas-pump"></i> ${vehicle.fuelType}</span>
                                            <span><i class="fas fa-shield-alt"></i> ${vehicle.noOfAirbags} Airbags</span>
                                            <span><i class="fas fa-users"></i> ${vehicle.seatingCapacity} Seats</span>
                                            <span><i class="fas fa-cog"></i> ${vehicle.vehicleType}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="price-details">
                                            <span class="price-primary">
                                                <i class="fas fa-rupee-sign"></i> ${vehicle.rentPerDay}/day
                                            </span>
                                        </div>
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
                                        <c:url var="editUrl" value="/admin/vehicles/edit/${vehicle.vehicleId}" />
                                        <c:url var="deleteUrl" value="/admin/vehicles/delete/${vehicle.vehicleId}" />
                                        
                                        <a href="${editUrl}" class="action-link action-edit">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="${deleteUrl}" class="action-link action-delete">
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
        function openModal() {
            document.getElementById('addVehicleModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('addVehicleModal').style.display = 'none';
            document.body.style.overflow = 'auto';
            document.getElementById('imagePreview').innerHTML = '';
            document.getElementById('addVehicleForm').reset();
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

        // Add Vehicle Form Submission
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
                    alert('Error adding vehicle: ' + (data.message || 'Unknown error occurred'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error adding vehicle. Please try again.');
            });
        });

        // Edit Vehicle Functions - Fix for dropdowns
        document.addEventListener('DOMContentLoaded', function() {
            // Add click event for edit buttons
            document.querySelectorAll('.action-edit').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const url = this.getAttribute('href');
                    console.log('Edit URL:', url);
                    
                    fetch(url)
                        .then(response => {
                            console.log('Response status:', response.status);
                            if (!response.ok) {
                                throw new Error(`Network response was not ok: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Received data:', data);
                            if (data.success) {
                                // Set form values
                                document.getElementById('edit_vehicle_id').value = data.vehicleId;
                                document.getElementById('edit_name').value = data.name || '';
                                document.getElementById('edit_type').value = data.type || '';
                                document.getElementById('edit_rent_per_day').value = data.rentPerDay || '';
                                
                                // Set dropdown values - ensure match by normalizing case
                                setDropdownValue('edit_availability_status', data.availabilityStatus);
                                setDropdownValue('edit_fuel_type', data.fuelType);
                                setDropdownValue('edit_vehicle_type', data.vehicleType);
                                
                                document.getElementById('edit_no_of_airbags').value = data.noOfAirbags || 0;
                                document.getElementById('edit_seating_capacity').value = data.seatingCapacity || 0;
                                document.getElementById('edit_color').value = data.color || '';
                                
                                // Show the modal
                                document.getElementById('editVehicleModal').style.display = 'flex';
                                document.body.style.overflow = 'hidden';
                            } else {
                                alert('Error: ' + (data.message || 'Failed to load vehicle details'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error loading vehicle details. Please try again.');
                        });
                });
            });
            
            // Helper function to set dropdown value
            function setDropdownValue(dropdownId, value) {
                if (!value) return;
                
                const dropdown = document.getElementById(dropdownId);
                if (!dropdown) return;
                
                const normalizedValue = value.toLowerCase();
                
                // Try to find exact match first
                for (let i = 0; i < dropdown.options.length; i++) {
                    const option = dropdown.options[i];
                    if (option.value === value) {
                        dropdown.selectedIndex = i;
                        return;
                    }
                }
                
                // Try case-insensitive match
                for (let i = 0; i < dropdown.options.length; i++) {
                    const option = dropdown.options[i];
                    if (option.value.toLowerCase() === normalizedValue) {
                        dropdown.selectedIndex = i;
                        return;
                    }
                }
                
                // If still no match, log it for debugging
                console.warn(`Could not find matching option for ${dropdownId} with value '${value}'`);
            }
        });

        function closeEditModal() {
            document.getElementById('editVehicleModal').style.display = 'none';
            document.body.style.overflow = 'auto';
            document.getElementById('editImagePreview').innerHTML = '';
            document.getElementById('editVehicleForm').reset();
        }

        function previewEditImage(input) {
            const preview = document.getElementById('editImagePreview');
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

        // Edit Vehicle Form Submission
        document.getElementById('editVehicleForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            
            fetch('${pageContext.request.contextPath}/admin/vehicles/edit', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    closeEditModal();
                    window.location.reload();
                } else {
                    alert('Error updating vehicle: ' + (data.message || 'Unknown error occurred'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error updating vehicle. Please try again.');
            });
        });

        // Add event listeners to edit and delete buttons
        document.addEventListener('DOMContentLoaded', function() {
            // Add click event for edit buttons
            document.querySelectorAll('.action-edit').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const url = this.getAttribute('href');
                    console.log('Edit URL:', url);
                    
                    fetch(url)
                        .then(response => {
                            console.log('Response status:', response.status);
                            if (!response.ok) {
                                throw new Error(`Network response was not ok: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Received data:', data);
                            if (data.success) {
                                document.getElementById('edit_vehicle_id').value = data.vehicleId;
                                document.getElementById('edit_name').value = data.name;
                                document.getElementById('edit_type').value = data.type;
                                document.getElementById('edit_rent_per_day').value = data.rentPerDay;
                                document.getElementById('edit_availability_status').value = data.availabilityStatus;
                                document.getElementById('edit_fuel_type').value = data.fuelType;
                                document.getElementById('edit_no_of_airbags').value = data.noOfAirbags;
                                document.getElementById('edit_seating_capacity').value = data.seatingCapacity;
                                document.getElementById('edit_vehicle_type').value = data.vehicleType;
                                document.getElementById('edit_color').value = data.color;
                                
                                document.getElementById('editVehicleModal').style.display = 'flex';
                                document.body.style.overflow = 'hidden';
                            } else {
                                alert('Error: ' + (data.message || 'Failed to load vehicle details'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error loading vehicle details. Please try again.');
                        });
                });
            });
            
            // Add click event for delete buttons
            document.querySelectorAll('.action-delete').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    if (confirm('Are you sure you want to delete this vehicle?')) {
                        const url = this.getAttribute('href');
                        console.log('Delete URL:', url);
                        
                        fetch(url, {
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            }
                        })
                        .then(response => {
                            console.log('Delete response status:', response.status);
                            return response.json();
                        })
                        .then(data => {
                            console.log('Delete response data:', data);
                            if (data.success) {
                                window.location.reload();
                            } else {
                                alert('Error deleting vehicle: ' + (data.message || 'Unknown error occurred'));
                            }
                        })
                        .catch(error => {
                            console.error('Delete error:', error);
                            alert('Error deleting vehicle. Please try again.');
                        });
                    }
                });
            });
        });
    </script>
</body>
</html> 