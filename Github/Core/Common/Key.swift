//
//  Key.swift
//  Github
//
//  Created by frodo on 15/10/24.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation

public struct Key {
    public struct User {
        static let CurrentLogin = "currentLogin"
        static let CurrentAvatarUrl = "currentAvatarUrl"
    }
    public struct SegueIdentifier {
        static let Country = "Country"
        static let City = "City" 
    }
    
    public struct LanguageFrom {
        static let User = "Language From User"
        static let Repository = "Language From Repository"
        static let Trending = "Repository"
    }
    
    public struct CellReuseIdentifier {
        static let UserCell = "UserCell"
        static let DiscoveryCell = "DiscoveryCell"
        static let RepositoryCell = "RepositoryCell"
        static let MoreCell = "MoreCell"
        
        static let LanguageCell = "LanguageCell"
        static let CountyCell = "CountyCell"
        static let CityCell = "CityCell"
    }
}
