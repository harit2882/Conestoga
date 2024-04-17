package com.harit.htgrocery.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import com.harit.htgrocery.databinding.ItemViewholderBinding;
import com.harit.htgrocery.model.Stock;

import java.util.List;

public class ListItemAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {
    private final List<Stock> itemList;
    ItemViewholderBinding binding;

    public ListItemAdapter(List<Stock> itemList, Context context) {
        this.itemList = itemList;
    }

    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // ViewBinding for ViewHolder
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        binding = ItemViewholderBinding.inflate(layoutInflater, parent, false);
        return new ViewHolder(binding);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
        // Bind the view for the item at the given position
        ((ViewHolder) holder).bindView(itemList.get(position));
    }

    @Override
    public int getItemCount() {
        return itemList.size();
    }

    // ViewHolder class to hold the item view
    class ViewHolder extends RecyclerView.ViewHolder {
        ItemViewholderBinding binding;

        public ViewHolder(ItemViewholderBinding recyclerRowBinding) {
            super(recyclerRowBinding.getRoot());
            this.binding = recyclerRowBinding;
        }

        public void bindView(Stock stock) {
            binding.txtItemCode.setText("Item Code: " + stock.getItemCode());
            binding.txtItemName.setText("Item Name: " + stock.getItemName());
            binding.txtPrice.setText("Price: " + stock.getPrice());
            binding.txtQty.setText("Stock Quantity: " + stock.getQtyStock());
            binding.txtTaxable.setText("Taxable: " + stock.isTaxable());
        }
    }
}