//
//  oneTopicTableView.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class oneTopicTableView: UITableViewController, API42Delegate {
    
    @IBOutlet var messagesTableView: UITableView!
    
    
    var apiController: APIControllerMessages? {
        didSet {
            if let apiCtrl = apiController {
                apiCtrl.delegate = self
                apiCtrl.getMessages()
            }
        }
    }

    var messages: [Response] = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func requestSuccess(data: Any?) {
        print("request success")
        if let messages = data as? [Response] {
            self.messages = messages
        }
        messagesTableView.reloadData()
    }
    
    /* table View */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! oneTopicTableViewCell

        /* le premier message semble toujours etre le topic donc pas de cas particulier */
        cell.message = messages[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }

    /*
     In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
