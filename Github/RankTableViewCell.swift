//
//  RankUserTableViewCell.swift
//  Github
//
//  Created by frodo on 15/10/21.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {
    
    var user: User? {
        didSet {
            updateUi()
        }
    }
 
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUi() {
        rankLabel?.text = nil
        titleImageView?.image = nil
        mainLabel?.text = nil
        detailLabel?.text = nil
        
        if let user = self.user {
            titleLabel?.text = user.login
            detailLabel?.text = user.avatar_url
        }
        
        let request = GithubRequest()
        request.fetch((user?.avatar_url)!) { (data) -> Void in
            let imageData = UIImage(data: data)
            self.headImageView?.image = imageData
        }
    }


}
