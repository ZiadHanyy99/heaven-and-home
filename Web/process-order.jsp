<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="src.DB"%>
<%@page import="src.Customer"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Processing | Heaven And Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        .error-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-title {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }
        .error-message {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: #000;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            text-decoration: none;
            text-align: center;
        }
        .btn:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
<%
    Customer c = (Customer) session.getAttribute("c");
    if (c == null || c.getEmail() == null || c.getEmail().isEmpty()) {
        response.sendRedirect("index.html");
        return;
    }

    // Get form parameters
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String postalCode = request.getParameter("postalCode");
    String phone = request.getParameter("phone");
    String paymentMethod = "Cash"; // Default to Cash on Delivery

    // Update address with city and postal code
    String updatedAddress = address + ", " + city + ", " + postalCode;
    c.setFirstName(firstName);
    c.setLastName(lastName);
    c.setAddress(updatedAddress);

    DB db = new DB();
    boolean userUpdated = db.updateUser(c);

    int orderId = db.createOrder(c.getEmail(), paymentMethod);

    if (orderId > 0) {
        response.sendRedirect("order-confirmation.jsp?orderId=" + orderId);
    } else {
        String errorMessage = "We're sorry, but there was an error processing your order.";
        Exception ex = (Exception) request.getAttribute("javax.servlet.error.exception");
        if (ex != null && ex instanceof SQLException) {
            errorMessage = ex.getMessage();
        }
        %>
        <div class="error-container">
            <h2 class="error-title">Order Processing Failed</h2>
            <p class="error-message"><%= errorMessage %></p>
            <p>Please try again or contact customer support if the problem persists.</p>
            <a href="checkout.jsp" class="btn">Back to Checkout</a>
        </div>
        <%
    }
%>
</body>
</html>