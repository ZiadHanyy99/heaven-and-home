<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="src.DB"%>
<%@page import="src.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<jsp:useBean id="c" class="src.Customer" scope="session" />
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | Heaven And Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* General Styling */
        body, h1, h2, h3, p, ul, li {
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        
        /* Search Bar */
        .search-container {
            display: flex;
            flex-direction: row;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            justify-content: space-between;
        }
        
        .logo {
            text-decoration: none;
            color: #000;
        }
        
        .logo h1 {
            font-size: 1.5rem;
            margin-bottom: 0;
        }
        
        .logo p {
            font-size: 0.8rem;
            color: #666;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .profile-button,
        .logout-button,
        .cart-button {
            padding: 8px 15px;
            background-color: #fdfdfd;
            color: #000;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            font-size: 0.9rem;
        }
        
        .logout-button {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .profile-button:hover,
        .cart-button:hover {
            background-color: #eee;
        }
        
        .logout-button:hover {
            background-color: #f5c6cb;
        }
        
        /* Navigation */
        header {
            background-color: #000;
            padding: 10px 20px;
        }
        
        nav {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
        }
        
        nav ul li a {
            text-decoration: none;
            color: #fff;
            padding: 10px;
        }
        
        nav ul li a:hover {
            color: #c40000;
        }
        
        .menu-toggle {
            color: beige;
            display: none;
            font-size: 2rem;
            cursor: pointer;
        }
        
        /* Cart Container */
        .cart-container {
            display: flex;
            max-width: 1200px;
            margin: 30px auto;
            gap: 20px;
            padding: 0 20px;
        }
        
        .cart-left {
            flex: 3;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .cart-right {
            flex: 1;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            height: fit-content;
        }
        
        /* Cart Items */
        .cart-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        
        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 20px;
        }
        
        .item-details {
            flex: 2;
        }
        
        .item-details h3 {
            font-size: 1.1rem;
            margin-bottom: 5px;
        }
        
        .quantity {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        
        .quantity input {
            width: 50px;
            padding: 5px;
            text-align: center;
            margin: 0 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        
        .price {
            flex: 1;
            font-size: 1.2rem;
            font-weight: bold;
            text-align: right;
            padding-right: 20px;
        }
        
        .trash-icon {
            cursor: pointer;
            color: #e74c3c;
            font-size: 1.2rem;
        }
        
        .trash-icon a {
            text-decoration: none;
            color: inherit;
        }
        
        /* Cart Summary */
        .cart-summary {
            margin-bottom: 20px;
        }
        
        .cart-summary p {
            margin-bottom: 10px;
            font-size: 1rem;
        }
        
        .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            margin-top: 15px;
            color: #000;
        }
        
        .checkout-btn {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #000;
            color: white;
            text-align: center;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }
        
        .checkout-btn:hover {
            background-color: #333;
        }
        
        .continue-shopping {
            display: inline-block;
            margin-top: 20px;
            color: #3498db;
            text-decoration: none;
        }
        
        .continue-shopping:hover {
            text-decoration: underline;
        }
        
        .empty-cart-message {
            text-align: center;
            padding: 50px 0;
            color: #666;
        }
        
        /* Footer */
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .cart-container {
                flex-direction: column;
            }
            
            .cart-item {
                flex-wrap: wrap;
            }
            
            .cart-item img {
                margin-bottom: 10px;
            }
            
            .item-details {
                flex: 1 0 100%;
                margin-bottom: 10px;
            }
            
            .price {
                text-align: left;
                padding-right: 0;
            }
            
            nav ul {
                display: none;
                flex-direction: column;
                width: 100%;
                text-align: center;
            }
            
            nav ul.show {
                display: flex;
            }
            
            .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>
    <%
        // Check if user is logged in
        if (c == null || c.getEmail() == null || c.getEmail().isEmpty()) {
            response.sendRedirect("index.html");
            return;
        }
        
        // Get cart items
        DB db = new DB();
        List<CartItem> cartItems = db.getCartItems(c.getEmail());
    %>
    
    <div class="search-container">
        <a href="home.jsp" class="logo">
            <h1>Heaven And Home</h1>
            <p>Style That Speaks Comfort</p>
        </a>
        
        <div class="action-buttons">
            <div class="user-welcome" style="margin-right: 15px;">
                Welcome, <jsp:getProperty name="c" property="firstName" />!
            </div>
            <form action="logout.jsp" method="post" style="display: inline;">
                <button type="submit" class="logout-button">Logout</button>
            </form>
            <a href="cart.jsp" class="cart-button">Cart</a>
        </div>
    </div>

    <header>
        <div class="header-content">
            <nav>
                <ul class="nav-links">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="bedroom.jsp">Bedrooms</a></li>
                    <li><a href="living.jsp">Living Room</a></li>
                    <li><a href="kitchen.jsp">Kitchen</a></li>
                    <li><a href="dining.jsp">Dining Room</a></li>
                    <li><a href="home.jsp#about-section">About</a></li>
                    <li><a href="home.jsp#contact-section">Contact</a></li>
                </ul>
                <div class="menu-toggle">☰</div>
            </nav>
        </div>
    </header>

    <div class="cart-container">
        <div class="cart-left">
            <% if (cartItems.isEmpty()) { %>
                <div class="empty-cart-message">
                    <h2>Your cart is empty</h2>
                    <p>Looks like you haven't added any products to your cart yet.</p>
                    <a href="home.jsp" class="continue-shopping">Continue Shopping</a>
                </div>
            <% } else { %>
                <% for (CartItem item : cartItems) { %>
                    <div class="cart-item">
                        <img src="<%= item.getImagePath() %>" alt="<%= item.getProductName() %>">
                        <div class="item-details">
                            <h3><%= item.getProductName() %></h3>
                            <div class="quantity">
                                Quantity:
                                <input type="number" value="<%= item.getQuantity() %>" min="1" readonly>
                            </div>
                        </div>
                        <div class="price">£<%= item.getPrice() %></div>
                        <div class="trash-icon">
                            <a href="remove-from-cart.jsp?id=<%= item.getProductId() %>" onclick="return confirm('Remove this item from cart?')">🗑️</a>
                        </div>
                    </div>
                <% } %>
                <a href="home.jsp" class="continue-shopping">← Continue Shopping</a>
            <% } %>
        </div>

        <div class="cart-right">
            <div class="cart-summary">
                <%
                    int totalItems = 0;
                    int totalAmount = 0;
                    
                    for (CartItem item : cartItems) {
                        totalItems += item.getQuantity();
                        totalAmount += item.getSubtotal();
                    }
                    
                    DecimalFormat df = new DecimalFormat("#,##0.00");
                %>
                <p>Items: <%= totalItems %></p>
                <p class="total-price">Total: £<%= df.format(totalAmount) %></p>
            </div>
            <a href="checkout.jsp" class="checkout-btn" <%= cartItems.isEmpty() ? "style='background-color: #ccc; cursor: not-allowed;' onclick='return false;'" : "" %>>PROCEED TO CHECKOUT</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Heaven And Home. All rights reserved.</p>
    </footer>
    
    <script>
        // Mobile menu toggle
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-links').classList.toggle('show');
        });
    </script>
</body>
</html>