//
//  topicsTableView.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class topicsTableView: UITableViewController, API42Delegate {
    
    @IBOutlet weak var NavigationBarTopics: UINavigationItem!
    @IBOutlet var topicTableView: UITableView!
    
    @IBAction func disconnectButtonClick(_ sender: Any) {
        print("IT WILL DISAPEAR")
        self.performSegue(withIdentifier: "segueToReconnect", sender: nil)
    }
    
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let topics = data as? [Topic]
        {
            self.topics.removeAll()
            self.topics = topics
            topicTableView.reloadData()
        }
    }
    
    func requestFailed(error: Error)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let topic:Topic = topics[indexPath.row]
        if (topic.author.id == apiController?.userId)
        {
            print("yes I can :)")
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == .delete) {
            print("delete")
            apiController?.deleteTopic(topic_id: topics[indexPath.row].id)
            topics.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    /* on load */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    /* navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToOneTopic"
        {
            if let origin_cell = (sender as? topicViewCell)
            {
                if let dest = segue.destination as? oneTopicTableView {
                    dest.apiController = APIControllerMessages(message_id: origin_cell.topic!.id, is_topic: true, controller: self.apiController!)
                }
            }
        } else if segue.identifier == "addTopicSegue" {
            if let dest = segue.destination as? newTopicPageController {
                dest.apiControllerTopic = self.apiController
            }
        }
    }
    
    @IBAction func unWindSegueNewTopic(segue: UIStoryboardSegue) {
        apiController?.getTopics()
    }
}
