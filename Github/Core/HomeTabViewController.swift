//
//  RootViewController.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 默认背景颜色
        self.tabBar.barTintColor = Theme.GrayColor
        // 点击后的颜色
        self.tabBar.tintColor = Theme.Color
    } 
}
