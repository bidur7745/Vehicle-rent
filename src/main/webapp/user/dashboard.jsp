<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - AutoRent</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-light: #4895ef;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --info-color: #4895ef;
            --warning-color: #f72585;
            --danger-color: #e63946;
            --dark-color: #212529;
            --light-color: #f8f9fa;
            --grey-color: #adb5bd;
            
            --text-color: #212529;
            --text-muted: #6c757d;
            
            --sidebar-width: 260px;
            --topbar-height: 70px;
            
            --shadow-sm: 0 2px 4px rgba(0,0,0,.05);
            --shadow-md: 0 4px 8px rgba(0,0,0,.1);
            --shadow-lg: 0 8px 16px rgba(0,0,0,.1);
            
            --transition-speed: 0.3s;
            --border-radius: 8px;
        }
        
        /* Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fb;
            color: var(--text-color);
            line-height: 1.6;
        }
        
        a {
            text-decoration: none;
            color: inherit;
        }
        
        /* Layout */
        .user-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, #2b2d42 0%, #1a1a2e 100%);
            color: #fff;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transition: all var(--transition-speed) ease;
            box-shadow: var(--shadow-lg);
            display: flex;
            flex-direction: column;
        }
        
        .sidebar-logo {
            padding: 20px;
            text-align: center;
            background: rgba(0,0,0,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-logo a {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            color: #fff;
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .sidebar-logo i {
            color: var(--primary-light);
        }
        
        .user-profile {
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            background: rgba(0,0,0,0.05);
        }
        
        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--primary-light);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 1.2rem;
            box-shadow: 0 0 0 3px rgba(255,255,255,0.1);
        }
        
        .user-info {
            flex: 1;
        }
        
        .user-info h4 {
            margin: 0;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .user-info span {
            font-size: 0.8rem;
            color: rgba(255,255,255,0.7);
        }
        
        .sidebar-menu {
            padding: 20px 0;
            flex: 1;
            overflow-y: auto;
        }
        
        .menu-section {
            margin-bottom: 15px;
        }
        
        .menu-section-title {
            padding: 0 20px;
            margin-bottom: 10px;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: rgba(255,255,255,0.5);
            font-weight: 600;
        }
        
        .menu-items {
            list-style: none;
        }
        
        .menu-item {
            position: relative;
        }
        
        .menu-item a {
            display: flex;
            align-items: center;
            padding: 12px 25px;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all var(--transition-speed) ease;
            position: relative;
            margin: 4px 10px;
            border-radius: 8px;
        }
        
        .menu-item a:hover {
            background: rgba(255,255,255,0.1);
            color: #fff;
        }
        
        .menu-item.active a {
            background: rgba(72, 149, 239, 0.2);
            color: var(--primary-light);
        }
        
        .menu-item i {
            width: 20px;
            margin-right: 10px;
            font-size: 1.1rem;
            color: var(--primary-light);
            transition: transform var(--transition-speed) ease;
        }
        
        .menu-item:hover i {
            transform: translateX(3px);
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: all var(--transition-speed) ease;
            padding: 20px;
            padding-top: calc(var(--topbar-height) + 20px);
        }
        
        /* Topbar */
        .topbar {
            position: fixed;
            top: 0;
            right: 0;
            left: var(--sidebar-width);
            height: var(--topbar-height);
            background: #fff;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 25px;
            z-index: 999;
            transition: all var(--transition-speed) ease;
        }
        
        .toggle-sidebar {
            display: none;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.25rem;
            color: var(--dark-color);
        }
        
        .topbar-title h1 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .topbar-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .action-item {
            position: relative;
            cursor: pointer;
        }
        
        .action-item i {
            font-size: 1.25rem;
            color: var(--dark-color);
            transition: color var(--transition-speed) ease;
        }
        
        .action-item:hover i {
            color: var(--primary-color);
        }
        
        .badge {
            position: absolute;
            top: -5px;
            right: -8px;
            background: var(--warning-color);
            color: #fff;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: 600;
            box-shadow: 0 0 0 2px #fff;
        }
        
        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        
        .stat-card {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            padding: 25px;
            transition: transform var(--transition-speed) ease, box-shadow var(--transition-speed) ease;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #fff;
        }
        
        .stat-icon.bookings {
            background: linear-gradient(45deg, #4361ee, #4895ef);
        }
        
        .stat-icon.active-rentals {
            background: linear-gradient(45deg, #4cc9f0, #4895ef);
        }
        
        .stat-icon.favorites {
            background: linear-gradient(45deg, #7209b7, #4361ee);
        }
        
        .stat-icon.wallet {
            background: linear-gradient(45deg, #f72585, #b5179e);
        }
        
        .stat-info {
            flex: 1;
        }
        
        .stat-info h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stat-info span {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        /* Content Sections */
        .content-section {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            margin-bottom: 25px;
        }
        
        .section-header {
            padding: 20px 25px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .section-header h2 {
            font-size: 1.2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-header h2 i {
            color: var(--primary-color);
        }
        
        .section-body {
            padding: 25px;
        }

        /* Profile Card */
        .profile-card {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .profile-header {
            background: linear-gradient(45deg, #4361ee, #4895ef);
            padding: 30px;
            color: #fff;
            text-align: center;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: white;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 15px;
            border: 3px solid rgba(255, 255, 255, 0.3);
        }

        .profile-name {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .profile-body {
            padding: 25px;
        }

        .profile-info {
            margin-bottom: 20px;
        }

        .info-item {
            display: flex;
            margin-bottom: 15px;
        }

        .info-label {
            width: 120px;
            font-weight: 600;
            color: var(--text-muted);
        }

        .info-value {
            flex: 1;
        }

        /* Tables */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .data-table th, 
        .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        
        .data-table th {
            font-weight: 600;
            color: var(--text-muted);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .data-table tbody tr {
            transition: background var(--transition-speed) ease;
        }
        
        .data-table tbody tr:hover {
            background: rgba(0,0,0,0.02);
        }
        
        .data-table td {
            vertical-align: middle;
        }
        
        /* Status Pills */
        .status-pill {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-active {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success-color);
        }
        
        .status-pending {
            background: rgba(247, 37, 133, 0.1);
            color: var(--warning-color);
        }
        
        .status-completed {
            background: rgba(72, 149, 239, 0.1);
            color: var(--info-color);
        }
        
        .status-cancelled {
            background: rgba(230, 57, 70, 0.1);
            color: var(--danger-color);
        }
        
        /* Action Buttons */
        .row-actions {
            display: flex;
            gap: 8px;
        }
        
        .action-btn {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: opacity var(--transition-speed) ease;
        }
        
        .action-btn:hover {
            opacity: 0.8;
        }
        
        .btn-view {
            background: var(--info-color);
        }
        
        .btn-edit {
            background: var(--primary-color);
        }
        
        .btn-download {
            background: var(--success-color);
        }
        
        /* Button Styles */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all var(--transition-speed) ease;
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: #fff;
        }
        
        .btn-primary:hover {
            background: var(--secondary-color);
        }
        
        .btn-secondary {
            background: var(--light-color);
            color: var(--text-color);
        }
        
        .btn-secondary:hover {
            background: var(--grey-color);
            color: #fff;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content, 
            .topbar {
                margin-left: 0;
                left: 0;
            }
            
            .toggle-sidebar {
                display: block;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .data-table {
                overflow-x: auto;
                display: block;
            }
        }

        /* Vehicles Grid */
        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .vehicle-card {
            background: #fff;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: all var(--transition-speed) ease;
        }
        
        .vehicle-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }
        
        .vehicle-image {
            position: relative;
            height: 180px;
            overflow: hidden;
        }
        
        .vehicle-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .vehicle-status {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            color: #fff;
            background: var(--success-color);
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        
        .vehicle-details {
            padding: 20px;
        }
        
        .vehicle-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .vehicle-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: var(--text-muted);
            font-size: 0.85rem;
        }
        
        .vehicle-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .feature {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
        
        .feature i {
            color: var(--primary-color);
            font-size: 0.9rem;
        }
        
        .vehicle-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid rgba(0,0,0,0.05);
        }
        
        .vehicle-price {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--dark-color);
        }
        
        .vehicle-price span {
            font-size: 0.8rem;
            font-weight: 400;
            color: var(--text-muted);
        }
    </style>
</head>
<body>
    <div class="user-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-logo">
                <a href="index.jsp">
                    <i class="fas fa-car-side"></i>
                    <span>AutoRent</span>
                </a>
            </div>
            
            <div class="user-profile">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="user-info">
                    <h4>Bidur Siwakoti</h4>
                    <span>Customer</span>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-section">
                    <h5 class="menu-section-title">Main</h5>
                    <ul class="menu-items">


                        <li class="menu-item">
                            <a href="user-bookings.jsp">
                                <i class="fas fa-calendar-check"></i>
                                <span>My Bookings</span>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="user-profile.jsp">
                                <i class="fas fa-user-circle"></i>
                                <span>My Profile</span>
                            </a>
                        </li>
                    </ul>
                </div>
                
                <div class="menu-section">
                    <ul class="menu-items">
                        <li class="menu-item">
                            <a href="login.jsp">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Logout</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </aside>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Topbar -->
            <div class="topbar">
                <div class="topbar-left">
                    <button class="toggle-sidebar">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="topbar-title">
                        <h1>User Dashboard</h1>
                    </div>
                </div>
                
                <div class="topbar-actions">
                    <div class="action-item">
                        <i class="fas fa-bell"></i>
                        <span class="badge">2</span>
                    </div>
                    <div class="action-item">
                        <i class="fas fa-envelope"></i>
                        <span class="badge">1</span>
                    </div>
                    <div class="action-item">
                        <i class="fas fa-user-circle"></i>
                    </div>
                </div>
            </div>
            
            <!-- Dashboard Cards -->
            <div class="dashboard-cards">
                <div class="stat-card">
                    <div class="stat-icon bookings">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>5</h3>
                        <span>Total Bookings</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon active-rentals">
                        <i class="fas fa-car"></i>
                    </div>
                    <div class="stat-info">
                        <h3>1</h3>
                        <span>Active Rentals</span>
                    </div>
                </div>
                

                

            </div>



        </div>
    </div>

    <script>
        // Toggle Sidebar
        const toggleBtn = document.querySelector('.toggle-sidebar');
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');
        const topbar = document.querySelector('.topbar');
        
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('show');
        });
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth < 992) {
                if (!sidebar.contains(e.target) && !toggleBtn.contains(e.target)) {
                    sidebar.classList.remove('show');
                }
            }
        });
        
        // Resize handler
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 992) {
                sidebar.classList.remove('show');
            }
        });
    </script>
</body>
</html> 