//
//  Lab3ViewController.swift
//  Harit_Thoriya_MT_8953007
//
//  Created by Harit Thoriya on 2023-11-08.
//

import UIKit

class Lab3ViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
   
    @IBOutlet weak var countryName: UITextField!
    
    @IBOutlet weak var ageNumber: UITextField!
    
    @IBOutlet weak var display: UITextView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Add the the textfield value to display
    @IBAction func addButton(_ sender: UIButton) {
        
        // if any textfield is empty then give error message
        if(firstName.text!.isEmpty || lastName.text!.isEmpty || countryName.text!.isEmpty ||
           ageNumber.text!.isEmpty){
    
            
            label.textColor = UIColor.systemRed
            label.text = "Complete the missing information"
            
        }else{
            label.text?.removeAll()
            display.text = "First Name: \(firstName.text!) \nLast Name: \(lastName.text!) \nCountry: \(countryName.text!) \nAge: \(ageNumber.text!)"
        }
        
    }
    
    // Submit if the all value are filled and give scessfully Submitted message
    @IBAction func submitButton(_ sender: UIButton) {
        
        if(firstName.text!.isEmpty || lastName.text!.isEmpty || countryName.text!.isEmpty ||
           ageNumber.text!.isEmpty){
            
            label.textColor = UIColor.systemRed
            label.text = "Complete the missing information"
        }else{
            label.textColor = UIColor.systemGreen
            label.text = "Successfully Submitted!"
        }
    }
    
    // clear the value of all text field and display textview
    @IBAction func clearButton(_ sender: UIButton) {
        firstName.text?.removeAll()
        lastName.text?.removeAll()
        countryName.text?.removeAll()
        ageNumber.text?.removeAll()
        label.text?.removeAll()
        display.text.removeAll()
    }

}
