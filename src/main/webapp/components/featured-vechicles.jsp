<%@ page import="com.autorent.services.VehicleService" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
<section class="featured-vehicles">
    <div class="container">
        <h2><i class="fas fa-star"></i> Featured Vehicles</h2>
        
        <!-- Debug Info -->
        <%
            VehicleService debugService = new VehicleService();
            List<Vehicle> allDebugVehicles = debugService.getAllVehicles();
            if(allDebugVehicles.isEmpty()) {
        %>
            <div class="alert alert-warning">
                <p><strong>Debug:</strong> No vehicles found in database.</p>
            </div>
        <% } else { %>
            <div class="alert alert-info" style="display: none;">
                <p><strong>Debug:</strong> Found <%= allDebugVehicles.size() %> vehicles in database.</p>
            </div>
        <% } %>
        
        <div class="vehicle-cards">
            <%
                VehicleService vehicleService = new VehicleService();
                List<Vehicle> allVehicles = vehicleService.getAllVehicles();
                
                // Select 2 random vehicles from the list
                List<Vehicle> randomVehicles = new ArrayList<>();
                
                if (allVehicles.size() > 0) {
                    Random random = new Random();
                    
                    // If there are less than 2 vehicles, use all available
                    int numToShow = Math.min(2, allVehicles.size());
                    
                    for (int i = 0; i < numToShow; i++) {
                        int remainingVehicles = allVehicles.size() - randomVehicles.size();
                        if (remainingVehicles <= 0) break;
                        
                        // Get a random index from remaining vehicles
                        int randomIndex = random.nextInt(remainingVehicles);
                        Vehicle selectedVehicle = null;
                        
                        // Find a vehicle that hasn't been selected yet
                        int currentIndex = 0;
                        for (Vehicle v : allVehicles) {
                            if (!randomVehicles.contains(v)) {
                                if (currentIndex == randomIndex) {
                                    selectedVehicle = v;
                                    break;
                                }
                                currentIndex++;
                            }
                        }
                        
                        if (selectedVehicle != null) {
                            randomVehicles.add(selectedVehicle);
                        }
                    }
                }
                
                // Display the randomly selected vehicles
                String[] badges = {"Popular", "Best Value"};
                int count = 0;
                
                for (Vehicle vehicle : randomVehicles) {
                    String badge = badges[count % badges.length];
                    
                    // Convert byte[] to Base64 image string if image exists
                    String imageBase64 = "";
                    if (vehicle.getImage() != null && vehicle.getImage().length > 0) {
                        imageBase64 = Base64.getEncoder().encodeToString(vehicle.getImage());
                    }
            %>
            <div class="vehicle-card">
                <div class="vehicle-image">
                    <% if(imageBase64 != null && !imageBase64.isEmpty()) { %>
                        <img src="data:image/jpeg;base64,<%= imageBase64 %>" alt="<%= vehicle.getName() %>" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/BMW-X7-model-card.webp';">
                    <% } else { %>
                        <img src="${pageContext.request.contextPath}/assets/images/BMW-X7-model-card.webp" alt="<%= vehicle.getName() %>">
                    <% } %>
                    <span class="vehicle-badge"><%= badge %></span>
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
                    count++;
                }
                
                // If no vehicles found, display a message
                if (randomVehicles.isEmpty()) {
            %>
            <div class="no-vehicles">
                <p>No featured vehicles available at the moment.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

