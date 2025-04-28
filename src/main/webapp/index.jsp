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
    <header class="sticky-header">
        <div class="container">
            <nav>
                <div class="logo">
                    <a href="index.jsp">
                        <i class="fas fa-car-side"></i> AutoRent
                    </a>
                </div>
                <div class="nav-container">
                    <ul class="nav-links">
                        <li><a href="index.jsp" class="active"><i class="fas fa-home"></i> Home</a></li>
                        <li><a href="vehicles.jsp"><i class="fas fa-car"></i> Vehicles</a></li>
                        <li><a href="booking.jsp"><i class="fas fa-calendar-alt"></i> Bookings</a></li>
                        <li><a href="about.jsp"><i class="fas fa-info-circle"></i> About us</a></li>
                    </ul>
                    <div class="auth-buttons">
                        <a href="login.jsp" class="btn btn-primary">Get Started</a>
                    </div>
                    <button class="mobile-menu">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
            </nav>
        </div>
    </header>

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

        <section class="featured-vehicles">
            <div class="container">
                <h2><i class="fas fa-star"></i> Featured Vehicles</h2>
                <div class="vehicle-cards">
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="./assets/images/BMW-X7-model-card.webp" alt="BMW X7">
                            <span class="vehicle-badge">Popular</span>
                        </div>
                        <div class="vehicle-info">
                            <h3>BMW X7</h3>
                            <div class="vehicle-features">
                                <span><i class="fas fa-users"></i> 7 Seats</span>
                                <span><i class="fas fa-cog"></i> Automatic</span>
                            </div>
                            <div class="vehicle-price">
                                <span class="price">Rs4000/day</span>
                                <a href="booking.jsp" class="btn btn-primary">Book Now</a>
                            </div>
                        </div>
                    </div>
                    <div class="vehicle-card">
                        <div class="vehicle-image">
                            <img src="./assets/images/toyota.jpg" alt="Toyota Camry">
                            <span class="vehicle-badge">Best Value</span>
                        </div>
                        <div class="vehicle-info">
                            <h3>Toyota Camry</h3>
                            <div class="vehicle-features">
                                <span><i class="fas fa-users"></i> 5 Seats</span>
                                <span><i class="fas fa-cog"></i> Automatic</span>
                            </div>
                            <div class="vehicle-price">
                                <span class="price">Rs5000/day</span>
                                <a href="booking.jsp" class="btn btn-primary">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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

        <!-- <section class="cta-section">
            <div class="container">
                <div class="cta-content">
                    <h2>Ready to Start Your Journey?</h2>
                    <p>Join thousands of satisfied customers who trust AutoRent for their travel needs.</p>
                    <a href="vehicles.jsp" class="btn btn-primary"><i class="fas fa-car"></i> Rent a Car Now</a>
                </div>
            </div>
        </section> -->
    </main>

    <footer class="site-footer">
        <div class="footer-container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <h3><i class="fas fa-car-side"></i> AutoRent</h3>
                    <p>Drive the car you want, when you want.</p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="index.jsp"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="vehicles.jsp"><i class="fas fa-chevron-right"></i> Vehicles</a></li>
                        <li><a href="booking.jsp"><i class="fas fa-chevron-right"></i> Bookings</a></li>
                        <li><a href="about.jsp"><i class="fas fa-chevron-right"></i> About Us</a></li>
                    </ul>
                </div>
                <div class="footer-contact">
                    <h4>Contact Us</h4>
                    <ul>
                        <li><i class="fas fa-envelope"></i> <a href="mailto:support@autorent.com">support@autorent.com</a></li>
                        <li><i class="fas fa-phone"></i> +977-9800000000</li>
                        <li><i class="fas fa-map-marker-alt"></i> Dulari Chowk, Morang, Nepal</li>
                    </ul>
                </div>
                <div class="footer-newsletter">
                    <h4>Newsletter</h4>
                    <p>Subscribe to our newsletter for updates and offers</p>
                    <form class="newsletter-form">
                        <input type="email" placeholder="Enter your email" required>
                        <button type="submit" class="btn-subscribe">Subscribe</button>
                    </form>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 <span>AutoRent</span>. All rights reserved.</p>
                <div class="footer-legal">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Cookie Policy</a>
                </div>
            </div>
        </div>
    </footer>

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