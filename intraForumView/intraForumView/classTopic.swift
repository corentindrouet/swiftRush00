//
//  topic.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class Topic : NSObject {
    
    let title: String
    let text: String
    let author: String
    let date: Date
    let message_id: UInt
    
    init(title: String, text: String, author: String, date: Date, message_id: UInt)
    {
        self.title = title
        self.text = text
        self.author = author
        self.date = date
        self.message_id = message_id
    }
}
