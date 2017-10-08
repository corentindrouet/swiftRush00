//
//  ViewController.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, API42Delegate, UIWebViewDelegate {
    var apiController: APIController?
    
    let credentials: credentialsStruct = credentialsStruct(UID: "b1b3251e18eee31db2b2f74b4a28b012e16e7da61e3bafa1f772a7874306dec1", Secret: "4e76a07ce47c3928b4e92940d58ab7994d3bcb58143db5e6094919051cc98f7c")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func requestSuccess(data: Any?) {
        print("login succeed")
        performSegue(withIdentifier: "segueToTopics", sender: nil)
    }

    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.loadRequest(URLRequest(url: URL(string: ("https://api.intra.42.fr/oauth/authorize?client_id=" + (self.credentials.UID!) + "&redirect_uri=http%3A%2F%2Fapi.intra.42.fr&response_type=code"))!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0))
            print("STARTING")
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let str = request.url?.absoluteString
        print(str!)
        if let url = str {
            if url.contains("code=") {
                let code = url.components(separatedBy: "=")
                print(code)
                apiController = APIControllerTopics(newDelegate: self, newCredentials: credentials, code: code[1])
            }
        }
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTopics" {
            if let dest = segue.destination as? topicsTableView {
                dest.apiController = APIControllerTopics(controller: apiController!)
            }
        }
    }
    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "segueToReconnect" {
            apiController = nil
            let storage = HTTPCookieStorage.shared
            for cookie in storage.cookies! {
                storage.deleteCookie(cookie)
            }
            self.webView.reload()
        }
    }
}

