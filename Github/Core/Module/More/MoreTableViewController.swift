//
//  MoreTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/24.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class MoreTableViewController: UITableViewController {
    
    var currentLogin: String?
    var currentAvatarUrl: String? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backgroundColor = Theme.Color

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        currentLogin = NSUserDefaults.standardUserDefaults().objectForKey(Key.User.CurrentLogin)?.stringValue
        currentAvatarUrl = NSUserDefaults.standardUserDefaults().objectForKey(Key.User.CurrentAvatarUrl)?.stringValue
    }

}
