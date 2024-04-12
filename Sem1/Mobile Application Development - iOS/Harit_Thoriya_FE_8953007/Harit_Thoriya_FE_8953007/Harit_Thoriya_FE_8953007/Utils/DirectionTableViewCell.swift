//
//  DirectionTableViewCell.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {

    @IBOutlet weak var intractionType: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var originFrom: UILabel!
    
    @IBOutlet weak var startPoint: UILabel!
    
    @IBOutlet weak var endPoint: UILabel!
    
    @IBOutlet weak var travelMethod: UILabel!
    
    @IBOutlet weak var totalDistance: UILabel!
    
    static let identifier = "DirectionTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DirectionTableViewCell", bundle: nil)
    }
    
    
    public func configure(history: History){
        
        self.intractionType.text = "Direction"
        
        self.cityName.text = history.searchName
        
        self.originFrom.text = history.originSource
        
        let dateFormatter = DateFormatter()
        
        if let direction = history.result as? Direction {
            
            self.startPoint.text = "Start: \(direction.startPoint ?? "N/A")"
            
            self.endPoint.text = "End: \(direction.endPoint ?? "N/A")"
            
            self.travelMethod.text = "Travel By: \(direction.travelType ?? "N/A")"
            
            self.totalDistance.text = "Distance: \(String(direction.distance))"
    
        
        } else {
            // Unable to cast to News
            print("The result is not of type Direction")
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
