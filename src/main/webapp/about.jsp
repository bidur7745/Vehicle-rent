<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - AutoRent</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .about-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        
        @media (max-width: 768px) {
            .about-container {
                grid-template-columns: 1fr;
            }
        }
        
        .about-content {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .about-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }
        
        .feature-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .feature-icon {
            font-size: 2rem;
            color: var(--secondary-color);
            margin-bottom: 1rem;
        }

        .team-section {
            padding: 4rem 0;
            background-color: #fff;
        }

        .team-section h2 {
            text-align: center;
            margin-bottom: 3rem;
            font-size: 2rem;
            color: #333;
        }

        .team-section h2 i {
            color: #1877F2;
            margin-right: 0.5rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            padding: 0 1rem;
        }

        .team-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            text-align: center;
            display: flex;
            flex-direction: column;
        }

        .team-card:hover {
            transform: translateY(-5px);
        }

        .team-card .image-container {
            width: 100%;
            height: 300px;
            overflow: hidden;
            position: relative;
            background: #f8f9fa;
            border-bottom: 3px solid #1877F2;
        }

        .team-card img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 1rem;
            background: #fff;
        }

        .team-card .content {
            padding: 1.5rem;
            background: white;
        }

        .team-card h3 {
            margin: 0 0 0.5rem;
            color: #333;
            font-size: 1.25rem;
        }

        .team-card p {
            color: #666;
            margin: 0;
            font-size: 1rem;
        }

        @media (max-width: 768px) {
            .team-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }

            .team-card .image-container {
                height: 250px;
            }
        }
    </style>
</head>
<body>
    <header class="sticky-header">
        <div class="container">
            <nav>
                <div class="logo">
                    <a href="index.html">
                        <i class="fas fa-car-side"></i> AutoRent
                    </a>
                </div>
                <div class="nav-container">
                    <ul class="nav-links">
                        <li><a href="index.html"><i class="fas fa-home"></i> Home</a></li>
                        <li><a href="vehicles.html"><i class="fas fa-car"></i> Vehicles</a></li>
                        <li><a href="booking.html"><i class="fas fa-calendar-alt"></i> Bookings</a></li>
                        <li><a href="about.html" class="active"><i class="fas fa-info-circle"></i> About us</a></li>
                    </ul>
                    <div class="auth-buttons">
                        <a href="login.html" class="btn btn-primary">Get Started</a>
                    </div>
                    <button class="mobile-menu">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
            </nav>
        </div>
    </header>

    <main>
        <section class="about-hero">
            <div class="container">
                <h1>About AutoRent</h1>
                <p>Your trusted partner in vehicle rentals since 2024</p>
            </div>
        </section>

        <section class="about-content">
            <div class="container">
                <div class="about-grid">
                    <div class="about-card">
                        <i class="fas fa-building fa-3x"></i>
                        <h3>Our Company</h3>
                        <p>AutoRent is Nepal's leading vehicle rental platform, providing convenient and reliable transportation solutions.</p>
                    </div>
                    <div class="about-card">
                        <i class="fas fa-bullseye fa-3x"></i>
                        <h3>Our Mission</h3>
                        <p>To make vehicle rental accessible, affordable, and hassle-free for everyone in Nepal.</p>
                    </div>
                    <div class="about-card">
                        <i class="fas fa-handshake fa-3x"></i>
                        <h3>Our Values</h3>
                        <p>We believe in transparency, reliability, and exceptional customer service.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="team-section">
            <div class="container">
                <h2><i class="fas fa-users"></i> Our Team</h2>
                <div class="team-grid">
                    <div class="team-card">
                        <div class="image-container">
                            <img src="./assetes/hal.png" alt="Team Member">
                        </div>
                        <div class="content">
                            <h3>Bidur Siwakoti</h3>
                            <p>Founder & CEO</p>
                        </div>
                    </div>
                    <div class="team-card">
                        <div class="image-container">
                            <img src="./assetes/lionel-messi-celebration-f-c-barcelona-hvg443b7e8ycuf0q.png" alt="Team Member">
                        </div>
                        <div class="content">
                            <h3>David Basnet</h3>
                            <p>Operations Manager</p>
                        </div>
                    </div>
                    <div class="team-card">
                        <div class="image-container">
                            <img src="./assetes/khvicha-card-24-25.png" alt="Team Member">
                        </div>
                        <div class="content">
                            <h3>Anmoyl Poudel</h3>
                            <p>Customer Relations</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="contact-section">
            <div class="container">
                <h2><i class="fas fa-envelope"></i> Contact Us</h2>
                <div class="contact-grid">
                    <div class="contact-info">
                        <div class="info-card">
                            <i class="fas fa-map-marker-alt"></i>
                            <h3>Our Location</h3>
                            <p>Dulari Chowk<br>Morang, Nepal</p>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-phone"></i>
                            <h3>Phone Numbers</h3>
                            <p>Main: +977-9800000000<br>Support: +977-9811111111</p>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-envelope"></i>
                            <h3>Email</h3>
                            <p>info@autorent.com<br>support@autorent.com</p>
                        </div>
                        <div class="info-card">
                            <i class="fas fa-clock"></i>
                            <h3>Business Hours</h3>
                            <p>Monday - Friday: 9:00 AM - 6:00 PM<br>Saturday: 10:00 AM - 4:00 PM</p>
                        </div>
                    </div>
                    <div class="contact-form">
                        <h3>Send us a Message</h3>
                        <form id="contactForm">
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" id="name" name="name" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" id="phone" name="phone" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="subject">Subject</label>
                                <input type="text" id="subject" name="subject" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="message">Message</label>
                                <textarea id="message" name="message" class="form-control" rows="5" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Send Message
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <section class="map-section">
            <div class="container">
                <div class="map-container">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3571.550325669127!2d87.30046697495558!3d26.65621353264462!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39ef6ea0c724a88f%3A0x7a6b16babeaffed8!2sDulari%20Chowk!5e0!3m2!1sen!2snp!4v1709728583030!5m2!1sen!2snp"
                        width="100%" 
                        height="450" 
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </section>
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
                        <li><a href="index.html"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="vehicles.html"><i class="fas fa-chevron-right"></i> Vehicles</a></li>
                        <li><a href="booking.html"><i class="fas fa-chevron-right"></i> Bookings</a></li>
                        <li><a href="about.html"><i class="fas fa-chevron-right"></i> About Us</a></li>
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
    <style>
        .site-footer {
            background-color: #1a1a1a;
            color: #ffffff;
            padding: 60px 0 20px;
            margin-top: 60px;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }

        .footer-brand h3 {
            color: #1877F2;
            font-size: 1.8rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-brand p {
            color: #b3b3b3;
            margin-bottom: 20px;
        }

        .social-links {
            display: flex;
            gap: 15px;
        }

        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: #2a2a2a;
            border-radius: 50%;
            color: #ffffff;
            transition: all 0.3s ease;
        }

        .social-link:hover {
            background: #1877F2;
            transform: translateY(-3px);
        }

        .footer-links h4,
        .footer-contact h4,
        .footer-newsletter h4 {
            color: #ffffff;
            font-size: 1.2rem;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-links h4::after,
        .footer-contact h4::after,
        .footer-newsletter h4::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 40px;
            height: 2px;
            background: #1877F2;
        }

        .footer-links ul,
        .footer-contact ul {
            list-style: none;
            padding: 0;
        }

        .footer-links li,
        .footer-contact li {
            margin-bottom: 12px;
        }

        .footer-links a,
        .footer-contact a {
            color: #b3b3b3;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .footer-links a:hover,
        .footer-contact a:hover {
            color: #1877F2;
            padding-left: 5px;
        }

        .footer-contact li {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #b3b3b3;
        }

        .footer-contact i {
            color: #1877F2;
        }

        .footer-newsletter p {
            color: #b3b3b3;
            margin-bottom: 20px;
        }

        .newsletter-form {
            display: flex;
            gap: 10px;
        }

        .newsletter-form input {
            flex: 1;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background: #2a2a2a;
            color: #ffffff;
        }

        .btn-subscribe {
            padding: 10px 20px;
            background: #1877F2;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-subscribe:hover {
            background: #1464d8;
        }

        .footer-bottom {
            border-top: 1px solid #2a2a2a;
            padding-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .footer-bottom p {
            color: #b3b3b3;
            margin: 0;
        }

        .footer-bottom span {
            color: #1877F2;
        }

        .footer-legal {
            display: flex;
            gap: 20px;
        }

        .footer-legal a {
            color: #b3b3b3;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-legal a:hover {
            color: #1877F2;
        }

        @media (max-width: 768px) {
            .footer-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .footer-bottom {
                flex-direction: column;
                text-align: center;
            }

            .footer-legal {
                justify-content: center;
            }

            .newsletter-form {
                flex-direction: column;
            }
        }
    </style>

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