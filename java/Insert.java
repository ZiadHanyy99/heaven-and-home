package src;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Mahmoud Khaled
 */
@WebServlet(name = "home", urlPatterns = {"/home"})
public class home extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DB db = new DB();
        RequestDispatcher rd;
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Customer customer = db.loginUser(email, password);

        PrintWriter out = response.getWriter();
        if (customer != null) {
            // Store the customer object in the session
            HttpSession session = request.getSession();
            session.setAttribute("c", customer);
            
            if ("admin@gmail.com".equals(email) && "Admin1234@".equals(password)) {
                rd = request.getRequestDispatcher("admin.jsp");
            } else {
                rd = request.getRequestDispatcher("home.jsp");
            }
            rd.forward(request, response);
        } else {
            rd = request.getRequestDispatcher("index.html");
            rd.include(request, response);
            
            out.println("<script>");
            out.println("document.getElementById('error-message').innerHTML = '<p style=\"color: red; font-size: 16px; margin-top: 20px;\">Invalid Email or Password</p>'; ");
            out.println("</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
