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
                if (apiCtrl.is_topic == true) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    print(apiCtrl.message_id)
                    apiCtrl.getMessages()
                }
            }
        }
    }

    var messages: [Response] = [Response]() {
        didSet {
            print ("set messages")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func requestSuccess(data: Any?)
    {
        print("request success")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let messages = data as? [Response] {
            self.messages = messages
        }
        messagesTableView.reloadData()
    }
    
    
    func requestFailed(error: Error)
    {
        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /* table View */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! oneTopicTableViewCell

        /* le premier message semble toujours etre le topic donc pas de cas particulier */
        cell.message = messages[indexPath.row]
        
        if cell.message?.responses?.count == 0 {
            cell.isResponsesLabel.isHidden =  true
        }
//        if cell.message?.author
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row \(indexPath.row)")
    }
    
    /* SEGUE */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "segueToResponses") {
            if let original_cell = sender as? oneTopicTableViewCell {
                
                /* don't perform segue if there is no response to the post */
                if original_cell.message!.responses!.count == 0  {
                    return (false)
                }
                /* don't perform segue if the message is the fiiirst message */
                if (original_cell.message!.id == self.apiController!.message_id) {
                    return (false)
                }
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToResponses" {
            if let dest = segue.destination as? oneTopicTableView {
                if let original_cell = sender as? oneTopicTableViewCell {
                    // le message duquel on regarde les reponses n'est pas affiche
                    dest.messages = (original_cell.message?.responses)!
                    print(dest.messages)
                    //dest.apiController = self.apiController!
                    //dest.apiController?.is_topic = false
                    //dest.apiController?.message_id = (original_cell.message?.id)!
                    dest.apiController = APIControllerMessages(message_id: (original_cell.message?.id)!, is_topic: false, controller: apiController!)
                }
            }
        } else if segue.identifier == "newMessageSegue" {
            if let dest = segue.destination as? newMessageController {
                dest.apiControllerMessage = self.apiController
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func unWindSegueNewMessage(segue: UIStoryboardSegue) {
        //apiController?.getTopics()
    }
    
}
