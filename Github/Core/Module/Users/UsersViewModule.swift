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
    var allDataSource = DataSource()
    var countryDataSource = DataSource()
    var cityDataSource = DataSource()
    
    var totalCount: Int = 0
    
    public func loadDataFromApiWithIsFirst(isFirst: Bool,  currentTab:Int, handler: (users: NSArray) -> Void) {
        var dataSource: DataSource?
        var location: String = ""
        var language: String = ""
        var q: String = ""
        
        if let defaultLanguage = NSUserDefaults.standardUserDefaults().objectForKey("language") {
            language = defaultLanguage as! String
        }
        
        switch currentTab {
        case 0:
            dataSource = cityDataSource
            
            if let defaultCity = NSUserDefaults.standardUserDefaults().objectForKey("city") {
                location = defaultCity as! String
            } else {
                location = "beijing"
            }
            break
        case 1:
            dataSource = countryDataSource
            if let defaultCountry = NSUserDefaults.standardUserDefaults().objectForKey("country") {
                location = defaultCountry as! String
            } else {
                location = "China"
            }
            break
        default:
            dataSource = allDataSource
            break
        }
        
        var page:Int = 0
        
        if (isFirst) {
            page = 1;
        } else {
            page = dataSource!.page!+1;
        }
        
        q = "location:\(location)+language:\(language)"
        if language.isEmpty {
            q = "location:\(location)"
            if location.isEmpty {
                q = "language:all languages"
            }
        }

        Server.shareInstance.searchUsersWithPage(page, q: q, sort: "followers", categoryLocation: location, categoryLanguage: language, completoinHandler: { (users, page, totalCount) -> Void in
            if (page <= 1) {
                 dataSource!.reset()
            }
            dataSource!.page = page
            self.totalCount = totalCount
            
            dataSource!.dsArray?.addObjectsFromArray(users)
            handler(users: dataSource!.dsArray!)
            }, errorHandler: { (errors) -> Void in
                // do nothing
                handler(users: NSArray())
        })
    }
}