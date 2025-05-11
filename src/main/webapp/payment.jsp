<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.autorent.model.Booking" %>
<%@ page import="com.autorent.model.Vehicle" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - AutoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .payment-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .payment-header {
            background-color: #f8f9fa;
            padding: 2rem 0;
            text-align: center;
            margin-bottom: 2rem;
            border-radius: 12px;
        }
        
        .payment-header h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .payment-header p {
            color: #666;
        }
        
        .booking-summary {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .booking-summary h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.5rem;
        }
        
        .summary-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        
        .summary-item {
            margin-bottom: 0.5rem;
        }
        
        .summary-item .label {
            font-weight: bold;
            color: #666;
        }
        
        .summary-item .value {
            color: #333;
        }
        
        .payment-options {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .payment-options h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.5rem;
        }
        
        .payment-methods {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .payment-method {
            padding: 1rem;
            border: 2px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .payment-method:hover, .payment-method.selected {
            border-color: #1877F2;
            background-color: #f0f7ff;
        }
        
        .payment-method-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 0.5rem;
        }
        
        .payment-method-header i {
            font-size: 1.5rem;
            color: #1877F2;
        }
        
        .payment-method-header h4 {
            margin: 0;
            font-size: 1.2rem;
            color: #333;
        }
        
        .payment-method-description {
            color: #666;
            font-size: 0.9rem;
            margin-left: 2.5rem;
        }
        
        .payment-method-content {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            display: none;
        }
        
        .payment-method.selected .payment-method-content {
            display: block;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }
        
        .form-row {
            display: flex;
            gap: 1rem;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .btn-primary {
            background-color: #1877F2;
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        
        .btn-primary:hover {
            background-color: #1464d8;
        }
        
        .payment-total {
            text-align: right;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        
        .payment-total span {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1877F2;
        }
        
        @media (max-width: 768px) {
            .summary-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <%
        // Get booking information from session
        Booking booking = (Booking) session.getAttribute("tempBooking");
        Vehicle vehicle = (Vehicle) session.getAttribute("bookingVehicle");
        
        if (booking == null || vehicle == null) {
            // If no booking information is available, redirect to vehicles page
            response.sendRedirect("vehicles.jsp");
            return;
        }
        
        // Get vehicle image
        String imageBase64 = "";
        if (vehicle.getImage() != null && vehicle.getImage().length > 0) {
            imageBase64 = Base64.getEncoder().encodeToString(vehicle.getImage());
        }
    %>

    <main>
        <section class="payment-container">
            <div class="payment-header">
                <h1>Complete Your Payment</h1>
                <p>Choose your preferred payment method</p>
            </div>
            
            <div class="booking-summary">
                <h3>Booking Summary</h3>
                <div class="summary-details">
                    <div class="summary-item">
                        <span class="label">Vehicle:</span>
                        <span class="value"><%= vehicle.getName() %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Pickup Location:</span>
                        <span class="value"><%= booking.getPickupLocation() %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Pickup Date:</span>
                        <span class="value"><%= booking.getStartDateTime().split(" ")[0] %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Pickup Time:</span>
                        <span class="value"><%= booking.getPickupTime() %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Drop Location:</span>
                        <span class="value"><%= booking.getDropLocation() %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Return Date:</span>
                        <span class="value"><%= booking.getEndDateTime().split(" ")[0] %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Return Time:</span>
                        <span class="value"><%= booking.getDropTime() %></span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Total Amount:</span>
                        <span class="value">Rs<%= booking.getTotalPrice() %></span>
                    </div>
                </div>
            </div>
            
            <div class="payment-options">
                <h3>Select Payment Method</h3>
                <form id="paymentForm" action="process-payment" method="post">
                    <input type="hidden" name="paymentMethod" id="paymentMethod" value="">
                    <input type="hidden" name="totalPrice" id="paymentTotalPrice" value="<%= booking.getTotalPrice() %>">
                    
                    <div class="payment-methods">
                        <div class="payment-method" data-method="ewallet">
                            <div class="payment-method-header">
                                <i class="fas fa-wallet"></i>
                                <h4>eWallet</h4>
                            </div>
                            <div class="payment-method-description">
                                Pay using your digital wallet for quick and secure payment
                            </div>
                            <div class="payment-method-content">
                                <div class="form-group">
                                    <label for="ewalletEmail">Email</label>
                                    <input type="email" id="ewalletEmail" class="form-control" placeholder="Email associated with your eWallet">
                                </div>
                                <div class="form-group">
                                    <label for="ewalletPassword">Password</label>
                                    <input type="password" id="ewalletPassword" class="form-control" placeholder="eWallet password">
                                </div>
                            </div>
                        </div>
                        
                        <div class="payment-method" data-method="card">
                            <div class="payment-method-header">
                                <i class="fas fa-credit-card"></i>
                                <h4>Credit/Debit Card</h4>
                            </div>
                            <div class="payment-method-description">
                                Pay using Visa, MasterCard, or any other major credit/debit card
                            </div>
                            <div class="payment-method-content">
                                <div class="form-group">
                                    <label for="cardNumber">Card Number</label>
                                    <input type="text" id="cardNumber" class="form-control" placeholder="1234 5678 9012 3456">
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="expiryDate">Expiry Date</label>
                                        <input type="text" id="expiryDate" class="form-control" placeholder="MM/YY">
                                    </div>
                                    <div class="form-group">
                                        <label for="cvv">CVV</label>
                                        <input type="text" id="cvv" class="form-control" placeholder="123">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="cardholderName">Cardholder Name</label>
                                    <input type="text" id="cardholderName" class="form-control" placeholder="Name on card">
                                </div>
                            </div>
                        </div>
                        
                        <div class="payment-method" data-method="pay-on-pickup">
                            <div class="payment-method-header">
                                <i class="fas fa-car"></i>
                                <h4>Pay on Vehicle Pickup</h4>
                            </div>
                            <div class="payment-method-description">
                                Pay at the time of vehicle pickup - cash or card accepted
                            </div>
                            <div class="payment-method-content">
                                <p>No advance payment required. You'll pay the full amount when you pick up the vehicle.</p>
                                <div class="form-group">
                                    <label>
                                        <input type="checkbox" id="termsCheckbox">
                                        I understand that I must pay the full amount at the time of vehicle pickup
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="payment-total">
                        Total: <span>Rs<%= booking.getTotalPrice() %></span>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-lock"></i> Pay Now
                    </button>
                </form>
            </div>
        </section>
    </main>
    
    <jsp:include page="components/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const paymentMethods = document.querySelectorAll('.payment-method');
            const paymentMethodInput = document.getElementById('paymentMethod');
            const paymentForm = document.getElementById('paymentForm');
            
            // Select payment method when clicked
            paymentMethods.forEach(method => {
                method.addEventListener('click', function() {
                    // Remove selected class from all methods
                    paymentMethods.forEach(m => m.classList.remove('selected'));
                    
                    // Add selected class to current method
                    this.classList.add('selected');
                    
                    // Update hidden input with selected payment method
                    paymentMethodInput.value = this.dataset.method;
                    
                    // Update button text based on selected method
                    const submitButton = document.querySelector('.btn-primary');
                    if (this.dataset.method === 'pay-on-pickup') {
                        submitButton.innerHTML = '<i class="fas fa-check-circle"></i> Confirm Booking';
                    } else {
                        submitButton.innerHTML = '<i class="fas fa-lock"></i> Pay Now';
                    }
                });
            });
            
            // Form validation
            paymentForm.addEventListener('submit', function(event) {
                event.preventDefault();
                
                // Check if a payment method is selected
                if (!paymentMethodInput.value) {
                    alert('Please select a payment method');
                    return;
                }
                
                console.log("Payment method selected:", paymentMethodInput.value);
                console.log("Total price in payment form:", document.querySelector(".payment-total span").textContent);
                
                // Simulate payment processing
                const loadingOverlay = document.createElement('div');
                loadingOverlay.style.position = 'fixed';
                loadingOverlay.style.top = '0';
                loadingOverlay.style.left = '0';
                loadingOverlay.style.width = '100%';
                loadingOverlay.style.height = '100%';
                loadingOverlay.style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
                loadingOverlay.style.display = 'flex';
                loadingOverlay.style.alignItems = 'center';
                loadingOverlay.style.justifyContent = 'center';
                loadingOverlay.style.zIndex = '9999';
                
                const spinner = document.createElement('div');
                spinner.innerHTML = '<i class="fas fa-spinner fa-spin" style="font-size: 3rem; color: #1877F2;"></i>';
                loadingOverlay.appendChild(spinner);
                
                document.body.appendChild(loadingOverlay);
                
                // Simulate payment processing (3 seconds)
                setTimeout(() => {
                    // Remove loading overlay
                    document.body.removeChild(loadingOverlay);
                    
                    console.log("Submitting form to", paymentForm.action);
                    // Submit the form to backend
                    paymentForm.submit();
                }, 3000);
            });
            
            // Generate a random payment ID
            function generatePaymentId() {
                return 'PAY-' + Math.random().toString(36).substr(2, 9).toUpperCase();
            }
        });
    </script>
</body>
</html> 