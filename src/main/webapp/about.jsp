<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - AutoRent</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

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
                            <img src="${pageContext.request.contextPath}/assets/images/bidur.png" alt="David Basnet">
                        </div>
                        <div class="content">
                            <h3>Bidur Siwakoti</h3>
                            <p>Operations Manager</p>
                        </div>
                    </div>

                    <div class="team-card">
                        <div class="image-container">
                            <img src="${pageContext.request.contextPath}/assets/images/david.png" alt="David Basnet">
                        </div>
                        <div class="content">
                            <h3>David Basnet</h3>
                            <p>Founder & CEO</p>
                        </div>
                    </div>
                    <div class="team-card">
                        <div class="image-container">
                            <img src="${pageContext.request.contextPath}/assets/images/anmol.jpg" alt="David Basnet">
                        </div>
                        <div class="content">
                            <h3>Anmoyl Poudel</h3>
                            <p>Customer Relations</p>
                        </div>
                    </div>

                    <div class="team-card">
                        <div class="image-container">
                            <img src="${pageContext.request.contextPath}/assets/images/pukar.jpg" alt="David Basnet">
                        </div>
                        <div class="content">
                            <h3>Pukar</h3>
                            <p>Lead Developer</p>
                        </div>
                    </div>

                    <div class="team-card">
                        <div class="image-container">
                            <img src="${pageContext.request.contextPath}/assets/images/prety.jpg" alt="David Basnet">
                        </div>
                        <div class="content">
                            <h3>Preety</h3>
                            <p>Marketing Specialist</p>
                        </div>
                    </div>
                </div>
                <p class="team-quote">AutoRent isn't just about cars — it's about freedom on your terms.</p>
            </div>
        </section>

        
    </main> 

    <jsp:include page="components/footer.jsp" />

    <style>
        /* ... existing styles ... */

        .team-grid {
            display: flex;
            flex-wrap: nowrap; /* Prevent wrapping */
            gap: 20px;
            overflow-x: auto; /* Add horizontal scroll if necessary */
            padding-bottom: 15px; /* Add some padding for the scrollbar */
            justify-content: center; /* Center the flex items */
        }

        .team-card {
            flex: 0 0 200px; /* Prevent shrinking/growing, set base width */
            width: 200px; /* Explicit width */
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center; /* Center content */
        }

        .team-card .image-container {
            width: 100%; /* Make image container take full card width */
            height: 200px; /* Set a fixed height for the image container */
            overflow: hidden;
        }

        .team-card .image-container img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover; /* Scale image to cover container, maintaining aspect ratio */
        }

        .team-card .content {
            padding: 15px;
        }

        .team-card h3 {
            margin: 0 0 5px 0;
            font-size: 1.2rem;
            color: #333;
        }

        .team-card p {
            margin: 0;
            font-size: 0.9rem;
            color: #666;
        }

        /* Adjust grid for smaller screens if needed */
        @media (max-width: 768px) {
            .team-grid {
                 justify-content: flex-start; /* Align to start on small screens */
            }
             .team-card {
                flex: 0 0 180px; /* Slightly smaller cards on mobile */
                width: 180px;
            }
            .team-card .image-container {
                 height: 180px;
            }
        }

        /* Styles for the team quote paragraph */
        .team-quote {
            font-size: 1.2rem;
            display: flex;
            justify-content: center;
            text-align: center;
            font-style: italic;
            color: #444;
            border-left: 4px solid #1877F2;
            padding-left: 15px;
            margin: 20px auto; /* Use auto for left/right margin to help center if flex isn't needed */
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            max-width: 800px; /* Add a max-width for better readability */
        }

        /* ... rest of existing styles ... */
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