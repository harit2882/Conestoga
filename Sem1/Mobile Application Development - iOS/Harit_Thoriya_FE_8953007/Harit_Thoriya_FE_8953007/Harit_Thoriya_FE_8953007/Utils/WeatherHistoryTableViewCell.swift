//
//  WeatherHistoryTableViewCell.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//

import UIKit

class WeatherHistoryTableViewCell: UITableViewCell {

    static let identifier = "WeatherHistoryTableViewCell"
    
    @IBOutlet weak var intractionType: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var originFrom: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var temprature: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var wind: UILabel!
    
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherHistoryTableViewCell", bundle: nil)
    }
    
    
    public func configure(history: History){
        
        self.intractionType.text = "Weather"
        
        self.cityName.text = history.searchName
        
        self.originFrom.text = "From: \(history.originSource ?? "N/A")"
        
        let dateFormatter = DateFormatter()

        // Set the format for date
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Set the format for time
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        if let date = history.dateTime {
            // Extract date
            self.date.text = "Date: \(dateFormatter.string(from: date))"

            // Extract time
            self.time.text = "Time: \(timeFormatter.string(from: date))"
        } else {
            self.date.text = "N/A"
            self.time.text = "N/A"
        }
        
        if let weather = history.result as? Weather {
            
            self.temprature.text = "Temprature: \(weather.temprature) °C"
            
            self.humidity.text = "Humdity : \(weather.humidity)%"
            
            self.wind.text = "Wind : \(String(format: "%.2f", weather.wind * 3.6)) km/h"
    
            
        } else {
            // Unable to cast to News
            print("The result is not of type News")
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
