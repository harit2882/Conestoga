package com.harit.htgrocery.model;


public class Stock {

    private int itemCode;
    private String itemName;
    private int qtyStock;
    private float price;
    private boolean taxable;

    // Constructor with all fields
    public Stock(int itemCode, String itemName, int qtyStock, float price, boolean taxable) {
        this.itemCode = itemCode;
        this.itemName = itemName;
        this.qtyStock = qtyStock;
        this.price = price;
        this.taxable = taxable;
    }

    // Constructor without itemCode
    public Stock(String itemName, int qtyStock, float price, boolean taxable) {
        this.itemName = itemName;
        this.qtyStock = qtyStock;
        this.price = price;
        this.taxable = taxable;
    }

    public Stock(){

    }

    // Getters and setters for each field
    public int getItemCode() {
        return itemCode;
    }

    public void setItemCode(int itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getQtyStock() {
        return qtyStock;
    }

    public void setQtyStock(int qtyStock) {
        this.qtyStock = qtyStock;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public boolean isTaxable() {
        return taxable;
    }

    public void setTaxable(boolean taxable) {
        this.taxable = taxable;
    }

    // Override toString() method to provide a string representation of the Stock object
    @Override
    public String toString() {
        return "Stock{" +
                "itemCode=" + itemCode +
                ", itemName='" + itemName + '\'' +
                ", qtyStock=" + qtyStock +
                ", price=" + price +
                ", taxable=" + taxable +
                '}';
    }
}
