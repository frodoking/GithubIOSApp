//
//  RepositoryDetailViewModule.swift
//  Github
//
//  Created by frodo on 15/11/7.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation
public class RepositoryDetailViewModule {
    static let Indicator: NSMutableArray = ["Contributors", "Forks", "Stargazers"]
    
    var contributorsDataSource = DataSource()
    var forksDataSource = DataSource()
    var stargazersDataSource = DataSource()
    
    var currentTabViewIndex: Int = 0
    
    public func loadDataFromApiWithIsFirst(isFirst: Bool, currentIndex: Int, userName: String, repositoryName: String,
        handler: (array: NSArray) -> Void) {
        var page:Int = 0
        switch currentIndex {
        case 0:
            if (isFirst) {
                page = 1
            } else {
                page = contributorsDataSource.page!+1
            }
            
            Server.shareInstance.reposDetailForContributorsWithPage(userName, repositoryName: repositoryName, page: page, completoinHandler: { (users, page) -> Void in
                    if (page <= 1) {
                        self.contributorsDataSource.reset()
                    }
                    self.contributorsDataSource.page = page
                    
                    self.contributorsDataSource.dsArray?.addObjectsFromArray(users)
                    handler(array: self.contributorsDataSource.dsArray!)
                },
                errorHandler: { (errors) -> Void in
                     // do nothing
                    handler(array: NSArray())
                })
            break
        case 1:
            if (isFirst) {
                page = 1
            } else {
                page = forksDataSource.page!+1
            }
            Server.shareInstance.reposDetailForForksWithPage(userName, repositoryName: repositoryName, page: page,
                completoinHandler: { (users, page) -> Void in
                    if (page <= 1) {
                        self.forksDataSource.reset()
                    }
                    self.forksDataSource.page = page
                    
                    self.forksDataSource.dsArray?.addObjectsFromArray(users)
                    handler(array: self.forksDataSource.dsArray!)
                },
                errorHandler: { (errors) -> Void in
                    // do nothing
                    handler(array: NSArray())
                })
            break
        case 2:
            if (isFirst) {
                page = 1
            } else {
                page = stargazersDataSource.page!+1
            }
            Server.shareInstance.reposDetailForStargazersWithPage(userName, repositoryName: repositoryName, page: page,
                completoinHandler: { (users, page) -> Void in
                    if (page <= 1) {
                        self.stargazersDataSource.reset()
                    }
                    self.stargazersDataSource.page = page
                    
                    self.stargazersDataSource.dsArray?.addObjectsFromArray(users)
                    handler(array: self.stargazersDataSource.dsArray!)
                },
                errorHandler: { (errors) -> Void in
                    // do nothing
                    handler(array: NSArray())
                })
            break
        default:break
        }
    }
}