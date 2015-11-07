//
//  User.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//
import UIKit
import SwiftyJSON

/*
"login": "frodoking",
"id": 7484982,
"avatar_url": "https://avatars.githubusercontent.com/u/7484982?v=3",
"gravatar_id": "",
"url": "https://api.github.com/users/frodoking",
"html_url": "https://github.com/frodoking",
"followers_url": "https://api.github.com/users/frodoking/followers",
"following_url": "https://api.github.com/users/frodoking/following{/other_user}",
"gists_url": "https://api.github.com/users/frodoking/gists{/gist_id}",
"starred_url": "https://api.github.com/users/frodoking/starred{/owner}{/repo}",
"subscriptions_url": "https://api.github.com/users/frodoking/subscriptions",
"organizations_url": "https://api.github.com/users/frodoking/orgs",
"repos_url": "https://api.github.com/users/frodoking/repos",
"events_url": "https://api.github.com/users/frodoking/events{/privacy}",
"received_events_url": "https://api.github.com/users/frodoking/received_events",
"type": "User",
"site_admin": false,
"name": "frodo",
"company": "BD",
"blog": "http://frodoking.github.io/",
"location": "beijing",
"email": "awangyun8@gmail.com",
"hireable": true,
"bio": null,
"public_repos": 42,
"public_gists": 0,
"followers": 16,
"following": 11,
"created_at": "2014-05-05T05:14:43Z",
"updated_at": "2015-11-07T05:29:00Z"
*/
public class User: NSObject {
    public var rank: Int?
    public var categoryLocation: String?
    public var categoryLanguage: String?
    
    public var id: Double?
    public var login: String?
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
    
    //detail part
    public var name: String?
    public var company: String?
    public var blog: String?
    public var location: String?
    public var email: String?
    public var hireable: Bool?
    public var bio: String?
    public var public_repos: Int?
    public var public_gists: Int?
    public var followers: Int?
    public var following: Int?
    public var created_at: String?
    public var updated_at: String?
    
    public func parseJson(json: JSON) {
        if let id = json["id"].double {
            self.id = id
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
        if let public_gists = json["public_gists"].int {
            self.public_gists = public_gists
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
        if let updated_at = json["updated_at"].string {
            self.updated_at = updated_at
        }
    }
    
    override public var description: String {
      return JSON(self).description
    }
}