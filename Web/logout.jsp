<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();
    
    // Redirect to the login page
    response.sendRedirect("index.html");
%>