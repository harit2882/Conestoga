//
//  QuadraticSceneViewController.swift
//  Harit_Thoriya_MT_8953007
//
//  Created by Harit Thoriya on 2023-11-07.
//

import UIKit

class QuadraticSceneViewController: UIViewController, UITextFieldDelegate {
    
    // three textfield for input A,B and C
    @IBOutlet weak var valueA: UITextField!
    @IBOutlet weak var valueB: UITextField!
    @IBOutlet weak var valueC: UITextField!
    
    // TextView for displaying message
    @IBOutlet weak var displayMessage: UITextView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueA.delegate = self
        valueB.delegate = self
        valueC.delegate = self
        
       // dismiss the keyboard on tapping outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Function to dismiss the keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    // Dismiss the keyboard when click on done or return key of keyboard for all 3 textfiled
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        valueA.resignFirstResponder()
        valueB.resignFirstResponder()
        valueA.resignFirstResponder()
        return true
    }

    
   // Calculate Button for calulating the value of x of quadratic function based on value of A,B and C
    @IBAction func calculateX(_ sender: UIButton) {
        
        displayMessage.text = ""
        
        // Check the given input is empty of not for all filed and if not then convert to double
        if let a = Double(valueA.text?.trimmingCharacters(in: .whitespaces) ?? ""), let b = Double(valueB.text?.trimmingCharacters(in: .whitespaces) ?? ""), let c = Double(valueC.text?.trimmingCharacters(in: .whitespaces) ?? "") {
            
            
            // Check the value of a is not 0, if it is then gives error message
            if a != 0 {
                
                // Finding discriminant
                let discriminant = b * b - 4 * a * c

                // Calculating Value of X based on value of discriminant
                if discriminant == 0 {
                    
                   let x = -b / (2 * a)
                    
                    displayMessage.textColor = .systemGreen
                    displayMessage.text = "There is only one value for X \nValue of X = \(String(format: "%.2f", x))"
                    
                } else if discriminant > 0 {
                    
                    let x1 : Double = ( -b + sqrt(discriminant)) / (2 * a)
                    
                    let x2 : Double = ( -b - sqrt(discriminant)) / (2 * a)
                    
                    displayMessage.textColor = .systemGreen
                    displayMessage.text = "There are two values for X” \n 1st value of x = \(String(format: "%.2f", x1)) \n 2nd value of x = \(String(format: "%.2f", x2))"
                    
                } else {
                    displayMessage.textColor = .red
                    displayMessage.text = "There are no results since the discriminant is less than zero."
                }
            }else{
                displayMessage.textColor = .red
                displayMessage.text = "The value you entered for A is invalid."
            }
            
        } else {
            displayMessage.textColor = .red
            
            // Give the message if all field is empty
            if valueA.text?.isEmpty ?? true && valueB.text?.isEmpty ?? true && valueC.text?.isEmpty ?? true {
                    displayMessage.text = "Enter value for A, B and C to find X."
            }
            else {
                
                // Check and gives the error message for invalid input of textfield
                    if Double(valueA.text?.trimmingCharacters(in: .whitespaces) ?? "") == nil {
                        displayMessage.text = "The value you entered for A is invalid.\n"
                    }
                    if Double(valueB.text?.trimmingCharacters(in: .whitespaces) ?? "") == nil {
                        displayMessage.text += "The value you entered for B is invalid.\n"
                    }
                    if Double(valueC.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") == nil {
                        displayMessage.text += "The value you entered for C is invalid."
                    }
                }
            
        }
    }
    
    // Resting the value of all textfield and reminding for entering the input
    @IBAction func clearButton(_ sender: UIButton) {
        
        valueA.text = ""
        valueB.text = ""
        valueC.text = ""
        
        displayMessage.textColor = .black
        displayMessage.text = "Enter value for A, B and C to find X."
        
    }

}
