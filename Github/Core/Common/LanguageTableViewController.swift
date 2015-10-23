//
//  LanguageTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/22.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {
    private struct Storyboard {
        static let CellReuseIdentifier = "LanguageCell"
    }

    var languages = [String]()
    var language: String = "Language"
    
    var entranceType: LanguageEntranceType = LanguageEntranceType.RepLanguageEntranceType
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.navigationController?.dismissViewControllerAnimated(true) { handle in
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = language
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        
        switch entranceType {
        case .UserLanguageEntranceType:
            languages=["","JavaScript","Java","PHP","Ruby","Python","CSS","C","Objective-C","Shell","R","Perl","Lua","HTML","Scala","Go"]
            break
        case .RepLanguageEntranceType:
            languages=["JavaScript","Java","PHP","Ruby","Python","CSS","C","Objective-C","Shell","R","Perl","Lua","HTML","Scala","Go"];
            break
        case .TrendingLanguageEntranceType:
            languages=["","javascript","java","php","ruby","python","css","c","objective-c","shell","r","perl","lua","html","scala","go"]
            break
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel!.text=languages[indexPath.section];
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch entranceType {
        case .UserLanguageEntranceType:
            NSUserDefaults.standardUserDefaults().setObject(2, forKey: "languageAppear")
            NSUserDefaults.standardUserDefaults().setObject(languages[indexPath.section], forKey: "language")
            break
        case .RepLanguageEntranceType:
            NSUserDefaults.standardUserDefaults().setObject(2, forKey: "languageAppear1")
            NSUserDefaults.standardUserDefaults().setObject(languages[indexPath.section], forKey: "language1")
            break
        case .TrendingLanguageEntranceType:
            NSUserDefaults.standardUserDefaults().setObject(2, forKey: "languageAppear2")
            NSUserDefaults.standardUserDefaults().setObject(languages[indexPath.section], forKey: "language2")
            break
        }
        self.navigationController?.dismissViewControllerAnimated(true) { handle in
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
