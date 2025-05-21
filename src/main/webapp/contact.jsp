<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Allow access to this page regardless of login status
    boolean isLoggedIn = session != null && session.getAttribute("user") != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        .contact-section {
            padding: 80px 0;
            margin-top: 60px;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        
        @media (max-width: 768px) {
            .contact-grid {
                grid-template-columns: 1fr;
            }
        }
        
        .contact-info {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .info-card {
            margin-bottom: 2rem;
            padding: 1rem;
            border-radius: 8px;
            background: #f8f9fa;
        }

        .info-card i {
            font-size: 2rem;
            color: #1877F2;
            margin-bottom: 1rem;
        }
        
        .info-card h3 {
            margin: 1rem 0;
            color: #333;
            font-size: 1.2rem;
        }
        
        .info-card p {
            color: #666;
            line-height: 1.6;
        }
        
        .contact-form {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .contact-form h3 {
            margin-bottom: 1.5rem;
            color: #333;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #666;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-primary {
            background-color: #1877F2;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1664d9;
        }
        
        .success-message {
            display: none;
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
        }

        .map-section {
            padding: 40px 0;
            background-color: #fff;
        }

        .map-container {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />

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
                    <div id="successMessage" class="success-message">
                        Your message has been sent successfully! We'll get back to you soon.
                    </div>
                    <form id="contactForm" onsubmit="return handleSubmit(event)">
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

    <jsp:include page="/components/footer.jsp" />

    <script>
        async function handleSubmit(event) {
            event.preventDefault();
            
            const form = document.getElementById('contactForm');
            const formData = new FormData(form);
            const successMessageDiv = document.getElementById('successMessage');
            const submitButton = form.querySelector('button[type="submit"]');
            
            // Hide previous messages
            successMessageDiv.style.display = 'none';
            successMessageDiv.classList.remove('success-message', 'error-message'); // Clear previous styles
            
            // Disable button and show loading indicator if desired
            submitButton.disabled = true;
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';

            try {
                const response = await fetch('${pageContext.request.contextPath}/contact', {
                    method: 'POST',
                    body: formData
                });

                const result = await response.json();

                // Enable button and restore text
                submitButton.disabled = false;
                submitButton.innerHTML = '<i class="fas fa-paper-plane"></i> Send Message';

                if (result.success) {
                    // Show success message
                    successMessageDiv.textContent = result.message;
                    successMessageDiv.classList.add('success-message');
                    successMessageDiv.style.display = 'block';

                    // Reset form
                    form.reset();

                    // Hide success message after 5 seconds
                    setTimeout(function() {
                        successMessageDiv.style.display = 'none';
                    }, 5000);

                } else {
                    // Show error message
                    successMessageDiv.textContent = result.message || 'An error occurred.';
                    successMessageDiv.classList.add('error-message'); // Add a class for error styling (you might need to define this in CSS)
                    successMessageDiv.style.display = 'block';
                }

            } catch (error) {
                console.error('Error submitting contact form:', error);
                // Enable button and restore text
                submitButton.disabled = false;
                submitButton.innerHTML = '<i class="fas fa-paper-plane"></i> Send Message';
                
                // Show generic error message
                successMessageDiv.textContent = 'An error occurred while sending your message. Please try again.';
                successMessageDiv.classList.add('error-message'); // Add a class for error styling
                successMessageDiv.style.display = 'block';
            }
            
            return false; // Prevent actual form submission
        }
    </script>
</body>
</html>