package model;

public class OrderResult {
    private int result;
    private int orderId;

    public OrderResult(int result, int orderId) {
        this.result = result;
        this.orderId = orderId;
    }

    public int getResult() {
        return result;
    }

    public int getOrderId() {
        return orderId;
    }
}

