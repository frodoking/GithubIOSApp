//
//  DataSource.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import Foundation

public class DataSource : CustomStringConvertible {
    
    var dsArray: NSMutableArray?
    var page: Int?
    var totalCount: Int?
    
    init() {
        self.dsArray = NSMutableArray.init(capacity: 32)
        self.page = 0;
    }
    
    public func reset() {
        self.page = 0
        self.dsArray!.removeAllObjects()
    }
    
    public var description: String {
        return ""
    }
}