//
//  Lab2ViewController.swift
//  Harit_Thoriya_MT_8953007
//
//  Created by Harit Thoriya on 2023-11-08.
//

import UIKit

class Lab2ViewController: UIViewController {
    
    // count variable for storing number of counting
    var count = 0;
    
    // step variable for desiding number of step to add or substract
    var step = 1;
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display number of count on starting of the screen
        displayLabel.text = String(count)
        
    }
    
    // Miuns button function decresed value of count based on step
    @IBAction func minusButton(_ sender: Any) {
        
        count = count - step
        displayLabel.text = String(count)
                
    }
    
    // Add button function add value into count based on step
    @IBAction func addButton(_ sender: Any) {
        count = count + step
        displayLabel.text = String(count)
    }
    
    // Resting the values of count
    @IBAction func resetButton(_ sender: Any) {
        count = 0
        displayLabel.text = String(count)
    }
    
    // Changes value of step
    @IBAction func stepButton(_ sender: UIButton) {
    
        // if the value of step is 1 then it will shows "Step = 1" in Button text and change value of it to 2
        if(step == 1){
            step = 2
            sender.setTitle("Step = 1", for: .normal)
            sender.backgroundColor = UIColor.systemRed
            
        }else{
            step = 1
            sender.setTitle("Step = 2", for: .normal)
            sender.backgroundColor = UIColor.systemOrange
            
        }
        
    }
    
}
