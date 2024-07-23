package model;

public class CustomerOrder {
    private String customerName;
    private String contactNumber;

    // Constructors
    public CustomerOrder() {
    }

    public CustomerOrder(String customerName, String contactNumber) {
        this.customerName = customerName;
        this.contactNumber = contactNumber;
    }

    // Getters and setters
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
}
