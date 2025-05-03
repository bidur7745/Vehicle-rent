<form action="uploadVehicleImage" method="post" enctype="multipart/form-data">
    <input type="number" name="vehicleId" placeholder="Vehicle ID" required />
    <input type="file" name="image" accept="image/*" required />
    <button type="submit">Upload</button>
</form>
