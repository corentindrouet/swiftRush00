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
    @IBOutlet weak var textLabel: UILabel!
    
    var message:Response? {
        didSet {
            if let msg = message {
                let format = DateFormatter()
                format.dateFormat = "yyyy MM dd HH:mm:ss"
                
                self.authorLabel.text = msg.author
                self.textLabel.text = msg.text
                self.dateLabel.text = format.string(from: msg.date)
            }
        }
    }

}