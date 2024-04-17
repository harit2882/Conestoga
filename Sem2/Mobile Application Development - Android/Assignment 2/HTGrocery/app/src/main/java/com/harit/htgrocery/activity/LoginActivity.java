package com.harit.htgrocery.activity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Toast;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;
import com.harit.htgrocery.BaseActivity;
import com.harit.htgrocery.databinding.ActivityLoginBinding;
import com.harit.htgrocery.model.User;

public class LoginActivity extends BaseActivity {

    ActivityLoginBinding binding;
    Boolean isSignedUp;
    Boolean isUserExists;
    SharedPreferences sharedPref1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Set up view binding
        binding = ActivityLoginBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        sharedPref1 = getSharedPreferences("login_details", MODE_PRIVATE);

        // Check if user is already logged in
        if (isUserLoggedIn()) {
            navigateToHome();
        }

        //Login button click event
        binding.btnLogin.setOnClickListener(v -> {
            // Create an User object
            User user = createUserObj();
            isUserExists = dbHelper.existsUser(user);

            // Check user is exists or not
            if (isUserExists) {

                boolean isLoggedIn = dbHelper.checkUserCredentials(user);
                if (isLoggedIn) {
                    // Save login status in SharedPreferences
                    SharedPreferences.Editor editor = sharedPref1.edit();
                    editor.putBoolean("isLoggedIn", true);
                    editor.putString("USER_ID", user.getUsername());
                    editor.putString("EMAIL_ID", user.getEmailId());
                    editor.apply();

                    // Navigate to home page
                    navigateToHome();
                } else {
                    // Showing invalid credentials dialog
                    new MaterialAlertDialogBuilder(LoginActivity.this)
                            .setTitle("Login Failed")
                            .setMessage("Invalid Username and/or Password")
                            .setPositiveButton("Okay", (dialog, which) -> {
                            })
                            .setNegativeButton("Cancel", (dialog, which) -> {
                            })
                            .show();
                }

            } else {
                // Showing login failed dialog for user not exists
                new MaterialAlertDialogBuilder(LoginActivity.this)
                        .setTitle("Login Failed")
                        .setMessage("User is not exists. Please SignUp")
                        .setPositiveButton("Okay", (dialog, which) -> {
                        })
                        .setNegativeButton("Cancel", (dialog, which) -> {
                        })
                        .show();
            }

        });

        //Signup button event
        binding.btnSignup.setOnClickListener(v -> {
            // Create an User object
            User user = createUserObj();
            isUserExists = dbHelper.existsUser(user);

            //Check if user is exist or not
            if (isUserExists) {
                // Show signup failed dialog
                new MaterialAlertDialogBuilder(LoginActivity.this)
                        .setTitle("SignUp Failed")
                        .setMessage("User already exists. Please Login")
                        .setPositiveButton("Okay", (dialog, which) -> {
                        })
                        .setNegativeButton("Cancel", (dialog, which) -> {
                        })
                        .show();

            } else {
                // Insert the User object into the database
                isSignedUp = dbHelper.insertUser(user);

                // Check whether signed up or not
                if (isSignedUp) {

                    Toast.makeText(this, "User is successfully registered.", Toast.LENGTH_LONG).show();
                    navigateToHome();

                } else {
                    // Show signup failed dialog
                    new MaterialAlertDialogBuilder(LoginActivity.this)
                            .setTitle("Login Failed")
                            .setMessage("Invalid User Id and/or Password")
                            .setPositiveButton("Okay", (dialog, which) -> {
                            })
                            .setNegativeButton("Cancel", (dialog, which) -> {
                            })
                            .show();
                }
            }
        });
    }

    // Create an User object method
    private User createUserObj() {

        String username = binding.edtUserId.getText().toString().trim();
        String email = binding.edtEmailid.getText().toString().trim();
        String password = binding.edtPassword.getText().toString().trim();
        User user = new User(username, email, password);

        return user;
    }

    private boolean isUserLoggedIn() {
        // Get the login status from SharedPreferences
        return sharedPref1.getBoolean("isLoggedIn", false);
    }

    private void navigateToHome() {
        Intent intent = new Intent(this, HomeActivity.class);
        startActivity(intent);
        finish();
    }
}