//
//  RankUserTableViewCell.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class RankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var user: User? {
        didSet {
            updateUi()
        }
    }
    
    private func updateUi() {
        rankLabel?.text = nil
        titleImageView?.image = nil
        mainLabel?.text = nil
        detailLabel?.text = nil
        
        if let user = self.user {
            rankLabel?.text = "\(user.rank)"
            mainLabel?.text = user.login
            detailLabel?.text = user.avatar_url
        }
        
        Alamofire.request(.GET, (user?.avatar_url)!)
            .responseData { response in
                print(response.request)
                print(response.response)
                print(response.result)
                let imageData = UIImage(data: response.data!)
                self.titleImageView?.image = imageData
        }
    }


}
