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
    public struct Language {
    }
    
    public struct CellReuseIdentifier {
        static let RankCell = "RankCell"
        static let DiscoveryCell = "DiscoveryCell"
        static let RepositoriesCell = "RepositoriesCell"
        static let MoreCell = "MoreCell"
        
        static let LanguageCell = "LanguageCell"
        static let CountyCell = "CountyCell"
        static let CityCell = "CityCell"
    }
}
