<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="src.Product"%>
<%@page import="src.DB"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<jsp:useBean id="c" class="src.Customer" scope="session" />
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Heaven And Home | Living Room Furniture</title>
    <link rel="stylesheet" href="../CSS/category.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* General Styling */
body, h1, h2, h3, p, ul, li {
    margin: 0;
    padding: 0;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

/* Search Bar */
.search-container {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 10px;
    background-color: #fff;
}

.search-container a{
    text-decoration: none;
    color: #000;

}
.search-bar {
    display: flex;
    align-items: center;
    margin-left: 210px;
    flex-grow: 1;
}

.search-bar input {
    padding: 14px;
    border: 1px solid #000;
    border-radius: 10px;
    width: 300px;
    margin-right: 20px;
}

.search-bar button {
    padding: 14px 20px;
    border: 1px solid #000;
    background-color: #000;
    color: white;
    border-radius: 10px;
    cursor: pointer;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 10px;
    align-items: center;
}

.login-button,
.signup-button,
.cart-button {
    padding: 10px 20px;
    background-color: #fdfdfd;
    color: #000;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-weight: bold;
    margin-right: 10px;
}

.login-button:hover,
.signup-button:hover,
.cart-button:hover {
    background-color: #bdbcbc;
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

/* Breadcrumb Section */
.breadcrumb-section {
    background: url('Images/background.jpg') no-repeat center 55%/cover;
    color: white;
    text-align: center;
    padding: 8rem 2rem;
    font-size: 2rem;
}

.breadcrumb-section p {
    font-size: 1.75rem;
    margin-top: 0.5rem;
}

/* Product List */
.product-list {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    padding: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.product {
    background: white;
    padding: 1rem;
    border-radius: 10px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.product:hover {
    transform: scale(1.05);
    box-shadow: 4px 4px 20px rgba(0, 0, 0, 0.2);
}

.product img {
    width: 100%;
    height: 250px;
    object-fit: cover;
    border-radius: 10px;
}

.product a {
    text-decoration: none;
}

h2 {
    font-size: 1.5rem;
    color: #333;
}

.price {
    font-size: 1.25rem;
    color: #d01a42;
    font-weight: bold;
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
@media (max-width: 1024px) {
    .search-bar {
        margin-left: 100px;
    }
    
    .product-list {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .breadcrumb-section {
        font-size: 1.5rem;
        padding: 5rem 1rem;
    }
}

@media (max-width: 768px) {
    /* Search Bar */
    .search-container {
        flex-direction: column;
        padding: 10px 5px;
    }
    
    .search-bar {
        margin-left: 0;
        width: 100%;
        margin-bottom: 10px;
    }
    
    .search-bar input {
        width: 70%;
        margin-right: 5px;
    }
    
    /* Action Buttons */
    .action-buttons {
        width: 100%;
        justify-content: space-around;
    }
    
    /* Navigation */
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
    
    /* Breadcrumb */
    .breadcrumb-section {
        padding: 4rem 1rem;
        font-size: 1.5rem;
    }
    
    .breadcrumb-section p {
        font-size: 1.25rem;
    }
    
    /* Product List */
    .product-list {
        grid-template-columns: 1fr;
        padding: 1rem;
    }
    
    .product img {
        height: 200px;
    }
}

@media (max-width: 480px) {
    .breadcrumb-section {
        font-size: 1.2rem;
        padding: 3rem 0.5rem;
    }
    
    .search-bar input {
        width: 65%;
    }
    
    .product img {
        height: 180px;
    }
}
    </style>
</head>
<body>
    <%
        // Get products for this category
        DB db = new DB();
        List<Product> products = db.getProductsByType("living");
    %>
    
    <!-- Search Bar -->
    <div class="search-container">
        <a href="home.jsp">
            <div class="logo">
                <h1>Heaven And Home </h1>
                <p>Style That Speaks Comfort</p>
            </div>
        </a>
        <div class="search-bar">
            <input type="text" id="search-input" placeholder="Search for products..." oninput="searchProducts()" />
            <button onclick="handleSearchClick()">Search</button>
        </div>
        <div class="action-buttons">
            <% if(c != null && c.getEmail() != null && !c.getEmail().isEmpty()) { %>
                <div class="user-welcome" style="display: flex; align-items: center; margin-right: 15px; color: #333; font-weight: 500;">
                    Welcome, <jsp:getProperty name="c" property="firstName" />!
                </div>
                <form action="logout.jsp" method="post" style="display: inline;">
                    <button type="submit" class="logout-button" style="background-color: #000; color: white; border: none; padding: 8px 15px; border-radius: 20px; cursor: pointer; font-size: 14px; transition: background-color 0.3s;">Logout</button>
                </form>
                <a href="cart.html" class="cart-button">Cart</a>
            <% } else { %>
                <a href="index.html" class="login-button">Log In</a>
                <a href="signUp.html" class="signup-button">Sign Up</a>
                <a href="cart.html" class="cart-button">Cart</a>
            <% } %>
        </div>
    </div>
    
    <!-- Header -->
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
                <div class="menu-toggle">☰</div> <!-- Hamburger Menu -->
            </nav>
        </div>
    </header>

    <!-- Breadcrumb Section -->
    <section class="breadcrumb-section">
        <h2>LIVING ROOM</h2>
        <p>HOME / FURNITURE / LIVING ROOM</p>
    </section>

    <!-- Product List Section -->
    <div class="product-list">
        <% if (products.isEmpty()) { %>
            <div style="text-align: center; padding: 50px;">
                <h3>No living room products found.</h3>
                <p>Please check back later or browse other categories.</p>
            </div>
        <% } else { %>
            <% for (Product product : products) { %>
                <div class="product">
                    <a href="product-detail.jsp?id=<%= product.getId() %>">
                        <img src="<%= product.getImage1() %>" alt="<%= product.getName() %>">
                        <h2><%= product.getName() %></h2>
                        <p class="price">£<%= product.getPrice() %></p>
                    </a>
                </div>
            <% } %>
        <% } %>
    </div>

    <footer>
        <p>&copy; 2025 Heaven And Home. All rights reserved.</p>
    </footer>
    
    <script>
        // Mobile menu toggle
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-links').classList.toggle('show');
        });
        
        // Function to search products
        function searchProducts() {
            var input = document.getElementById('search-input').value.toLowerCase();
            var products = document.querySelectorAll('.product');
            
            products.forEach(function(product) {
                var productName = product.querySelector('h2').textContent.toLowerCase();
                if (productName.includes(input)) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }
    
        // Redirect to product page on Enter with fuzzy search
        document.getElementById('search-input').addEventListener('keydown', function (event) {
            if (event.key === 'Enter') {
                event.preventDefault(); // Prevent form submission or other default behavior
                searchProducts(); // Call searchProducts to handle filtering on Enter key press
    
                const query = event.target.value.trim().toLowerCase();
                const roomPages = {
                    "living room": "living.jsp",
                    "bedroom": "bedroom.jsp",
                    "kitchen": "kitchen.jsp",
                    "dining": "dining.jsp"
                };
    
                // Fuzzy search: find a match that contains the input
                const matchedPage = Object.keys(roomPages).find(room =>
                    room.toLowerCase().includes(query)
                );
    
                if (matchedPage) {
                    window.location.href = roomPages[matchedPage]; // Redirect to matched page
                } else {
                    alert("No matching room found. Try typing part of the room name (e.g., 'living', 'bed', 'kitchen').");
                }
            }
        });
       
        function handleSearchClick() {
            searchProducts(); // Filter visible products
            
            const query = document.getElementById('search-input').value.trim().toLowerCase();
            const roomPages = {
                "living room": "living.jsp",
                "bedroom": "bedroom.jsp",
                "kitchen": "kitchen.jsp",
                "dining": "dining.jsp"
            };

            const matchedPage = Object.keys(roomPages).find(room =>
                room.toLowerCase().includes(query)
            );

            if (matchedPage) {
                window.location.href = roomPages[matchedPage];
            } else {
                alert("No matching room found. Try typing part of the room name (e.g., 'living', 'bed', 'kitchen').");
            }
        }
    </script>
</body>
</html>