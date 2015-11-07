//
//  UserDetailViewModule.swift
//  Github
//
//  Created by frodo on 15/10/27.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation

public class UserDetailViewModule {
    static let Indicator: NSMutableArray = ["Repositories", "Following", "Followers"]
    var userRepositoriesDataSource = DataSource()
    var userFollowingDataSource = DataSource()
    var userFollowersDataSource = DataSource()
    var currentTabViewIndex: Int = 0
    

    public func loadUserFromApi(userName: String, handler: (user: User?) -> Void) {
        Server.shareInstance.userDetailWithUserName(userName,
            completoinHandler: { user in
                handler(user: user)
            },
            errorHandler: { errors in
                handler(user: nil)
            })
    }
    
    public func loadDataFromApiWithIsFirst(isFirst: Bool, currentIndex: Int, userName: String, handler: (array: NSArray) -> Void) {
        
        switch currentIndex {
            case 0:
                var page:Int = 0
                
                if (isFirst) {
                    page = 1;
                } else {
                    page = userRepositoriesDataSource.page!+1;
                }
                
                Server.shareInstance.userRepositoriesWithPage(page, userName: userName, sort: "updated",
                    completoinHandler: { (repositories, page) in
                        if (page <= 1) {
                            self.userRepositoriesDataSource.reset()
                        }
                        self.userRepositoriesDataSource.page = page
                        
                        self.userRepositoriesDataSource.dsArray?.addObjectsFromArray(repositories)
                        handler(array: self.userRepositoriesDataSource.dsArray!)
                    },
                    errorHandler: { errors in
                        // do nothing
                        handler(array: NSArray())
                })
                break
            case 1:
                var page:Int = 0
                
                if (isFirst) {
                    page = 1;
                } else {
                    page = userFollowingDataSource.page!+1;
                }
                
                Server.shareInstance.userFollowingWithPage(page, userName: userName,
                    completoinHandler: { (users, page) in
                        if (page <= 1) {
                            self.userFollowingDataSource.reset()
                        }
                        self.userFollowingDataSource.page = page
                        
                        self.userFollowingDataSource.dsArray?.addObjectsFromArray(users)
                        handler(array: self.userFollowingDataSource.dsArray!)
                    },
                    errorHandler: { errors in
                        // do nothing
                        handler(array: NSArray())
                })
                break
            case 2:
                var page:Int = 0
                
                if (isFirst) {
                    page = 1;
                } else {
                    page = userFollowersDataSource.page!+1;
                }
                
                Server.shareInstance.userFollowersWithPage(page, userName: userName,
                    completoinHandler: { (users, page) in
                        if (page <= 1) {
                            self.userFollowersDataSource.reset()
                        }
                        self.userFollowersDataSource.page = page
                        
                        self.userFollowersDataSource.dsArray?.addObjectsFromArray(users)
                        handler(array: self.userFollowersDataSource.dsArray!)
                    },
                    errorHandler: { errors in
                        // do nothing
                        handler(array: NSArray())
                })
                break
            default: break
        }
    }
}