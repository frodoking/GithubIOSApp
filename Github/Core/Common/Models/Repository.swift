//
//  Repository.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Repository: NSObject {
    public var id: Int?
    public var name: String?
    public var full_name: String?
    public var owner: User?
    public var isPrivate: Bool?
    public var html_url: String?
    public var repositoryDescription: String?
    public var isFork: Bool?
    public var url: String?
    
    public var forks_url: String?
    public var keys_url: String?
    public var collaborators_url: String?
    public var created_at: String?
    public var updated_at: String?
    public var pushed_at: String?
    public var homepage: String?
    public var size: Int?
    public var stargazers_count: Int?
    public var watchers_count: Int?
    public var language: String?
    public var forks_count: Int?
    public var open_issues_count: Int?
    public var forks: Int?
    public var open_issues: Int?
    public var watchers: Int?
    
    //detail
    public var parentOwnerName: String?
    
    public func parseJson(json: JSON) {
        if let id = json["id"].int  {
            self.id = id
        }
        
        if let name = json["name"].string  {
            self.name = name
        }
        
        if let full_name = json["full_name"].string  {
            self.full_name = full_name
        }
        
        let ownerJson = json["owner"]
        if ownerJson != nil {
            let user = User()
            user.parseJson(ownerJson)
            self.owner = user
        }
        
        if let isPrivate = json["private"].bool  {
            self.isPrivate = isPrivate
        }
        
        if let html_url = json["html_url"].string  {
            self.html_url = html_url
        }
        
        if let repositoryDescription = json["description"].string  {
            self.repositoryDescription = repositoryDescription
        }
        
        if let isFork = json["fork"].bool  {
            self.isFork = isFork
        }
        
        if let url = json["url"].string  {
            self.url = url
        }
        
        if let forks_url = json["forks_url"].string  {
            self.forks_url = forks_url
        }
        
        if let keys_url = json["keys_url"].string  {
            self.keys_url = keys_url
        }
        
        if let collaborators_url = json["collaborators_url"].string  {
            self.collaborators_url = collaborators_url
        }
        
        if let created_at = json["created_at"].string  {
            self.created_at = created_at
        }
        
        if let updated_at = json["updated_at"].string  {
            self.updated_at = updated_at
        }
        
        if let pushed_at = json["pushed_at"].string  {
            self.pushed_at = pushed_at
        }
        
        if let homepage = json["homepage"].string  {
            self.homepage = homepage
        }
        
        if let size = json["size"].int  {
            self.size = size
        }
        if let stargazers_count = json["stargazers_count"].int  {
            self.stargazers_count = stargazers_count
        }
        if let watchers_count = json["watchers_count"].int  {
            self.watchers_count = watchers_count
        }
        if let language = json["language"].string  {
            self.language = language
        }
        if let forks_count = json["forks_count"].int  {
            self.forks_count = forks_count
        }
        if let open_issues_count = json["open_issues_count"].int  {
            self.open_issues_count = open_issues_count
        }
        if let forks = json["forks"].int  {
            self.forks = forks
        }
        if let open_issues = json["open_issues"].int  {
            self.open_issues = open_issues
        }
        if let watchers = json["watchers"].int  {
            self.watchers = watchers
        }
    }
    
    override public var description: String {
        return "my id: \(id!) \n"
    }
}