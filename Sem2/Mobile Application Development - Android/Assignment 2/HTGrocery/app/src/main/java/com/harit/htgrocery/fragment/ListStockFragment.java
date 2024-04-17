package com.harit.htgrocery.fragment;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.harit.htgrocery.DBHelper;
import com.harit.htgrocery.adapter.ListItemAdapter;
import com.harit.htgrocery.databinding.FragmentListStockBinding;
import com.harit.htgrocery.model.Stock;

import java.util.ArrayList;
import java.util.List;

public class ListStockFragment extends Fragment {

    // View Binding
    FragmentListStockBinding binding;

    // List of items
    List<Stock> itemList = new ArrayList<>();

    // Adapter for the RecyclerView
    ListItemAdapter listItemAdapter;

    DBHelper dbHelper;

    public ListStockFragment() {
        // Required empty public constructor
    }

    public ListStockFragment(DBHelper dbHelper) {
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
        binding = FragmentListStockBinding.inflate(inflater, container, false);

        // Getting all item list from database
        itemList = dbHelper.getAllItems();

        // Checking if list is empty or not
        if (itemList.isEmpty()) {
            Toast.makeText(getActivity(), "No Item records found", Toast.LENGTH_LONG).show();
        } else {
            // Set up RecyclerView layout manager and adapter
            RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(getContext());
            binding.rcView.setLayoutManager(layoutManager);
            listItemAdapter = new ListItemAdapter(itemList, getContext());
            binding.rcView.setAdapter(listItemAdapter);

            // Notify the adapter of data changes
            listItemAdapter.notifyDataSetChanged();
        }

        return binding.getRoot();

    }
    @Override
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

    }
}