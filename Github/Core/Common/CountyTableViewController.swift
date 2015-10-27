//
//  CountyTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/22.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CountyTableViewController: UITableViewController {

    var countrys = [String]()
    
    var country: String?
    var cityArray = [String]()


    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "County"
        
        countrys=["USA","UK","Germany","China","Canada","India","France","Australia","Other"]
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
        return self.countrys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.CountyCell, forIndexPath: indexPath)

        cell.textLabel!.text=countrys[indexPath.section]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row != countrys.count-1) {
            NSUserDefaults.standardUserDefaults().setObject(countrys[indexPath.row], forKey: "country")
        } else {
            NSUserDefaults.standardUserDefaults().setObject("China", forKey: "country")
        }
        
        country = countrys[indexPath.row]
        
        if (indexPath.row==0) {
            //美国
            cityArray = ["San Francisco","New York","Seattle","Chicago","Los Angeles","Boston","Washington","San Diego","San Jose","Philadelphia"]
            
        }else if (indexPath.row==1) {
            //        uk
            cityArray = ["London","Cambridge","Manchester","Edinburgh","Bristol","Birmingham","Glasgow","Oxford","Newcastle","Leeds"]
        }else if (indexPath.row==2){
            //germany
            cityArray = ["Berlin","Munich","Hamburg","Cologne","Stuttgart","Dresden","Leipzig"]
        }else if (indexPath.row==3){
            cityArray = ["beijing","shanghai","shenzhen","hangzhou","guangzhou","chengdu","nanjing","wuhan","suzhou","xiamen","tianjin","chongqing","changsha"]
        }else if (indexPath.row==4){
            //        canada
            cityArray = ["Toronto","Vancouver","Montreal","ottawa","Calgary","Quebec"]
        }else if (indexPath.row==5){
            //        india
            cityArray = ["Chennai","Pune","Hyderabad","Mumbai","New Delhi","Noida","Ahmedabad","Gurgaon","Kolkata"]
        }else if (indexPath.row==6){
            //        france
            cityArray = ["paris","Lyon","Toulouse","Nantes"]
        }else if (indexPath.row==7){
            //        澳大利亚
            cityArray = ["sydney","Melbourne","Brisbane","Perth"]
        }else if (indexPath.row==8){
            //        other
            cityArray = ["Tokyo","Moscow","Singapore","Seoul"];
        }
        
        self.performSegueWithIdentifier("city", sender: self)

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
        if let
        navigationController = segue.destinationViewController as? UINavigationController,
            detailViewController = navigationController.topViewController as? CityTableViewController {
                detailViewController.cities = cityArray
                detailViewController.title = country
        }
        
    }
}
