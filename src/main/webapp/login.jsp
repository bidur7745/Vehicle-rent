<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AutoRent</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .auth-container {
            min-height: calc(100vh - 200px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background-size: cover;
            background: linear-gradient(rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.9)), url('assets/images/BMW-X7-model-card.webp') center;
        }

        .auth-card {
            background: white;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .auth-header h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .auth-header p {
            color: #666;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #1877F2;
            outline: none;
        }

        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }

        .auth-footer p {
            margin-bottom: 1rem;
            color: #666;
        }

        .btn-primary {
            width: 100%;
            padding: 0.75rem;
            background: #1877F2;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background: #1464d8;
        }

        .price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #1877F2;
        }

        .price::before {
            content: "Rs ";
        }

        @media (max-width: 768px) {
            .auth-container {
                padding: 1rem;
            }

            .auth-card {
                padding: 1.5rem;
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
                        <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
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
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h1>Welcome Back</h1>
                    <p>Sign in to continue to AutoRent</p>
                </div>

                <form id="loginForm" action="${pageContext.request.contextPath}/LoginServlet" method="POST">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-control" required>
                        <a href="forgot-password.jsp" class="forgot-password">Forgot Password?</a>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>

                    <div class="auth-footer">
                        <p>
                            Don't have an account? 
                            <a href="register.jsp" style="color: #1877F2; text-decoration: none;">Sign Up</a>
                        </p>
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
</body>
</html> 