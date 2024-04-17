package com.harit.htgrocery;

import android.os.Bundle;


import androidx.appcompat.app.AppCompatActivity;

public class BaseActivity extends AppCompatActivity {
    protected DBHelper dbHelper;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Creating database helper object
        dbHelper = new DBHelper(getApplicationContext());
    }
}