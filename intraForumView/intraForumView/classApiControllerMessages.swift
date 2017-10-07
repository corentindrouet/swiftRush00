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
    
    init(topic: Topic, newDelegate: API42Delegate?, newCredentials: credentialsStruct, code: String)
    {
        self.topic = topic
        super.init(newDelegate: newDelegate, newCredentials: newCredentials, code: code)
    }
    
    func getMessages()
    {
       // if let request = self.getRequestForUrl(url: "/topics/" + String(topic.id) + "/messages", httpMethod: <#T##String#>)
       // {
            
       // }
    }
    
    func getMessagesResponses()
    {
    
    }
}
