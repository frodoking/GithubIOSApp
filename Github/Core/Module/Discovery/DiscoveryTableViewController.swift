//
//  DiscoveryTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/24.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class DiscoveryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backgroundColor = Theme.Color  
    }

}
