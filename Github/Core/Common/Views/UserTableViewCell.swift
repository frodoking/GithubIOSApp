//
//  RankTableViewCell2.swift
//  Github
//
//  Created by frodo on 15/10/26.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class UserTableViewCell: UITableViewCell {

    var rankLabel: UILabel!
    var titleImageView: UIImageView!
    var mainLabel: UILabel!
    var detailLabel: UILabel!
    
    var isInitialized = false
    
    var user: User? {
        didSet {
            if !isInitialized {
                loadSubview()
            }
            
            updateUi()
        }
    }
    
    private func loadSubview() {
        let h: CGFloat = 70.5
        let orginX: CGFloat = 0
        let w = UIScreen.mainScreen().bounds.width - orginX * 2
        let preWidth: CGFloat = 15
        let rankWidth: CGFloat = 45
        let sufRankWidth: CGFloat = 10
        let imageViewWidth: CGFloat = 50
        let sufImageViewWidth: CGFloat = 25
        
        let contentWidth = w - 2 * preWidth
        let labelWidth = contentWidth-sufRankWidth-imageViewWidth-sufImageViewWidth
        
        contentView.bounds = CGRectMake(0, 0, w, h)
        
        rankLabel = UILabel.init(frame: CGRectMake(0, (h-30)/2, rankWidth+preWidth, 30))
        self.contentView.addSubview(rankLabel)
        
        titleImageView = UIImageView.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth, (h-imageViewWidth)/2, imageViewWidth, imageViewWidth))
        self.contentView.addSubview(titleImageView)
        
        mainLabel = UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth+imageViewWidth+sufImageViewWidth, (h-imageViewWidth)/2, labelWidth, imageViewWidth))
        self.contentView.addSubview(mainLabel)
        
        detailLabel=UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth+imageViewWidth+sufImageViewWidth, (h-imageViewWidth)/2+imageViewWidth/2, labelWidth, imageViewWidth/2))
        detailLabel.numberOfLines = 0
        self.contentView.addSubview(detailLabel)
        
        mainLabel.numberOfLines = 0
        rankLabel.textColor = Theme.Color
        mainLabel.textColor = Theme.Color
        detailLabel.textColor = Theme.GrayColor
        rankLabel.textAlignment = NSTextAlignment.Center
        mainLabel.font = UIFont.systemFontOfSize(18)
        detailLabel.font = UIFont.systemFontOfSize(13)
        mainLabel.textAlignment = NSTextAlignment.Left
        detailLabel.textAlignment = NSTextAlignment.Left
        
        titleImageView.layer.cornerRadius = 10
        titleImageView.layer.borderColor = Theme.GrayColor.CGColor
        titleImageView.layer.borderWidth = 0.3
        titleImageView.layer.masksToBounds=true
        
        isInitialized = true
    }

    private func updateUi() {
        if let user = self.user {
            if let _ = user.rank {
                rankLabel.text = "\(user.rank!)"
            }
            
            mainLabel.text = user.login!
            detailLabel.text = user.url!
            
            Alamofire.request(.GET, (user.avatar_url)!)
                .responseData { response in
                    NSLog("Fetch: Image: \(self.user?.avatar_url)")
                    let imageData = UIImage(data: response.data!)
                    self.titleImageView?.image = imageData
            }
        }
    }
}
