//
//  topicsTableView.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class topicsTableView: UITableViewController, API42Delegate {
    
    @IBOutlet var topicTableView: UITableView!
    
    var apiController: APIControllerTopics? {
        didSet {
            apiController?.delegate = self
            apiController?.getTopics()
            print("OUI")
        }
    }
    
    var topicController: APIControllerTopics? {
        didSet {
            if let controller = topicController {
                controller.delegate = self
            }
        }
    }
    var topics: [Topic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestSuccess(data: Any?)
    {
        print("get topics with success")
        if let topics = data as? [Topic]
        {
            self.topics.removeAll()
            self.topics = topics
            topicTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! topicViewCell
        let tmp = topics[indexPath.row]
        cell.topic = tmp
        return cell
    }
}
