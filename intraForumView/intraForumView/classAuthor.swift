//
//  classAuthor.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/8/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class Author : NSObject {
    var id: UInt
    var name: String
    
    init(id: UInt, name: String) {
        self.id = id
        self.name = name
    }
    
    override var description: String { return ("[\(id): \(name)]") }
}
