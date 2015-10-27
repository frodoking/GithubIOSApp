//
//  UserRankTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var viewModule: UsersViewModule?
    var tab: Int = 1
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backgroundColor = Theme.Color
        
        viewModule = UsersViewModule()
        
        refresh()
    } 
    
    @IBAction func refreshAction(sender: UIRefreshControl) {
        refresh()
    }
    
    private func refresh() {
        refreshControl?.beginRefreshing()
        viewModule!.loadDataFromApiWithIsFirst(true, currentTab: tab) { users in
            self.refreshControl?.endRefreshing()
            if users.count > 0 {
                self.users = users as! [User]
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func cityAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("country", sender: self)
    }

    @IBAction func languageAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("language", sender: self)
    }
}

// MARK: - Table view data source
extension UsersTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.users.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.UserCell, forIndexPath: indexPath) as! UserTableViewCell
        
        
        cell.user = self.users[indexPath.section]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Theme.UserTableViewCellHeight
    }
}

// MARK: - Table view data delegate
extension UsersTableViewController {
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
}

// MARK: - Navigation
extension UsersTableViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destinationViewController
        if let controller = viewController as? LanguageTableViewController {
            controller.entranceType = LanguageEntranceType.UserLanguageEntranceType
            controller.title = "Language"
        } else if let
            navigationController = viewController as? UINavigationController,
            detailViewController = navigationController.topViewController as? UserDetailViewController
        {
            if let cell = sender as? UserTableViewCell {
                let selectedIndex = tableView.indexPathForCell(cell)?.section
                if let index = selectedIndex {
                    detailViewController.user = users[index]
                }
            }
        }
    }
}
