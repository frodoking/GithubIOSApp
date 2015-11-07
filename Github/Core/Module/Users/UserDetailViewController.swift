//
//  UserDetailViewController.swift
//  Github
//
//  Created by frodo on 15/10/25.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class UserDetailViewController: UIViewController, ViewPagerIndicatorDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emaiButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    
    
    @IBOutlet weak var viewPagerIndicator: ViewPagerIndicator!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshAction:", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()
    
    
    var viewModule: UserDetailViewModule?
    var tabIndex: Int = 0
    var array: NSArray? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var user: User? {
        didSet {
            self.title = user?.login
        }
    }
    
    private func updateUserInfo () {
        if let _ = user {
            if let avatar_url = user!.avatar_url {
                Alamofire.request(.GET, avatar_url)
                    .responseData { response in
                        NSLog("Fetch: Image: \(avatar_url)")
                        let imageData = UIImage(data: response.data!)
                        self.titleImageView?.image = imageData
                }
            }
            
            if let login = user!.login {
                loginButton.setTitle(login, forState:UIControlState.Normal)
            }
            
            if let email = user!.email {
                emaiButton.setTitle(email, forState:UIControlState.Normal)
            }
            
            if let name = user!.name {
                nameLabel.text = name
            }
            
            if let blog = user!.blog {
                blogButton.setTitle(blog, forState:UIControlState.Normal)
            }
            
            if let company = user!.company {
                companyLabel.text = company
            }
            
            if let location = user!.location {
                locationLabel.text = location
            }
            
            if let created_at = user!.created_at {
                createLabel.text = created_at
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets=false
        self.view.backgroundColor = Theme.WhiteColor
        
        self.navigationController?.navigationBar.backgroundColor = Theme.Color
        
        titleImageView.layer.cornerRadius = 10
        titleImageView.layer.borderColor = Theme.GrayColor.CGColor
        titleImageView.layer.borderWidth = 0.3
        titleImageView.layer.masksToBounds=true
        
        viewModule = UserDetailViewModule()
        if self.user != nil {
            viewModule?.loadUserFromApi((self.user!.login)!, handler: { user in
                if user != nil {
                    self.user = user
                    self.updateUserInfo()
                }
            })
        }
        
        updateUserInfo()
        
        viewPagerIndicator.titles = UserDetailViewModule.Indicator
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
        
        viewPagerIndicator.setSelectedIndex(tabIndex)
        refreshAction(refreshControl)
    }
    
    func refreshAction(sender: UIRefreshControl) {
        self.refreshControl.beginRefreshing()
        
        if let _ = user {
            viewModule?.loadDataFromApiWithIsFirst(true, currentIndex: tabIndex, userName: (user?.login)!,
                handler: { array in
                    self.refreshControl.endRefreshing()
                    
                    if array.count > 0 {
                        self.array = array
                    }
            })
        }
    }
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        if let prevViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] {
            self.navigationController?.popToViewController(prevViewController, animated: true)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
}

// MARK: - ViewPagerIndicator
extension UserDetailViewController {
    // 点击顶部选中后回调
    func indicatorChange(indicatorIndex: Int) {
        self.tabIndex = indicatorIndex
        switch indicatorIndex {
            case 0:
                self.array = viewModule!.userRepositoriesDataSource.dsArray
                break
            case 1:
                self.array = viewModule!.userFollowingDataSource.dsArray
                break
            case 2:
                self.array = viewModule!.userFollowersDataSource.dsArray
                break
            default:break
        }
        
        self.refreshAction(self.refreshControl)
    }
}

// MARK: - UITableViewDataSource
extension UserDetailViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if array == nil {
            return 0
        }
        return self.array!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tabIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.RepositoryCell, forIndexPath: indexPath) as! RepositoryTableViewCell
            cell.repository = self.array![indexPath.section] as? Repository
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Key.CellReuseIdentifier.UserCell, forIndexPath: indexPath) as! UserTableViewCell
            cell.user = self.array![indexPath.section] as? User
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tabIndex == 0 {
            return Theme.RepositoryTableViewCellheight
        }
        return Theme.UserTableViewCellHeight
    }
}
// MARK: - Navigation
extension UserDetailViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destinationViewController
        if let userDetailViewController = viewController as? UserDetailViewController {
            if let cell = sender as? UserTableViewCell {
                let selectedIndex = tableView.indexPathForCell(cell)?.section
                if let index = selectedIndex {
                    userDetailViewController.user = self.array![index] as? User
                }
            }
        } else if let repositoryDetailViewController = viewController as? RepositoryDetailViewController {
            if let cell = sender as? RepositoryTableViewCell {
                let selectedIndex = tableView.indexPathForCell(cell)?.section
                if let index = selectedIndex {
                    repositoryDetailViewController.repository = self.array![index] as? Repository
                }
            }
        }
    }
}


