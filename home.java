package src;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.nio.file.*;

@WebServlet("/FileUploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class FileUploadServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the file part from the request
        Part filePart = request.getPart("file");
        String fileName = getSubmittedFileName(filePart);
        
        if (fileName == null || fileName.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No file selected");
            return;
        }
        
        // Generate a unique filename to prevent overwriting
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        
        // Define the upload directory
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Create directory and any parent directories
        }
        
        // Log the upload directory for debugging
        System.out.println("Upload directory: " + uploadPath);
        System.out.println("Directory exists: " + uploadDir.exists());
        
        try {
            // Save the file to the server
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);
            
            // Log file information for debugging
            System.out.println("File uploaded to: " + filePath);
            System.out.println("File size: " + filePart.getSize() + " bytes");
            System.out.println("File exists after upload: " + new File(filePath).exists());
            
            // Return the web-accessible path to the client
            // This is the key change - return a path that will work in HTML
            String webPath = "images/" + uniqueFileName;
            System.out.println("Web path returned: " + webPath);
            
            response.setContentType("text/plain");
            response.getWriter().write(webPath);
        } catch (Exception e) {
            System.out.println("Error uploading file: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error uploading file: " + e.getMessage());
        }
    }
    
    // Helper method to get the submitted file name
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
}