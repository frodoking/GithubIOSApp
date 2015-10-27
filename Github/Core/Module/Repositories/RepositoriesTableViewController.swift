//
//  RepositoriesTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {

    var viewModule: RepositoriesViewModule?
    var language: String = "JavaScript"
    
    var repositories = [Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backgroundColor = Theme.Color
        
        viewModule = RepositoriesViewModule()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let languageAppear = NSUserDefaults.standardUserDefaults().objectForKey("languageAppear1")?.integerValue {
            if (languageAppear == 2) {
                NSUserDefaults.standardUserDefaults().setObject("1", forKey: "languageAppear1")
                if let languageTmp = NSUserDefaults.standardUserDefaults().objectForKey("language1")?.stringValue {
                    if (languageTmp.isEmpty) {
                        self.language = "JavaScript";
                    } else {
                        self.language = languageTmp
                    }
                }
                
                self.title = language;
            }
        }
        
        refresh()
    }
    
    @IBAction func refreshAction(sender: UIRefreshControl) {
        refresh()
    }
    
    private func refresh() {
        refreshControl?.beginRefreshing()
        viewModule!.loadDataFromApiWithIsFirst(true, language: self.language) { repositories in
            self.refreshControl?.endRefreshing()
            if repositories.count > 0 {
                self.repositories = repositories as! [Repository]
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source
extension RepositoriesTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.repositories.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    @IBAction func languageAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("repositoriesLanguage", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.RepositoryCell, forIndexPath: indexPath) as! RepositoryTableViewCell
        
        // Configure the cell...
        cell.repository = self.repositories[indexPath.section]
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Theme.RepositoryTableViewCellheight
    }
}

// MARK: - Table view data delegate
extension RepositoriesTableViewController {
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
extension RepositoriesTableViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destinationViewController
        if let controller = viewController as? LanguageTableViewController {
            controller.entranceType = LanguageEntranceType.RepLanguageEntranceType
            controller.title = "Language"
        }
    }
}

