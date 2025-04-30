<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Safely check if user is logged in
    boolean isLoggedIn = false;
    try {
        isLoggedIn = session != null && session.getAttribute("user") != null;
    } catch (Exception e) {
        // If there's any session error, consider user as logged out
        if (session != null) {
            session.invalidate();
        }
    }
%>

<style>
    .profile-dropdown {
        position: relative;
        display: inline-block;
    }

    .profile-btn {
        background: none;
        border: none;
        color: #333;
        padding: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        font-size: 16px;
    }

    .profile-btn i.fa-user-circle {
        font-size: 24px;
        color: #1877F2;
    }

    .profile-btn:hover {
        background-color: rgba(0, 0, 0, 0.05);
        border-radius: 5px;
    }

    .dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        padding: 8px 0;
        min-width: 200px;
        display: none;
        z-index: 1000;
    }

    .profile-dropdown.active .dropdown-menu {
        display: block;
        animation: slideDown 0.3s ease;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .dropdown-menu a {
        display: flex;
        align-items: center;
        padding: 12px 20px;
        color: #333;
        text-decoration: none;
        transition: background-color 0.2s;
        gap: 10px;
    }

    .dropdown-menu a i {
        width: 20px;
        color: #666;
    }

    .dropdown-menu a:hover {
        background-color: #f8f9fa;
    }

    .dropdown-divider {
        height: 1px;
        background-color: #e9ecef;
        margin: 8px 0;
    }

    .logout-btn {
        color: #dc3545 !important;
    }

    .logout-btn i {
        color: #dc3545 !important;
    }
</style>

<header class="sticky-header">
    <div class="container">
        <nav>
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <i class="fas fa-car-side"></i> AutoRent
                </a>
            </div>
            <div class="nav-container">
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/index.jsp" ${pageContext.request.servletPath.equals("/index.jsp") ? "class='active'" : ""}><i class="fas fa-home"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/vehicles.jsp" ${pageContext.request.servletPath.equals("/vehicles.jsp") ? "class='active'" : ""}><i class="fas fa-car"></i> Vehicles</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp" ${pageContext.request.servletPath.equals("/about.jsp") ? "class='active'" : ""}><i class="fas fa-info-circle"></i> About us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp" ${pageContext.request.servletPath.equals("/contact.jsp") ? "class='active'" : ""}><i class="fas fa-phone"></i> Contact</a></li>
                </ul>
                <div class="auth-buttons">
                    <% if (isLoggedIn) { %>
                        <div class="profile-dropdown">
                            <button class="profile-btn">
                                <i class="fas fa-user-circle"></i>
                                <span>${sessionScope.user.firstName}</span>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user"></i> My Profile</a>
                                <a href="${pageContext.request.contextPath}/user/bookings"><i class="fas fa-calendar-check"></i> My Bookings</a>
                                <div class="dropdown-divider"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Get Started</a>
                    <% } %>
                </div>
                <button class="mobile-menu">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
        </nav>
    </div>
</header>

<script>
    // Profile dropdown functionality
    const profileDropdown = document.querySelector('.profile-dropdown');
    const profileBtn = document.querySelector('.profile-btn');

    if (profileBtn) {
        profileBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            profileDropdown.classList.toggle('active');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', (e) => {
            if (!profileDropdown.contains(e.target)) {
                profileDropdown.classList.remove('active');
            }
        });
    }

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