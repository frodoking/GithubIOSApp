//
//  UserRankTableViewController.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, ViewPagerIndicatorDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var viewPagerIndicator: ViewPagerIndicator!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshAction:", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()
    
    
    var viewModule: UsersViewModule?
     var tabIndex: Int = 0
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = Theme.WhiteColor
        
        self.navigationController?.navigationBar.backgroundColor = Theme.Color
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        viewModule = UsersViewModule()
        
        
        viewPagerIndicator.titles = UsersViewModule.Indicator
        //监听ViewPagerIndicator选中项变化
        viewPagerIndicator.delegate = self
        
        viewPagerIndicator.setTitleColorForState(Theme.Color, state: UIControlState.Selected) //选中文字的颜色
        viewPagerIndicator.setTitleColorForState(UIColor.blackColor(), state: UIControlState.Normal) //正常文字颜色
        viewPagerIndicator.tintColor = Theme.Color //指示器和基线的颜色
        viewPagerIndicator.showBottomLine = true //基线是否显示
        viewPagerIndicator.autoAdjustSelectionIndicatorWidth = true//指示器宽度是按照文字内容大小还是按照count数量平分屏幕
        viewPagerIndicator.indicatorDirection = .Bottom//指示器位置
        viewPagerIndicator.titleFont = UIFont.systemFontOfSize(14)
        
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.estimatedRowHeight = tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if let city = NSUserDefaults.standardUserDefaults().objectForKey("city") {
            UsersViewModule.Indicator[0] = city
        } else {
            UsersViewModule.Indicator[0] = "beijing"
        }
        
        if let country = NSUserDefaults.standardUserDefaults().objectForKey("country") {
            UsersViewModule.Indicator[1] = country
        } else {
            UsersViewModule.Indicator[1] = "China"
        }
        
        viewPagerIndicator.setSelectedIndex(tabIndex)
    }
    
    func refreshAction(sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        viewModule!.loadDataFromApiWithIsFirst(true, currentTab: tabIndex) { users in
            self.refreshControl.endRefreshing()
            if users.count > 0 {
                self.users = users as! [User]
                self.totalCountLabel.text = "total:\(self.viewModule!.totalCount)"
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func cityAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier(Key.SegueIdentifier.Country, sender: self)
    }

    @IBAction func languageAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier(Key.SegueIdentifier.Language, sender: self)
    }
}

// MARK: - ViewPagerIndicator
extension UsersViewController {
    // 点击顶部选中后回调
    func indicatorChange(indicatorIndex: Int) {
        self.tabIndex = indicatorIndex
        self.refreshAction(self.refreshControl)
    }
}

// MARK: - Table view data source
extension UsersViewController {
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.users.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.UserCell, forIndexPath: indexPath) as! UserTableViewCell
        
        
        cell.user = self.users[indexPath.section]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Theme.UserTableViewCellHeight
    }
}

// MARK: - Table view data delegate
extension UsersViewController {
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
extension UsersViewController {
    
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
