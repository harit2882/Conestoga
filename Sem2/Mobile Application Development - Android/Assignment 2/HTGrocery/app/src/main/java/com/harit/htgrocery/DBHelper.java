package com.harit.htgrocery;

import static com.harit.htgrocery.util.DatabaseUtils.User.TABLE_NAME;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

import com.harit.htgrocery.model.Purchase;
import com.harit.htgrocery.model.Sales;
import com.harit.htgrocery.model.Stock;
import com.harit.htgrocery.model.User;
import com.harit.htgrocery.util.DatabaseUtils;

import java.util.ArrayList;
import java.util.List;

public class DBHelper extends SQLiteOpenHelper {

    // Constructor
    public DBHelper(@Nullable Context context) {
        super(context, DatabaseUtils.DBNAME, null, DatabaseUtils.VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // Creating Users table
        String createUsersTable = "CREATE TABLE " + TABLE_NAME + " ("
                + DatabaseUtils.User.COLUMN_EMAIL + " TEXT PRIMARY KEY, "
                + DatabaseUtils.User.COLUMN_USERNAME + " TEXT, "
                + DatabaseUtils.User.COLUMN_PASSWORD + " TEXT);";
        db.execSQL(createUsersTable);

        // Creating Stock table
        String createStockTable = "CREATE TABLE " + DatabaseUtils.Stock.TABLE_NAME + " ("
                + DatabaseUtils.Stock.COLUMN_ITEM_CODE + " INTEGER PRIMARY KEY AUTOINCREMENT, "
                + DatabaseUtils.Stock.COLUMN_ITEM_NAME + " TEXT, "
                + DatabaseUtils.Stock.COLUMN_QTY_STOCK + " INTEGER, "
                + DatabaseUtils.Stock.COLUMN_PRICE + " FLOAT, "
                + DatabaseUtils.Stock.COLUMN_TAXABLE + " BOOLEAN);";
        db.execSQL(createStockTable);

        // Creating Sales table
        String createSalesTable = "CREATE TABLE " + DatabaseUtils.Sales.TABLE_NAME + " ("
                + DatabaseUtils.Sales.COLUMN_ORDER_NO + " INTEGER PRIMARY KEY AUTOINCREMENT, "
                + DatabaseUtils.Sales.COLUMN_ITEM_CODE + " INTEGER, "
                + DatabaseUtils.Sales.COLUMN_CUSTOMER_NAME + " TEXT, "
                + DatabaseUtils.Sales.COLUMN_CUSTOMER_EMAIL + " TEXT, "
                + DatabaseUtils.Sales.COLUMN_QTY_SOLD + " INTEGER, "
                + DatabaseUtils.Sales.COLUMN_DATE_OF_SALES + " DATE, "
                + "FOREIGN KEY (" + DatabaseUtils.Sales.COLUMN_ITEM_CODE + ") "
                + "REFERENCES " + DatabaseUtils.Stock.TABLE_NAME + "(" + DatabaseUtils.Stock.COLUMN_ITEM_CODE + "));";
        db.execSQL(createSalesTable);

        // Creating Purchase table
        String createPurchaseTable = "CREATE TABLE " + DatabaseUtils.Purchase.TABLE_NAME + " ("
                + DatabaseUtils.Purchase.COLUMN_INVOICE_NUMBER + " INTEGER PRIMARY KEY AUTOINCREMENT, "
                + DatabaseUtils.Purchase.COLUMN_ITEM_CODE + " INTEGER, "
                + DatabaseUtils.Purchase.COLUMN_QTY_PURCHASED + " INTEGER, "
                + DatabaseUtils.Purchase.COLUMN_DATE_OF_PURCHASE + " DATE);";
        db.execSQL(createPurchaseTable);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        db.execSQL("DROP TABLE IF EXISTS " + DatabaseUtils.Stock.TABLE_NAME);
        db.execSQL("DROP TABLE IF EXISTS " + DatabaseUtils.Sales.TABLE_NAME);
        db.execSQL("DROP TABLE IF EXISTS " + DatabaseUtils.Purchase.TABLE_NAME);
        onCreate(db);
    }

    public Boolean insertUser(User user) {

        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        // Add user details
        cv.put(DatabaseUtils.User.COLUMN_USERNAME, user.getUsername());
        cv.put(DatabaseUtils.User.COLUMN_EMAIL, user.getEmailId());
        cv.put(DatabaseUtils.User.COLUMN_PASSWORD, user.getPassword());

        long result = db.insert(TABLE_NAME, null, cv);
        return (result != -1);
    }

    public Boolean existsUser(User user) {
        SQLiteDatabase db = this.getReadableDatabase();

        // Columns to retrieve
        String[] columns = {DatabaseUtils.User.COLUMN_EMAIL};

        String selection = DatabaseUtils.User.COLUMN_EMAIL + " = ?";

        // Selection arguments
        String[] selectionArgs = {user.getEmailId()};

        // Query the database
        Cursor cursor = db.query(
                TABLE_NAME,
                columns,
                selection,
                selectionArgs,
                null,
                null,
                null
        );

        // Check if any rows were returned
        boolean exists = cursor.getCount() > 0;

        cursor.close();
        // Return whether the user exists
        return exists;
    }

    public boolean checkUserCredentials(User user) {
        SQLiteDatabase db = this.getReadableDatabase();

        // Define the columns to retrieve
        String[] columns = {DatabaseUtils.User.COLUMN_EMAIL};

        // Selection criteria
        String selection = DatabaseUtils.User.COLUMN_EMAIL + " = ? AND " +
                DatabaseUtils.User.COLUMN_USERNAME + " = ? AND " +
                DatabaseUtils.User.COLUMN_PASSWORD + " = ?";

        // Selection arguments
        String[] selectionArgs = {user.getEmailId(), user.getUsername(), user.getPassword()};

        // Query the database
        Cursor cursor = db.query(
                TABLE_NAME,
                columns,
                selection,
                selectionArgs,
                null,
                null,
                null
        );

        // Checking if any rows were returned
        boolean credentialsValid = cursor.getCount() > 0;

        // Closing the cursor
        cursor.close();

        // Return result
        return credentialsValid;
    }

    public Boolean insertStock(Stock stock) {

        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        // Add stock details
        cv.put(DatabaseUtils.Stock.COLUMN_ITEM_NAME, stock.getItemName());
        cv.put(DatabaseUtils.Stock.COLUMN_PRICE, stock.getPrice());
        cv.put(DatabaseUtils.Stock.COLUMN_QTY_STOCK, stock.getQtyStock());
        cv.put(DatabaseUtils.Stock.COLUMN_TAXABLE, stock.isTaxable());

        long result = db.insert(DatabaseUtils.Stock.TABLE_NAME, null, cv);
        return (result != -1);
    }

    public Boolean insertSales(Sales sales) {

        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        cv.put(DatabaseUtils.Sales.COLUMN_ITEM_CODE, sales.getItemCode());
        cv.put(DatabaseUtils.Sales.COLUMN_CUSTOMER_NAME, sales.getCustomerName());
        cv.put(DatabaseUtils.Sales.COLUMN_CUSTOMER_EMAIL, sales.getCustomerEmail());
        cv.put(DatabaseUtils.Sales.COLUMN_QTY_SOLD, sales.getQtySold());
        cv.put(DatabaseUtils.Sales.COLUMN_DATE_OF_SALES, sales.getDateOfSales().toString());

        long result = db.insert(DatabaseUtils.Sales.TABLE_NAME, null, cv);
        // If insert was successful, then update the stock quantity
        if (result != -1) {
            updateStockQty(sales.getItemCode(), sales.getQtySold());
            return true;
        }

        return false;
    }

    // Method to check if there is sufficient quantity in stock
    public boolean isSufficientStockAvailable(int itemCode, int qtySold) {
        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery(
                "SELECT " + DatabaseUtils.Stock.COLUMN_QTY_STOCK + " FROM " + DatabaseUtils.Stock.TABLE_NAME +
                        " WHERE " + DatabaseUtils.Stock.COLUMN_ITEM_CODE + " = ?",
                new String[]{String.valueOf(itemCode)}
        );

        if (cursor.moveToFirst()) {
            int availableQty = cursor.getInt(0);
            cursor.close();

            // Check if the available quantity is sufficient
            return availableQty >= qtySold;
        }

        cursor.close();
        return false;
    }

    // Method to check if an item code exists in the stock
    public boolean doesItemCodeExist(int itemCode) {
        SQLiteDatabase db = this.getReadableDatabase();

        // Columns to retrieve
        String[] columns = {DatabaseUtils.Stock.COLUMN_ITEM_CODE};

        // Selection criteria
        String selection = DatabaseUtils.Stock.COLUMN_ITEM_CODE + " = ?";

        // Selection arguments
        String[] selectionArgs = {String.valueOf(itemCode)};

        // Query
        Cursor cursor = db.query(
                DatabaseUtils.Stock.TABLE_NAME,
                columns,
                selection,
                selectionArgs,
                null,
                null,
                null
        );

        // Check if any rows were returned
        boolean exists = cursor.getCount() > 0;

        // Close cursor
        cursor.close();

        // Return whether the item code exists
        return exists;
    }

    public boolean updateStockQty(int itemCode, int qtySold) {
        SQLiteDatabase db = this.getWritableDatabase();

        String query = "UPDATE " + DatabaseUtils.Stock.TABLE_NAME +
                " SET " + DatabaseUtils.Stock.COLUMN_QTY_STOCK + " = " + DatabaseUtils.Stock.COLUMN_QTY_STOCK + " - ? " +
                "WHERE " + DatabaseUtils.Stock.COLUMN_ITEM_CODE + " = ?";

        // Executing the SQL query
        db.execSQL(query, new Object[]{qtySold, itemCode});

        // Check if any rows were updated
        Cursor cursor = db.rawQuery("SELECT changes()", null);
        cursor.moveToFirst();
        int changes = cursor.getInt(0);
        cursor.close();

        // Return true if the update
        return changes > 0;
    }

    public Boolean insertPurchase(Purchase purchase) {

        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();
        cv.put(DatabaseUtils.Sales.COLUMN_ITEM_CODE, purchase.getItemCode());
        cv.put(DatabaseUtils.Sales.COLUMN_QTY_SOLD, purchase.getQtyPurchased());
        cv.put(DatabaseUtils.Sales.COLUMN_DATE_OF_SALES, purchase.getDateOfPurchase().toString());

        long result = db.insert(DatabaseUtils.Sales.TABLE_NAME, null, cv);
        // If insert was successful, update the stock quantity
        if (result != -1) {
            updateStockQtyPurchased(purchase.getItemCode(), purchase.getQtyPurchased());
            return true;
        }
        return false;
    }

    public boolean updateStockQtyPurchased(int itemCode, int qtyPurchased) {
        SQLiteDatabase db = this.getWritableDatabase();

        // SQL query to increment the stock quantity
        String query = "UPDATE " + DatabaseUtils.Stock.TABLE_NAME +
                " SET " + DatabaseUtils.Stock.COLUMN_QTY_STOCK + " = " + DatabaseUtils.Stock.COLUMN_QTY_STOCK + " + ? " +
                "WHERE " + DatabaseUtils.Stock.COLUMN_ITEM_CODE + " = ?";

        // Execute the SQL query
        db.execSQL(query, new Object[]{qtyPurchased, itemCode});

        // Checking if any rows were updated
        Cursor cursor = db.rawQuery("SELECT changes()", null);
        cursor.moveToFirst();
        int changes = cursor.getInt(0);
        cursor.close();

        // Return true if the update
        return changes > 0;
    }

    public Stock searchItemById(int itemCode) {

        // Get a readable database instance
        SQLiteDatabase db = this.getReadableDatabase();

        // Columns to retrieve
        String[] columns = {
                DatabaseUtils.Stock.COLUMN_ITEM_CODE,
                DatabaseUtils.Stock.COLUMN_ITEM_NAME,
                DatabaseUtils.Stock.COLUMN_QTY_STOCK,
                DatabaseUtils.Stock.COLUMN_PRICE,
                DatabaseUtils.Stock.COLUMN_TAXABLE
        };

        // Selection criteria
        String selection = DatabaseUtils.Stock.COLUMN_ITEM_CODE + " = ?";

        // Selection arguments
        String[] selectionArgs = {String.valueOf(itemCode)};

        // Query the database
        Cursor cursor = db.query(
                DatabaseUtils.Stock.TABLE_NAME,
                columns,
                selection,
                selectionArgs,
                null,
                null,
                null
        );

        Stock stock = null;

        // If the cursor contains data, retrieve the item details
        if (cursor.moveToFirst()) {
            // Getting item details from the cursor
            int code = cursor.getInt(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_ITEM_CODE));
            String itemName = cursor.getString(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_ITEM_NAME));
            int qtyStock = cursor.getInt(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_QTY_STOCK));
            float price = cursor.getFloat(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_PRICE));
            int taxableInt = cursor.getInt(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_TAXABLE));


            // Creating a Stock object
            stock = new Stock(code, itemName, qtyStock, price, taxableInt == 1);
        }

        // Close the cursor when done
        cursor.close();

        // Return the Stock object
        return stock;
    }


    public List<Stock> getAllItems() {

        // Create a list to hold the items
        List<Stock> stockList = new ArrayList<>();

        // Readable database instance
        SQLiteDatabase db = this.getReadableDatabase();

        // Columns to retrieve
        String[] columns = {
                DatabaseUtils.Stock.COLUMN_ITEM_CODE,
                DatabaseUtils.Stock.COLUMN_ITEM_NAME,
                DatabaseUtils.Stock.COLUMN_QTY_STOCK,
                DatabaseUtils.Stock.COLUMN_PRICE,
                DatabaseUtils.Stock.COLUMN_TAXABLE
        };

        // Query for all rows in the Stock table
        Cursor cursor = db.query(
                DatabaseUtils.Stock.TABLE_NAME,
                columns,
                null,
                null,
                null,
                null,
                null
        );

        // Getting each item
        while (cursor.moveToNext()) {
            // Get item details from the cursor
            int code = cursor.getInt(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_ITEM_CODE));
            String itemName = cursor.getString(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_ITEM_NAME));
            int qtyStock = cursor.getInt(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_QTY_STOCK));
            float price = cursor.getFloat(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_PRICE));
            boolean isTaxable = cursor.getInt(cursor.getColumnIndexOrThrow(DatabaseUtils.Stock.COLUMN_TAXABLE)) > 0;

            // Creating a Stock object
            Stock stock = new Stock(code, itemName, qtyStock, price, isTaxable);

            // Add the item to the list
            stockList.add(stock);
        }

        // Close the cursor when done
        cursor.close();

        // Return the list of items
        return stockList;
    }


}
