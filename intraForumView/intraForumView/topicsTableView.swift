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
            if let apiCtrl = apiController {
                apiCtrl.delegate = self
                apiCtrl.getTopics()
            }
        }
    }
    
    var topicController: APIControllerTopics? {
        didSet {
            if let controller = topicController {
                controller.delegate = self
            }
        }
    }
    
    var topics: [Topic] = [Topic]()

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
    
    /* table view */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! topicViewCell
        cell.topic = topics[indexPath.row]
        return cell
    }
    
    /* on load */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToOneTopic"
        {
            if let origin_cell = sender as? topicViewCell
            {
                if let dest = segue.destination as? oneTopicTableView {
                    dest.topic = origin_cell.topic
                }
            }
        }
    }
    
}
