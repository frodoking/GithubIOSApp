//
//  CityTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/22.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {

    var cities = [String]()
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        if let prevViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] {
            self.navigationController?.popToViewController(prevViewController, animated: true)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = UIColor.whiteColor()
    } 

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.cities.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.CityCell, forIndexPath: indexPath)
        
        cell.textLabel!.text = cities[indexPath.section]
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.navigationController?.viewControllers.count > 0 {
            if let rootViewController = self.navigationController?.viewControllers[0] {
                if let usersViewController = rootViewController as? UsersViewController {
                    usersViewController.city = cities[indexPath.section]
                }
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
