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

public class UserRankViewModule {
    var language: NSString?
    var dataSource = DataSource()
    
    public func loadDataFromApiWithIsFirst(isFirst: Bool,  currentIndex:Int, handler: (users: NSArray) -> Void) {
        if (currentIndex==1) {
            
            var page:Int = 0
            
            if (isFirst) {
                page = 1;
            } else {
                page = dataSource.page!+1;
            }
            
            var city: String
            if let defaultCity = NSUserDefaults.standardUserDefaults().objectForKey("pinyinCity") {
                city = defaultCity as! String
            } else {
                city = "beijing"
            }
            
            var language: String
            if let defaultLanguage = NSUserDefaults.standardUserDefaults().objectForKey("language") {
                language = defaultLanguage as! String
            } else {
                language = ""
            }
            
            var q = "location:\(city)+language:\(language)"
            if language.isEmpty {
                q = "location:\(city)"
            }
            
            Server.shareInstance.searchUsersWithPage(page, q: q, sort: "desc", categoryLocation: city, categoryLanguage: language, completoinHandler: { (users, page, totalCount) -> Void in
                    if (page <= 1) {
                        self.dataSource.reset()
                    }
                    self.dataSource.page = page
                    print(totalCount)
                
                    self.dataSource.dsArray?.addObjectsFromArray(users)
                    handler(users: self.dataSource.dsArray!)
                }, errorHandler: { (errors) -> Void in
                    // do nothing
                    handler(users: NSArray())
                })
            }
    }
}