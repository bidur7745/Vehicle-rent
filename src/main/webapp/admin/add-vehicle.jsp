<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vehicle - AutoRent</title>
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
            
            --shadow-sm: 0 2px 4px rgba(0,0,0,.05);
            --shadow-md: 0 4px 8px rgba(0,0,0,.1);
            --shadow-lg: 0 8px 16px rgba(0,0,0,.1);
            
            --transition-speed: 0.3s;
            --border-radius: 8px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: rgba(0,0,0,0.5);
            color: var(--text-color);
            line-height: 1.6;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        
        /* Modal */
        .modal {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 800px;
            overflow: hidden;
            animation: modal-open 0.3s ease;
        }
        
        @keyframes modal-open {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .modal-header {
            padding: 20px 25px;
            background: var(--primary-color);
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .modal-title {
            font-size: 1.25rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .close-btn {
            background: none;
            border: none;
            color: #fff;
            font-size: 1.25rem;
            cursor: pointer;
            transition: all var(--transition-speed) ease;
        }
        
        .close-btn:hover {
            transform: rotate(90deg);
        }
        
        .modal-body {
            padding: 25px;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        /* Form Styles */
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            color: var(--text-color);
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
            transition: all var(--transition-speed) ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .form-text {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 5px;
        }
        
        /* File Upload */
        .file-upload-container {
            border: 2px dashed #ddd;
            padding: 30px;
            text-align: center;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all var(--transition-speed) ease;
            position: relative;
        }
        
        .file-upload-container:hover {
            border-color: var(--primary-color);
        }
        
        .file-upload-container i {
            font-size: 2.5rem;
            color: var(--grey-color);
            margin-bottom: 15px;
        }
        
        .file-upload-text {
            font-size: 0.95rem;
            color: var(--text-muted);
        }
        
        .file-upload {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        
        /* Checkboxes */
        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 10px;
        }
        
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            cursor: pointer;
        }
        
        /* Modal Footer */
        .modal-footer {
            padding: 20px 25px;
            background: #f8f9fa;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
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
        
        .btn-secondary {
            background: #f1f3f5;
            color: var(--dark-color);
        }
        
        .btn-secondary:hover {
            background: #dee2e6;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            
            .checkbox-group {
                grid-template-columns: 1fr 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="modal">
        <div class="modal-header">
            <h2 class="modal-title">
                <i class="fas fa-plus-circle"></i>
                Add New Vehicle
            </h2>
            <button class="close-btn">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div class="modal-body">
            <form id="addVehicleForm">
                <!-- Basic Information -->
                <h3 class="section-title">Basic Information</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="name">Vehicle Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="e.g. BMW X7">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="color">Color</label>
                        <input type="text" class="form-control" id="color" name="color" placeholder="e.g. Black">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="type">Vehicle Type</label>
                        <select class="form-control" id="type" name="type">
                            <option value="">Select Type</option>
                            <option value="sedan">Sedan</option>
                            <option value="suv">SUV</option>
                            <option value="hatchback">Hatchback</option>
                            <option value="luxury">Luxury</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="rent_per_day">Daily Rate (Rs)</label>
                        <input type="number" class="form-control" id="rent_per_day" name="rent_per_day" placeholder="e.g. 5000">
                    </div>
                </div>
                
                <!-- Vehicle Details -->
                <h3 class="section-title">Vehicle Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="seating_capacity">Seating Capacity</label>
                        <input type="number" class="form-control" id="seating_capacity" name="seating_capacity" placeholder="e.g. 5">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="vehicle_type">Transmission</label>
                        <select class="form-control" id="vehicle_type" name="vehicle_type">
                            <option value="">Select Transmission</option>
                            <option value="automatic">Automatic</option>
                            <option value="manual">Manual</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="fuel_type">Fuel Type</label>
                        <select class="form-control" id="fuel_type" name="fuel_type">
                            <option value="">Select Fuel Type</option>
                            <option value="petrol">Petrol</option>
                            <option value="diesel">Diesel</option>
                            <option value="electric">Electric</option>
                            <option value="hybrid">Hybrid</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="no_of_airbags">Number of Airbags</label>
                        <input type="number" class="form-control" id="no_of_airbags" name="no_of_airbags" placeholder="e.g. 6">
                    </div>
                </div>
                
                <!-- Vehicle Image -->
                <h3 class="section-title">Vehicle Image</h3>
                <div class="form-group">
                    <div class="file-upload-container">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <div class="file-upload-text">
                            <p>Drag and drop your image here, or <span style="color: var(--primary-color);">browse</span></p>
                            <p class="form-text">Supported formats: JPEG, PNG. Max size: 5MB</p>
                        </div>
                        <input type="file" class="file-upload" id="image_file" name="image_file" accept="image/*">
                        <input type="hidden" id="image_url" name="image_url">
                    </div>
                </div>
                
                <!-- Features -->
                <h3 class="section-title">Features</h3>
                <div class="form-group">
                    <div class="checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="air_conditioning"> 
                            Air Conditioning
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="bluetooth"> 
                            Bluetooth
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="navigation"> 
                            Navigation
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="parking_sensors"> 
                            Parking Sensors
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="backup_camera"> 
                            Backup Camera
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="sunroof"> 
                            Sunroof
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="leather_seats"> 
                            Leather Seats
                        </label>
                        <label class="checkbox-label">
                            <input type="checkbox" name="features" value="child_seats"> 
                            Child Seats
                        </label>
                    </div>
                </div>
                
                <!-- Description -->
                <h3 class="section-title">Description</h3>
                <div class="form-group">
                    <textarea class="form-control" id="description" rows="5" placeholder="Enter vehicle description..."></textarea>
                </div>
                
                <!-- Status -->
                <h3 class="section-title">Status</h3>
                <div class="form-group">
                    <select class="form-control" id="availability_status" name="availability_status">
                        <option value="available">Available</option>
                        <option value="rented">Rented</option>
                        <option value="maintenance">Maintenance</option>
                    </select>
                </div>
            </form>
        </div>
        
        <div class="modal-footer">
            <button class="btn btn-secondary" id="cancelBtn">
                <i class="fas fa-times"></i>
                Cancel
            </button>
            <button class="btn btn-primary" id="saveBtn">
                <i class="fas fa-save"></i>
                Save Vehicle
            </button>
        </div>
    </div>
    
    <script>
        // Close button functionality (just for demo)
        document.querySelector('.close-btn').addEventListener('click', () => {
            window.history.back();
        });
        
        document.querySelector('#cancelBtn').addEventListener('click', () => {
            window.history.back();
        });
        
        // File upload preview functionality
        const fileUpload = document.querySelector('#image_file');
        const fileUploadContainer = document.querySelector('.file-upload-container');
        
        fileUpload.addEventListener('change', (e) => {
            if (e.target.files.length > 0) {
                const fileName = e.target.files[0].name;
                fileUploadContainer.innerHTML = `
                    <i class="fas fa-file-image" style="color: var(--primary-color);"></i>
                    <div class="file-upload-text">
                        <p style="color: var(--primary-color);">${fileName}</p>
                        <p class="form-text">Click to change file</p>
                    </div>
                    <input type="file" class="file-upload" id="image_file" name="image_file" accept="image/*">
                    <input type="hidden" id="image_url" name="image_url">
                `;
                
                // Re-attach event listener to the new input
                document.querySelector('#image_file').addEventListener('change', (e) => {
                    fileUpload.dispatchEvent(new Event('change'));
                });
                
                // In a real application, you would upload the file and set the image_url value
            }
        });
        
        // Save button functionality (just for demo)
        document.querySelector('#saveBtn').addEventListener('click', () => {
            // In a real application, here you would validate the form and submit the data
            alert('Vehicle saved successfully!');
            window.history.back();
        });
    </script>
</body>
</html> 