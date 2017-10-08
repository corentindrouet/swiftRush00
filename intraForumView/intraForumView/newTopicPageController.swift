//
//  newTopicPageControllerViewController.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/8/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class newTopicPageController: UIViewController, API42Delegate {
    
    var apiControllerTopic: APIControllerTopics? {
        didSet {
            apiControllerTopic?.delegate = self
        }
    }

    @IBOutlet weak var topicTitleText: UITextView! {
        didSet {
            topicTitleText.layer.borderColor = UIColor.black.cgColor
            topicTitleText.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet weak var topicContentText: UITextView! {
        didSet {
            topicContentText.layer.borderColor = UIColor.black.cgColor
            topicContentText.layer.borderWidth = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestSuccess(data: Any?) {
        print("ON PASS ICI")
        performSegue(withIdentifier: "unWindSegueToTopic", sender: nil)
    }
    
    @IBAction func addNewTopic(_ sender: Any) {
        apiControllerTopic?.createTopic(title: self.topicTitleText.text!, text: self.topicContentText.text!)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
