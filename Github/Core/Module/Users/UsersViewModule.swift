//
//  UserRankViewModule.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class UsersViewModule { 
    var dataSource = DataSource()
    
    var totalCount: Int = 0
    
    public func loadDataFromApiWithIsFirst(isFirst: Bool,  location: String, language: String, handler: (users: NSArray) -> Void) {
        var q: String = ""
        var page:Int = 0
        
        if (isFirst) {
            page = 1;
        } else {
            page = dataSource.page!+1;
        }
        
        if !language.isEmpty && !location.isEmpty {
            q = "location:\(location)+language:\(language)"
        } else if language.isEmpty && !location.isEmpty {
            q = "location:\(location)"
        } else if !language.isEmpty && location.isEmpty {
            q = "language:\(language)"
        }
        
        Server.shareInstance.searchUsersWithPage(page, q: q, sort: "followers", location: location, language: language, completoinHandler: { (users, page, totalCount) -> Void in
            if (page <= 1) {
                 self.dataSource.reset()
            }
            self.dataSource.page = page
            self.totalCount = totalCount
            
            self.dataSource.dsArray?.addObjectsFromArray(users)
            handler(users: self.dataSource.dsArray!)
            }, errorHandler: { (errors) -> Void in
                // do nothing
                handler(users: NSArray())
        })
    }
}