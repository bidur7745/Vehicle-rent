<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                            <option value="0-50">Rs0 - Rs5000/day</option>
                            <option value="51-100">Rs5100 - Rs10000/day</option>
                            <option value="101+">$101+/day</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="availability">Availability</label>
                        <select id="availability" class="form-control">
                            <option value="">Any Time</option>
                            <option value="today">Available Today</option>
                            <option value="week">This Week</option>
                        </select>
                    </div>
                </div>
            </div>
        </section>

        <section class="vehicles-grid">
            <div class="container">
                <div class="vehicle-cards">
                    <!-- Vehicle Card 1 -->
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="./assets/images/BMW-X7-model-card.webp" alt="BMW X7">
                            <span class="vehicle-badge">Available</span>
                        </div>
                        <div class="vehicle-info">
                            <h3>BMW X7</h3>
                            <div class="vehicle-features">
                                <span><i class="fas fa-users"></i> 7 Seats</span>
                                <span><i class="fas fa-cog"></i> Automatic</span>
                                <span><i class="fas fa-gas-pump"></i> Diesel</span>
                            </div>
                            <div class="vehicle-price">
                                <span class="price">Rs4000/day</span>
                                <a href="booking.html" class="btn btn-primary">Book Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Vehicle Card 2 -->
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="./assetes/toyota.jpg" alt="Toyota Camry">
                            <span class="vehicle-badge">Available</span>
                        </div>
                        <div class="vehicle-info">
                            <h3>Toyota Camry</h3>
                            <div class="vehicle-features">
                                <span><i class="fas fa-users"></i> 5 Seats</span>
                                <span><i class="fas fa-cog"></i> Automatic</span>
                                <span><i class="fas fa-gas-pump"></i> Petrol</span>
                            </div>
                            <div class="vehicle-price">
                                <span class="price">Rs6000/day</span>
                                <a href="booking.html" class="btn btn-primary">Book Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Add more vehicle cards as needed -->
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
    </script>
</body>
</html> 