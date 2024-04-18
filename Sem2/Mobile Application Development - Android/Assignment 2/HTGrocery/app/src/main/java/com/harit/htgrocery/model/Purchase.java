package com.harit.htgrocery.model;

public class Purchase {
    private int invoiceNumber;
    private int itemCode;
    private int qtyPurchased;
    private String dateOfPurchase;

    // Constructor
    public Purchase() {
    }

    public Purchase(int itemCode, int qtyPurchased, String dateOfPurchase) {
        this.itemCode = itemCode;
        this.qtyPurchased = qtyPurchased;
        this.dateOfPurchase = dateOfPurchase;
    }

    // Getters and Setters for each field
    public int getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(int invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public int getItemCode() {
        return itemCode;
    }

    public void setItemCode(int itemCode) {
        this.itemCode = itemCode;
    }

    public int getQtyPurchased() {
        return qtyPurchased;
    }

    public void setQtyPurchased(int qtyPurchased) {
        this.qtyPurchased = qtyPurchased;
    }

    public String getDateOfPurchase() {
        return dateOfPurchase;
    }

    public void setDateOfPurchase(String dateOfPurchase) {
        this.dateOfPurchase = dateOfPurchase;
    }
}
