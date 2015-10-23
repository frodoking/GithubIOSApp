//
//  UserRankTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class UserRankTableViewController: UITableViewController {
    
    var viewModule: UserRankViewModule?
    var index: Int = 1
    
    private struct Storyboard {
        static let CellReuseIdentifier = "RankCell"
    }
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension 
        
        viewModule = UserRankViewModule()
        
        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
    }
    
    private func refresh() {
        refreshControl?.beginRefreshing()
        viewModule!.loadDataFromApiWithIsFirst(true, currentIndex: index) { users in
            self.refreshControl?.endRefreshing()
            if users.count > 0 {
                self.users = users as! [User]
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.users.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! RankTableViewCell

        // Configure the cell...
        cell.user = self.users[indexPath.section]
        
        
        return cell
    }
    
    
    @IBAction func cityAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("country", sender: self)
    }

    @IBAction func languageAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("language", sender: self)
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destinationViewController
        if let controller = viewController as? LanguageTableViewController {
            controller.entranceType = LanguageEntranceType.UserLanguageEntranceType
            controller.title = "Language"
        }
    }

}
