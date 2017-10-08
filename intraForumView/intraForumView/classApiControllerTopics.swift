//
//  APIControllerTopicRequest.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class APIControllerTopics : APIControllerRequests
{
    
    func getTopics()
    {
        print("start to get topics")
        if let request = self.getRequestForUrl(url: "/topics?sort=-created_at", httpMethod: "GET")
        {
            print("will start task")
            let task = URLSession.shared.dataTask(with: request)
            {
                (data, response, error) in
                if let response: NSArray = self.parseRequestToArray(data: data, response: response, error: error)
                {
                    let topics = self.parseTopics(data: response)
                    //print(topics)
                    DispatchQueue.main.async {
                        self.delegate?.requestSuccess(data: topics)
                    }
                }
            }
            task.resume()
        }
    }
    
    func createTopic(title: String, text: String) {
        if var request = self.getRequestForUrl(url: "/topics", httpMethod: "POST") {
            let parameters: [String:Any] = [
                "topic": [
                    "author_id": self.userId!,
                    "cursus_ids": [1],
                    "kind": "normal",
                    "language_id": 1,
                    "name": title,
                    "messages_attributes": [[
                        "author_id": self.userId!,
                        "content": text
                    ]],
                    "tag_ids": [8]
                ]
            ]
            print(self.userId!)
            print(self.token!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            /*do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
            } catch let err {
                print(err)
            }*/
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
    
    func deleteTopic(topic_id: UInt)
    {
        if let request = self.getRequestForUrl(url: "/topics/" + String(topic_id), httpMethod: "DELETE")
        {
            let task = URLSession.shared.dataTask(with: request)
            {
                (data, response, error) in
                print(response!)
                if let err = error {
                    self.delegate?.requestFailed(error: err)
                }
                else
                {
                    print(response!)
                    DispatchQueue.main.async {
                        self.delegate?.requestSuccess(data: nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    /* private */
    
    // on topic array :
    // {
    // "id": 6,
    // "name": "Fear is the path to the dark side... fear leads to anger... anger leads to hate... hate leads to suffering.",
    // "author": {
    //      "id": 48,
    //      "login": "dmaul",
    //      "url": "https:api.intra.42.fr/v2/users/dmaul"
    //     },
    // "created_at": "2017-03-06T14:59:41.165Z",
    // "message": {
    //      "id": 51,
    //      "content": {
    //          "markdown": "Portland echo irony. Scenester farm-to-table paleo. 3 wolf moon stumptown pickled skateboard bitters tacos next level tilde. Taxidermy pabst echo aesthetic.\nShoreditch pork belly put a bird on it bushwick offal beard. Williamsburg kickstarter marfa waistcoat food truck photo booth. Fingerstache tacos tousled humblebrag drinking. Umami wes anderson hashtag bicycle rights selfies echo freegan kale chips. Polaroid chartreuse fanny pack.\nPoutine heirloom deep v wayfarers green juice. Gastropub farm-to-table tousled ennui slow-carb aesthetic crucifix narwhal. Pour-over austin synth flexitarian wayfarers tattooed jean shorts.",
    //          "html": null
    //       }
    //     },
    // }

    private func parseTopics(data: NSArray) -> [Topic]
    {
        let topics:[Topic] = data.map
            {
                (rawTopic) in
                var id:UInt = 0
                var title = ""
                var text = ""
                let author:Author = Author(id: 0, name: "")
                var date:Date = Date()
                var message_id:UInt = 0
                    
                if let topic = rawTopic as? NSDictionary
                {
                    print(topic)
                    /* id */
                    if let get_id = topic["id"] as? UInt {
                        id = get_id
                    }
                    /* title */
                    if let get_title = topic["name"] as? String {
                        title = get_title
                    }
                    /* author */
                    if let get_author = topic["author"] as? NSDictionary {
                        if let get_user_id = get_author["id"] as? UInt {
                            author.id = get_user_id
                        }
                        if let get_user_name = get_author["login"] as? String {
                            author.name = get_user_name
                        }
                    }
                    /* date */
                    if let get_date = topic["created_at"] as? String {
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [.withFullDate,
                                                   .withTime,
                                                   .withDashSeparatorInDate,
                                                   .withColonSeparatorInTime]
                        if let convert_date = formatter.date(from: get_date) {
                            date = convert_date
                        }
                    }
                    /* text and message id */
                    if let get_message = topic["message"] as? NSDictionary {
                        /* message_id */
                        if let get_id = get_message["id"] as? UInt {
                            message_id = get_id
                        }
                        /* text */
                        if let get_content = get_message["content"] as? NSDictionary {
                            if let get_content_markdown = get_content["markdown"] as? String {
                                text = get_content_markdown
                            }
                        }
                    }
                }
                return Topic(id: id, title: title, text: text, author: author, date: date, message_id: message_id)
            }
        return topics
    }
}
