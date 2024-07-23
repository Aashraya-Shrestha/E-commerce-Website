package model;

import java.util.Date;

public class OrderHistoryModel {
    private int orderId;
    private Date datePlaced;
    private String deliveryAddress;
    private int totalQuantity;
    private double totalPrice;

    public OrderHistoryModel(int orderId, Date datePlaced, String deliveryAddress, int totalQuantity, double totalPrice) {
        this.orderId = orderId;
        this.datePlaced = datePlaced;
        this.deliveryAddress = deliveryAddress;
        this.totalQuantity = totalQuantity;
        this.totalPrice = totalPrice;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getDatePlaced() {
        return datePlaced;
    }

    public void setDatePlaced(Date datePlaced) {
        this.datePlaced = datePlaced;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
