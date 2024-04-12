//
//  NewsHistoryTableViewCell.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//

import UIKit

class NewsHistoryTableViewCell: UITableViewCell {

    static let identifier = "NewsHistoryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsHistoryTableViewCell", bundle: nil)
    }
    
    @IBOutlet var title: UITextView!
    
    @IBOutlet var descriptionLabel: UITextView!
    
    @IBOutlet var source: UILabel!
    
    @IBOutlet var author: UILabel!
    
    @IBOutlet var intractionType: UILabel!
    
    @IBOutlet var cityName: UILabel!
    
    @IBOutlet var originFrom: UILabel!
    
    
    public func configure(history: History){
        
        self.intractionType.text = "News"
        
        self.cityName.text = history.searchName
        
        self.originFrom.text = "From: \(history.originSource ?? "No Origin")"
        
        if let news = history.result as? News {
            print("News Title = \(news.title ?? "Hahaa")")
                self.title.text = news.title
                self.descriptionLabel.text = news.discription
                self.source.text = news.source
                self.author.text = news.author
            } else {
                // Handle the case where result is not of type News
                self.title.text = "N/A"
                self.descriptionLabel.text = "N/A"
                self.source.text = "N/A"
                self.author.text = "N/A"
                
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
