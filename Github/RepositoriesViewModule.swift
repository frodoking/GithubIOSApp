//
//  RepositoriesViewModule.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation

public class RepositoriesViewModule {
    var dataSource = DataSource()
    
    public func loadDataFromApiWithIsFirst (isFirst: Bool, language: String, handler: (repositories: NSArray) -> Void) {
        var page = 0;
        if (isFirst) {
            page = 1;
        } else {
            page = dataSource.page! + 1;
        }
        
        Server.shareInstance.searchRepositoriesWithPage(page, q: "language:\(language)", sort: "stars",
            completoinHandler: { (repositories, page, totalCount) -> Void in
                if (page <= 1) {
                    self.dataSource.reset()
                }
                self.dataSource.page = page
                print(totalCount)
                
                self.dataSource.dsArray?.addObjectsFromArray(repositories)
                handler(repositories: self.dataSource.dsArray!)
            })
            { (errors) -> Void in
                // do nothing
                handler(repositories: NSArray())
            }
    }
}
