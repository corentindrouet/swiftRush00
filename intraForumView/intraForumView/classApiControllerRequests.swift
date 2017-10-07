//
//  classApiControllerRequests.swift
//  intraForumView
//
//  Created by Mathilde RESSIER on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class APIControllerRequests : APIController
{
    let basic_url = "https://api.intra.42.fr/v2"
    
    func getRequestForUrl(url: String, httpMethod: String) -> URLRequest?
    {
        var request: URLRequest? = nil
        
        if let req_url = URL(string: self.basic_url + url)
        {
            request = URLRequest(url: req_url)
            request!.httpMethod = httpMethod
            print(self.token!)
            request!.setValue(self.token!, forHTTPHeaderField: "Authorization")
            request!.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        }
        return (request)
    }
}

