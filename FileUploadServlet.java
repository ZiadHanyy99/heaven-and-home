package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.io.File;

public class DB {

    private Connection connection;
    private Statement statement;
    private static final String DATABASE_URL = "jdbc:derby://localhost:1527/Heaven And Home3;create=true";
    private static final String DRIVER_CLASS = "org.apache.derby.jdbc.ClientDriver";

    public DB() {
        try {
            Class.forName(DRIVER_CLASS);
            connection = DriverManager.getConnection(DATABASE_URL);
            statement = connection.createStatement();

            // Create Customer table
            try {
                String CREATE_CUSTOMER_TABLE_SQL = """
                                                  CREATE TABLE Customer (
                                                      firstName VARCHAR(25),
                                                      lastName VARCHAR(25),
                                                      address VARCHAR(100),
                                                      email VARCHAR(25),
                                                      password VARCHAR(25),
                                                      PRIMARY KEY (email)
                                                  )
                                                  """;
                statement.executeUpdate(CREATE_CUSTOMER_TABLE_SQL);
                System.out.println("Customer table created successfully.");
            } catch (SQLException e) {
                if (e.getSQLState().equals("X0Y32")) {
                    System.out.println("Customer table already exists.");
                } else {
                    System.out.println("Error creating Customer table: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Create product table
            try {
                String CREATE_PRODUCT_TABLE_SQL = """
                                                 CREATE TABLE product (
                                                     ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
                                                     name VARCHAR(255),
                                                     type VARCHAR(100),
                                                     price INTEGER,
                                                     description VARCHAR(1000),
                                                     stock INTEGER,
                                                     image1 VARCHAR(255),
                                                     image2 VARCHAR(255),
                                                     image3 VARCHAR(255),
                                                     image4 VARCHAR(255),
                                                     image5 VARCHAR(255)
                                                 )
                                                 """;
                statement.executeUpdate(CREATE_PRODUCT_TABLE_SQL);
                System.out.println("product table created successfully.");
            } catch (SQLException e) {
                if (e.getSQLState().equals("X0Y32")) {
                    System.out.println("product table already exists.");
                } else {
                    System.out.println("Error creating product table: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Create order table
            try {
                String CREATE_ORDER_TABLE_SQL = """
                                              CREATE TABLE "order" (
                                                   ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
                                                   CUSTOMER_EMAIL VARCHAR(25) NOT NULL,
                                                   ORDER_DATE TIMESTAMP NOT NULL,
                                                   TOTAL_AMOUNT INTEGER NOT NULL,
                                                   PAYMENT_METHOD VARCHAR(10) NOT NULL,
                                                   PRIMARY KEY (ID),
                                                   FOREIGN KEY (CUSTOMER_EMAIL) REFERENCES Customer(email)
                                               )
                                               """;
                statement.executeUpdate(CREATE_ORDER_TABLE_SQL);
                System.out.println("order table created successfully.");
            } catch (SQLException e) {
                if (e.getSQLState().equals("X0Y32")) {
                    System.out.println("order table already exists.");
                } else {
                    System.out.println("Error creating order table: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Create order_items table
            try {
                String CREATE_ORDER_ITEMS_TABLE_SQL = """
                                                    CREATE TABLE order_items (
                                                         ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
                                                         order_id INTEGER NOT NULL,
                                                         product_id INTEGER NOT NULL,
                                                         quantity INTEGER NOT NULL,
                                                         PRIMARY KEY (ID),
                                                         FOREIGN KEY (order_id) REFERENCES "order"(ID),
                                                         FOREIGN KEY (product_id) REFERENCES product(ID)
                                                     )
                                                     """;
                statement.executeUpdate(CREATE_ORDER_ITEMS_TABLE_SQL);
                System.out.println("order_items table created successfully.");
            } catch (SQLException e) {
                if (e.getSQLState().equals("X0Y32")) {
                    System.out.println("order_items table already exists.");
                } else {
                    System.out.println("Error creating order_items table: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Create cart_items table
            try {
                String CREATE_CART_ITEMS_TABLE_SQL = """
                                                    CREATE TABLE cart_items (
                                                        ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
                                                        customer_email VARCHAR(25),
                                                        product_id INTEGER,
                                                        quantity INTEGER,
                                                        FOREIGN KEY (customer_email) REFERENCES Customer(email),
                                                        FOREIGN KEY (product_id) REFERENCES product(ID)
                                                    )
                                                    """;
                statement.executeUpdate(CREATE_CART_ITEMS_TABLE_SQL);
                System.out.println("cart_items table created successfully.");
            } catch (SQLException e) {
                if (e.getSQLState().equals("X0Y32")) {
                    System.out.println("cart_items table already exists.");
                } else {
                    System.out.println("Error creating cart_items table: " + e.getMessage());
                    e.printStackTrace();
                }
            }

        } catch (SQLException e) {
            System.out.println("Database error occurred: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.out.println("Database driver not found: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, statement, connection);
        }
    }

    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) {
                conn.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Ensures image paths are correctly formatted for web display
     */
    private String fixImagePath(String imagePath) {
        if (imagePath == null || imagePath.trim().isEmpty()) {
            return "";
        }
        
        System.out.println("Original image path: " + imagePath);
        
        if (imagePath.startsWith("http://") || imagePath.startsWith("https://")) {
            return imagePath;
        }
        
        while (imagePath.startsWith("/")) {
            imagePath = imagePath.substring(1);
        }
        
        if (!imagePath.startsWith("images/")) {
            imagePath = "images/" + imagePath;
        }
        
        System.out.println("Fixed image path: " + imagePath);
        
        return imagePath;
    }

    // User-related methods (unchanged)
    public int storeUser(Customer u) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String SQL_STMT = "INSERT INTO Customer (firstName, lastName, address, email, password) VALUES (?,?,?,?,?)";
            pstmt = connection.prepareStatement(SQL_STMT);

            pstmt.setString(1, u.getFirstName());
            pstmt.setString(2, u.getLastName());
            pstmt.setString(3, u.getAddress());
            pstmt.setString(4, u.getEmail());
            pstmt.setString(5, u.getPassword());

            int result = pstmt.executeUpdate();
            System.out.println("Inserted user: " + u.getEmail() + ", Rows affected: " + result);
            return result;
        } catch (SQLException e) {
            System.out.println("Database error occurred while storing user: " + e.getMessage());
            e.printStackTrace();
            return 0;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }

    public Customer loginUser(String email, String password) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String getUserQuery = "SELECT * FROM Customer WHERE email = ? AND password = ?";
            pstmt = connection.prepareStatement(getUserQuery);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setFirstName(rs.getString("firstName"));
                customer.setLastName(rs.getString("lastName"));
                customer.setAddress(rs.getString("address"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                System.out.println("User logged in: " + email);
                return customer;
            }
        } catch (SQLException e) {
            System.out.println("Database error while logging in user: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return null;
    }

    public ArrayList<Customer> getAllUsers() {
        ArrayList<Customer> users = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT firstName, lastName, address, email FROM Customer";
            pstmt = connection.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setFirstName(rs.getString("firstName"));
                customer.setLastName(rs.getString("lastName"));
                customer.setAddress(rs.getString("address"));
                customer.setEmail(rs.getString("email"));
                users.add(customer);
            }
            System.out.println("Fetched " + users.size() + " users from database.");
        } catch (SQLException e) {
            System.out.println("Error fetching users: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return users;
    }

    public Customer getUserDetails(String email) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT * FROM Customer WHERE email = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Customer user = new Customer();
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                System.out.println("Fetched user details for: " + email);
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error getting user details for " + email + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return new Customer();
    }

    public boolean updateUser(Customer u) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String updateQuery = "UPDATE Customer SET firstName = ?, lastName = ?, address = ?, password = ? WHERE email = ?";
            pstmt = connection.prepareStatement(updateQuery);
            pstmt.setString(1, u.getFirstName());
            pstmt.setString(2, u.getLastName());
            pstmt.setString(3, u.getAddress());
            pstmt.setString(4, u.getPassword() != null ? u.getPassword() : "");
            pstmt.setString(5, u.getEmail());
            int rowsUpdated = pstmt.executeUpdate();
            System.out.println("Updated user: " + u.getEmail() + ", Rows affected: " + rowsUpdated);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Error updating user " + u.getEmail() + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }

    public boolean deleteUser(String email) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String deleteQuery = "DELETE FROM Customer WHERE email = ?";
            pstmt = connection.prepareStatement(deleteQuery);
            pstmt.setString(1, email);
            int rowsDeleted = pstmt.executeUpdate();
            System.out.println("Deleted user: " + email + ", Rows affected: " + rowsDeleted);
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }

    // Product-related methods (unchanged)
    public int storeProduct(Product p) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String SQL_STMT = "INSERT INTO product (name, type, price, description, stock, image1, image2, image3, image4, image5) VALUES (?,?,?,?,?,?,?,?,?,?)";
            pstmt = connection.prepareStatement(SQL_STMT);

            pstmt.setString(1, p.getName());
            pstmt.setString(2, p.getType());
            pstmt.setInt(3, p.getPrice());
            pstmt.setString(4, p.getDescription());
            pstmt.setInt(5, p.getStock());
            
            pstmt.setString(6, normalizePathForStorage(p.getImage1()));
            pstmt.setString(7, normalizePathForStorage(p.getImage2()));
            pstmt.setString(8, normalizePathForStorage(p.getImage3()));
            pstmt.setString(9, normalizePathForStorage(p.getImage4()));
            pstmt.setString(10, normalizePathForStorage(p.getImage5()));

            int result = pstmt.executeUpdate();
            System.out.println("Inserted product: " + p.getName() + ", Rows affected: " + result);
            return result;
        } catch (SQLException e) {
            System.out.println("Database error occurred while storing product: " + e.getMessage());
            e.printStackTrace();
            return 0;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }
    
    private String normalizePathForStorage(String path) {
        if (path == null || path.trim().isEmpty()) {
            return null;
        }
        
        while (path.startsWith("/")) {
            path = path.substring(1);
        }
        
        if (path.startsWith("http://") || path.startsWith("https://")) {
            return path;
        }
        
        if (path.startsWith("images/")) {
            return path;
        }
        
        return "images/" + path;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT * FROM product";
            pstmt = connection.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setName(rs.getString("name"));
                product.setType(rs.getString("type"));
                product.setPrice(rs.getInt("price"));
                product.setDescription(rs.getString("description"));
                product.setStock(rs.getInt("stock"));
                
                product.setImage1(fixImagePath(rs.getString("image1")));
                product.setImage2(fixImagePath(rs.getString("image2")));
                product.setImage3(fixImagePath(rs.getString("image3")));
                product.setImage4(fixImagePath(rs.getString("image4")));
                product.setImage5(fixImagePath(rs.getString("image5")));
                
                products.add(product);
            }
            System.out.println("Fetched " + products.size() + " products from database.");
        } catch (SQLException e) {
            System.out.println("Error fetching products: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return products;
    }

    public Product getProductDetails(int id) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT * FROM product WHERE ID = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setName(rs.getString("name"));
                product.setType(rs.getString("type"));
                product.setPrice(rs.getInt("price"));
                product.setDescription(rs.getString("description"));
                product.setStock(rs.getInt("stock"));
                
                product.setImage1(fixImagePath(rs.getString("image1")));
                product.setImage2(fixImagePath(rs.getString("image2")));
                product.setImage3(fixImagePath(rs.getString("image3")));
                product.setImage4(fixImagePath(rs.getString("image4")));
                product.setImage5(fixImagePath(rs.getString("image5")));
                
                System.out.println("Fetched product details for ID: " + id);
                return product;
            }
        } catch (SQLException e) {
            System.out.println("Error getting product details for ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return new Product();
    }

    public boolean updateProduct(Product p) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String updateQuery = "UPDATE product SET name = ?, type = ?, price = ?, description = ?, stock = ?, image1 = ?, image2 = ?, image3 = ?, image4 = ?, image5 = ? WHERE ID = ?";
            pstmt = connection.prepareStatement(updateQuery);
            pstmt.setString(1, p.getName());
            pstmt.setString(2, p.getType());
            pstmt.setInt(3, p.getPrice());
            pstmt.setString(4, p.getDescription());
            pstmt.setInt(5, p.getStock());
            
            pstmt.setString(6, normalizePathForStorage(p.getImage1()));
            pstmt.setString(7, normalizePathForStorage(p.getImage2()));
            pstmt.setString(8, normalizePathForStorage(p.getImage3()));
            pstmt.setString(9, normalizePathForStorage(p.getImage4()));
            pstmt.setString(10, normalizePathForStorage(p.getImage5()));
            
            pstmt.setInt(11, p.getId());
            int rowsUpdated = pstmt.executeUpdate();
            System.out.println("Updated product ID: " + p.getId() + ", Rows affected: " + rowsUpdated);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Error updating product ID " + p.getId() + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }

    public boolean deleteProduct(int id) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String deleteQuery = "DELETE FROM product WHERE ID = ?";
            pstmt = connection.prepareStatement(deleteQuery);
            pstmt.setInt(1, id);
            int rowsDeleted = pstmt.executeUpdate();
            System.out.println("Deleted product ID: " + id + ", Rows affected: " + rowsDeleted);
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting product ID " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }
    
    public List<Product> getProductsByType(String type) {
        List<Product> products = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT * FROM product WHERE type = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, type);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setName(rs.getString("name"));
                product.setType(rs.getString("type"));
                product.setPrice(rs.getInt("price"));
                product.setDescription(rs.getString("description"));
                product.setStock(rs.getInt("stock"));
                
                product.setImage1(fixImagePath(rs.getString("image1")));
                product.setImage2(fixImagePath(rs.getString("image2")));
                product.setImage3(fixImagePath(rs.getString("image3")));
                product.setImage4(fixImagePath(rs.getString("image4")));
                product.setImage5(fixImagePath(rs.getString("image5")));
                
                products.add(product);
            }
            System.out.println("Fetched " + products.size() + " products of type: " + type);
        } catch (SQLException e) {
            System.out.println("Error fetching products by type: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return products;
    }
    
    // Cart-related methods (unchanged)
    public boolean addToCart(String customerEmail, int productId, int quantity) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            
            String checkQuery = "SELECT quantity FROM cart_items WHERE customer_email = ? AND product_id = ?";
            pstmt = connection.prepareStatement(checkQuery);
            pstmt.setString(1, customerEmail);
            pstmt.setInt(2, productId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                int newQuantity = currentQuantity + quantity;
                
                closeResources(rs, pstmt, null);
                
                String updateQuery = "UPDATE cart_items SET quantity = ? WHERE customer_email = ? AND product_id = ?";
                pstmt = connection.prepareStatement(updateQuery);
                pstmt.setInt(1, newQuantity);
                pstmt.setString(2, customerEmail);
                pstmt.setInt(3, productId);
                
                int rowsUpdated = pstmt.executeUpdate();
                System.out.println("Updated cart item quantity for product ID: " + productId + ", Rows affected: " + rowsUpdated);
                return rowsUpdated > 0;
            } else {
                closeResources(rs, pstmt, null);
                
                String insertQuery = "INSERT INTO cart_items (customer_email, product_id, quantity) VALUES (?, ?, ?)";
                pstmt = connection.prepareStatement(insertQuery);
                pstmt.setString(1, customerEmail);
                pstmt.setInt(2, productId);
                pstmt.setInt(3, quantity);
                
                int rowsInserted = pstmt.executeUpdate();
                System.out.println("Added product ID: " + productId + " to cart, Rows affected: " + rowsInserted);
                return rowsInserted > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error adding product to cart: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(rs, pstmt, connection);
        }
    }
    
    public boolean removeFromCart(String customerEmail, int productId) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String deleteQuery = "DELETE FROM cart_items WHERE customer_email = ? AND product_id = ?";
            pstmt = connection.prepareStatement(deleteQuery);
            pstmt.setString(1, customerEmail);
            pstmt.setInt(2, productId);
            
            int rowsDeleted = pstmt.executeUpdate();
            System.out.println("Removed product ID: " + productId + " from cart, Rows affected: " + rowsDeleted);
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.out.println("Error removing product from cart: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }
    
    public List<CartItem> getCartItems(String customerEmail) {
        List<CartItem> cartItems = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = """
                          SELECT c.product_id, c.quantity, p.name, p.price, p.image1 
                          FROM cart_items c 
                          JOIN product p ON c.product_id = p.ID 
                          WHERE c.customer_email = ?
                          """;
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, customerEmail);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("name"));
                item.setPrice(rs.getInt("price"));
                item.setImagePath(fixImagePath(rs.getString("image1")));
                
                cartItems.add(item);
            }
            System.out.println("Fetched " + cartItems.size() + " cart items for customer: " + customerEmail);
        } catch (SQLException e) {
            System.out.println("Error fetching cart items: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return cartItems;
    }
    
    public int getCartItemCount(String customerEmail) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT SUM(quantity) as total FROM cart_items WHERE customer_email = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, customerEmail);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error getting cart item count: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, connection);
        }
        return 0;
    }
    
    public boolean clearCart(String customerEmail) {
        PreparedStatement pstmt = null;
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String deleteQuery = "DELETE FROM cart_items WHERE customer_email = ?";
            pstmt = connection.prepareStatement(deleteQuery);
            pstmt.setString(1, customerEmail);
            
            int rowsDeleted = pstmt.executeUpdate();
            System.out.println("Cleared cart for customer: " + customerEmail + ", Rows affected: " + rowsDeleted);
            return true;
        } catch (SQLException e) {
            System.out.println("Error clearing cart: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, connection);
        }
    }
    // Add these methods to your existing DB.java file

    /**
     * Get all orders
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT o.ID, o.CUSTOMER_EMAIL, o.ORDER_DATE, o.TOTAL_AMOUNT, o.PAYMENT_METHOD, " +
                          "c.firstName, c.lastName, c.address " +
                          "FROM \"order\" o " +
                          "JOIN Customer c ON o.CUSTOMER_EMAIL = c.email " +
                          "ORDER BY o.ORDER_DATE DESC";
            pstmt = connection.prepareStatement(query);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("ID"));
                order.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                order.setOrderDate(rs.getTimestamp("ORDER_DATE"));
                order.setTotalAmount(rs.getInt("TOTAL_AMOUNT"));
                order.setPaymentMethod(rs.getString("PAYMENT_METHOD"));
                order.setCustomerFirstName(rs.getString("firstName"));
                order.setCustomerLastName(rs.getString("lastName"));
                order.setShippingAddress(rs.getString("address"));
                
                // Get order items
                order.setItems(getOrderItems(order.getId()));
                
                orders.add(order);
            }
            
            System.out.println("Fetched " + orders.size() + " orders from database.");
        } catch (SQLException e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        } finally {
            closeResources(rs, pstmt, connection);
        }
        
        return orders;
    }

    /**
     * Get order details by ID
     */
    public Order getOrderDetails(int orderId) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT o.ID, o.CUSTOMER_EMAIL, o.ORDER_DATE, o.TOTAL_AMOUNT, o.PAYMENT_METHOD, " +
                          "c.firstName, c.lastName, c.address " +
                          "FROM \"order\" o " +
                          "JOIN Customer c ON o.CUSTOMER_EMAIL = c.email " +
                          "WHERE o.ID = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("ID"));
                order.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                order.setOrderDate(rs.getTimestamp("ORDER_DATE"));
                order.setTotalAmount(rs.getInt("TOTAL_AMOUNT"));
                order.setPaymentMethod(rs.getString("PAYMENT_METHOD"));
                order.setCustomerFirstName(rs.getString("firstName"));
                order.setCustomerLastName(rs.getString("lastName"));
                order.setShippingAddress(rs.getString("address"));
                
                // Get order items
                order.setItems(getOrderItems(order.getId()));
                
                System.out.println("Fetched order details for ID: " + orderId);
                return order;
            }
        } catch (SQLException e) {
            System.out.println("Error getting order details for ID " + orderId + ": " + e.getMessage());
        } finally {
            closeResources(rs, pstmt, connection);
        }
        
        return null;
    }

    /**
     * Get order items for an order
     */
    private List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            connection = DriverManager.getConnection(DATABASE_URL);
            String query = "SELECT oi.ID, oi.order_id, oi.product_id, oi.quantity, " +
                          "p.name, p.price, p.image1 " +
                          "FROM order_items oi " +
                          "JOIN product p ON oi.product_id = p.ID " +
                          "WHERE oi.order_id = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("ID"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("name"));
                item.setProductPrice(rs.getInt("price"));
                
                // Fix image path if needed
                String imagePath = rs.getString("image1");
                if (imagePath != null && !imagePath.isEmpty()) {
                    item.setProductImage(fixImagePath(imagePath));
                }
                
                items.add(item);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order items: " + e.getMessage());
        } finally {
            closeResources(rs, pstmt, connection);
        }
        
        return items;
    }

    /**
     * Create a new order from cart items with payment method
     */
    public int createOrder(String customerEmail, String paymentMethod) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int orderId = -1;
        
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DATABASE_URL);
            conn.setAutoCommit(false);

            // Verify customer exists
            String checkCustomerSQL = "SELECT COUNT(*) FROM Customer WHERE email = ?";
            pstmt = conn.prepareStatement(checkCustomerSQL);
            pstmt.setString(1, customerEmail);
            rs = pstmt.executeQuery();
            if (!rs.next() || rs.getInt(1) == 0) {
                throw new SQLException("Customer email not found: " + customerEmail);
            }
            closeResources(rs, pstmt, null);

            // Get cart items
            List<CartItem> cartItems = getCartItems(customerEmail);
            if (cartItems.isEmpty()) {
                throw new SQLException("Cart is empty");
            }

            // Calculate total amount
            int totalAmount = 0;
            for (CartItem item : cartItems) {
                totalAmount += item.getSubtotal();
            }

            // Create order
            String insertOrderSQL = "INSERT INTO \"order\" (CUSTOMER_EMAIL, ORDER_DATE, TOTAL_AMOUNT, PAYMENT_METHOD) VALUES (?, CURRENT_TIMESTAMP, ?, ?)";
            pstmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, customerEmail);
            pstmt.setInt(2, totalAmount);
            pstmt.setString(3, paymentMethod);
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                    
                    // Add order items
                    for (CartItem item : cartItems) {
                        String insertItemSQL = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
                        pstmt = conn.prepareStatement(insertItemSQL);
                        pstmt.setInt(1, orderId);
                        pstmt.setInt(2, item.getProductId());
                        pstmt.setInt(3, item.getQuantity());
                        pstmt.executeUpdate();
                        
                        // Update product stock
                        updateProductStock(conn, item.getProductId(), item.getQuantity());
                    }
                    
                    // Clear the cart
                    clearCart(conn, customerEmail);
                }
            }
            
            conn.commit();
            System.out.println("Created order ID: " + orderId + " for customer: " + customerEmail);
            return orderId;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("Transaction rolled back due to: " + e.getMessage());
                } catch (SQLException ex) {
                    System.out.println("Error rolling back transaction: " + ex.getMessage());
                }
            }
            System.out.println("Error creating order: " + e.getMessage());
            return -1;
        } finally {
            closeResources(rs, pstmt, conn);
        }
    }

    /**
     * Update product stock within a transaction
     */
    private void updateProductStock(Connection conn, int productId, int quantity) throws SQLException {
        PreparedStatement pstmt = null;
        try {
            String updateSQL = "UPDATE product SET stock = stock - ? WHERE ID = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, productId);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }

    /**
     * Clear cart within a transaction
     */
    private boolean clearCart(Connection conn, String customerEmail) throws SQLException {
        PreparedStatement pstmt = null;
        try {
            String deleteQuery = "DELETE FROM cart_items WHERE customer_email = ?";
            pstmt = conn.prepareStatement(deleteQuery);
            pstmt.setString(1, customerEmail);
            int rowsDeleted = pstmt.executeUpdate();
            System.out.println("Cleared cart for customer: " + customerEmail + ", Rows affected: " + rowsDeleted);
            return true;
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }

    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }
    
}