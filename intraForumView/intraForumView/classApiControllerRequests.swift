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
    
    /*
    ** get the result of a task and try to return the data as an array
    */
    func parseRequestToArray(data: Data?, response: URLResponse?, error: Error?) -> NSArray?
    {
        if let err = error {
            print (err)
//          self.delegate.getMessagesError(err)
        }
        else
        {
            if let d = data
            {
                print ("data: \(d)")
                do
                {
                    if let response: NSArray = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                    {
                        print ("get response as array")
                        return (response)
                    }
                }
                catch (let err)
                {
                    print (err)
//                  self.delegate?.getMessagesError()
                }
                
            }
        }
        return (nil)
    }
}

