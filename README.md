# Heaven & Home — Furniture E-Commerce Web Application

> A full-stack Java EE furniture e-commerce platform built with JSP and Servlets. Customers can browse furniture by category, view detailed product pages, manage a shopping cart, and place orders. Includes an admin panel for product and order management.

**Author:** Ziad Hany Mohamed Salem  
**Department:** Cybersecurity  
**Course:** Web Programming  
**Stack:** Java EE · JSP · Servlets · MySQL · GlassFish  
**Date:** 2025

---

## Features

### Customer Side
- Sign up and login with session-based authentication
- Browse furniture by category — Bedroom, Dining, Kitchen, Living Room
- View detailed product pages with multiple images per product
- Add items to shopping cart with quantity management
- Checkout with shipping address and payment method (Cash / Visa)
- Order processing and confirmation

### Admin Panel
- Secure admin login (`admin@gmail.com`)
- View and manage all products
- View all customer orders
- Upload product images

### Architecture Highlights
- **MVC pattern** — Servlets as controllers, JSP as views, Java classes as models
- **Session management** — Customer object stored in `HttpSession` across pages
- **Serializable models** — `Customer` and `CartItem` implement `Serializable` for session storage
- **MySQL backend** via JDBC through a centralized `DB` class
- **File upload** servlet for admin product image management

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | JSP (JavaServer Pages), HTML, CSS |
| Backend | Java Servlets (Jakarta EE) |
| Database | MySQL via JDBC |
| Server | GlassFish / Apache Tomcat |
| Build Tool | Apache Ant (NetBeans project) |
| IDE | NetBeans |

---

## Project Structure

```
heaven-and-home/
│
├── src/java/src/                  ← Java source files
│   ├── home.java                  ← Login servlet — authenticates and routes users
│   ├── Customer.java              ← Customer model (Serializable)
│   ├── Product.java               ← Product model (id, name, type, price, stock, images)
│   ├── CartItem.java              ← Cart item model (Serializable, subtotal calculation)
│   ├── Order.java                 ← Order model with OrderItem list
│   ├── OrderItem.java             ← Individual order line item
│   ├── DB.java                    ← Database access layer (all JDBC queries)
│   ├── AddToCartServlet.java      ← Handles add-to-cart requests
│   ├── FileUploadServlet.java     ← Admin product image upload
│   └── Insert.java                ← Insert/register new customer
│
└── web/                           ← JSP views and static assets
    ├── index.html                 ← Login page
    ├── signUp.html                ← Registration page
    ├── home.jsp                   ← Home page (after login)
    ├── bedroom.jsp                ← Bedroom furniture category
    ├── dining.jsp                 ← Dining furniture category
    ├── kitchen.jsp                ← Kitchen furniture category
    ├── living.jsp                 ← Living room furniture category
    ├── product-detail.jsp         ← Individual product detail with image gallery
    ├── cart.jsp                   ← Shopping cart view
    ├── checkout.jsp               ← Checkout form (address + payment)
    ├── process-order.jsp          ← Order processing and confirmation
    ├── remove-from-cart.jsp       ← Remove item from cart
    ├── admin.jsp                  ← Admin dashboard
    ├── logout.jsp                 ← Session invalidation and redirect
    └── Images/                    ← Product images organized by category
        ├── bedroom/
        ├── dining/
        ├── kitchen/
        └── livingRooms/
```

---

## Class Design

```
Customer  (Serializable)
  └── Stored in HttpSession — persists across all JSP pages

Product
  └── id, name, type, price, description, stock
  └── image1 ... image5 (multiple product images)

CartItem  (Serializable)
  └── productId, productName, quantity, price
  └── getSubtotal() → price × quantity

Order
  └── customerEmail, shippingAddress, orderDate, totalAmount, paymentMethod
  └── List<OrderItem> items
  └── calculateTotalFromItems()

OrderItem
  └── Individual line item within an Order

DB  (Data Access Layer)
  └── loginUser(), getProducts(), addToCart(), processOrder()...

Servlets (Controllers)
  ├── home.java          → POST /home  — login + session creation
  ├── AddToCartServlet   → POST /addToCart
  ├── FileUploadServlet  → POST /upload
  └── Insert.java        → POST /insert — new customer registration
```

---

## Setup & Installation

### Requirements
- Java JDK 17+
- GlassFish 7 or Apache Tomcat 10+
- MySQL 8.x
- NetBeans IDE (recommended) or any Java EE IDE

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/ZiadHany99/heaven-and-home.git

# 2. Open in NetBeans
# File → Open Project → select the Heaven And Home folder

# 3. Set up the database
# Create a MySQL database and import the schema
# Update DB credentials in DB.java

# 4. Configure GlassFish server in NetBeans
# Tools → Servers → Add Server → GlassFish

# 5. Run the project
# Right-click project → Run
# Navigate to: http://localhost:8080/Heaven_And_Home/

# Admin login:
# Email:    admin@gmail.com
# Password: Admin1234@
```

---

## Key Learning Outcomes

- Java EE web development with JSP and Servlets (MVC pattern)
- Session management and object serialization in web applications
- JDBC database connectivity and query execution
- Multi-role authentication (customer vs admin)
- File upload handling in Java Servlets
- Shopping cart state management across HTTP requests
- Building and deploying a `.war` file with Apache Ant

---

## Disclaimer

This project was developed for academic purposes as part of a Web Programming course. All product data and customer information used during development was fictional test data.
