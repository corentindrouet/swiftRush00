//
//  classResponse.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class Response : NSObject
{
    let id: UInt
    let text: String
    let author: String
    let date: Date
    let responses:[Response]?
    
    init(id: UInt, text: String, author: String, date: Date, responses: [Response]?) {
        self.id = id
        self.text = text
        self.author = author
        self.date = date
        self.responses = responses
    }
}
