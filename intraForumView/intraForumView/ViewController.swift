//
//  ViewController.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, API42Delegate, UIWebViewDelegate {
    var ApiController: APIController?
    
    let credentials: credentialsStruct = credentialsStruct(UID: "b1b3251e18eee31db2b2f74b4a28b012e16e7da61e3bafa1f772a7874306dec1", Secret: "4e76a07ce47c3928b4e92940d58ab7994d3bcb58143db5e6094919051cc98f7c")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ApiController = APIController(newDelegate: self, newCredentials: credentials)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func treatTopic(str: String) {
        
    }
    
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.loadRequest(URLRequest(url: URL(string: ("https://api.intra.42.fr/oauth/authorize?client_id=" + (self.credentials.UID!) + "&redirect_uri=http%3A%2F%2Fapi.intra.42.fr&response_type=code"))!))
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let str = request.url?.absoluteString
        if let url = str {
            if url.contains("code=") {
                let code = url.components(separatedBy: "=")
                print(code)
                webView.isHidden = true
                ApiController = APIController(newDelegate: self, newCredentials: credentials, code: code[1])
                
            }
        }
        return true
    }
    
}

