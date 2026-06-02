<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="c" class="src.Customer" scope="session" />
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Heaven And Home | Stylish & Unique Homeware</title>
    <link rel="icon" type="image/png" href="../Images/logo.jpg" />
    <link rel="stylesheet" href="../CSS/home.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
       /* Reset and Base */
body, h1, h2, h3, p, ul, li {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    line-height: 1.6;
    color: #333;
}

/* Search Bar */
.search-container {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 15px 20px;
    background-color: #fff;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.logo h1 {
    font-size: 1.8em;
    color: #000;
    margin-bottom: 5px;
}

.logo p {
    font-size: 0.9em;
    color: #666;
    font-style: italic;
}

.search-bar {
    display: flex;
    align-items: center;
    margin-left: 210px;
    flex-grow: 1;
}

.search-bar input {
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 30px;
    width: 300px;
    margin-right: 15px;
    font-size: 0.95em;
    transition: all 0.3s;
}

.search-bar input:focus {
    border-color: #000;
    outline: none;
}

.search-bar button {
    padding: 12px 25px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 30px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s;
}

.search-bar button:hover {
    background-color: #333;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 12px;
    align-items: center;
}

.login-button,
.signup-button,
.cart-button {
    padding: 10px 18px;
    background-color: #f8f8f8;
    color: #000;
    border: 1px solid #ddd;
    border-radius: 30px;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.9em;
    transition: all 0.3s;
}

.login-button:hover,
.signup-button:hover,
.cart-button:hover {
    background-color: #e9e9e9;
    border-color: #ccc;
}

/* Navigation */
header {
    background-color: #000;
    padding: 0 20px;
    position: sticky;
    top: 0;
    z-index: 100;
}

nav {
    display: flex;
    justify-content: center;
    align-items: center;
}

nav ul {
    list-style: none;
    display: flex;
    gap: 25px;
    padding: 15px 0;
}

nav ul li a {
    text-decoration: none;
    color: #fff;
    padding: 8px 0;
    font-weight: 500;
    position: relative;
    transition: color 0.3s;
}

nav ul li a:after {
    content: '';
    position: absolute;
    width: 0;
    height: 2px;
    bottom: 0;
    left: 0;
    background-color: #c40000;
    transition: width 0.3s;
}

nav ul li a:hover {
    color: #c40000;
}

nav ul li a:hover:after {
    width: 100%;
}

.menu-toggle {
    color: beige;
    display: none;
    font-size: 1.8em;
    cursor: pointer;
    padding: 10px;
}

/* Hero Section */
.hero {
    position: relative;
    height: 100vh;
    width: 100%;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}

.hero video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -1;
}

.hero h1 {
    color: white;
    font-size: 3.5em;
    position: relative;
    z-index: 1;
    text-shadow: 2px 2px 8px rgba(0,0,0,0.6);
    margin-bottom: 20px;
    animation: fadeIn 1.5s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Image Section */
.image-section {
    padding: 40px 20px;
    background-color: #fff;
}

.image-row-static {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 20px;
    padding: 20px 0;
}

.image-row-static img {
    width: 450px;
    height: 600px;
    object-fit: cover;
    border-radius: 10px;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.image-row-static img:hover {
    transform: scale(1.03);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

/* Shop by Room Title */
.shop-by-room-title {
    text-align: center;
    font-size: 2.2em;
    color: #222;
    font-weight: bold;
    margin: 60px 0 40px;
    position: relative;
}

.shop-by-room-title:after {
    content: '';
    display: block;
    width: 80px;
    height: 3px;
    background: #c40000;
    margin: 15px auto 0;
}

/* Clickable Grid */
.clickable-image-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 30px;
    max-width: 1400px;
    margin: 0 auto;
}

.image-container {
    text-align: center;
    flex: 1 1 300px;
    max-width: 350px;
}

.image-container a img {
    width: 100%;
    height: 250px;
    object-fit: cover;
    border-radius: 10px;
    transition: transform 0.3s ease-in-out;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.image-container a img:hover {
    transform: scale(1.05);
}

.image-container p {
    margin-top: 15px;
    font-weight: bold;
    font-size: 1.3em;
    color: #333;
    transition: color 0.3s;
}

.image-container:hover p {
    color: #c40000;
}

/* About Section */
.about-section {
    padding: 80px 40px;
    background-color: #f9f9f9;
}

.about-content {
    max-width: 1200px;
    margin: 0 auto;
}

.about-section h2 {
    font-size: 2.5em;
    text-align: center;
    margin-bottom: 50px;
    color: #222;
    position: relative;
}

.about-section h2:after {
    content: '';
    display: block;
    width: 80px;
    height: 3px;
    background: #c40000;
    margin: 15px auto 0;
}

.about-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 30px;
    margin-bottom: 50px;
}

.about-card {
    flex: 1 1 300px;
    max-width: 350px;
    background: #fff;
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    transition: transform 0.3s;
}

.about-card:hover {
    transform: translateY(-10px);
}

.about-card i {
    font-size: 2.5em;
    color: #c40000;
    margin-bottom: 20px;
}

.about-card h3 {
    font-size: 1.4em;
    margin-bottom: 15px;
    color: #222;
}

.about-card p {
    color: #666;
    line-height: 1.6;
}

.about-story {
    max-width: 800px;
    margin: 0 auto;
    text-align: center;
}

.about-story h3 {
    font-size: 1.6em;
    margin-bottom: 20px;
    color: #222;
}

.about-story p {
    color: #555;
    line-height: 1.8;
    margin-bottom: 20px;
}

/* Contact Section */
.contact-section {
    padding: 80px 20px;
    background-color: #fff;
}

.contact-container {
    max-width: 1200px;
    margin: 0 auto;
}

.contact-section h2 {
    font-size: 2.5em;
    text-align: center;
    margin-bottom: 50px;
    color: #222;
    position: relative;
}

.contact-section h2:after {
    content: '';
    display: block;
    width: 80px;
    height: 3px;
    background: #c40000;
    margin: 15px auto 0;
}

.contact-methods {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 30px;
    margin-bottom: 50px;
}

.contact-card {
    flex: 1 1 300px;
    max-width: 350px;
    background: #f9f9f9;
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    transition: transform 0.3s;
}

.contact-card:hover {
    transform: translateY(-5px);
}

.contact-card i {
    font-size: 2em;
    color: #c40000;
    margin-bottom: 20px;
}

.contact-card h3 {
    font-size: 1.3em;
    margin-bottom: 15px;
    color: #222;
}

.contact-card p {
    color: #666;
    line-height: 1.6;
}

.social-links {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 40px;
}

.social-links a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: #f1f1f1;
    border-radius: 50%;
    color: #333;
    font-size: 1.2em;
    transition: all 0.3s;
}

.social-links a:hover {
    background: #c40000;
    color: #fff;
    transform: translateY(-3px);
}

/* Footer */
footer {
    background-color: #222;
    color: #fff;
    padding: 60px 20px 0;
}

.footer-content {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
    justify-content: space-between;
}

.footer-section {
    flex: 1 1 200px;
    min-width: 200px;
    margin-bottom: 30px;
}

.footer-section h3 {
    font-size: 1.2em;
    margin-bottom: 20px;
    color: #fff;
    position: relative;
    padding-bottom: 10px;
}

.footer-section h3:after {
    content: '';
    position: absolute;
    left: 0;
    bottom: 0;
    width: 40px;
    height: 2px;
    background: #c40000;
}

.footer-section ul {
    list-style: none;
}

.footer-section ul li {
    margin-bottom: 10px;
}

.footer-section ul li a {
    color: #bbb;
    text-decoration: none;
    transition: color 0.3s;
}

.footer-section ul li a:hover {
    color: #fff;
}

.newsletter p {
    color: #bbb;
    margin-bottom: 15px;
    line-height: 1.6;
}

.newsletter-form {
    display: flex;
    gap: 10px;
}

.newsletter-form input {
    flex: 1;
    padding: 12px 15px;
    border: none;
    border-radius: 4px;
    background: #333;
    color: #fff;
}

.newsletter-form input::placeholder {
    color: #999;
}

.newsletter-form button {
    padding: 0 20px;
    background: #c40000;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.3s;
}

.newsletter-form button:hover {
    background: #a30000;
}

.footer-bottom {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px 0;
    border-top: 1px solid #444;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.footer-bottom p {
    color: #999;
    font-size: 0.9em;
}

.payment-methods {
    display: flex;
    gap: 15px;
}

.payment-methods i {
    font-size: 1.8em;
    color: #999;
    transition: color 0.3s;
}

.payment-methods i:hover {
    color: #fff;
}

/* Responsive Adjustments */
@media (max-width: 1024px) {
    .search-bar {
        margin-left: 100px;
    }
    
    .hero h1 {
        font-size: 3em;
    }
    
    .image-row-static img {
        width: 350px;
        height: 500px;
    }
}

@media (max-width: 768px) {
    .search-container {
        flex-direction: column;
        gap: 15px;
        padding: 15px;
    }
    
    .search-bar {
        margin-left: 0;
        width: 100%;
    }
    
    .search-bar input {
        width: 70%;
        margin-right: 10px;
    }
    
    .action-buttons {
        width: 100%;
        justify-content: center;
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
    
    .hero {
        height: 70vh;
    }
    
    .hero h1 {
        font-size: 2.2em;
        padding: 0 20px;
    }
    
    .image-row-static {
        flex-direction: column;
    }
    
    .image-row-static img {
        width: 100%;
        height: auto;
        max-height: 500px;
    }
    
    .shop-by-room-title {
        margin: 40px 0 30px;
        font-size: 1.8em;
    }
    
    .about-section,
    .contact-section {
        padding: 60px 20px;
    }
    
    .footer-content {
        gap: 30px;
    }
}

@media (max-width: 480px) {
    .hero h1 {
        font-size: 1.8em;
    }
    
    .search-bar input {
        width: 65%;
    }
    
    .image-container {
        flex: 1 1 100%;
    }
    
    .about-card,
    .contact-card {
        flex: 1 1 100%;
    }
    
    .footer-section {
        flex: 1 1 100%;
    }
    
    .newsletter-form {
        flex-direction: column;
    }
    
    .newsletter-form button {
        padding: 12px;
    }
}
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
    </style>
</head>
<body>
    <!-- action buttons / search container /Search Bar  -->
    <div class="search-container">
        <div class="logo">
            <h1>Heaven And Home</h1>
            <p>Style That Speaks Comfort</p>
        </div>
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
                    <li><a href="#about-section">About</a></li>
                    <li><a href="#contact-section">Contact</a></li>
                </ul>
                <div class="menu-toggle">☰</div>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <video autoplay muted loop>
            <source src="videos/welcome.mp4" type="video/mp4" />
            Your browser does not support the video tag.
        </video>
        <h1>Stylish & Unique Homeware</h1>
    </section>

    <!-- Image Section -->
    <section class="image-section">
        <div class="image-row-static">
            <img src="Images/Home/h1.jpeg" alt="Home Decor 1" />
            <img src="Images/Home/h2.jpeg" alt="Home Decor 2" />
            <img src="Images/Home/h3.jpeg" alt="Home Decor 3" />
        </div>

        <h2 class="shop-by-room-title">Shop By Room :</h2>

        <div class="clickable-image-grid">
            <div class="image-container" data-name="Living Room">
                <a href="living.jsp">
                    <img src="../Images/Home/living.jpeg" alt="Living Room" />
                </a>
                <p>Living Room</p>
            </div>
            <div class="image-container" data-name="Bedroom">
                <a href="bedroom.jsp">
                    <img src="Images/Home/bedroom.jpeg" alt="Bedroom" />
                </a>
                <p>Bedroom</p>
            </div>
            <div class="image-container" data-name="Dining">
                <a href="dining.jsp">
                    <img src="Images/Home/dining.jfif" alt="Dining" />
                </a>
                <p> Kitchen</p>
            </div>
            <div class="image-container" data-name="Kitchen">
                <a href="kitchen.jsp">
                    <img src="Images/Home/kitchen.jpeg" alt="Kitchen" />
                </a>
                <p>Dining</p>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about-section" class="about-section">
        <div class="about-content">
            <h2>Our Story</h2>
            <div class="about-grid">
                <div class="about-card">
                    <i class="fas fa-home"></i>
                    <h3>Our Vision</h3>
                    <p>To redefine home living by blending contemporary design with timeless comfort, creating spaces that inspire and rejuvenate.</p>
                </div>
                <div class="about-card">
                    <i class="fas fa-heart"></i>
                    <h3>Our Passion</h3>
                    <p>We're driven by a love for craftsmanship and design, curating only the finest pieces that stand the test of time.</p>
                </div>
                <div class="about-card">
                    <i class="fas fa-star"></i>
                    <h3>Our Promise</h3>
                    <p>Quality materials, ethical sourcing, and exceptional customer service form the foundation of everything we do.</p>
                </div>
            </div>
            <div class="about-story">
                <h3>From Humble Beginnings</h3>
                <p>Founded in 2015, Heaven And Home began as a small boutique in Cairo, Egypt. What started as a passion project has grown into a beloved destination for home enthusiasts across the region. Each piece in our collection is thoughtfully selected to bring warmth, style, and functionality to your living spaces.</p>
                <p>Today, we continue to honor our roots while embracing innovation, offering an ever-evolving collection that meets the needs of modern living without compromising on quality or design integrity.</p>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact-section" class="contact-section">
        <div class="contact-container">
            <h2>Get In Touch</h2>
            <div class="contact-methods">
                <div class="contact-card">
                    <i class="fas fa-map-marker-alt"></i>
                    <h3>Visit Us</h3>
                    <p>123 Design District<br>Cairo, Egypt</p>
                </div>
                <div class="contact-card">
                    <i class="fas fa-phone-alt"></i>
                    <h3>Call Us</h3>
                    <p>+20 12 1066 5996<br>Mon-Fri: 9am-6pm</p>
                </div>
                <div class="contact-card">
                    <i class="fas fa-envelope"></i>
                    <h3>Email Us</h3>
                    <p>info@heavenandhome.com<br>Response within 24 hours</p>
                </div>
            </div>
            <div class="social-links">
                <a href="https://www.facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://www.pinterest.com" target="_blank"><i class="fab fa-pinterest-p"></i></a>
                <a href="https://www.twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="living.html">Living Room</a></li>
                    <li><a href="bedroom.html">Bedroom</a></li>
                    <li><a href="kitchen.html">Kitchen</a></li>
                    <li><a href="dining.html">Dining Room</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Customer Service</h3>
                <ul>
                    <li><a href="#">Shipping Policy</a></li>
                    <li><a href="#">Returns & Exchanges</a></li>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Size Guide</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Company</h3>
                <ul>
                    <li><a href="#about-section">About Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                </ul>
            </div>
            <div class="footer-section newsletter">
                <h3>Stay Updated</h3>
                <p>Subscribe for design tips and exclusive offers</p>
                <form class="newsletter-form">
                    <input type="email" placeholder="Your email address" required>
                    <button type="submit">Subscribe</button>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Heaven And Home. All rights reserved.</p>
            <div class="payment-methods">
                <i class="fab fa-cc-visa"></i>
                <i class="fab fa-cc-mastercard"></i>
                <i class="fab fa-cc-paypal"></i>
            </div>
        </div>
    </footer>

    <script>
        // Mobile menu toggle
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-links').classList.toggle('show');
        });

        // Search functionality
        function searchProducts() {
            var input = document.getElementById('search-input').value.toLowerCase();
        }
    
        document.getElementById('search-input').addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                handleSearchClick();
            }
        });
       
        function handleSearchClick() {
            const query = document.getElementById('search-input').value.trim().toLowerCase();
            const roomPages = {
                "living room": "living.html",
                "bedroom": "bedroom.html",
                "kitchen": "kitchen.html",
                "dining": "dining.html"
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