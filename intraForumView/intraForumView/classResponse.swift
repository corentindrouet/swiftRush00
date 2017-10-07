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
    let auteur: String
    let date: String
    let responses:[Response]?
    
    init(id: UInt, text: String, auteur: String, date: String, responses: [Response]?) {
        self.id = id
        self.text = text
        self.auteur = auteur
        self.date = date
        self.responses = responses
    }
}
