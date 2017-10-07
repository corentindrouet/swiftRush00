//
//  topicsTableView.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class topicsTableView: UITableViewController {
    
    @IBOutlet var topicTableView: UITableView!
    var apiController: APIControllerTopics? {
        didSet {
            apiController?.delegateTopicTable = self
            apiController?.getTopics()
            print("OUI")
        }
    }
    
    var topicController: APIControllerTopics? {
        didSet {
            if let controller = topicController {
                controller.delegateTopicTable = self
            }
        }
    }
    var topics: [Topic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func updateTopics(newTopics: [Topic]) {
        print("UPDATING...")
        self.topics.removeAll()
        //self.topics = newTopics
        self.topics = [Topic](newTopics)
        print(self.topics.count)
        topicTableView.reloadData()
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
