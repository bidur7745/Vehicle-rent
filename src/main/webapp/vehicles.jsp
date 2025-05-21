<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.autorent.services.VehicleService" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicles - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <main>
        <section class="vehicles-hero">
            <div class="container">
                <h1>Our Vehicles</h1>
                <p>Choose from our wide selection of quality vehicles</p>
            </div>
        </section>

        <section class="vehicle-filters">
            <div class="container">
                <div class="filter-grid">
                    <div class="filter-group">
                        <label for="category">Category</label>
                        <select id="category" class="form-control">
                            <option value="">All Categories</option>
                            <option value="sedan">Sedan</option>
                            <option value="suv">SUV</option>
                            <option value="luxury">Luxury</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="price">Price Range</label>
                        <select id="price" class="form-control">
                            <option value="">All Prices</option>
                            <option value="0-5000">Under Rs5,000/day</option>
                            <option value="5001-20000">Rs5,001 - Rs20,000/day</option>
                            <option value="20001-40000">Rs20,001 - Rs40,000/day</option>
                            <option value="40001+">Above Rs40,000/day</option>
                        </select>
                    </div>
                    <div class="filter-group filter-actions">
                        <button id="applyFilters" class="btns btn-primarys" title="Apply Filters">
                            <i class="fas fa-check"></i>
                        </button>
                        <button id="resetFilters" class="btns btn-secondarys" title="Reset Filters">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <section class="vehicles-grid">
            <div class="container">
                <div class="vehicle-cards">
                    <%
                        VehicleService vehicleService = new VehicleService();
                        List<Vehicle> vehicles = vehicleService.getAllVehicles();
                        
                        if (vehicles != null && !vehicles.isEmpty()) {
                            for (Vehicle vehicle : vehicles) {
                                // Convert byte[] to Base64 image string if image exists
                                String imageBase64 = "";
                                if (vehicle.getImage() != null && vehicle.getImage().length > 0) {
                                    imageBase64 = Base64.getEncoder().encodeToString(vehicle.getImage());
                                }
                                
                                String availabilityStatus = vehicle.getAvailabilityStatus();
                                if (availabilityStatus == null || availabilityStatus.isEmpty()) {
                                    availabilityStatus = "Available";
                                }
                    %>
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <% if(imageBase64 != null && !imageBase64.isEmpty()) { %>
                                <img src="data:image/jpeg;base64,<%= imageBase64 %>" alt="<%= vehicle.getName() %>" 
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/BMW-X7-model-card.webp';">
                            <% } else { %>
                                <img src="${pageContext.request.contextPath}/assets/images/BMW-X7-model-card.webp" alt="<%= vehicle.getName() %>">
                            <% } %>
                            <span class="vehicle-badge <%= availabilityStatus.equalsIgnoreCase("Available") ? "available" : "booked" %>">
                                <%= availabilityStatus %>
                            </span>
                        </div>
                        <div class="vehicle-info">
                            <h3><%= vehicle.getName() %></h3>
                            <div class="vehicle-features">
                                <span><i class="fas fa-users"></i> <%= vehicle.getSeatingCapacity() %> Seats</span>
                                <span><i class="fas fa-cog"></i> <%= vehicle.getType() %></span>
                                <% if(vehicle.getFuelType() != null && !vehicle.getFuelType().isEmpty()) { %>
                                    <span><i class="fas fa-gas-pump"></i> <%= vehicle.getFuelType() %></span>
                                <% } %>
                            </div>
                            <div class="vehicle-price">
                                <span class="price">Rs<%= vehicle.getRentPerDay() %>/day</span>
                                <% if(availabilityStatus != null && availabilityStatus.equalsIgnoreCase("Available")) { %>
                                    <a href="booking.jsp?id=<%= vehicle.getVehicleId() %>" class="btn btn-primary">Book Now</a>
                                <% } else if (availabilityStatus != null && availabilityStatus.equalsIgnoreCase("Maintenance")) { %>
                                    <button class="btn btn-booked" disabled>Under Maintenance</button>
                                <% } else { %>
                                    <button class="btn btn-booked" disabled>Currently Booked</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="no-vehicles">
                        <p>No vehicles available at the moment. Check back soon!</p>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="components/footer.jsp" />


    <script>
        // Mobile Menu Toggle
        const mobileMenuBtn = document.querySelector('.mobile-menu');
        const navContainer = document.querySelector('.nav-container');
        
        mobileMenuBtn.addEventListener('click', () => {
            navContainer.classList.toggle('active');
            mobileMenuBtn.innerHTML = navContainer.classList.contains('active') 
                ? '<i class="fas fa-times"></i>' 
                : '<i class="fas fa-bars"></i>';
        });

        // Close mobile menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!navContainer.contains(e.target) && navContainer.classList.contains('active')) {
                navContainer.classList.remove('active');
                mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
            }
        });
        
        // Filter functionality
        document.addEventListener('DOMContentLoaded', function() {
            const categorySelect = document.getElementById('category');
            const priceSelect = document.getElementById('price');
            const applyFiltersBtn = document.getElementById('applyFilters');
            const resetFiltersBtn = document.getElementById('resetFilters');
            const vehicleCards = document.querySelectorAll('.vehicle-card');
            
            function applyFilters() {
                const selectedCategory = categorySelect.value.toLowerCase();
                const selectedPrice = priceSelect.value;
                
                let visibleCount = 0;
                
                vehicleCards.forEach(card => {
                    let showCard = true;
                    
                    // Filter by category
                    if (selectedCategory) {
                        const vehicleType = card.querySelector('.vehicle-features span:nth-child(2)').textContent.trim().toLowerCase();
                        const vehicleName = card.querySelector('h3').textContent.trim().toLowerCase();
                        
                        // Check if either type or name contains the selected category
                        if (!vehicleType.includes(selectedCategory) && !vehicleName.includes(selectedCategory)) {
                            showCard = false;
                        }
                    }
                    
                    // Filter by price
                    if (selectedPrice && showCard) {
                        const priceText = card.querySelector('.price').textContent.trim();
                        // Extract only the numeric value from the price text
                        const price = parseFloat(priceText.replace(/[^0-9.]/g, ''));
                        
                        if (!isNaN(price)) {
                            switch(selectedPrice) {
                                case '0-5000':
                                    if (price > 5000) showCard = false;
                                    break;
                                case '5001-20000':
                                    if (price < 5001 || price > 20000) showCard = false;
                                    break;
                                case '20001-40000':
                                    if (price < 20001 || price > 40000) showCard = false;
                                    break;
                                case '40001+':
                                    if (price < 40001) showCard = false;
                                    break;
                            }
                        } else {
                            console.error('Could not parse price:', priceText);
                        }
                    }
                    
                    // Show/hide the card
                    card.style.display = showCard ? '' : 'none';
                    if (showCard) visibleCount++;
                });
                
                // Handle no results message
                let noVehiclesMsg = document.querySelector('.no-vehicles');
                
                if (visibleCount === 0) {
                    if (!noVehiclesMsg) {
                        noVehiclesMsg = document.createElement('div');
                        noVehiclesMsg.className = 'no-vehicles';
                        noVehiclesMsg.innerHTML = '<p>No vehicles match your selected filters.</p>';
                        document.querySelector('.vehicle-cards').appendChild(noVehiclesMsg);
                    }
                } else if (noVehiclesMsg) {
                    noVehiclesMsg.remove();
                }

                // Log filter results for debugging
                console.log('Filter Results:', {
                    selectedCategory,
                    selectedPrice,
                    visibleCount,
                    totalCards: vehicleCards.length
                });
            }
            
            function resetFilters() {
                categorySelect.value = '';
                priceSelect.value = '';
                applyFilters();
            }
            
            // Attach filter events
            applyFiltersBtn.addEventListener('click', applyFilters);
            resetFiltersBtn.addEventListener('click', resetFilters);
            
            // Also apply filters when pressing Enter in select elements
            categorySelect.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    applyFilters();
                }
            });
            
            priceSelect.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    applyFilters();
                }
            });

            // Apply filters when select values change
            categorySelect.addEventListener('change', applyFilters);
            priceSelect.addEventListener('change', applyFilters);
        });
    </script>

    <style>
        .vehicle-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }
        
        .vehicle-badge.available {
            background-color: #4CAF50;
            color: white;
        }
        
        .vehicle-badge.booked {
            background-color: #f44336;
            color: white;
        }
        
        .btn-booked {
            background-color: #040a3a;
            color: white;
            cursor: not-allowed;
            opacity: 0.7;
        }
        
        .btn-booked:hover {
            background-color: #10022e;
            opacity: 0.7;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            align-items: end;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .filter-group label {
            font-weight: 500;
            color: #333;
        }

        .form-control {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .filter-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            flex-direction: row;
            align-items: center;
        }

        .btns {
            width: 40px;
            height: 40px;
            padding: 0;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .btns i {
            font-size: 16px;
        }

        .btn-primarys {
            background-color: #28a745;
            color: white;
        }

        .btn-primarys:hover {
            background-color: #218838;
            transform: scale(1.1);
        }

        .btn-secondarys {
            background-color: #dc3545;
            color: white;
        }

        .btn-secondarys:hover {
            background-color: #c82333;
            transform: scale(1.1);
        }

        @media (max-width: 768px) {
            .filter-grid {
                grid-template-columns: 1fr;
            }
            
            .filter-actions {
                justify-content: center;
            }
        }

        .no-vehicles {
            grid-column: 1 / -1;
            text-align: center;
            padding: 2rem;
            background: #f8f9fa;
            border-radius: 8px;
            margin: 1rem 0;
        }

        .no-vehicles p {
            color: #6c757d;
            font-size: 1.1rem;
            margin: 0;
        }
    </style>
</body>
</html> 