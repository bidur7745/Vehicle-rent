<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - AutoRent</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <style>
        .contact-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        
        @media (max-width: 768px) {
            .contact-container {
                grid-template-columns: 1fr;
            }
        }
        
        .contact-info {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .contact-info h3 {
            margin-bottom: 1rem;
        }
        
        .contact-info p {
            margin-bottom: 0.5rem;
        }
        
        .contact-form {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .success-message {
            display: none;
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <div class="logo">
                    <h1>AutoRent</h1>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="vehicles.jsp">Vehicles</a></li>
                    <li><a href="my-bookings.jsp">My Bookings</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="contact.jsp" class="active">Contact</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="container">
        <h2>Contact Us</h2>
        
        <div class="success-message" id="successMessage">
            Thank you for your message! We'll get back to you soon.
        </div>
        
        <div class="contact-container">
            <div class="contact-info">
                <h3>Get in Touch</h3>
                <p><strong>Address:</strong> 123 Auto Street, City, Country</p>
                <p><strong>Phone:</strong> +1 (123) 456-7890</p>
                <p><strong>Email:</strong> info@autorent.com</p>
                <p><strong>Business Hours:</strong></p>
                <p>Monday - Friday: 9:00 AM - 6:00 PM</p>
                <p>Saturday: 10:00 AM - 4:00 PM</p>
                <p>Sunday: Closed</p>
            </div>

            <div class="contact-form">
                <form id="contactForm" onsubmit="return handleSubmit(event)">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" rows="5" required></textarea>
                    </div>

                    <div class="form-group mt-2">
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Send Message</button>
                    </div>
                </form>
            </div>
        </div>
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
        function handleSubmit(event) {
            event.preventDefault();
            
            // Show success message
            document.getElementById('successMessage').style.display = 'block';
            
            // Reset form
            document.getElementById('contactForm').reset();
            
            // Hide success message after 5 seconds
            setTimeout(function() {
                document.getElementById('successMessage').style.display = 'none';
            }, 5000);
            
            return false;
        }
    </script>
</body>
<link rel="stylesheet" href="assets/css/style.css">
</html>