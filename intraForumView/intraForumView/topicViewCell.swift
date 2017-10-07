//
//  topicViewCell.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class topicViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var topic: Topic? {
        didSet {
            if let currentTopic = topic {
                let format = DateFormatter()
                format.dateFormat = "yyyy MM dd HH:mm:ss"
                NameLabel.text = currentTopic.author
                dateLabel.text = format.string(from: currentTopic.date)
                descriptionLabel.text = currentTopic.text
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
