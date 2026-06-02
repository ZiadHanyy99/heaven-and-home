<%-- 
    Document   : admin
    Created on : May 16, 2025, 3:17:12 PM
    Author     : Mahmoud Khaled
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="src.Customer"%>
<%@page import="src.Product"%>
<%@page import="src.Order"%>
<%@page import="src.OrderItem"%>
<%@page import="src.DB"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
// Check if user is logged in (you can adjust this based on your authentication system)
// If not logged in, redirect to login page
/*
if (session.getAttribute("adminUser") == null) {
    response.sendRedirect("login.jsp");
    return;
}
*/

// Process logout request
if ("logout".equals(request.getParameter("action"))) {
    // Invalidate the session
    session.invalidate();
    // Redirect to login page
    response.sendRedirect("index.html");
    return;
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            body {
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }
            .container {
                width: 95%;
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px;
            }
            header {
                background-color: #2c3e50;
                color: white;
                padding: 20px 0;
                margin-bottom: 30px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                position: relative;
            }
            .header-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
            }
            h1, h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            .logout-btn {
                background-color: #e74c3c;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }
            .logout-btn:hover {
                background-color: #c0392b;
            }
            .tabs {
                display: flex;
                justify-content: center;
                margin-bottom: 30px;
            }
            .tab-btn {
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .tab-btn:first-child {
                border-radius: 5px 0 0 5px;
            }
            .tab-btn:last-child {
                border-radius: 0 5px 5px 0;
            }
            .tab-btn.active {
                background-color: #2c3e50;
            }
            .tab-content {
                display: none;
            }
            .tab-content.active {
                display: block;
            }
            .dashboard-stats {
                display: flex;
                justify-content: space-between;
                margin-bottom: 30px;
            }
            .stat-card {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                flex: 1;
                margin: 0 10px;
                text-align: center;
            }
            .stat-card h3 {
                font-size: 1.5rem;
                margin-bottom: 10px;
                color: #2c3e50;
            }
            .stat-card p {
                font-size: 2rem;
                font-weight: bold;
                color: #3498db;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #3498db;
                color: white;
                font-weight: 600;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            .actions {
                display: flex;
                gap: 10px;
            }
            .btn {
                padding: 8px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }
            .btn-view {
                background-color: #3498db;
                color: white;
            }
            .btn-edit {
                background-color: #f39c12;
                color: white;
            }
            .btn-delete {
                background-color: #e74c3c;
                color: white;
            }
            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 10px 15px;
                font-size: 16px;
                margin-bottom: 20px;
            }
            .btn:hover {
                opacity: 0.9;
            }
            .empty-message {
                text-align: center;
                padding: 20px;
                font-size: 1.2rem;
                color: #7f8c8d;
            }
            .address-cell {
                max-width: 200px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .form-container {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
            }
            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }
            .form-row {
                display: flex;
                gap: 15px;
            }
            .form-row .form-group {
                flex: 1;
            }
            .product-image {
                max-width: 100px;
                max-height: 100px;
                object-fit: cover;
            }
            .image-preview {
                display: flex;
                gap: 10px;
                margin-top: 10px;
                flex-wrap: wrap;
            }
            .image-preview img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .success-message, .error-message {
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 4px;
                text-align: center;
            }
            .success-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .user-info {
                color: white;
                font-size: 14px;
            }
            
            /* Order details styles */
            .order-details {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            .order-header h2 {
                margin-bottom: 0;
            }
            .order-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 20px;
            }
            .order-meta-item {
                flex: 1;
                min-width: 200px;
            }
            .order-meta-item h3 {
                font-size: 1rem;
                margin-bottom: 5px;
                color: #7f8c8d;
            }
            .order-meta-item p {
                font-size: 1.1rem;
                font-weight: 500;
            }
            .order-items-table {
                width: 100%;
                margin-bottom: 20px;
            }
            .order-items-table th {
                background-color: #f8f9fa;
                color: #333;
            }
            .order-total {
                text-align: right;
                font-size: 1.2rem;
                font-weight: 600;
                margin-top: 20px;
                padding-top: 10px;
                border-top: 1px solid #eee;
            }
            .order-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <header>
                <div class="header-content">
                    <h1>Admin Dashboard</h1>
                    <div>
                        <span class="user-info">
                            <!-- Display logged in user info if available -->
                            <% if (session.getAttribute("adminUser") != null) { %>
                                Welcome, <%= session.getAttribute("adminUser") %>
                            <% } %>
                        </span>
                        <form action="admin.jsp" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="logout">
                            <button type="submit" class="logout-btn">Logout</button>
                        </form>
                    </div>
                </div>
            </header>
            
            <% 
                DB db = new DB();
                ArrayList<Customer> users = db.getAllUsers();
                List<Product> products = db.getAllProducts();
                List<Order> orders = db.getAllOrders();
                
                // Process form submissions
                String action = request.getParameter("action");
                String message = null;
                String messageType = null;
                
                if (action != null) {
                    if (action.equals("addUser")) {
                        String firstName = request.getParameter("firstName");
                        String lastName = request.getParameter("lastName");
                        String email = request.getParameter("email");
                        String address = request.getParameter("address");
                        String password = request.getParameter("password");
                        
                        Customer newUser = new Customer();
                        newUser.setFirstName(firstName);
                        newUser.setLastName(lastName);
                        newUser.setEmail(email);
                        newUser.setAddress(address);
                        newUser.setPassword(password);
                        
                        int result = db.storeUser(newUser);
                        if (result > 0) {
                            message = "User added successfully!";
                            messageType = "success";
                            // Refresh user list
                            users = db.getAllUsers();
                        } else {
                            message = "Failed to add user. Please try again.";
                            messageType = "error";
                        }
                    } else if (action.equals("editUser")) {
                        String firstName = request.getParameter("firstName");
                        String lastName = request.getParameter("lastName");
                        String email = request.getParameter("email");
                        String address = request.getParameter("address");
                        String password = request.getParameter("password");
                        
                        Customer updatedUser = new Customer();
                        updatedUser.setFirstName(firstName);
                        updatedUser.setLastName(lastName);
                        updatedUser.setEmail(email);
                        updatedUser.setAddress(address);
                        updatedUser.setPassword(password);
                        
                        boolean result = db.updateUser(updatedUser);
                        if (result) {
                            message = "User updated successfully!";
                            messageType = "success";
                            // Refresh user list
                            users = db.getAllUsers();
                        } else {
                            message = "Failed to update user. Please try again.";
                            messageType = "error";
                        }
                    } else if (action.equals("deleteUser")) {
                        String email = request.getParameter("email");
                        
                        // Fix for the deleteUser method - using the correct table name
                        boolean result = false;
                        try {
                            java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:derby://localhost:1527/Heaven And Home;create=true");
                            java.sql.PreparedStatement stmt = conn.prepareStatement("DELETE FROM Customer WHERE email = ?");
                            stmt.setString(1, email);
                            result = stmt.executeUpdate() > 0;
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        
                        if (result) {
                            message = "User deleted successfully!";
                            messageType = "success";
                            // Refresh user list
                            users = db.getAllUsers();
                        } else {
                            message = "Failed to delete user. Please try again.";
                            messageType = "error";
                        }
                    } else if (action.equals("addProduct")) {
                        String name = request.getParameter("name");
                        String type = request.getParameter("type");
                        int price = Integer.parseInt(request.getParameter("price"));
                        String description = request.getParameter("description");
                        int stock = Integer.parseInt(request.getParameter("stock"));
                        String image1 = request.getParameter("image1");
                        String image2 = request.getParameter("image2");
                        String image3 = request.getParameter("image3");
                        String image4 = request.getParameter("image4");
                        String image5 = request.getParameter("image5");
                        
                        Product newProduct = new Product();
                        newProduct.setName(name);
                        newProduct.setType(type);
                        newProduct.setPrice(price);
                        newProduct.setDescription(description);
                        newProduct.setStock(stock);
                        newProduct.setImage1(image1);
                        newProduct.setImage2(image2);
                        newProduct.setImage3(image3);
                        newProduct.setImage4(image4);
                        newProduct.setImage5(image5);
                        
                        int result = db.storeProduct(newProduct);
                        if (result > 0) {
                            message = "Product added successfully!";
                            messageType = "success";
                            // Refresh product list
                            products = db.getAllProducts();
                        } else {
                            message = "Failed to add product. Please try again.";
                            messageType = "error";
                        }
                    } else if (action.equals("editProduct")) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        String name = request.getParameter("name");
                        String type = request.getParameter("type");
                        int price = Integer.parseInt(request.getParameter("price"));
                        String description = request.getParameter("description");
                        int stock = Integer.parseInt(request.getParameter("stock"));
                        String image1 = request.getParameter("image1");
                        String image2 = request.getParameter("image2");
                        String image3 = request.getParameter("image3");
                        String image4 = request.getParameter("image4");
                        String image5 = request.getParameter("image5");
                        
                        Product updatedProduct = new Product();
                        updatedProduct.setId(id);
                        updatedProduct.setName(name);
                        updatedProduct.setType(type);
                        updatedProduct.setPrice(price);
                        updatedProduct.setDescription(description);
                        updatedProduct.setStock(stock);
                        updatedProduct.setImage1(image1);
                        updatedProduct.setImage2(image2);
                        updatedProduct.setImage3(image3);
                        updatedProduct.setImage4(image4);
                        updatedProduct.setImage5(image5);
                        
                        boolean result = db.updateProduct(updatedProduct);
                        if (result) {
                            message = "Product updated successfully!";
                            messageType = "success";
                            // Refresh product list
                            products = db.getAllProducts();
                        } else {
                            message = "Failed to update product. Please try again.";
                            messageType = "error";
                        }
                    } else if (action.equals("deleteProduct")) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        
                        boolean result = db.deleteProduct(id);
                        if (result) {
                            message = "Product deleted successfully!";
                            messageType = "success";
                            // Refresh product list
                            products = db.getAllProducts();
                        } else {
                            message = "Failed to delete product. Please try again.";
                            messageType = "error";
                        }
                    }
                }
                
                // Get user to edit if requested
                Customer userToEdit = null;
                String editUserEmail = request.getParameter("editUserEmail");
                if (editUserEmail != null) {
                    userToEdit = db.getUserDetails(editUserEmail);
                }
                
                // Get product to edit if requested
                Product productToEdit = null;
                String editProductId = request.getParameter("editProductId");
                if (editProductId != null) {
                    productToEdit = db.getProductDetails(Integer.parseInt(editProductId));
                }
                
                // Get order details if requested
                Order orderDetails = null;
                String viewOrderId = request.getParameter("viewOrderId");
                if (viewOrderId != null) {
                    orderDetails = db.getOrderDetails(Integer.parseInt(viewOrderId));
                }
                
                // Determine which tab to show
                String activeTab = "users-tab";
                if (request.getParameter("tab") != null) {
                    activeTab = request.getParameter("tab");
                } else if (action != null) {
                    if (action.equals("addProduct") || action.equals("editProduct") || action.equals("deleteProduct") || editProductId != null) {
                        activeTab = "products-tab";
                    } else if (viewOrderId != null) {
                        activeTab = "orders-tab";
                    }
                }
                
                // Format helpers
                DecimalFormat priceFormat = new DecimalFormat("#,##0.00");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            %>
            
            <!-- Display success or error message if any -->
            <% if (message != null) { %>
                <div class="<%= messageType.equals("success") ? "success-message" : "error-message" %>">
                    <%= message %>
                </div>
            <% } %>
            
            <div class="tabs">
                <button class="tab-btn <%= activeTab.equals("users-tab") ? "active" : "" %>" onclick="location.href='admin.jsp?tab=users-tab'">Manage Users</button>
                <button class="tab-btn <%= activeTab.equals("products-tab") ? "active" : "" %>" onclick="location.href='admin.jsp?tab=products-tab'">Manage Products</button>
                <button class="tab-btn <%= activeTab.equals("orders-tab") ? "active" : "" %>" onclick="location.href='admin.jsp?tab=orders-tab'">Manage Orders</button>
            </div>
            
            <!-- Users Tab -->
            <div id="users-tab" class="tab-content <%= activeTab.equals("users-tab") ? "active" : "" %>">
                <div class="dashboard-stats">
                    <div class="stat-card">
                        <h3>Total Customers</h3>
                        <p><%= users.size() %></p>
                    </div>
                </div>
                
                <% if (userToEdit == null) { %>
                    <!-- Add User Form -->
                    <div class="form-container">
                        <h2>Add New User</h2>
                        <form action="admin.jsp" method="post">
                            <input type="hidden" name="action" value="addUser">
                            <input type="hidden" name="tab" value="users-tab">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" class="form-control" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" id="address" name="address" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-add" style="width: 100%;">Add User</button>
                        </form>
                    </div>
                <% } else { %>
                    <!-- Edit User Form -->
                    <div class="form-container">
                        <h2>Edit User</h2>
                        <form action="admin.jsp" method="post">
                            <input type="hidden" name="action" value="editUser">
                            <input type="hidden" name="tab" value="users-tab">
                            <input type="hidden" name="email" value="<%= userToEdit.getEmail() %>">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" class="form-control" value="<%= userToEdit.getFirstName() %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" class="form-control" value="<%= userToEdit.getLastName() %>" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email">Email (cannot be changed)</label>
                                <input type="email" id="email" class="form-control" value="<%= userToEdit.getEmail() %>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" id="address" name="address" class="form-control" value="<%= userToEdit.getAddress() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password (leave blank to keep current)</label>
                                <input type="password" id="password" name="password" class="form-control">
                            </div>
                            <div class="form-row">
                                <button type="submit" class="btn btn-edit" style="flex: 1;">Update User</button>
                                <a href="admin.jsp?tab=users-tab" class="btn btn-delete" style="flex: 1; text-align: center; text-decoration: none;">Cancel</a>
                            </div>
                        </form>
                    </div>
                <% } %>
                
                <h2>Customer List</h2>
                <% if (users.isEmpty()) { %>
                    <div class="empty-message">No customers found in the database.</div>
                <% } else { %>
                    <table>
                        <thead>
                            <tr>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Customer customer : users) { %>
                                <tr>
                                    <td><%= customer.getFirstName() %></td>
                                    <td><%= customer.getLastName() %></td>
                                    <td><%= customer.getEmail() %></td>
                                    <td class="address-cell" title="<%= customer.getAddress() %>">
                                        <%= customer.getAddress() %>
                                    </td>
                                    <td class="actions">
                                        <a href="admin.jsp?tab=users-tab&editUserEmail=<%= customer.getEmail() %>" class="btn btn-edit">Edit</a>
                                        <form action="admin.jsp" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="deleteUser">
                                            <input type="hidden" name="tab" value="users-tab">
                                            <input type="hidden" name="email" value="<%= customer.getEmail() %>">
                                            <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this user?')">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
            
            <!-- Products Tab -->
            <div id="products-tab" class="tab-content <%= activeTab.equals("products-tab") ? "active" : "" %>">
                <div class="dashboard-stats">
                    <div class="stat-card">
                        <h3>Total Products</h3>
                        <p><%= products.size() %></p>
                    </div>
                </div>
                
                <% if (productToEdit == null) { %>
                    <!-- Add Product Form -->
                    <div class="form-container">
                        <h2>Add New Product</h2>
                        <form action="admin.jsp" method="post">
                            <input type="hidden" name="action" value="addProduct">
                            <input type="hidden" name="tab" value="products-tab">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productName">Product Name</label>
                                    <input type="text" id="productName" name="name" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="productType">Type</label>
                                    <select id="productType" name="type" class="form-control" required>
                                        <option value="" disabled selected>Select a type</option>
                                        <option value="bedroom">Bedroom</option>
                                        <option value="kitchen">Kitchen</option>
                                        <option value="dining">Dining</option>
                                        <option value="living">Living</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productPrice">Price</label>
                                    <input type="number" id="productPrice" name="price" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="productStock">Stock</label>
                                    <input type="number" id="productStock" name="stock" class="form-control" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="productDescription">Description</label>
                                <textarea id="productDescription" name="description" class="form-control" rows="4" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Product Images</label>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="image1">Image 1</label>
                                        <input type="file" id="image1" onchange="updateImagePath('image1')">
                                        <input type="hidden" name="image1" id="image1Path">
                                    </div>
                                    <div class="form-group">
                                        <label for="image2">Image 2</label>
                                        <input type="file" id="image2" onchange="updateImagePath('image2')">
                                        <input type="hidden" name="image2" id="image2Path">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="image3">Image 3</label>
                                        <input type="file" id="image3" onchange="updateImagePath('image3')">
                                        <input type="hidden" name="image3" id="image3Path">
                                    </div>
                                    <div class="form-group">
                                        <label for="image4">Image 4</label>
                                        <input type="file" id="image4" onchange="updateImagePath('image4')">
                                        <input type="hidden" name="image4" id="image4Path">
                                    </div>
                                    <div class="form-group">
                                        <label for="image5">Image 5</label>
                                        <input type="file" id="image5" onchange="updateImagePath('image5')">
                                        <input type="hidden" name="image5" id="image5Path">
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-add" style="width: 100%;">Add Product</button>
                        </form>
                    </div>
                <% } else { %>
                    <!-- Edit Product Form -->
                    <div class="form-container">
                        <h2>Edit Product</h2>
                        <form action="admin.jsp" method="post">
                            <input type="hidden" name="action" value="editProduct">
                            <input type="hidden" name="tab" value="products-tab">
                            <input type="hidden" name="id" value="<%= productToEdit.getId() %>">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productName">Product Name</label>
                                    <input type="text" id="productName" name="name" class="form-control" value="<%= productToEdit.getName() %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="productType">Type</label>
                                    <select id="productType" name="type" class="form-control" required>
                                        <option value="Bedroom" <%= "Bedroom".equals(productToEdit.getType()) ? "selected" : "" %>>Bedroom</option>
                                        <option value="Kitchen" <%= "Kitchen".equals(productToEdit.getType()) ? "selected" : "" %>>Kitchen</option>
                                        <option value="Dining" <%= "Dining".equals(productToEdit.getType()) ? "selected" : "" %>>Dining</option>
                                        <option value="Living" <%= "Living".equals(productToEdit.getType()) ? "selected" : "" %>>Living</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productPrice">Price</label>
                                    <input type="number" id="productPrice" name="price" class="form-control" value="<%= productToEdit.getPrice() %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="productStock">Stock</label>
                                    <input type="number" id="productStock" name="stock" class="form-control" value="<%= productToEdit.getStock() %>" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="productDescription">Description</label>
                                <textarea id="productDescription" name="description" class="form-control" rows="4" required><%= productToEdit.getDescription() %></textarea>
                            </div>
                            <div class="form-group">
                                <label>Product Images</label>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="editImage1">Image 1</label>
                                        <% if (productToEdit.getImage1() != null && !productToEdit.getImage1().isEmpty()) { %>
                                            <div><img src="<%= productToEdit.getImage1() %>" alt="Image 1" style="width: 100px; height: 100px; object-fit: cover;"></div>
                                        <% } %>
                                        <input type="file" id="editImage1" onchange="updateImagePath('editImage1')">
                                        <input type="hidden" name="image1" id="editImage1Path" value="<%= productToEdit.getImage1() != null ? productToEdit.getImage1() : "" %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="editImage2">Image 2</label>
                                        <% if (productToEdit.getImage2() != null && !productToEdit.getImage2().isEmpty()) { %>
                                            <div><img src="<%= productToEdit.getImage2() %>" alt="Image 2" style="width: 100px; height: 100px; object-fit: cover;"></div>
                                        <% } %>
                                        <input type="file" id="editImage2" onchange="updateImagePath('editImage2')">
                                        <input type="hidden" name="image2" id="editImage2Path" value="<%= productToEdit.getImage2() != null ? productToEdit.getImage2() : "" %>">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="editImage3">Image 3</label>
                                        <% if (productToEdit.getImage3() != null && !productToEdit.getImage3().isEmpty()) { %>
                                            <div><img src="<%= productToEdit.getImage3() %>" alt="Image 3" style="width: 100px; height: 100px; object-fit: cover;"></div>
                                        <% } %>
                                        <input type="file" id="editImage3" onchange="updateImagePath('editImage3')">
                                        <input type="hidden" name="image3" id="editImage3Path" value="<%= productToEdit.getImage3() != null ? productToEdit.getImage3() : "" %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="editImage4">Image 4</label>
                                        <% if (productToEdit.getImage4() != null && !productToEdit.getImage4().isEmpty()) { %>
                                            <div><img src="<%= productToEdit.getImage4() %>" alt="Image 4" style="width: 100px; height: 100px; object-fit: cover;"></div>
                                        <% } %>
                                        <input type="file" id="editImage4" onchange="updateImagePath('editImage4')">
                                        <input type="hidden" name="image4" id="editImage4Path" value="<%= productToEdit.getImage4() != null ? productToEdit.getImage4() : "" %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="editImage5">Image 5</label>
                                        <% if (productToEdit.getImage5() != null && !productToEdit.getImage5().isEmpty()) { %>
                                            <div><img src="<%= productToEdit.getImage5() %>" alt="Image 5" style="width: 100px; height: 100px; object-fit: cover;"></div>
                                        <% } %>
                                        <input type="file" id="editImage5" onchange="updateImagePath('editImage5')">
                                        <input type="hidden" name="image5" id="editImage5Path" value="<%= productToEdit.getImage5() != null ? productToEdit.getImage5() : "" %>">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <button type="submit" class="btn btn-edit" style="flex: 1;">Update Product</button>
                                <a href="admin.jsp?tab=products-tab" class="btn btn-delete" style="flex: 1; text-align: center; text-decoration: none;">Cancel</a>
                            </div>
                        </form>
                    </div>
                <% } %>
                
                <h2>Product List</h2>
                <% if (products.isEmpty()) { %>
                    <div class="empty-message">No products found in the database.</div>
                <% } else { %>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Image</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product product : products) { %>
                                <tr>
                                    <td><%= product.getId() %></td>
                                    <td><%= product.getName() %></td>
                                    <td><%= product.getType() %></td>
                                    <td>£<%= priceFormat.format(product.getPrice()) %></td>
                                    <td><%= product.getStock() %></td>
                                    <td>
                                        <% if (product.getImage1() != null && !product.getImage1().isEmpty()) { %>
                                            <img src="<%= product.getImage1() %>" alt="<%= product.getName() %>" class="product-image">
                                        <% } else { %>
                                            No Image
                                        <% } %>
                                    </td>
                                    <td class="actions">
                                        <a href="admin.jsp?tab=products-tab&editProductId=<%= product.getId() %>" class="btn btn-edit">Edit</a>
                                        <form action="admin.jsp" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="deleteProduct">
                                            <input type="hidden" name="tab" value="products-tab">
                                            <input type="hidden" name="id" value="<%= product.getId() %>">
                                            <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
            
            <!-- Orders Tab -->
            <div id="orders-tab" class="tab-content <%= activeTab.equals("orders-tab") ? "active" : "" %>">
                <div class="dashboard-stats">
                    <div class="stat-card">
                        <h3>Total Orders</h3>
                        <p><%= orders.size() %></p>
                    </div>
                    <%
                        // Calculate total revenue
                        int totalRevenue = 0;
                        int cashOrders = 0;
                        int visaOrders = 0;
                        for (Order order : orders) {
                            totalRevenue += order.getTotalAmount();
                            if ("Cash".equals(order.getPaymentMethod())) {
                                cashOrders++;
                            } else if ("Visa".equals(order.getPaymentMethod())) {
                                visaOrders++;
                            }
                        }
                    %>
                    <div class="stat-card">
                        <h3>Total Revenue</h3>
                        <p>£<%= priceFormat.format(totalRevenue) %></p>
                    </div>
                    <div class="stat-card">
                        <h3>Cash Orders</h3>
                        <p><%= cashOrders %></p>
                    </div>
                    <div class="stat-card">
                        <h3>Visa Orders</h3>
                        <p><%= visaOrders %></p>
                    </div>
                </div>
                
                <% if (orderDetails != null) { %>
                    <!-- Order Details View -->
                    <div class="order-details">
                        <div class="order-header">
                            <h2>Order #<%= orderDetails.getId() %></h2>
                        </div>
                        
                        <div class="order-meta">
                            <div class="order-meta-item">
                                <h3>Customer</h3>
                                <p><%= orderDetails.getCustomerFullName() %></p>
                                <p><%= orderDetails.getCustomerEmail() %></p>
                            </div>
                            <div class="order-meta-item">
                                <h3>Shipping Address</h3>
                                <p><%= orderDetails.getShippingAddress() %></p>
                            </div>
                            <div class="order-meta-item">
                                <h3>Order Date</h3>
                                <p><%= dateFormat.format(orderDetails.getOrderDate()) %></p>
                            </div>
                            <div class="order-meta-item">
                                <h3>Payment Method</h3>
                                <p><%= orderDetails.getPaymentMethod() %></p>
                            </div>
                        </div>
                        
                        <h3>Order Items</h3>
                        <table class="order-items-table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (OrderItem item : orderDetails.getItems()) { %>
                                    <tr>
                                        <td>
                                            <div style="display: flex; align-items: center;">
                                                <% if (item.getProductImage() != null && !item.getProductImage().isEmpty()) { %>
                                                    <img src="<%= item.getProductImage() %>" alt="<%= item.getProductName() %>" style="width: 50px; height: 50px; object-fit: cover; margin-right: 10px;">
                                                <% } %>
                                                <%= item.getProductName() %>
                                            </div>
                                        </td>
                                        <td>£<%= priceFormat.format(item.getProductPrice()) %></td>
                                        <td><%= item.getQuantity() %></td>
                                        <td>£<%= priceFormat.format(item.getSubtotal()) %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                        
                        <div class="order-total">
                            Total: £<%= priceFormat.format(orderDetails.getTotalAmount()) %>
                        </div>
                        
                        <div class="order-actions">
                            <a href="admin.jsp?tab=orders-tab" class="btn btn-delete">Back to Orders</a>
                        </div>
                    </div>
                <% } else { %>
                    <h2>Order List</h2>
                    <% if (orders.isEmpty()) { %>
                        <div class="empty-message">No orders found in the database.</div>
                    <% } else { %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Date</th>
                                    <th>Total</th>
                                    <th>Payment</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Order order : orders) { %>
                                    <tr>
                                        <td>#<%= order.getId() %></td>
                                        <td><%= order.getCustomerFullName() %></td>
                                        <td><%= dateFormat.format(order.getOrderDate()) %></td>
                                        <td>£<%= priceFormat.format(order.getTotalAmount()) %></td>
                                        <td><%= order.getPaymentMethod() %></td>
                                        <td class="actions">
                                            <a href="admin.jsp?tab=orders-tab&viewOrderId=<%= order.getId() %>" class="btn btn-view">View</a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } %>
                <% } %>
            </div>
            
            <script>
                // Function to update image path when file is selected
                function updateImagePath(inputId) {
                    const input = document.getElementById(inputId);
                    const pathInput = document.getElementById(inputId + 'Path');
                    
                    if (input.files && input.files[0]) {
                        // In a real application, you would upload the file to the server
                        // and get back a URL. For now, we'll just use the file name.
                        pathInput.value = 'images/' + input.files[0].name;
                    }
                }
            </script>
        </div>
    </body>
</html>