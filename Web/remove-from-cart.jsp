<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="src.DB"%>
<jsp:useBean id="c" class="src.Customer" scope="session" />
<%
    // Check if user is logged in
    if (c == null || c.getEmail() == null || c.getEmail().isEmpty()) {
        response.sendRedirect("index.html");
        return;
    }
    
    // Get product ID from request
    int productId = 0;
    try {
        productId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect("cart.jsp");
        return;
    }
    
    // Remove product from cart
    DB db = new DB();
    boolean success = db.removeFromCart(c.getEmail(), productId);
    
    // Redirect back to cart
    response.sendRedirect("cart.jsp");
%>