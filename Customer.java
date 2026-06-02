/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package src;

import java.io.Serializable;

/**
 *
 * @author Mahmoud Khaled
 */


public class CartItem implements Serializable {
    private int productId;
    private int quantity;
    private String productName;
    private int price;
    private String imagePath;
    
    public CartItem() {
    }
    
    public CartItem(int productId, int quantity, String productName, int price, String imagePath) {
        this.productId = productId;
        this.quantity = quantity;
        this.productName = productName;
        this.price = price;
        this.imagePath = imagePath;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public int getSubtotal() {
        return price * quantity;
    }
}