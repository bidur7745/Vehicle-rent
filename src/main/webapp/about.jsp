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