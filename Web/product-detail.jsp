<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="src.Product"%>
<%@page import="src.DB"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<!DOCTYPE html>
<jsp:useBean id="c" class="src.Customer" scope="session" />
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>/* General Styling */
body, h1, h2, h3, p, ul, li {
    margin: 0;
    padding: 0;
}
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

.search-container {
    display: flex;
    align-items: center;
    padding: 10px;
    background-color: #fff;
    justify-content: space-between;
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
    color: #d01a42;
}

/* Hamburger Menu */
.menu-toggle {
    display: none;
    color:beige;
    font-size: 2rem;
    cursor: pointer;
}

/* Product Page - Responsive Version */
.product-page {
    display: flex;
    flex-wrap: wrap;
    max-width: 1200px;
    margin: 40px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    gap: 40px;
}

.image-gallery {
    flex: 1 1 500px;
    display: flex;
    flex-direction: row;
    gap: 20px;
    min-width: 300px;
}


.thumbnail-images {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.thumbnail-images img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    cursor: pointer;
    border: 1px solid #ddd;
    border-radius: 4px;
    transition: all 0.3s ease;
}

.thumbnail-images img:hover {
    transform: scale(1.05);
    border-color: #555;
}

.main-image {
    flex: 1;
    min-width: 0;
    height: 500px;
    max-width: 100%;
    object-fit: cover;
    border: 1px solid #ccc;
    border-radius: 5px;
    transition: opacity 0.3s ease-in-out;
}

.product-info {
    flex: 1 1 400px;
    min-width: 300px;
}

.product-info h1 {
    font-size: clamp(24px, 2.5vw, 28px);
    margin-bottom: 10px;
}

.price {
    color: #000000;
    font-size: clamp(20px, 2vw, 22px);
    margin-bottom: 10px;
}

.availability {
    color: #2196f3;
    margin-bottom: 20px;
}

.description {
    margin-bottom: 20px;
    line-height: 1.5;
}


.product a {
    text-decoration: none;  
}

.quantity-selector {
    display: flex;
    align-items: center;
    margin-top: 20px;
    margin-bottom: 20px;
}

.quantity-selector label {
    margin-right: 10px;
}

.quantity-selector input {
    width: 60px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-align: center;
}

.add-to-cart {
    background-color: #000000;
    color: white;
    padding: 12px 50px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 20px;
    font-size: 16px;
    transition: background-color 0.3s;
}

.add-to-cart:hover {
    background-color: #333;
}

/* Highlight the active thumbnail */
.thumbnail-images img.active {
    border: 3px solid #000000;
}

/* You May Like Section */
.you-may-like {
    max-width: 1200px;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.you-may-like h2 {
    font-size: 26px;
    margin-bottom: 20px;
}

.like-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Increased min column width */
    gap: 20px;
}

.like-grid a {
    text-decoration: none;
    color: black;
    text-align: center;
}

.like-grid img {
    width: 100%;
    height: 220px; /* Increased height */
    object-fit: cover;
    border-radius: 0; /* No rounded corners */
    transition: transform 0.3s;
}

.like-grid img:hover {
    transform: scale(1.05);
}

.like-grid p {
    margin-top: 8px;
    font-weight: 500;
}

footer {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 20px;
    margin-top: 40px;
}

/* Add these media queries at the end of your existing CSS */
/* They will only activate on smaller screens */

@media (max-width: 1200px) {
    .search-bar {
        margin-left: 100px;
    }
    
    .product-page {
        margin: 30px 20px;
    }
    
    .you-may-like {
        margin: 40px 20px;
    }
}

@media (max-width: 992px) {
    .search-bar {
        margin-left: 50px;
    }
    
    .image-gallery {
        flex-direction: column;
    }
    
    .thumbnail-images {
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
    }
    
    .main-image {
        width: 100%;
        height: auto;
    }
}

@media (max-width: 768px) {
    .search-container {
        flex-wrap: wrap;
    }
    
    .search-bar {
        margin-left: 0;
        width: 100%;
        order: 1;
        margin-top: 10px;
    }
    
    .action-buttons {
        margin-left: auto;
    }
    
    nav ul {
        display: none;
        flex-direction: column;
        width: 100%;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #000;
        padding: 15px 0;
    }
    
    nav ul.show {
        display: flex;
    }
    
    .menu-toggle {
        display: block;
    }
    
    .product-info {
        text-align: center;
    }
    
    .add-to-cart {
        margin-left: auto;
        margin-right: auto;
    }
    
    .like-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 576px) {
    .search-bar input {
        width: 70%;
    }
    
    .action-buttons {
        width: 100%;
        justify-content: space-around;
        margin-top: 10px;
    }
    
    .thumbnail-images img {
        width: 60px;
        height: 60px;
    }
    
    .like-grid {
        grid-template-columns: 1fr;
    }
}

</style>
    <%
        // Get the product ID from the URL parameter
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            // Handle invalid ID
        }
        
        // Get product details
        DB db = new DB();
        Product product = db.getProductDetails(productId);
        
        // Check if product exists
        boolean productExists = product != null && product.getId() > 0;
        
        // Get related products (same type but different ID)
        List<Product> relatedProducts = new ArrayList<>();
        if (productExists) {
            List<Product> allTypeProducts = db.getProductsByType(product.getType());
            Random rand = new Random();
            
            // Filter out the current product and get up to 4 random products
            List<Product> filteredProducts = new ArrayList<>();
            for (Product p : allTypeProducts) {
                if (p.getId() != product.getId()) {
                    filteredProducts.add(p);
                }
            }
            
            // Get up to 4 random products
            int count = Math.min(4, filteredProducts.size());
            for (int i = 0; i < count; i++) {
                if (filteredProducts.isEmpty()) break;
                int randomIndex = rand.nextInt(filteredProducts.size());
                relatedProducts.add(filteredProducts.get(randomIndex));
                filteredProducts.remove(randomIndex);
            }
        }
    %>
    <title>Heaven And Home | <%= productExists ? product.getName() : "Product Not Found" %></title>
    <link rel="stylesheet" href="../CSS/product.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Additional styles for user welcome and logout */
        .user-welcome {
            display: flex;
            align-items: center;
            margin-right: 15px;
            color: #333;
            font-weight: 500;
        }
        
        .logout-form {
            display: inline;
        }
        
        .logout-button {
            background-color: #000;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        
        .logout-button:hover {
            background-color: rgb(155, 138, 18);
        }
        
        .thumbnail-images img.active {
            border: 2px solid #000;
        }
    </style>
</head>
<body>
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
                <div class="user-welcome">
                    Welcome, <jsp:getProperty name="c" property="firstName" />!
                </div>
                <form action="logout.jsp" method="post" class="logout-form">
                    <button type="submit" class="logout-button">Logout</button>
                </form>
                <a href="cart.jsp" class="cart-button">Cart</a>
            <% } else { %>
                <a href="index.html" class="login-button">Log In</a>
                <a href="signUp.html" class="signup-button">Sign Up</a>
                <a href="cart.jsp" class="cart-button">Cart</a>
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

    <% if (!productExists) { %>
        <div style="text-align: center; padding: 50px;">
            <h2>Product Not Found</h2>
            <p>The product you're looking for doesn't exist or has been removed.</p>
            <a href="home.jsp" style="display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #000; color: white; text-decoration: none; border-radius: 25px;">Return to Home</a>
        </div>
    <% } else { %>
        <main class="product-page">
            <div class="image-gallery">
                <div class="thumbnail-images">
                    <% if (product.getImage1() != null && !product.getImage1().isEmpty()) { %>
                        <img src="<%= product.getImage1() %>" alt="Thumbnail 1" class="active" onclick="changeImage('<%= product.getImage1() %>', this)">
                    <% } %>
                    
                    <% if (product.getImage2() != null && !product.getImage2().isEmpty()) { %>
                        <img src="<%= product.getImage2() %>" alt="Thumbnail 2" onclick="changeImage('<%= product.getImage2() %>', this)">
                    <% } %>
                    
                    <% if (product.getImage3() != null && !product.getImage3().isEmpty()) { %>
                        <img src="<%= product.getImage3() %>" alt="Thumbnail 3" onclick="changeImage('<%= product.getImage3() %>', this)">
                    <% } %>
                    
                    <% if (product.getImage4() != null && !product.getImage4().isEmpty()) { %>
                        <img src="<%= product.getImage4() %>" alt="Thumbnail 4" onclick="changeImage('<%= product.getImage4() %>', this)">
                    <% } %>
                    
                    <% if (product.getImage5() != null && !product.getImage5().isEmpty()) { %>
                        <img src="<%= product.getImage5() %>" alt="Thumbnail 5" onclick="changeImage('<%= product.getImage5() %>', this)">
                    <% } %>
                </div>
                <img src="<%= product.getImage1() %>" alt="<%= product.getName() %>" class="main-image" id="mainImage">
            </div>

            <div class="product-info">
                <h1><%= product.getName() %></h1>
                <p class="price">£<%= product.getPrice() %></p>
                <p class="availability"><%= product.getStock() > 0 ? "In Stock" : "Out of Stock" %></p>
                <p class="description"><%= product.getDescription() %></p>
                
                <% if (c != null && c.getEmail() != null && !c.getEmail().isEmpty() && product.getStock() > 0) { %>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <div class="quantity-selector">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStock() %>">
                        </div>
                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>
                <% } else if (product.getStock() <= 0) { %>
                    <button class="add-to-cart" disabled style="background-color: #ccc; cursor: not-allowed;">Out of Stock</button>
                <% } else { %>
                    <a href="index.html" class="add-to-cart" style="display: inline-block; text-align: center; text-decoration: none;">Log in to Add to Cart</a>
                <% } %>
            </div>
        </main>

        <!-- You May Also Like Section -->
        <section class="you-may-like">
            <h2>You May Also Like</h2>
            <div class="like-grid">
                <% if (relatedProducts.isEmpty()) { %>
                    <p style="text-align: center; grid-column: span 4;">No related products found.</p>
                <% } else { %>
                    <% for (Product relatedProduct : relatedProducts) { %>
                        <a href="product-detail.jsp?id=<%= relatedProduct.getId() %>">
                            <img src="<%= relatedProduct.getImage1() %>" alt="<%= relatedProduct.getName() %>">
                            <p><%= relatedProduct.getName() %></p>
                        </a>
                    <% } %>
                <% } %>
            </div>
        </section>
    <% } %>

    <footer>
        <p>&copy; 2025 Heaven And Home. All rights reserved.</p>
    </footer>

    <script>
        function changeImage(imageSrc, thumbElement) {
            const mainImage = document.getElementById('mainImage');
            mainImage.style.opacity = '0.3';
            setTimeout(() => {
                mainImage.src = imageSrc;
                mainImage.style.opacity = '1';
            }, 150);
            
            // Update active thumbnail
            const thumbnails = document.querySelectorAll('.thumbnail-images img');
            thumbnails.forEach(img => img.classList.remove('active'));
            thumbElement.classList.add('active');
        }

        // Mobile menu toggle
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-links').classList.toggle('show');
        });

        // Function to search products
        function searchProducts() {
            var input = document.getElementById('search-input').value.toLowerCase();
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