//
//  topic.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class Topic : NSObject {
    
    let id: UInt
    let title: String
    let text: String
    let author: String
    let date: Date
    let message_id: UInt
    
    init(id: UInt, title: String, text: String, author: String, date: Date, message_id: UInt)
    {
        self.id = id
        self.title = title
        self.text = text
        self.author = author
        self.date = date
        self.message_id = message_id
    }
    
    override var description: String { return ("[\(id)] \"\(title)\" by \(author) :\n\(text)\n-----------------------------------------------------------\n") }
}
