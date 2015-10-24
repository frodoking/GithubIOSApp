//
//  RepositoriesTableViewCell.swift
//  Github
//
//  Created by frodo on 15/10/23.
//  Copyright © 2015年 frodo. All rights reserved.
//

import UIKit
import Alamofire

class RepositoriesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var repositoryLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    
    var repository: Repository? {
        didSet {
            updateUi()
        }
    }
    
    private func updateUi() {
        if let repository = self.repository {
            rankLabel.text = "\(repository.id!)"
            repositoryLabel.text = repository.name!
            userLabel.text = "Owner: \(repository.owner?.login!)"
            
            descriptionLabel.text = repository.repositoryDescription!
            starLabel.text = "Star: \(repository.stargazers_count!)"
            forkLabel.text = "Fork: \(repository.forks_count!)"
            
            Alamofire.request(.GET, (repository.owner!.avatar_url)!)
                .responseData { response in
                    NSLog("Fetch: Image: \(self.repository?.owner!.avatar_url)")
                    let imageData = UIImage(data: response.data!)
                    self.titleImageView?.image = imageData
            }
        }
    }

}
