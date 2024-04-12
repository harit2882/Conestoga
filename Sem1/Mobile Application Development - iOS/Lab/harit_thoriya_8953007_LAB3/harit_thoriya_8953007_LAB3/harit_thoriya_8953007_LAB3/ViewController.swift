//
//  ViewController.swift
//  harit_thoriya_8953007_LAB3
//
//  Created by Harit Thoriya on 2023-09-27.
//

import UIKit

class ViewController: UIViewController {

    	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
   
    @IBOutlet weak var countryName: UITextField!
    
    @IBOutlet weak var ageNumber: UITextField!
    
    @IBOutlet weak var display: UITextView!
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func addButton(_ sender: UIButton) {
        

        
        if(firstName.text!.isEmpty || lastName.text!.isEmpty || countryName.text!.isEmpty ||
           ageNumber.text!.isEmpty){
    
            
            label.textColor = UIColor.systemRed
            label.text = "Complete the missing information"
            
        }else{
            label.text?.removeAll()
            display.text = "First Name: \(firstName.text!) \nLast Name: \(lastName.text!) \nCountry: \(countryName.text!) \nAge: \(ageNumber.text!)"
        }
        
    }
    
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
    
    @IBAction func clearButton(_ sender: UIButton) {
        firstName.text?.removeAll()
        lastName.text?.removeAll()
        countryName.text?.removeAll()
        ageNumber.text?.removeAll()
        label.text?.removeAll()
        display.text.removeAll()
    }
}

