//
//  newMessageController.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/8/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class newMessageController: UIViewController, API42Delegate {

    var apiControllerMessage: APIControllerMessages? {
        didSet {
            apiControllerMessage?.delegate = self
        }
    }
    @IBOutlet weak var newMessageText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestSuccess(data: Any?) {
        apiControllerMessage?.getMessages()
        performSegue(withIdentifier: "newMessageSegue", sender: nil)
    }
    
    func requestFailed(error: Error){
        print(error)
    }

    @IBAction func addMessage(_ sender: Any) {
        apiControllerMessage?.createMessage(text: newMessageText.text)
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
