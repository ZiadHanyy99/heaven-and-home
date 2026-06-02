package src;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("c");
        
        // Check if user is logged in
        if (customer == null || customer.getEmail() == null || customer.getEmail().isEmpty()) {
            response.sendRedirect("index.html");
            return;
        }
        
        // Get product ID and quantity from request
        int productId = 0;
        int quantity = 1;
        
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
            if (request.getParameter("quantity") != null) {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("home.jsp");
            return;
        }
        
        // Add product to cart
        DB db = new DB();
        boolean success = db.addToCart(customer.getEmail(), productId, quantity);
        
        // Redirect back to product page or cart
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("cart.jsp");
        }
    }
}
