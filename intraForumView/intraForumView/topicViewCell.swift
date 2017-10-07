//
//  topicViewCell.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class topicViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var topic: Topic? {
        didSet {
            if let currentTopic = topic {
                let format = DateFormatter()
                format.dateFormat = "yyyy MM dd HH:mm:ss"
                
                titleLabel.text = currentTopic.title
                authorLabel.text = "By " + currentTopic.author
                descriptionLabel.text = currentTopic.text
                dateLabel.text = format.string(from: currentTopic.date)
            }
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
