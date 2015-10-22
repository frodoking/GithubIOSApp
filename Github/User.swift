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

    public let myID: Double
    public let rank: Int
    public let categoryLocation: String
    public let categoryLanguage: String
    public let login: String
    public let userId: Int
    public let avatar_url: String
    public let gravatar_id: Int
    public let url: String
    public let html_url: String
    public let followers_url: String
    public let following_url: String
    public let gists_url: String
    public let starred_url: String
    public let subscriptions_url: String
    public let organizations_url: String
    public let repos_url: String
    public let events_url: String
    public let received_events_url: String
    public let type: String
    public let site_admin: Bool
    public let score: String
    
    //detail part
    public let name: String
    public let company: String
    public let blog: String
    public let location: String
    public let email: String
    public let public_repos: Int
    public let followers: Int
    public let following: Int
    public let created_at: String
    
    public var description: String {
//        let json = JSON(NSData(self))?
        return ""
    }
}