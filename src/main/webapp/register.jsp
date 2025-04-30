<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - AutoRent</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/auth.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  
</head>
<body>
    <% 
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) session.getAttribute("successMessage");
    // Clear the success message after reading it
    session.removeAttribute("successMessage");
%>

<% if (errorMessage != null) { %>
    <div id="toast" style="
        position: fixed;
        top: 30px;
        right: 30px;
        min-width: 250px;
        background-color: #f44336;
        color: white;
        text-align: center;
        border-radius: 4px;
        padding: 16px;
        z-index: 9999;
        font-size: 16px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        opacity: 0.95;
        animation: slideIn 0.5s, fadeOut 0.5s 3s;">
        <%= errorMessage %>
    </div>
<% } %>

<% if (successMessage != null) { %>
    <div id="successToast" style="
        position: fixed;
        top: 30px;
        right: 30px;
        min-width: 250px;
        background-color: #4CAF50;
        color: white;
        text-align: center;
        border-radius: 4px;
        padding: 16px;
        z-index: 9999;
        font-size: 16px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        opacity: 0.95;
        animation: slideIn 0.5s, fadeOut 0.5s 3s;">
        <%= successMessage %>
    </div>
<% } %>

<jsp:include page="components/navbar.jsp" />

    <main>
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h1>Create Account</h1>
                    <p>Join AutoRent and start your journey</p>
                </div>

                <form id="registerForm" action="RegisterServlet" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" class="form-control" 
                                   value="${firstName != null ? firstName : ''}" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" class="form-control" 
                                   value="${lastName != null ? lastName : ''}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               value="${email != null ? email : ''}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               value="${phone != null ? phone : ''}" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                        </div>
                    </div>

                    <div class="terms">
                        <label>
                            <input type="checkbox" required>
                            I agree to the <a href="terms.jsp">Terms of Service</a> and <a href="privacy.jsp">Privacy Policy</a>
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> Create Account
                    </button>

                    <div class="auth-footer">
                        <p>
                            Already have an account?
                            <a href="login.jsp" style="color: #1877F2; text-decoration: none;">Sign In</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
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

        // Password validation
        const form = document.getElementById('registerForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        form.addEventListener('submit', (e) => {
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    </script>
</body>
</html> 