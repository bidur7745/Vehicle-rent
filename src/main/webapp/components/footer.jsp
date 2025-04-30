<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    // Mobile menu functionality
    const mobileMenuBtn = document.querySelector('.mobile-menu');
    const navContainer = document.querySelector('.nav-container');
    
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
</script>