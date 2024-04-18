package com.harit.htgrocery.model;

public class Sales {
    private int orderNumber;
    private int itemCode;
    private String customerName;
    private String customerEmail;
    private int qtySold;
    private String dateOfSales;

    // Default constructor
    public Sales() {
    }

    // Parameterized constructor
    public Sales(int orderNumber, int itemCode, String customerName, String customerEmail, int qtySold,String dateOfSales) {
        this.orderNumber = orderNumber;
        this.itemCode = itemCode;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.qtySold = qtySold;
        this.dateOfSales = dateOfSales;
    }

    // Getter and Setter methods

    public int getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(int orderNumber) {
        this.orderNumber = orderNumber;
    }

    public int getItemCode() {
        return itemCode;
    }

    public void setItemCode(int itemCode) {
        this.itemCode = itemCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public int getQtySold() {
        return qtySold;
    }

    public void setQtySold(int qtySold) {
        this.qtySold = qtySold;
    }

    public String getDateOfSales() {
        return dateOfSales;
    }

    public void setDateOfSales(String dateOfSales) {
        this.dateOfSales = dateOfSales;
    }

    @Override
    public String toString() {
        return "Sales{" +
                "orderNumber=" + orderNumber +
                ", itemCode=" + itemCode +
                ", customerName='" + customerName + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", qtySold=" + qtySold +
                ", dateOfSales=" + dateOfSales +
                '}';
    }
}
