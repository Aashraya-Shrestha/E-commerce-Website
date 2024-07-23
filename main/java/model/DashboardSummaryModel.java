package model;

public class DashboardSummaryModel {
    private int totalUsers;
    private int totalProducts;
    private double totalSales;
    private int totalOrders;

    // Constructor
    public DashboardSummaryModel(int totalUsers, int totalProducts, double totalSales, int totalOrders) {
        this.totalUsers = totalUsers;
        this.totalProducts = totalProducts;
        this.totalSales = totalSales;
        this.totalOrders = totalOrders;
    }

    public DashboardSummaryModel() {};
    // Getters and Setters
    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getTotalProducts() {
        return totalProducts;
    }

    public void setTotalProducts(int totalProducts) {
        this.totalProducts = totalProducts;
    }

    public double getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(double totalSales) {
        this.totalSales = totalSales;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }
}
