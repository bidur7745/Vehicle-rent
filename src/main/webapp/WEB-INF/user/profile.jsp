<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            margin-top: 90px;
        }

        .profile-header {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            background: #1877F2;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-avatar i {
            font-size: 48px;
            color: white;
        }

        .profile-info h1 {
            margin: 0;
            color: #333;
            font-size: 24px;
        }

        .profile-info p {
            margin: 5px 0;
            color: #666;
        }

        .profile-details {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .details-section {
            margin-bottom: 30px;
        }

        .details-section h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .details-section h2 i {
            color: #1877F2;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .detail-item {
            margin-bottom: 15px;
        }

        .detail-item label {
            display: block;
            color: #666;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .detail-item .value {
            color: #333;
            font-size: 16px;
            font-weight: 500;
        }

        .edit-btn {
            background: #1877F2;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 16px;
            transition: background-color 0.2s;
        }

        .edit-btn:hover {
            background: #1664d9;
        }

        .edit-form {
            display: none;
        }

        .edit-form.active {
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .cancel-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .save-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Toast Messages */
        .toast {
            position: fixed;
            top: 30px;
            right: 30px;
            min-width: 250px;
            padding: 16px;
            border-radius: 4px;
            color: white;
            text-align: center;
            z-index: 9999;
            font-size: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            opacity: 0.95;
            animation: slideIn 0.5s, fadeOut 0.5s 3s;
        }

        .toast-success {
            background-color: #4CAF50;
        }

        .toast-error {
            background-color: #f44336;
        }

        @keyframes slideIn {
            from {transform: translateX(100%)}
            to {transform: translateX(0)}
        }

        @keyframes fadeOut {
            from {opacity: 0.95}
            to {opacity: 0}
        }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />

    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) session.getAttribute("successMessage");
        session.removeAttribute("successMessage");
    %>

    <% if (errorMessage != null) { %>
        <div class="toast toast-error">
            <%= errorMessage %>
        </div>
    <% } %>

    <% if (successMessage != null) { %>
        <div class="toast toast-success">
            <%= successMessage %>
        </div>
    <% } %>

    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div class="profile-info">
                <h1>${sessionScope.user.firstName} ${sessionScope.user.lastName}</h1>
                <p>${sessionScope.user.email}</p>
                <p>Member since ${sessionScope.user.createdAt}</p>
            </div>
        </div>

        <div class="profile-details">
            <div class="details-section">
                <h2><i class="fas fa-user-circle"></i> Personal Information</h2>
                <div class="details-grid">
                    <div class="detail-item">
                        <label>First Name</label>
                        <div class="value">${sessionScope.user.firstName}</div>
                    </div>
                    <div class="detail-item">
                        <label>Last Name</label>
                        <div class="value">${sessionScope.user.lastName}</div>
                    </div>
                    <div class="detail-item">
                        <label>Email Address</label>
                        <div class="value">${sessionScope.user.email}</div>
                    </div>
                    <div class="detail-item">
                        <label>Phone Number</label>
                        <div class="value">${sessionScope.user.phone}</div>
                    </div>
                </div>
                <button class="edit-btn" onclick="toggleEditForm()">
                    <i class="fas fa-edit"></i> Edit Profile
                </button>
            </div>

            <form id="editForm" class="edit-form" action="${pageContext.request.contextPath}/UpdateProfileServlet" method="POST">
                <div class="details-grid">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" value="${sessionScope.user.firstName}" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" value="${sessionScope.user.lastName}" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" value="${sessionScope.user.email}" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" value="${sessionScope.user.phone}" required>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="cancel-btn" onclick="toggleEditForm()">Cancel</button>
                    <button type="submit" class="save-btn">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />

    <script>
        function toggleEditForm() {
            const editForm = document.getElementById('editForm');
            editForm.classList.toggle('active');
        }

        // Auto-hide toast messages
        setTimeout(function() {
            const toasts = document.querySelectorAll('.toast');
            toasts.forEach(toast => {
                toast.style.display = 'none';
            });
        }, 3500);
    </script>
</body>
</html> 