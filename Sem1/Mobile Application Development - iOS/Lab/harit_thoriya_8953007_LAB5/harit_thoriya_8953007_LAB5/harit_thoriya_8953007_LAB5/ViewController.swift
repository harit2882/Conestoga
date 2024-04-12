//
//  ViewController.swift
//  harit_thoriya_8953007_LAB5
//
//  Created by Harit Thoriya on 2023-10-10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        informationButton.layer.borderWidth = 1
        informationButton.layer.borderColor = informationButton.tintColor.cgColor
        
        level1Button.layer.borderWidth = 1
        level1Button.layer.borderColor = level1Button.tintColor.cgColor
        
        level2Button.layer.borderWidth = 1
        level2Button.layer.borderColor = level2Button.tintColor.cgColor
        
        
    }

    @IBOutlet weak var level1Button: UIButton!
    
    @IBOutlet weak var level2Button: UIButton!
    
    @IBOutlet weak var informationButton: UIButton!
    
}

