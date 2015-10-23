//
//  Server.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class Server: NSObject {
    //NSMutableDictionary *header=[NSMutableDictionary dictionaryWithObject:@"application/vnd.github.v3+json" forKey:@"Accept"];
   // self = [self initWithHostName:@"api.github.com" customHeaderFields:header];
    
    static let customHeaderFields = ["Accept": "application/vnd.github.v3+json"]

    struct URL {
        static let Host: String = "https://api.github.com"
        static let Users: String = Host + "/search/users" // sort=followers&order=desc&q=language:java
        static let Repositories: String = Host + "/search/repositories"
        static let Country: String = Host + "aa"
    }
    
    class var shareInstance: Server {
        struct Singleton {
            static let instance = Server()
        }
        return Singleton.instance
    }
    
    // https://developer.github.com/v3/search/#search-users
    // Search users
    public func searchUsersWithPage(page: Int, q: String, sort: String, categoryLocation: String, categoryLanguage: String,
        completoinHandler: (users: [User], page: Int, totalCount: Int) -> Void,
        errorHandler: (errors: AnyObject) -> Void) {
            let params = ["sort": "\(sort)", "q": "\(q)", "page": "\(page)"]
            NSLog("Fetch: Host: \(Server.URL.Users) , params: \(params)")
            Alamofire.request(.GET, Server.URL.Users, parameters: params, encoding: ParameterEncoding.URL, headers: Server.customHeaderFields)
                .responseJSON { response in
                if response.result.isSuccess {
                    NSLog("======= Success ======= ")
                    if let json = response.result.value {
                        let jsonObject = JSON(json)
                        let totalCount = jsonObject["total_count"].int
                        print("totalCount: \(totalCount)")
                        
                        let jsonItems = jsonObject["items"].arrayValue
                        var users = [User]()
                        for ( var i = 0; i < jsonItems.count; i++) {
                            let item = jsonItems[i]
                            
                            let user = User()
                            user.parseJson(item)
                            print(user.description)
                            
                            user.rank = Int((page-1)*30+(i+1))
                            user.categoryLanguage = categoryLanguage;
                            user.categoryLocation = categoryLocation;
                            user.id = NSDate.timeIntervalSinceReferenceDate()
                            users.append(user)
                        }
                        
                        completoinHandler(users: users, page: page, totalCount: totalCount!)
                    }
                } else {
                    if(response.result.error != nil) {
                        NSLog("Error: \(response.result.error)")
                        errorHandler(errors: response.result.error!)
                    }
                }
            }
    }
    
    // Search repositories 
    // https://api.github.com/search/repositories?q=language:java&sort=stars&page=0
    public func searchRepositoriesWithPage(page: Int, q: String, sort: String,
        completoinHandler: (repositories: [Repository], page: Int, totalCount: Int) -> Void,
        errorHandler: (errors: AnyObject) -> Void) {
            let params = ["sort": "\(sort)", "q": "\(q)", "page": "\(page)"]
            NSLog("Fetch: Host: \(Server.URL.Repositories) , params: \(params)")
            Alamofire.request(.GET, Server.URL.Repositories, parameters: params, encoding: ParameterEncoding.URL, headers: Server.customHeaderFields)
                .responseJSON { response in
                    if response.result.isSuccess {
                        NSLog("======= Success ======= ")
                        if let json = response.result.value {
                            let jsonObject = JSON(json)
                            let totalCount = jsonObject["total_count"].int
                            print("totalCount: \(totalCount)")
                            
                            let jsonItems = jsonObject["items"].arrayValue
                            var repositories = [Repository]()
                            for ( var i = 0; i < jsonItems.count; i++) {
                                let item = jsonItems[i]
                                
                                let repository = Repository()
                                repository.parseJson(item)
                                print(repository.description)
                                repositories.append(repository)
                            }
                            
                            completoinHandler(repositories: repositories, page: page, totalCount: totalCount!)
                        }
                    } else {
                        if(response.result.error != nil) {
                            NSLog("Error: \(response.result.error)")
                            errorHandler(errors: response.result.error!)
                        }
                    }
            }
    }
}
