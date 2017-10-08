//
//  oneTopicTableViewCell.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class oneTopicTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var isResponsesLabel: UILabel!
    
    var message:Response? {
        didSet {
            if let msg = message {
                let format = DateFormatter()
                format.dateFormat = "yyyy MM dd HH:mm:ss"
                
                self.contentLabel.text = msg.text
                self.authorLabel.text = msg.author.name
                self.dateLabel.text = format.string(from: msg.date)
            }
        }
    }

}
