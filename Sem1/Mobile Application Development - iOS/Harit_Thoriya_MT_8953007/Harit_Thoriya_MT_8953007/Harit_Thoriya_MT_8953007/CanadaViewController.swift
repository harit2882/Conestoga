//
//  CanadaViewController.swift
//  Harit_Thoriya_MT_8953007
//
//  Created by Harit Thoriya on 2023-11-09.
//

import UIKit

class CanadaViewController: UIViewController, UITextFieldDelegate {
    
    // Array of number os cities
    var cities = ["Calgary","Halifax","Montreal","Toronto","Vancouver","Winnipeg"]
    
    
    @IBOutlet weak var cityImage: UIImageView!
    
    @IBOutlet weak var cityInput: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityImage.image = UIImage.canada
        
    
        cityInput.delegate = self
        
        // dismiss the keyboard on tapping outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    
    }
    
    // Function to dismiss the keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    // Dismiss the keyboard when click on done or return key of keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityInput.resignFirstResponder()
        return true
    }
    
    // Search the user enterd city into citues array if not give the error message
    @IBAction func findCityButton(_ sender: Any) {
        
        if(cityInput.text != nil && cities.contains(cityInput.text!.capitalized)){
            
            errorLabel.text = ""
            cityImage.image = UIImage(named: cityInput.text!.capitalized)
            
        }else{
            
            errorLabel.text = "City not found or invalid input"
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
