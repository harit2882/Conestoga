package com.harit.htgrocery.fragment;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.harit.htgrocery.DBHelper;
import com.harit.htgrocery.R;
import com.harit.htgrocery.activity.HomeActivity;
import com.harit.htgrocery.databinding.FragmentAddStockBinding;
import com.harit.htgrocery.model.Stock;

public class AddStockFragment extends Fragment {

    Boolean insertStatus;
    // Binding object
    FragmentAddStockBinding binding;
    boolean isTaxable;
    DBHelper dbHelper;


    public AddStockFragment(DBHelper dbHelper){
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
        binding = FragmentAddStockBinding.inflate(inflater, container, false);
        return binding.getRoot();

    }

    @Override
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        // Cancel button click listener
        binding.btnCancel.setOnClickListener(v -> {
            Intent homeIntent = new Intent(getActivity(), HomeActivity.class);
            startActivity(homeIntent);
        });

        // Save button click listener
        binding.btnSave.setOnClickListener(v -> {
            if (formValidated()) {
                Stock stock = createStockObj();


                insertStatus = dbHelper.insertStock(stock);
                if (insertStatus) {
                    Toast.makeText(getContext(), "Stock added Successfully", Toast.LENGTH_LONG).show();
                } else {
                    Toast.makeText(getContext(), "Something went wrong", Toast.LENGTH_LONG).show();
                }
            }
        });

        // RadioButton click even
        binding.taxRadioGroup.setOnCheckedChangeListener((group, checkedId) -> {

            if (checkedId == R.id.radioTaxable) {
                isTaxable = true;
            } else if (checkedId == R.id.radioNonTaxable) {
                isTaxable = false;
            }
        });
    }

    private Stock createStockObj() {
        Stock stock = new Stock();

        stock.setItemName(binding.edtItemName.getText().toString().trim());
        stock.setQtyStock(Integer.parseInt(binding.edtQty.getText().toString().trim()));
        stock.setPrice(Float.parseFloat(binding.edtPrice.getText().toString().trim()));
        stock.setTaxable(isTaxable);
        return stock;
    }

    //Method for validation user input
    private boolean formValidated(){

        if(binding.edtItemName.length() == 0){
            binding.edtItemName.setError("This Field is required");
            return false;
        }
        if(binding.taxRadioGroup.getCheckedRadioButtonId() == -1){
            Toast.makeText(getContext(), "Select tax information", Toast.LENGTH_SHORT).show();
            return false;
        }
        if(binding.edtQty.length() == 0){
            binding.edtQty.setError("This Field is required");
            return false;
        }
        if (binding.edtPrice.length() == 0){
            binding.edtPrice.setError("This Field is required");
            return false;
        }
        return true;
    }

}