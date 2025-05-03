<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vehicle - AutoRent</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .booking-hero {
            background-color: #f8f9fa;
            padding: 3rem 0;
            text-align: center;
            margin-bottom: 2rem;
        }

        .booking-hero h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .booking-hero p {
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        .booking-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            padding: 2rem 0;
        }
        
        .vehicle-summary {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .vehicle-summary img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .vehicle-summary h3 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .vehicle-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #666;
        }

        .feature-item i {
            color: #1877F2;
        }
        
        .booking-details {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .booking-details h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        
        .price-summary {
            margin-top: 2rem;
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .price-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: #666;
        }
        
        .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1877F2;
            border-top: 2px solid #dee2e6;
            padding-top: 1rem;
            margin-top: 1rem;
        }

        .booking-notice {
            margin-top: 1.5rem;
            padding: 1rem;
            background: #e8f4ff;
            border-radius: 8px;
            color: #1877F2;
        }

        .booking-notice i {
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .booking-container {
                grid-template-columns: 1fr;
            }

            .vehicle-features {
                grid-template-columns: 1fr;
            }

            .booking-hero h1 {
                font-size: 2rem;
            }
        }

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
</head>
<body>
    <jsp:include page="components/navbar.jsp" />


    <main>
        <section class="booking-hero">
            <div class="container">
                <h1>Book Your Vehicle</h1>
                <p>Complete your booking in just a few simple steps</p>
            </div>
        </section>

        <section class="container">
            <div class="booking-container">
                <div class="vehicle-summary">
                    <img src="./assets/images/BMW-X7-model-card.webp" alt="BMW X7">
                    <h3>BMW X7</h3>
                    <div class="vehicle-features">
                        <div class="feature-item">
                            <i class="fas fa-users"></i>
                            <span>7 Seats</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-cog"></i>
                            <span>Automatic</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-gas-pump"></i>
                            <span>Diesel</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-suitcase"></i>
                            <span>4 Bags</span>
                        </div>
                    </div>
                    <div class="price-item">
                        <span>Base Rate:</span>
                        <span>Rs2000/day</span>
                    </div>
                    <div class="booking-notice">
                        <i class="fas fa-info-circle"></i>
                        <span>Free cancellation up to 24 hours before pickup</span>
                    </div>
                </div>

                <div class="booking-details">
                    <h3>Booking Details</h3>
                    <form id="bookingForm" action="process-booking" method="post">
                        <div class="form-group">
                            <label for="pickupLocation">Pickup Location</label>
                            <select id="pickupLocation" name="pickupLocation" class="form-control" required>
                                <option value="">Select pickup location</option>
                                <option value="airport">Tribhuvan International Airport</option>
                                <option value="city">Kathmandu City Center</option>
                                <option value="thamel">Thamel</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="startDate">Pickup Date</label>
                            <input type="date" id="startDate" name="startDate" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="startTime">Pickup Time</label>
                            <input type="time" id="startTime" name="startTime" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="endDate">Return Date</label>
                            <input type="date" id="endDate" name="endDate" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="endTime">Return Time</label>
                            <input type="time" id="endTime" name="endTime" class="form-control" required>
                        </div>

                        <div class="price-summary">
                            <div class="price-item">
                                <span>Daily Rate:</span>
                                <span>Rs2000</span>
                            </div>
                            <div class="price-item">
                                <span>Number of Days:</span>
                                <span id="daysCount">0</span>
                            </div>
                            <div class="price-item">
                                <span>Service Charge:</span>
                                <span>Rs500/day</span>
                            </div>
                            <div class="price-item total-price">
                                <span>Total Price:</span>
                                <span id="totalPrice">Rs0</span>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1.5rem;">
                            <i class="fas fa-check-circle"></i> Confirm Booking
                        </button>
                    </form>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="components/footer.jsp" />

   
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

        // Booking calculations
        document.addEventListener('DOMContentLoaded', function() {
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            const daysCount = document.getElementById('daysCount');
            const totalPrice = document.getElementById('totalPrice');
            const dailyRate = 2000;
            const serviceCharge = 500;

            function calculatePrice() {
                if (startDate.value && endDate.value) {
                    const start = new Date(startDate.value);
                    const end = new Date(endDate.value);
                    const diffTime = Math.abs(end - start);
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
                    
                    daysCount.textContent = diffDays;
                    const total = (dailyRate + serviceCharge) * diffDays;
                    totalPrice.textContent = 'Rs' + total;
                }
            }

            startDate.addEventListener('change', calculatePrice);
            endDate.addEventListener('change', calculatePrice);

            // Set minimum date to today
            const today = new Date().toISOString().split('T')[0];
            startDate.min = today;
            endDate.min = today;

            // Validate end date is after start date
            startDate.addEventListener('change', function() {
                endDate.min = startDate.value;
            });
        });
    </script>
</body>
</html> 