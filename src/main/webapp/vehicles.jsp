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
                            <option value="0-5000">Rs0 - Rs5000/day</option>
                            <option value="5001-10000">Rs5001 - Rs10000/day</option>
                            <option value="10001+">Rs10001+/day</option>
                        </select>
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
                            <span class="vehicle-badge"><%= availabilityStatus %></span>
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
                                <a href="booking.jsp?id=<%= vehicle.getVehicleId() %>" class="btn btn-primary">Book Now</a>
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
            const vehicleCards = document.querySelectorAll('.vehicle-card');
            
            function applyFilters() {
                const selectedCategory = categorySelect.value.toLowerCase();
                const selectedPrice = priceSelect.value;
                
                let visibleCount = 0;
                
                vehicleCards.forEach(card => {
                    let showCard = true;
                    
                    // Filter by category
                    if (selectedCategory) {
                        // Look for vehicle type in features section
                        const features = card.querySelectorAll('.vehicle-features span');
                        let matchFound = false;
                        console.log("Category:", selectedCategory);

                        
                        features.forEach(feature => {
                            const featureText = feature.textContent.toLowerCase();
                            if (featureText.includes(selectedCategory)) {
                                matchFound = true;
                            }
                        });
                        
                        // Also check vehicle name
                        const vehicleName = card.querySelector('h3').textContent.toLowerCase();
                        if (vehicleName.includes(selectedCategory)) {
                            matchFound = true;
                        }
                        
                        if (!matchFound) {
                            showCard = false;
                        }
                    }
                    
                    // Filter by price
                    if (selectedPrice && showCard) {
                        const priceText = card.querySelector('.price').textContent;
                        const price = parseFloat(priceText.replace('Rs', '').replace('/day', '').trim());
                        
                        if (selectedPrice === '0-5000') {
                            if (price > 5000) showCard = false;
                        } else if (selectedPrice === '5001-10000') {
                            if (price < 5001 || price > 10000) showCard = false;
                        } else if (selectedPrice === '10001+') {
                            if (price < 10001) showCard = false;
                        }
                        console.log("Price Range:", selectedPrice);
                    }
                    
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
                
                console.log(`Filter applied: ${visibleCount} vehicles visible`);
            }
            
            // Attach filter events
            categorySelect.addEventListener('change', applyFilters);
            priceSelect.addEventListener('change', applyFilters);
        });
    </script>
</body>
</html> 