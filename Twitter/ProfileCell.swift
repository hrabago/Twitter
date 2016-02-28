//
//  ProfileCell.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/26/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet: Tweet!{
        
        didSet{
            
            fullNameLabel.text = tweet.user?.name
            usernameLabel.text = "@\((tweet.user?.screenname)!)"
            tweetLabel.text = tweet.text
            //timeLabel.text = "· \((tweet?.timeAgo)!)"
            
            profileImageView.setImageWithURL((tweet.user?.imageURL)!)
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        fullNameLabel.preferredMaxLayoutWidth = fullNameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
