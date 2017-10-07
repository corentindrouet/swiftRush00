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
    
    init(topic: Topic, controller: APIController)
    {
        self.topic = topic
        super.init(controller: controller)
    }
    
    func getMessages()
    {
        if let request = self.getRequestForUrl(url: "/topics/" + String(topic.id) + "/messages", httpMethod: "GET")
        {
            let task = URLSession.shared.dataTask(with: request)
            {
                (data, response, error) in
                if let response: NSArray = self.parseRequestToArray(data: data, response: response, error: error)
                {
                    let messages = self.parseMessages(data: response)
                    DispatchQueue.main.async {
                        self.delegate?.requestSuccess(data: messages)
                    }
                    print(messages)
                }
            }
            task.resume()
        }
    }

    /* PRIVATE */
    
    // {
    //    "id": 1,
    //    "author": {
    //       "id": 20,
    //        "login": "pamidala"
    //        }
    //    "content": "Cliche seitan ...",
    //   "replies": [{
    //            ... new object ...
    //        }],
    //    "created_at": "2017-03-06T14:59:37.766Z",
    

    private func parseMessages(data: NSArray) -> [Response]
    {
        let messages:[Response] = data.map
        {
            (rawMessage) in
            var id:UInt = 0
            var text = ""
            var author = ""
            var date = ""
            var replies: NSArray = []
            var responses:[Response] = [Response]()
            
            if let message = rawMessage as? NSDictionary
            {
                /* message id */
                if let get_id = message["id"] as? UInt {
                    id = get_id
                }
                /* author */
                if let get_author = message["author"] as? NSDictionary {
                    if let get_user_name = get_author["login"] as? String {
                        author = get_user_name
                    }
                }
                /* content */
                if let get_text = message["content"] as? String {
                    text = get_text
                }
                /* replies */
                if let get_replies = message["replies"] as? NSArray {
                    replies = get_replies
                }
                /* date */
                if let get_date = message["created_at"] as? String {
                    date = get_date // temp
                }
            }
            
            if replies.count > 0 {
                responses = parseMessages(data: replies)
            }
            return (Response(id: id, text: text, author: author, date: Date(), responses: responses)) // temp date
        }
        return messages
    }
}
