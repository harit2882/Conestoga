package com.example.haritassignment1;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.View;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.haritassignment1.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    // MainActivity view binging variable
    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);

        // binding variable with view
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        // setting listeners
        binding.btnC.setOnClickListener(this);
        binding.btnF.setOnClickListener(this);

    }


    // Validation function
    private boolean validateTemperatureInput(String temperatureString, boolean isCelsius) {
        boolean isError = false;

        // Check if input is empty
        if (temperatureString.isEmpty()) {
            binding.etvTempInput.setError("This field is required");
            isError = true;
        } else {
            try {
                double temperature = Double.parseDouble(temperatureString);

                if (isCelsius) {
                    // Edging Celsius temperature
                    if (temperature < -273.15) {
                        binding.etvTempInput.setError("Extreme Low Temperature < -273.15°C");
                        isError = true;
                    } else if (temperature > 1000) {
                        binding.etvTempInput.setError("Extreme High Temperature > 1000°C");
                        isError = true;
                    }
                } else {
                    // Edging Fahrenheit temperature
                    if (temperature < -459.67) {
                        binding.etvTempInput.setError("Extreme Low Temperature < -459.67°F)");
                        isError = true;
                    } else if (temperature > 1832) {
                        binding.etvTempInput.setError("Extreme High Temperature > 1832°F)");
                        isError = true;
                    }
                }
            } catch (NumberFormatException e) {
                binding.etvTempInput.setError("Please enter a valid numeric value");
                isError = true;
            }
        }

        return !isError; // Return true if no errors
    }

    @SuppressLint("DefaultLocale")
    @Override
    public void onClick(View view) {

        // Click event for C button
        if (view.getId() == binding.btnC.getId()){

            // Extracting fahrenheit value from text view
            String fahrenheitString = binding.etvTempInput.getText().toString().trim();

            // Validation value of fahrenheit
            if (validateTemperatureInput(fahrenheitString, false)) {

                // Converting from string to double
                double fahrenheit = Double.parseDouble(fahrenheitString);

                // Login for converting to celsius
                double celsius = (fahrenheit - 32) * 5 / 9;

                // Setting the result to textview
                binding.tvOutput.setText(String.format("%.2f", celsius));
                binding.tvOutputUnit.setText("C");
                binding.tvOutputUnit.setVisibility(View.VISIBLE);
            }
        }
        // Click event for F button
        else if (view.getId() == binding.btnF.getId()) {

            // Extracting fahrenheit value from text view
            String celsiusString = binding.etvTempInput.getText().toString();

            // Validation value of celsius
            if (validateTemperatureInput(celsiusString, true)) {

                // Converting from string to double
                double celsius = Double.parseDouble(celsiusString);

                // Login for converting to fahrenheit
                double fahrenheit = (celsius * 9 / 5) + 32;

                // Setting the result to textview
                binding.tvOutput.setText(String.format("%.2f", fahrenheit));
                binding.tvOutputUnit.setText("F");
                binding.tvOutputUnit.setVisibility(View.VISIBLE);
            }
        }
    }
}