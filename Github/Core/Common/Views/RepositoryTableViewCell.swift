//
//  RepositoriesTableViewCell.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class RepositoryTableViewCell: UITableViewCell {

    
    var rankLabel: UILabel!
    var repositoryLabel: UILabel!
    
    var userLabel: UILabel!
    var descriptionLabel: UILabel!
    var titleImageView: UIImageView!
    var starLabel: UILabel!
    var forkLabel: UILabel!
    var homePageBt: UIButton!
    
    var isInitialized = false
    
    var repository: Repository? {
        didSet {
            if !isInitialized {
                loadSubview()
            }
            updateUi()
        }
    }
    
    private func loadSubview() {
        let h: CGFloat = 94.5 //orginY*2+repositoryLabelHeight*4+spacce*2=96
        let heightSpace: CGFloat = 2
        let orginX: CGFloat = 0
        let w: CGFloat = UIScreen.mainScreen().bounds.width-orginX*2
        let preWidth: CGFloat = 10
        let rankWidth: CGFloat = 40
        let sufRankWidth: CGFloat = 10
        let repositoryLabelWidth: CGFloat = 180
        let userLabelWidth: CGFloat = 110
        let imageViewWidth: CGFloat = 30
        let labelWidth: CGFloat = w-2*preWidth-rankWidth-sufRankWidth
        
        let repositoryLabelHeight: CGFloat = 20
        let orginY: CGFloat = 5
        contentView.bounds = CGRectMake(0, 0, w, h)
        
        rankLabel = UILabel.init(frame: CGRectMake(preWidth, orginY, rankWidth, repositoryLabelHeight))
        self.contentView.addSubview(rankLabel)
        rankLabel.font = UIFont.systemFontOfSize(12)
        rankLabel.textColor = Theme.GrayTextColor
        
        repositoryLabel = UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth, orginY, repositoryLabelWidth, repositoryLabelHeight))
        self.contentView.addSubview(repositoryLabel)
        repositoryLabel.font = UIFont.systemFontOfSize(12)
        repositoryLabel.textColor = Theme.Color
        
        userLabel = UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight+heightSpace, userLabelWidth, repositoryLabelHeight))
        self.contentView.addSubview(userLabel)
        userLabel.font = UIFont.systemFontOfSize(12)
        userLabel.textColor = Theme.GrayTextColor
        
        
        descriptionLabel = UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth, orginY+repositoryLabelHeight*2+heightSpace*2, labelWidth, repositoryLabelHeight*2))
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines=0
        descriptionLabel.font = UIFont.systemFontOfSize(13)
        
        titleImageView = UIImageView.init(frame: CGRectMake(preWidth+(rankWidth - imageViewWidth)/2, orginY+30+heightSpace, imageViewWidth, imageViewWidth))
        self.contentView.addSubview(titleImageView)
        titleImageView.layer.cornerRadius=5
        titleImageView.layer.borderColor = Theme.GrayColor.CGColor
        titleImageView.layer.borderWidth=0.2
        titleImageView.layer.masksToBounds=true
        
        starLabel = UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth+repositoryLabelWidth, orginY, 65, repositoryLabelHeight))
        self.contentView.addSubview(starLabel)
        starLabel.font = UIFont.systemFontOfSize(12)
        starLabel.textColor = Theme.GrayTextColor
        
        forkLabel = UILabel.init(frame: CGRectMake(preWidth+rankWidth+sufRankWidth+65+5+repositoryLabelWidth, orginY, 65, repositoryLabelHeight))
        self.contentView.addSubview(forkLabel)
        forkLabel.font = UIFont.systemFontOfSize(12)
        forkLabel.textColor = Theme.GrayTextColor
        
        homePageBt = UIButton.init(type: UIButtonType.Custom)
        self.contentView.addSubview(homePageBt)
        homePageBt.setTitleColor(Theme.Color, forState: UIControlState.Normal)
        homePageBt.titleLabel?.font = UIFont.systemFontOfSize(12)
        
        homePageBt.frame=CGRectMake(preWidth+rankWidth+sufRankWidth+userLabelWidth, orginY+repositoryLabelHeight+heightSpace, labelWidth-userLabelWidth, repositoryLabelHeight)
        homePageBt.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        homePageBt.titleLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        
        isInitialized = true
    }
    
    private func updateUi() {
        if let repository = self.repository {
            rankLabel.text = "\(repository.id!)"
            repositoryLabel.text = repository.name!
            userLabel.text = "Owner: \(repository.owner!.login!)"
            
            descriptionLabel.text = repository.repositoryDescription!
            starLabel.text = "Star: \(repository.stargazers_count!)"
            forkLabel.text = "Fork: \(repository.forks_count!)"
            
            Alamofire.request(.GET, (repository.owner!.avatar_url)!)
                .responseData { response in
//                    NSLog("Fetch: Image: \(self.repository?.owner!.avatar_url)")
                    let imageData = UIImage(data: response.data!)
                    self.titleImageView?.image = imageData
            }
        }
    }

}
