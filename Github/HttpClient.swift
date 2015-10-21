//
//  HttpClient.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation

public class HttpClient {
    static let Base_Url_User: String = "https://api.github.com/search/users?sort=followers&order=desc&q=language:"
    static let Language_Objective_C: String = "objective-c"
    static let Language_Java: String = "java"
    static let Language_C: String = "c"
    
    public let url: String
    
    init() {
        self.url = HttpClient.Base_Url_User
    }
    
    init(_url: String) {
        self.url = _url
    }
    
    func fetchUser(language: String, handler: (users: [User]) -> Void ) {
        fetch(self.url + language) { (data) -> Void in
            let jsonResult: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            if let jsonObject = jsonResult as? NSDictionary {
                if let items = jsonObject["items"] as? NSArray {
                    var users: [User] = [User]()
                    for item in items {
                        let login = item["login"] as? String
                        let avatar_url = item["avatar_url"] as? String
                        let user = User(login: login!, avatar_url: avatar_url!)
                        print("\(user)")
                        users.append(user)
                    }
                    handler(users: users)
                }
            }
        }
    }
    
    func fetch(urlString: String, completioHandler: (data: NSData!) -> Void) {
        print("fetch url: \(urlString)")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            if let url = NSURL(string: urlString) {
                let request = NSURLRequest(URL: url)
                let task = session.downloadTaskWithRequest(request, completionHandler: {
                    (localURL, response, error) -> Void in
                    
                    if localURL != nil {
                        let nsData = NSData(contentsOfURL: localURL!)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            completioHandler(data: nsData)
                        })
                    }
                    
                    if (error == nil) {
                        print("success >>>>> \n")
                    } else {
                        print("error >>>>> \n")
                    }
                })
                task.resume()
            }
        })
    }
}