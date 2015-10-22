//
//  Server.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation

struct Server {
    struct URL {
        static let Base: String = "https://api.github.com"
        static let Users: String = Base + "/search/users" // sort=followers&order=desc&q=language:java
        static let Country: String = Base + "aa"
    }
}
