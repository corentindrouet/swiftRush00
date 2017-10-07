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
        if let request = self.getRequestForUrl(url: "/topics", httpMethod: "GET")
        {
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
                var author = ""
                var date = ""
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
                        if let get_author_name = get_author["login"] as? String {
                            author = get_author_name
                        }
                    }
                    /* date */
                    if let get_date = topic["created_at"] as? String {
                        date = get_date // TEMP : to convert to date
                        _ = date // TEMP for warning...
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
                return Topic(id: id, title: title, text: text, author: author, date: Date(), message_id: message_id) // DATE TEMP
            }
        return topics
    }
}
