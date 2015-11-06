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
        
        if self.navigationController?.viewControllers.count > 0 {
            if let rootViewController = self.navigationController?.viewControllers[0] {
                if let usersViewController = rootViewController as? UsersViewController {
                    usersViewController.country = country!
                }
            }
        }
        
        self.performSegueWithIdentifier(Key.SegueIdentifier.City, sender: self)
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cityTableViewController = segue.destinationViewController as? CityTableViewController {
                cityTableViewController.cities = cityArray
                cityTableViewController.title = country
        }
        
    }
}
