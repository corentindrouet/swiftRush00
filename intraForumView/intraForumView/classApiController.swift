//
//  classApiController.swift
//  intraForumView
//
//  Created by Corentin DROUET on 10/7/17.
//  Copyright © 2017 Corentin DROUET / Mathilde Ressier. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate: API42Delegate?
    var token: String?
    let credentials: credentialsStruct?
    var userId: UInt?
    
    init(newDelegate: API42Delegate?, newCredentials: credentialsStruct, code: String) {
        self.delegate = newDelegate
        self.credentials = newCredentials
        let options = ("grant_type=authorization_code&client_id=" + (self.credentials?.UID!)! + "&client_secret=" + (self.credentials?.Secret!)! + "&code=" + code + "&redirect_uri=http%3A%2F%2Fapi.intra.42.fr").data(using: String.Encoding.utf8)
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = options
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            print(response!)
            if let err = error {
                self.delegate?.requestFailed(error: err)
                print(err)
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let newToken = dic["access_token"] as? String {
                            self.token = "Bearer " + newToken
                            DispatchQueue.main.async {
                                //self.delegate?.requestSuccess(data: nil)
                                self.getUserId()
                            }
                        }
                    }
                } catch (let err) {
                    self.delegate?.requestFailed(error: err)
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    init(controller: APIController)
    {
        self.delegate = controller.delegate
        self.token = controller.token
        self.userId = controller.userId
        self.credentials = controller.credentials
    }
    
    private func getUserId() {
        let url = URL(string: "https://api.intra.42.fr/v2/me")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(self.token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            print(response!)
            if let err = error {
                print(err)
                self.delegate?.requestFailed(error: err)
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let id = dic["id"] as? UInt {
                            print("USERID")
                            self.userId = id
                            print(self.userId!)
                            DispatchQueue.main.async {
                                self.delegate?.requestSuccess(data: self.token!)
                            }
                        }
                    }
                } catch (let err) {
                    self.delegate?.requestFailed(error: err)
                    print(err)
                }
            }
        }
        task.resume()
    }
    
}
