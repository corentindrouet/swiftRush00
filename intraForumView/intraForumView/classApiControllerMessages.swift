//
//  classApiControllerMessages.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class APIControllerMessages : APIControllerRequests
{
    let topic: Topic
    
    init(topic: Topic, newDelegate: API42Delegate?, newCredentials: credentialsStruct) {
        self.topic = topic
        super.init(newDelegate: newDelegate, newCredentials: newCredentials)
    }
    
    func getMessages()
    {
        
    }
    
    func getMessagesResponses()
    {
    
    }
}
