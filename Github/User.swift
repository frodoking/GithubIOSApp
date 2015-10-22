//
//  User.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct User: CustomStringConvertible {

    public var myID: Double?
    public var rank: Int?
    public var categoryLocation: String?
    public var categoryLanguage: String?
    public var login: String?
    public var userId: Int?
    public var avatar_url: String?
    public var gravatar_id: Int?
    public var url: String?
    public var html_url: String?
    public var followers_url: String?
    public var following_url: String?
    public var gists_url: String?
    public var starred_url: String?
    public var subscriptions_url: String?
    public var organizations_url: String?
    public var repos_url: String?
    public var events_url: String?
    public var received_events_url: String?
    public var type: String?
    public var site_admin: Bool?
    public var score: String?
    
    //detail part
    public var name: String?
    public var company: String?
    public var blog: String?
    public var location: String?
    public var email: String?
    public var public_repos: Int?
    public var followers: Int?
    public var following: Int?
    public var created_at: String?
    
    public mutating func parseJson(json: JSON) {
        if let myID = json["myID"].double {
            self.myID = myID
        }
        
        if let rank = json["rank"].int {
            self.rank = rank
        }
        
        if let categoryLocation = json["categoryLocation"].string {
            self.categoryLocation = categoryLocation
        }
        
        if let categoryLanguage = json["categoryLanguage"].string {
            self.categoryLanguage = categoryLanguage
        }
        
        if let login = json["login"].string {
            self.login = login
        }
        
        if let userId = json["userId"].int {
            self.userId = userId
        }
        
        if let avatar_url = json["avatar_url"].string {
            self.avatar_url = avatar_url
        }
        
        if let gravatar_id = json["gravatar_id"].int {
            self.gravatar_id = gravatar_id
        }
        
        if let url = json["url"].string {
            self.url = url
        }
        
        if let html_url = json["html_url"].string {
            self.html_url = html_url
        }
        
        if let followers_url = json["followers_url"].string {
            self.followers_url = followers_url
        }
        
        if let following_url = json["following_url"].string {
            self.following_url = following_url
        }
        
        if let gists_url = json["gists_url"].string {
            self.gists_url = gists_url
        }
        
        if let starred_url = json["starred_url"].string {
            self.starred_url = starred_url
        }
        
        if let subscriptions_url = json["subscriptions_url"].string {
            self.subscriptions_url = subscriptions_url
        }
        
        if let organizations_url = json["organizations_url"].string {
            self.organizations_url = organizations_url
        }
        
        if let repos_url = json["repos_url"].string {
            self.repos_url = repos_url
        }
        
        if let events_url = json["events_url"].string {
            self.events_url = events_url
        }
        
        if let received_events_url = json["received_events_url"].string {
            self.received_events_url = received_events_url
        }
        
        if let type = json["type"].string {
            self.type = type
        }
        
        if let site_admin = json["site_admin"].bool {
            self.site_admin = site_admin
        }
        
        if let score = json["score"].string {
            self.score = score
        }
        
        if let name = json["name"].string {
            self.name = name
        }
        
        if let company = json["company"].string {
            self.company = company
        }
        
        if let blog = json["blog"].string {
            self.blog = blog
        }
        if let location = json["location"].string {
            self.location = location
        }
        if let email = json["email"].string {
            self.email = email
        }
        if let public_repos = json["public_repos"].int {
            self.public_repos = public_repos
        }
        if let followers = json["followers"].int {
            self.followers = followers
        }
        if let following = json["following"].int {
            self.following = following
        }
        if let created_at = json["created_at"].string {
            self.created_at = created_at
        } 
    }
    
    public var description: String {
//        let json = JSON(NSData(self))?
        return ""
    }
}