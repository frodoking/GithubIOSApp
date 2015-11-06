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

class CountryTableViewController: UITableViewController {

    var countrys = [String]()
    
    var country: String = "Country" {
        didSet {
            if self.navigationController?.viewControllers.count > 0 {
                if let rootViewController = self.navigationController?.viewControllers[0] {
                    if let usersViewController = rootViewController as? UsersViewController {
                        usersViewController.country = country
                    }
                }
            }
        }
    }
    var cityId  = 0 {
        didSet {
            country = countrys[cityId]
        }
    }

    @IBAction func backAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Country"
        
        countrys=["USA","UK","Germany","China","Canada","India","France","Australia","Other"] 
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
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cityTableViewController = segue.destinationViewController as? CityTableViewController {
            var cityArray = [String]()
            if let _ = sender as? UITableViewCell {
               cityId = (self.tableView.indexPathForSelectedRow?.section)!
            }
            switch cityId {
            case 0: //美国
                cityArray = ["San Francisco","New York","Seattle","Chicago","Los Angeles","Boston","Washington","San Diego","San Jose","Philadelphia"]
                break
            case 1: // uk
                cityArray = ["London","Cambridge","Manchester","Edinburgh","Bristol","Birmingham","Glasgow","Oxford","Newcastle","Leeds"]
                break
            case 2: //germany
                cityArray = ["Berlin","Munich","Hamburg","Cologne","Stuttgart","Dresden","Leipzig"]
                break
            case 3: // China
                cityArray = ["beijing","shanghai","shenzhen","hangzhou","guangzhou","chengdu","nanjing","wuhan","suzhou","xiamen","tianjin","chongqing","changsha"]
                break
            case 4: // canada
                cityArray = ["Toronto","Vancouver","Montreal","ottawa","Calgary","Quebec"]
                break
            case 5: // india
                cityArray = ["Chennai","Pune","Hyderabad","Mumbai","New Delhi","Noida","Ahmedabad","Gurgaon","Kolkata"]
                break
            case 6: // france
                cityArray = ["paris","Lyon","Toulouse","Nantes"]
                break
            case 7: // 澳大利亚
                cityArray = ["sydney","Melbourne","Brisbane","Perth"]
                break
            default: //        other
                cityArray = ["Tokyo","Moscow","Singapore","Seoul"];
                break
            }

            cityTableViewController.cities = cityArray
            cityTableViewController.title = country
        }
    }
}
