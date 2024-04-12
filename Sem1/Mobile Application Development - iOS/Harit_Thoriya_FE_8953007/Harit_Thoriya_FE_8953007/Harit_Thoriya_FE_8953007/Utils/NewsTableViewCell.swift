//
//  NewsTableViewCell.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-07.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    public func configure( title: String?, description: String?, source: String?, author:String?){
        
        self.title.text = title
        
        self.descriptionLabel.text = description
        
        self.source.text = source
        
        self.author.text = author
        
    }

    @IBOutlet  var title: UITextView!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    
    @IBOutlet var source: UILabel!
    
    
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
