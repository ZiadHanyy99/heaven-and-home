package src;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Insert", urlPatterns = {"/Insert"})
public class Insert extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        RequestDispatcher rd;

        String fn = request.getParameter("firstName");
        String ln = request.getParameter("lastName");
        String address = request.getParameter("address"); 
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Customer user = new Customer(fn, ln, address, email, password); 
        DB db = new DB();

        int value = db.storeUser(user); 

        if (value > 0) {
            // Registration successful -> Redirect to homepage
            rd = request.getRequestDispatcher("index.html");
            rd.forward(request, response);
        } else {
            // Registration failed -> Stay in signup page and show error
            rd = request.getRequestDispatcher("signUp.html");
            rd.include(request, response);

            out.println("<script>");
            out.println("document.getElementById('error-message').innerHTML = 'This email is used, please try again with another email';");
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
        return "Handles user registration with address";
    }
}
