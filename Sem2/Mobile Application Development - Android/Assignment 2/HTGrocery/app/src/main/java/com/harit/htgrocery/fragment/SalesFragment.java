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
import com.harit.htgrocery.databinding.FragmentSalesBinding;
import com.harit.htgrocery.model.Sales;

import java.util.Calendar;

public class SalesFragment extends Fragment {


    // Binding object
    FragmentSalesBinding binding;
    DBHelper dbHelper;
    DatePickerDialog datePicker;
    Boolean insertStatus;

    public SalesFragment(DBHelper dbHelper) {
        this.dbHelper = dbHelper;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // View Binding
        binding = FragmentSalesBinding.inflate(inflater, container, false);
        return binding.getRoot();

    }

    @Override
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        // Cancel click listener
        binding.btnCancel.setOnClickListener(v -> {
            Intent homeIntent = new Intent(getActivity(), HomeActivity.class);
            startActivity(homeIntent);
        });

        // Save click listener
        binding.btnSave.setOnClickListener(v -> {

            // Checking validation for input field
            if (formValidated()) {
                // Creating sales object
                Sales sales = createSalesObj();

                // Check if Item is already exist in database by item code
                if(dbHelper.doesItemCodeExist(sales.getItemCode())){

                    // Check if sufficient stock available for sale
                    if(dbHelper.isSufficientStockAvailable(sales.getItemCode(), sales.getQtySold())){

                        // calling insert method of helper class to insert sale object
                        insertStatus = dbHelper.insertSales(sales);
                        if (insertStatus) {
                            Toast.makeText(getContext(), "Item has been successfully sold", Toast.LENGTH_LONG).show();
                        } else {
                            Toast.makeText(getContext(), "Something went wrong", Toast.LENGTH_LONG).show();
                        }
                    }else{
                        binding.edtQtySold.setError("Not enough quantity available in stock");
                    }
                }else{
                    binding.edtItemCode.setError("Item Code does not exist");
                }


            }
        });

        //Date picker click event
        binding.edtDateOfSale.setOnClickListener(v -> {
            // Get the current date
            Calendar cal = Calendar.getInstance();
            int dayOfSale = cal.get(Calendar.DAY_OF_MONTH);
            int monthOfSale = cal.get(Calendar.MONTH);
            int yearOfSale = cal.get(Calendar.YEAR);

            // Create a DatePickerDialog
            datePicker = new DatePickerDialog(requireContext(), (datePicker, year, month, day) -> {
                binding.edtDateOfSale.setText(day + "/" + (month + 1) + "/" + year);
            }, yearOfSale, monthOfSale, dayOfSale);

            // Preventing future dates
            datePicker.getDatePicker().setMaxDate(cal.getTimeInMillis());

            // Show the date picker
            datePicker.show();
        });

    }

    private Sales createSalesObj() {
        Sales sales = new Sales();

        sales.setItemCode(Integer.parseInt(binding.edtItemCode.getText().toString().trim()));
        sales.setCustomerName(binding.edtCustName.getText().toString().trim());
        sales.setQtySold(Integer.parseInt(binding.edtQtySold.getText().toString().trim()));
        sales.setCustomerEmail(binding.edtCustEmail.getText().toString().trim());
        sales.setDateOfSales(binding.edtDateOfSale.getText().toString().trim());

        return sales;
    }

    private boolean formValidated(){

        if(binding.edtItemCode.length() == 0){
            binding.edtItemCode.setError("This Field is required");
            return false;
        }
        if(binding.edtCustName.length() == 0){
            binding.edtCustName.setError("This Field is required");;
            return false;
        }
        if(binding.edtCustEmail.length() == 0){
            binding.edtCustEmail.setError("This Field is required");
            return false;
        }
        if (binding.edtQtySold.length() == 0){
            binding.edtQtySold.setError("This Field is required");
            return false;
        }
        if (binding.edtDateOfSale.length() == 0){
            binding.edtQtySold.setError("This Field is required");
            return false;
        }
        return true;
    }
}