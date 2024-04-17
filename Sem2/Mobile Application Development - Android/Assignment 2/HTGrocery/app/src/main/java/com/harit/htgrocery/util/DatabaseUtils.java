package com.harit.htgrocery.util;

public final class DatabaseUtils {

    // Database name
    public static String DBNAME = "HTGrocery.db";

    // Database version
    public static int VERSION = 1;

    // User table
    public static class User {
        public static final String TABLE_NAME = "User";
        public static final String COLUMN_USERNAME = "username";
        public static final String COLUMN_EMAIL = "emailId";
        public static final String COLUMN_PASSWORD = "password";
    }

    // Stock table
    public static class Stock {
        public static final String TABLE_NAME = "Stock";
        public static final String COLUMN_ITEM_CODE = "itemCode";
        public static final String COLUMN_ITEM_NAME = "itemName";
        public static final String COLUMN_QTY_STOCK = "qtyStock";
        public static final String COLUMN_PRICE = "price";
        public static final String COLUMN_TAXABLE = "taxable";
    }

    // Sales table
    public static class Sales {
        public static final String TABLE_NAME = "Sales";
        public static final String COLUMN_ORDER_NO = "orderNumber";
        public static final String COLUMN_ITEM_CODE = "itemCode";
        public static final String COLUMN_CUSTOMER_NAME = "customerName";
        public static final String COLUMN_CUSTOMER_EMAIL = "customerEmail";
        public static final String COLUMN_QTY_SOLD = "qtySold";
        public static final String COLUMN_DATE_OF_SALES = "dateOfSales";
    }

    // Purchase table
    public static class Purchase {
        public static final String TABLE_NAME = "Purchase";
        public static final String COLUMN_INVOICE_NUMBER = "invoiceNumber";
        public static final String COLUMN_ITEM_CODE = "itemCode";
        public static final String COLUMN_QTY_PURCHASED = "qtyPurchased";
        public static final String COLUMN_DATE_OF_PURCHASE = "dateOfPurchase";
    }
}
