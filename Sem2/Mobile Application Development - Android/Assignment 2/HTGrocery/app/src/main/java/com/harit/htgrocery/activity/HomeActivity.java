package com.harit.htgrocery.activity;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

import com.harit.htgrocery.BaseActivity;
import com.harit.htgrocery.R;
import com.harit.htgrocery.databinding.ActivityHomeBinding;
import com.harit.htgrocery.fragment.AddStockFragment;
import com.harit.htgrocery.fragment.ListStockFragment;
import com.harit.htgrocery.fragment.PurchaseFragment;
import com.harit.htgrocery.fragment.SalesFragment;
import com.harit.htgrocery.fragment.SearchStockFragment;

public class HomeActivity extends BaseActivity {

    // Binding object
    ActivityHomeBinding homeBinding;

    ActionBarDrawerToggle mToggle;

    // SharedPreferences
    SharedPreferences sharedPref2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // ViewBinding
        homeBinding = ActivityHomeBinding.inflate(getLayoutInflater());
        setContentView(homeBinding.getRoot());

        init();
    }

    private void init() {
        //Getting user name from session data in shared preference
        sharedPref2 = getSharedPreferences("login_details", MODE_PRIVATE);
        homeBinding.txtWelcome.setText("Welcome " + sharedPref2.getString("USER_ID", null));

        // Set up ActionBarDrawerToggle and support action bar
        mToggle = new ActionBarDrawerToggle(this, homeBinding.drawerLayout, homeBinding.materialToolbar, R.string.nav_open, R.string.nav_close);
        homeBinding.drawerLayout.addDrawerListener(mToggle);
        mToggle.syncState();
        setSupportActionBar(homeBinding.materialToolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        // Set up the navigation drawer listener
        SetNavigationDrawer();
    }

    private void SetNavigationDrawer() {
        homeBinding.navView.setNavigationItemSelectedListener(item -> {
            Fragment frag = null;
            int itemId = item.getItemId();

            // Selecting menu item
            if (itemId == R.id.nav_add_stock) {
                frag = new AddStockFragment(dbHelper);
            } else if (itemId == R.id.nav_sales) {
                frag = new SalesFragment(dbHelper);
            } else if (itemId == R.id.nav_purchase) {
                frag = new PurchaseFragment(dbHelper);
            } else if (itemId == R.id.nav_search_stock) {
                frag = new SearchStockFragment(dbHelper);
            } else if (itemId == R.id.nav_list_stock) {
                frag = new ListStockFragment(dbHelper);
            } else if (itemId == R.id.nav_log_out) {
                logout();
            }
            // Replace the current fragment and close the drawer
            if (frag != null) {
                FragmentTransaction fragTrans = getSupportFragmentManager().beginTransaction();
                fragTrans.replace(R.id.frame, frag);
                fragTrans.commit();
                homeBinding.drawerLayout.closeDrawers();
                return true;
            }
            return false;
        });
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (mToggle.onOptionsItemSelected(item)) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private void logout() {
        // Clear the session data
        SharedPreferences.Editor editor = sharedPref2.edit();
        editor.clear();
        editor.apply();

        // Navigate back to the login page
        Intent loginIntent = new Intent(this, LoginActivity.class);
        loginIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(loginIntent);

        Toast.makeText(this, "Logged out successfully", Toast.LENGTH_SHORT).show();
    }

}