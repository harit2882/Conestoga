package com.harit.htgrocery.fragment;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;
import com.harit.htgrocery.DBHelper;
import com.harit.htgrocery.activity.HomeActivity;
import com.harit.htgrocery.databinding.FragmentSearchStockBinding;
import com.harit.htgrocery.model.Stock;

public class SearchStockFragment extends Fragment {

    // Binding object
    FragmentSearchStockBinding binding;
    DBHelper dbHelper;
    Stock searchStock;

    public SearchStockFragment() {
        // Required empty public constructor
    }

    public SearchStockFragment(DBHelper dbHelper) {
        this.dbHelper = dbHelper;
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // View Binding
        binding = FragmentSearchStockBinding.inflate(inflater, container, false);
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

        //Search click listener
        binding.btnSearch.setOnClickListener(v -> {

            // Checking validation for input field
            if (formValidated()) {
                try {
                    int itemCode = Integer.parseInt(binding.edtItemCode.getText().toString().trim());

                    // Check item is available or not
                    if (dbHelper.doesItemCodeExist(itemCode)) {

                        // Search item by item code
                        searchStock = dbHelper.searchItemById(itemCode);

                        //Showing item details in dialog is not null
                        if (searchStock != null) {
                            new MaterialAlertDialogBuilder(requireContext())
                                    .setTitle("Item Details")
                                    .setMessage(
                                            "Item Code: " + searchStock.getItemCode() + "\n" +
                                                    "Item Name: " + searchStock.getItemName() + "\n" +
                                                    "Quantity in Stock: " + searchStock.getQtyStock() + "\n" +
                                                    "Price: " + searchStock.getPrice() + "\n" +
                                                    "Taxable: " + searchStock.isTaxable())
                                    .setPositiveButton("OK", null)
                                    .show();
                        }

                    } else {
                        binding.edtItemCode.setError("Item Code does not exist");
                    }
                } catch (NumberFormatException e) {
                    binding.edtItemCode.setError("Enter integer value");
                }
            }
        });
    }

    private boolean formValidated() {
        if (binding.edtItemCode.length() == 0) {
            binding.edtItemCode.setError("This Field is required");
            return false;
        }
        return true;
    }
}