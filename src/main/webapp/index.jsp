<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoRent - Vehicle Rental Service</title>
    <!-- <link rel="stylesheet" href="assets/css/style.css"> -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>
    <jsp:include page="components/navbar.jsp" />
    <main>
        <section class="hero-simple">
            <div class="container">
                <div class="hero-content">
                    <div class="hero-text">
                        <h1>Your Journey Begins Here</h1>
                        <p>Experience the freedom of the road with our premium vehicle rental service. Choose from a wide range of cars, SUVs, and luxury vehicles.</p>
                        <a href="vehicles.jsp" class="btn btn-primary"><i class="fas fa-car"></i> Browse Vehicles</a>
                    </div>
                    <div class="hero-image">
                        <img src="./assets/images/BMW-X7-model-card.webp" alt="Luxury Car">
                    </div>
                </div>
            </div>
        </section>
        
<jsp:include page="components/featured-vechicles.jsp" />
      
        <section class="services">
            <div class="container">
                <h2><i class="fas fa-check-circle"></i> Our Services</h2>
                <div class="services-grid">
                    <div class="service-card">
                        <i class="fas fa-car fa-3x"></i>
                        <h3>Wide Selection</h3>
                        <p>Choose from our extensive fleet of vehicles to match your needs and style.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-shield-alt fa-3x"></i>
                        <h3>Insurance Coverage</h3>
                        <p>Drive with peace of mind with our comprehensive insurance coverage.</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-headset fa-3x"></i>
                        <h3>24/7 Support</h3>
                        <p>Our customer support team is always ready to assist you.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="how-it-works">
            <div class="container">
                <h2><i class="fas fa-map-signs"></i> How It Works</h2>
                <div class="steps-grid">
                    <div class="step">
                        <i class="fas fa-search"></i>
                        <h3>1. Browse & Select</h3>
                        <p>Choose from our wide range of vehicles</p>
                    </div>
                    <div class="step">
                        <i class="fas fa-calendar-check"></i>
                        <h3>2. Book & Pay</h3>
                        <p>Secure your booking with easy payment</p>
                    </div>
                    <div class="step">
                        <i class="fas fa-key"></i>
                        <h3>3. Pick Up & Go</h3>
                        <p>Get your keys and start your journey</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="testimonials">
            <div class="container">
                <h2><i class="fas fa-quote-right"></i> Customer Reviews</h2>
                <div class="testimonials-grid">
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p>"Excellent service! The car was in perfect condition and the rental process was smooth."</p>
                            <div class="testimonial-author">
                                <i class="fas fa-user-circle fa-2x" style="color: #1877F2;"></i>
                                <div>
                                    <h4>John D.</h4>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p>"Best car rental service in town! Will definitely use again for my next trip."</p>
                            <div class="testimonial-author">
                                <i class="fas fa-user-circle fa-2x" style="color: #1877F2;"></i>
                                <div>
                                    <h4>Sarah M.</h4>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


    </main>

    <jsp:include page="components/footer.jsp" />

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuBtn = document.querySelector('.mobile-menu');
            const navContainer = document.querySelector('.nav-container');
            if (mobileMenuBtn && navContainer) {
                mobileMenuBtn.addEventListener('click', () => {
                    navContainer.classList.toggle('active');
                    mobileMenuBtn.innerHTML = navContainer.classList.contains('active') 
                        ? '<i class="fas fa-times"></i>' 
                        : '<i class="fas fa-bars"></i>';
                });

                document.addEventListener('click', (e) => {
                    if (!navContainer.contains(e.target) && navContainer.classList.contains('active')) {
                        navContainer.classList.remove('active');
                        mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
                    }
                });
            }
        });
    </script>
</body>
</html> 