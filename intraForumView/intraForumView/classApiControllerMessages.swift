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
    var message_id: UInt = 0
    var is_topic: Bool = false
    
    init(message_id: UInt, is_topic: Bool, controller: APIController)
    {
        super.init(controller: controller)
        self.message_id = message_id
        self.is_topic = is_topic
    }
    
    func getMessages()
    {
        let start_url = is_topic ? "/topics/" : "/messages/"
        let url = start_url + String(message_id) + "/messages"
        if let request = self.getRequestForUrl(url: url, httpMethod: "GET")
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
    
    func createMessage(text: String) {
        var urlString: String
        var parameters: [String:Any]
        if is_topic {
            urlString = "/topics/"
            parameters = [
                "topic_id": message_id,
                "message": [
                    "author_id": self.userId!,
                    "content": text
                ]
            ]
        } else {
            urlString = "/messages/"
            parameters = [
                "message_id": message_id,
                "message": [
                    "author_id": self.userId!,
                    "content": text
                ]
            ]
        }
        if var request = self.getRequestForUrl(url: urlString + String(message_id) + "/messages", httpMethod: "POST") {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                print(response!)
                if let err = error {
                    print(err)
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.requestSuccess(data: nil)
                    } /*if let d = data {
                     print(d)
                     do {
                     if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                     print(dic)
                     }
                     } catch let err {
                     print(err)
                     }*/
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
            let author:Author = Author(id: 0, name: "")
            var date: Date = Date()
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
                    if let get_user_id = get_author["id"] as? UInt {
                        author.id = get_user_id
                    }
                    if let get_user_name = get_author["login"] as? String {
                        author.name = get_user_name
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
                    let formatter = ISO8601DateFormatter()
                    formatter.formatOptions = [.withFullDate,
                                               .withTime,
                                               .withDashSeparatorInDate,
                                               .withColonSeparatorInTime]
                    if let convert_date = formatter.date(from: get_date) {
                        date = convert_date
                    }
                }
            }
            
            if replies.count > 0 {
                responses = parseMessages(data: replies)
            }
            return (Response(id: id, text: text, author: author, date: date, responses: responses)) // temp date
        }
        return messages
    }
}
