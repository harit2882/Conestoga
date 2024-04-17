package com.harit.htgrocery.fragment;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.harit.htgrocery.DBHelper;
import com.harit.htgrocery.activity.HomeActivity;
import com.harit.htgrocery.databinding.FragmentPurchaseBinding;
import com.harit.htgrocery.model.Purchase;

import java.util.Calendar;

public class PurchaseFragment extends Fragment {

    // Binding object
    FragmentPurchaseBinding binding;
    Boolean insertStatus;
    DBHelper dbHelper;
    DatePickerDialog datePicker;

    public PurchaseFragment() {
        // Required empty public constructor
    }

    public PurchaseFragment(DBHelper dbHelper) {
        this.dbHelper = dbHelper;
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // View Binding
        binding = FragmentPurchaseBinding.inflate(inflater, container, false);
        return binding.getRoot();

    }

    @Override
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);


        //Cancel click listener
        binding.btnCancel.setOnClickListener(v -> {
            Intent homeIntent = new Intent(getActivity(), HomeActivity.class);
            startActivity(homeIntent);
        });

        //Save click listener
        binding.btnSave.setOnClickListener(v -> {

            // Checking validation for input field
            if (formValidated()) {

                // Creating purchase object
                Purchase purchase = createPurchaseObj();

                // Check if Item is already exist in database by item code
                if (dbHelper.doesItemCodeExist(purchase.getItemCode())) {

                    // calling insert method of helper class to insert purchase object
                    insertStatus = dbHelper.insertPurchase(purchase);

                    // Showing toast message based on result of inserting data
                    if (insertStatus) {
                        Toast.makeText(getContext(), "Item has been successfully purchased", Toast.LENGTH_LONG).show();
                    } else {
                        Toast.makeText(getContext(), "Something went wrong", Toast.LENGTH_LONG).show();
                    }

                } else {
                    binding.edtItemCode.setError("Item Code does not exist");
                }
            }
        });

        //Date picker click event
        binding.edtDateOfPurchase.setOnClickListener(v -> {
            // Get the current date
            Calendar cal = Calendar.getInstance();
            int dayOfSale = cal.get(Calendar.DAY_OF_MONTH);
            int monthOfSale = cal.get(Calendar.MONTH);
            int yearOfSale = cal.get(Calendar.YEAR);

            // Create a DatePickerDialog
            datePicker = new DatePickerDialog(requireContext(), (datePicker, year, month, day) -> {
                binding.edtDateOfPurchase.setText(day + "/" + (month + 1) + "/" + year);
            }, yearOfSale, monthOfSale, dayOfSale);

            // Preventing future dates
            datePicker.getDatePicker().setMaxDate(cal.getTimeInMillis());

            // Show the date picker
            datePicker.show();
        });


    }

    private Purchase createPurchaseObj() {
        Purchase purchase = new Purchase();

        purchase.setItemCode(Integer.parseInt(binding.edtItemCode.getText().toString().trim()));
        purchase.setQtyPurchased(Integer.parseInt(binding.edtQtySold.getText().toString().trim()));
        purchase.setDateOfPurchase(binding.edtDateOfPurchase.getText().toString().trim());
        return purchase;
    }

    private boolean formValidated() {

        if (binding.edtItemCode.length() == 0) {
            binding.edtItemCode.setError("This Field is required");
            return false;
        }
        if (binding.edtQtySold.length() == 0) {
            binding.edtQtySold.setError("This Field is required");
            return false;
        }
        if (binding.edtDateOfPurchase.length() == 0) {
            binding.edtDateOfPurchase.setError("This Field is required");
            return false;
        }
        return true;
    }
}