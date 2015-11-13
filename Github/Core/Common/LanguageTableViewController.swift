//
//  LanguageTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/22.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {

    var languages = [String]()
    var language: String = "Language"
     
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = language
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        languages=["All Languages","JavaScript","Java","PHP","Ruby","Python","CSS","C","Objective-C","Shell","R","Perl","Lua","HTML","Scala","Go"]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.languages.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.LanguageCell, forIndexPath: indexPath)
        
        cell.textLabel!.text=languages[indexPath.section]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var language = languages[indexPath.section]
        if indexPath.section == 0 {
            language = ""
        }
        if let prevViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] {
            switch prevViewController {
            case is UsersViewController:
                let usersViewController = prevViewController as! UsersViewController
                usersViewController.language = language
                break
            case is RepositoriesTableViewController:
                let repositoriesTableViewController = prevViewController as! RepositoriesTableViewController
                repositoriesTableViewController.language = language
                break
            default:break
            }
            self.navigationController?.popToViewController(prevViewController, animated: true)

        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }

}
