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
        static let UserRepositories: String = Host + "/users/%@/repos" // /users/frodoking/repos
        static let UserFollowing: String = Host + "/users/%@/following"
        static let UserFollowers: String = Host + "/users/%@/followers"
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
                    NSLog("======= Success Response ======= ")
                    print(response)
                    NSLog("======= Success Response ======= ")
                    if let json = response.result.value {
                        let jsonObject = JSON(json)
                        var totalCount = 0
                        if let count = jsonObject["total_count"].int  {
                            totalCount = count
                        }
                        let jsonItems = jsonObject["items"].arrayValue
                        var users = [User]()
                        for ( var i = 0; i < jsonItems.count; i++) {
                            let item = jsonItems[i]
                            
                            let user = User()
                            user.parseJson(item)
                            
                            user.rank = Int((page-1)*30+(i+1))
                            user.categoryLanguage = categoryLanguage;
                            user.categoryLocation = categoryLocation;
                            user.id = NSDate.timeIntervalSinceReferenceDate()
                            users.append(user)
                        }
                        
                        completoinHandler(users: users, page: page, totalCount: totalCount)
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
                            
                            let jsonItems = jsonObject["items"].arrayValue
                            var repositories = [Repository]()
                            for ( var i = 0; i < jsonItems.count; i++) {
                                let item = jsonItems[i]
                                
                                let repository = Repository()
                                repository.parseJson(item)
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
    
    //https://developer.github.com/v3/repos/#list-user-repositories
    //List user repositories
    //GET /users/:username/repos?sort=updated&page=%ld
    public func userRepositoriesWithPage(page: Int, userName: String, sort: String,
        completoinHandler: (repositories: [Repository], page: Int) -> Void,
        errorHandler: (errors: AnyObject) -> Void) {
            let params = ["page": "\(page)", "sort": "\(sort)"]
            let url: String = NSString.init(format: Server.URL.UserRepositories, userName) as String
            NSLog("Fetch: Host: \(url) , params: \(params)")
            Alamofire.request(.GET, url, parameters: params, encoding: ParameterEncoding.URL, headers: Server.customHeaderFields)
                .responseJSON { response in
                    if response.result.isSuccess {
                        NSLog("======= Success ======= ")
                        if let json = response.result.value {
                            let jsonObject = JSON(json)
                            let jsonItems = jsonObject.arrayValue
                            var repositories = [Repository]()
                            for ( var i = 0; i < jsonItems.count; i++) {
                                let item = jsonItems[i]
                                
                                let repository = Repository()
                                repository.parseJson(item)
                                repositories.append(repository)
                                NSLog("==>> repository \(repository) <<== ")
                            }
                            
                            completoinHandler(repositories: repositories, page: page)
                        }
                    } else {
                        if(response.result.error != nil) {
                            NSLog("Error: \(response.result.error)")
                            errorHandler(errors: response.result.error!)
                        }
                    }
            }
    }
    
    //List users followed by another user
    //https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
    //GET /users/:username/following like /users/%@/following?page=%ld
    public func userFollowingWithPage(page: Int, userName: String,
        completoinHandler: (users: [User], page: Int) -> Void,
        errorHandler: (errors: AnyObject) -> Void)  {
            let params = ["page": "\(page)"]
            let url: String = NSString.init(format: Server.URL.UserFollowing, userName) as String
            NSLog("Fetch: Host: \(url) , params: \(params)")
            Alamofire.request(.GET, url, parameters: params, encoding: ParameterEncoding.URL, headers: Server.customHeaderFields)
                .responseJSON { response in
                    if response.result.isSuccess {
                        NSLog("======= Success ======= ")
                        if let json = response.result.value {
                            let jsonObject = JSON(json)
                            let jsonItems = jsonObject.arrayValue
                            var users = [User]()
                            for ( var i = 0; i < jsonItems.count; i++) {
                                let item = jsonItems[i]
                                
                                let user = User()
                                user.parseJson(item)
                                user.rank = (i+1)
                                users.append(user)
                                NSLog("==>> user \(user) <<== ")
                            }
                            
                            completoinHandler(users: users, page: page)
                        }
                    } else {
                        if(response.result.error != nil) {
                            NSLog("Error: \(response.result.error)")
                            errorHandler(errors: response.result.error!)
                        }
                    }
            }
    }
    
    //List followers of a user
    //https://developer.github.com/v3/users/followers/#list-followers-of-a-user
    //GET /users/:username/followers like /users/%@/followers?page=%ld
    public func userFollowersWithPage(page: Int, userName: String,
        completoinHandler: (users: [User], page: Int) -> Void,
        errorHandler: (errors: AnyObject) -> Void)  {
            let params = ["page": "\(page)"]
            let url: String = NSString.init(format: Server.URL.UserFollowers, userName) as String
            NSLog("Fetch: Host: \(url) , params: \(params)")
            Alamofire.request(.GET, url, parameters: params, encoding: ParameterEncoding.URL, headers: Server.customHeaderFields)
                .responseJSON { response in
                    if response.result.isSuccess {
                        NSLog("======= Success ======= ")
                        if let json = response.result.value {
                            let jsonObject = JSON(json)
                            let jsonItems = jsonObject.arrayValue
                            var users = [User]()
                            for ( var i = 0; i < jsonItems.count; i++) {
                                let item = jsonItems[i]
                                
                                let user = User()
                                user.parseJson(item)
                                user.rank = (i+1)
                                users.append(user)
                                NSLog("==>> user \(user) <<== ")
                            }
                            
                            completoinHandler(users: users, page: page)
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
