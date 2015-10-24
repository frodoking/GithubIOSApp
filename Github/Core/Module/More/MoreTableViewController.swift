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
    private struct Storyboard {
        static let CellReuseIdentifier = "MoreCell"
    }

    var currentLogin: String?
    var currentAvatarUrl: String?
    
    var items = ["Login", "About", "Feedback", "Logout"]
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (currentLogin != nil) {
            return 4
        } else {
            return 3
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        if (indexPath.section == 0 && currentLogin != nil) {
                cell.textLabel!.text = currentLogin
                Alamofire.request(.GET, currentAvatarUrl!)
                    .responseData { response in
                        let imageData = UIImage(data: response.data!)
                        cell.imageView?.image = imageData
                }
        } else {
            cell.textLabel!.text = items[indexPath.section]
        }
        
        if (indexPath.section == 3 && currentLogin != nil) {
            cell.textLabel!.text = items[3]
        }

        return cell
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
