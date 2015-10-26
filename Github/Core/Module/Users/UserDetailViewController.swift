//
//  UserDetailViewController.swift
//  Github
//
//  Created by frodo on 15/10/25.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class UserDetailViewController: UIViewController, ViewPagerIndicatorDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emaiButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    
    
    @IBOutlet weak var viewPagerIndicator: ViewPagerIndicator!
    @IBOutlet weak var scrollView: UIScrollView!

    
    var user: User? {
        didSet {
            self.title = user?.login
        }
    }
    
    private func updateUserInfo () {
        Alamofire.request(.GET, (user?.avatar_url)!)
            .responseData { response in
                NSLog("Fetch: Image: \(self.user!.avatar_url)")
                let imageData = UIImage(data: response.data!)
                self.titleImageView?.image = imageData
        }
        
        if let login = user!.login {
            loginButton.titleLabel?.text = login
        }
        
        if let email = user!.email {
            emaiButton.titleLabel?.text = email
        }
        
        if let name = user!.name {
            nameLabel.text = name
        }
        
        if let blog = user!.blog {
            blogButton.titleLabel?.text = blog
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
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUserInfo()
        
        viewPagerIndicator.titles = ["Apple","Banana","Cherry","Durin"]
        //监听ViewPagerIndicator选中项变化
        viewPagerIndicator.delegate = self
        
        viewPagerIndicator.setTitleColorForState(Theme.Color, state: UIControlState.Selected) //选中文字的颜色
        viewPagerIndicator.setTitleColorForState(UIColor.blackColor(), state: UIControlState.Normal) //正常文字颜色
        viewPagerIndicator.tintColor = Theme.Color //指示器和基线的颜色
        viewPagerIndicator.showBottomLine = true //基线是否显示
        viewPagerIndicator.autoAdjustSelectionIndicatorWidth = true//指示器宽度是按照文字内容大小还是按照count数量平分屏幕
        viewPagerIndicator.indicatorDirection = .Bottom//指示器位置
        
        //样式
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        //内容大小
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(viewPagerIndicator.count ), height: scrollView.bounds.height)
        
        //根据顶部的数量加入子Item
        for(var i = 0; i < viewPagerIndicator.count; i++ ) {
            let title = viewPagerIndicator.titles[i] as! String
            let textView = UILabel(frame: CGRectMake(self.view.bounds.width * CGFloat(i), 0, self.view.bounds.width, scrollView.bounds.height))
            textView.text = title
            textView.textAlignment = NSTextAlignment.Center
            scrollView.addSubview(textView)
        }

        //tableView.estimatedRowHeight = tableView.rowHeight
        //tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.backgroundColor = Theme.Color
    

        // Do any additional setup after loading the view.
    }
    
    //点击顶部选中后回调
    func indicatorChange(indicatorIndex: Int) {
        scrollView.scrollRectToVisible(CGRectMake(self.view.bounds.width * CGFloat(indicatorIndex), 0, self.view.bounds.width, scrollView.bounds.height), animated: true)
    }
    //滑动scrollview回调
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let xOffset: CGFloat = scrollView.contentOffset.x
        let x: Float = Float(xOffset)
        let width:Float = Float(self.view.bounds.width)
        let index = Int((x + (width * 0.5)) / width)
        viewPagerIndicator.setSelectedIndex(index) //改变顶部选中
    }
}
