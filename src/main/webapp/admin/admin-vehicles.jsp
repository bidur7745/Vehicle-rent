<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management - AutoRent</title>
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
        .admin-container {
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
        
        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            background: #fff;
            padding: 20px 25px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
        }
        
        .page-title h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark-color);
        }
        
        /* Filter Section */
        .filter-section {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            padding: 20px;
            margin-bottom: 25px;
        }
        
        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        
        .filter-group label {
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-muted);
        }
        
        .filter-input {
            padding: 10px 15px;
            border: 1px solid rgba(0,0,0,0.1);
            border-radius: 8px;
            font-size: 0.9rem;
            transition: all var(--transition-speed) ease;
        }
        
        .filter-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        /* Vehicles Grid */
        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
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
        
        .vehicle-status.maintenance {
            background: var(--warning-color);
        }
        
        .vehicle-status.booked {
            background: var(--info-color);
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
        
        .action-buttons {
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
        
        .btn-delete {
            background: var(--danger-color);
        }
        
        /* Buttons */
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
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 35px;
            gap: 5px;
        }
        
        .page-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: var(--border-radius);
            background: #fff;
            color: var(--dark-color);
            font-weight: 600;
            transition: all var(--transition-speed) ease;
            box-shadow: var(--shadow-sm);
        }
        
        .page-link:hover {
            background: var(--primary-light);
            color: #fff;
        }
        
        .page-link.active {
            background: var(--primary-color);
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
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .vehicles-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-logo">
                <a href="admin-dashboard.jsp">
                    <i class="fas fa-car-side"></i>
                    <span>AutoRent</span>
                </a>
            </div>
            
            <div class="user-profile">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="user-info">
                    <h4>Admin User</h4>
                    <span>Administrator</span>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-section">
                    <h5 class="menu-section-title">Main</h5>
                    <ul class="menu-items">
                        <li class="menu-item">
                            <a href="admin-dashboard.jsp">
                                <i class="fas fa-gauge-high"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="menu-item active">
                            <a href="admin-vehicles.jsp">
                                <i class="fas fa-car"></i>
                                <span>Vehicles</span>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="admin-bookings.jsp">
                                <i class="fas fa-calendar-check"></i>
                                <span>Bookings</span>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="admin-users.jsp">
                                <i class="fas fa-users"></i>
                                <span>Users</span>
                            </a>
                        </li>
                    </ul>
                </div>
                
                
                <div class="menu-section">

                        </li>
                        <li class="menu-item">
                            <a href="login.jsp">
                                <i class="fas fa-power-off"></i>
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
                        <h1>Vehicle Management</h1>
                    </div>
                </div>
                
                <div class="topbar-actions">
                    <div class="action-item">
                        <i class="fas fa-bell"></i>
                        <span class="badge">3</span>
                    </div>
                    <div class="action-item">
                        <i class="fas fa-envelope"></i>
                        <span class="badge">5</span>
                    </div>
                    <div class="action-item">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
            </div>
            
            <!-- Page Header -->
            <div class="page-header">
                <div class="page-title">
                    <h2>Vehicle Management</h2>
                </div>
                <button class="btn btn-primary" onclick="window.location.href='add-vehicle.jsp'">
                    <i class="fas fa-plus"></i>
                    <span>Add New Vehicle</span>
                </button>
            </div>
            
 
            
            <!-- Vehicles Grid -->
            <div class="vehicles-grid">
                <!-- Vehicle Card 1 -->
                <div class="vehicle-card">
                    <div class="vehicle-image">
                        <img src="./assetes/BMW-X7-model-card.webp" alt="BMW X7">
                        <div class="vehicle-status">Available</div>
                    </div>
                    <div class="vehicle-details">
                        <h3 class="vehicle-title">BMW X7</h3>
                        <div class="vehicle-meta">
                            <span><i class="fas fa-tag"></i> SUV</span>
                            <span><i class="fas fa-id-card"></i> BA-123-PA</span>
                        </div>
                        <div class="vehicle-features">
                            <div class="feature">
                                <i class="fas fa-users"></i>
                                <span>7 Seats</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-cog"></i>
                                <span>Automatic</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-gas-pump"></i>
                                <span>Diesel</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-calendar"></i>
                                <span>2023</span>
                            </div>
                        </div>
                        <div class="vehicle-actions">
                            <div class="vehicle-price">
                                Rs 4,000 <span>/day</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn btn-view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn btn-edit"><i class="fas fa-edit"></i></button>
                                <button class="action-btn btn-delete"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Vehicle Card 2 -->
                <div class="vehicle-card">
                    <div class="vehicle-image">
                        <img src="./assetes/toyota.jpg" alt="Toyota Camry">
                        <div class="vehicle-status">Available</div>
                    </div>
                    <div class="vehicle-details">
                        <h3 class="vehicle-title">Toyota Camry</h3>
                        <div class="vehicle-meta">
                            <span><i class="fas fa-tag"></i> Sedan</span>
                            <span><i class="fas fa-id-card"></i> BA-456-PA</span>
                        </div>
                        <div class="vehicle-features">
                            <div class="feature">
                                <i class="fas fa-users"></i>
                                <span>5 Seats</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-cog"></i>
                                <span>Automatic</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-gas-pump"></i>
                                <span>Petrol</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-calendar"></i>
                                <span>2022</span>
                            </div>
                        </div>
                        <div class="vehicle-actions">
                            <div class="vehicle-price">
                                Rs 6,000 <span>/day</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn btn-view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn btn-edit"><i class="fas fa-edit"></i></button>
                                <button class="action-btn btn-delete"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Vehicle Card 3 -->
                <div class="vehicle-card">
                    <div class="vehicle-image">
                        <img src="./assetes/honda.jpg" alt="Honda Civic">
                        <div class="vehicle-status booked">Booked</div>
                    </div>
                    <div class="vehicle-details">
                        <h3 class="vehicle-title">Honda Civic</h3>
                        <div class="vehicle-meta">
                            <span><i class="fas fa-tag"></i> Sedan</span>
                            <span><i class="fas fa-id-card"></i> BA-789-PA</span>
                        </div>
                        <div class="vehicle-features">
                            <div class="feature">
                                <i class="fas fa-users"></i>
                                <span>5 Seats</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-cog"></i>
                                <span>Automatic</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-gas-pump"></i>
                                <span>Petrol</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-calendar"></i>
                                <span>2022</span>
                            </div>
                        </div>
                        <div class="vehicle-actions">
                            <div class="vehicle-price">
                                Rs 5,500 <span>/day</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn btn-view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn btn-edit"><i class="fas fa-edit"></i></button>
                                <button class="action-btn btn-delete"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Vehicle Card 4 -->
                <div class="vehicle-card">
                    <div class="vehicle-image">
                        <img src="./assetes/tata-nexon.jpg" alt="Tata Nexon">
                        <div class="vehicle-status maintenance">Maintenance</div>
                    </div>
                    <div class="vehicle-details">
                        <h3 class="vehicle-title">Tata Nexon</h3>
                        <div class="vehicle-meta">
                            <span><i class="fas fa-tag"></i> SUV</span>
                            <span><i class="fas fa-id-card"></i> BA-012-PA</span>
                        </div>
                        <div class="vehicle-features">
                            <div class="feature">
                                <i class="fas fa-users"></i>
                                <span>5 Seats</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-cog"></i>
                                <span>Manual</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-gas-pump"></i>
                                <span>Diesel</span>
                            </div>
                            <div class="feature">
                                <i class="fas fa-calendar"></i>
                                <span>2021</span>
                            </div>
                        </div>
                        <div class="vehicle-actions">
                            <div class="vehicle-price">
                                Rs 3,000 <span>/day</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn btn-view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn btn-edit"><i class="fas fa-edit"></i></button>
                                <button class="action-btn btn-delete"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Pagination -->
            <div class="pagination">
                <a href="#" class="page-link"><i class="fas fa-chevron-left"></i></a>
                <a href="#" class="page-link active">1</a>
                <a href="#" class="page-link">2</a>
                <a href="#" class="page-link">3</a>
                <a href="#" class="page-link"><i class="fas fa-chevron-right"></i></a>
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