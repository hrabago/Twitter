//
//  TweetCell.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/14/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate{
    
    optional func tweetCell(tweetCell: TweetCell, didChangeValue value: Bool)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    weak var delegate: TweetCellDelegate?
    
    let favoritePressedImage = UIImage(named: "like-action-on.png")! as UIImage

    
    var tweet: Tweet!{
        
        didSet{
    
            fullNameLabel.text = tweet.user?.name
            usernameLabel.text = "@\((tweet.user?.screenname)!)"
            tweetLabel.text = tweet.text
            timeLabel.text = "- \((tweet.createdAt)!)"
            
            profileImageView.setImageWithURL((tweet.user?.imageURL)!)

            
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        fullNameLabel.preferredMaxLayoutWidth = fullNameLabel.frame.size.width
        
        favoriteButton.addTarget(self, action: "favoriteValueChanged", forControlEvents:UIControlEvents.TouchUpInside)
        
        retweetButton.addTarget(self, action: "retweetValueChanged", forControlEvents:UIControlEvents.TouchUpInside)
        
        
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        fullNameLabel.preferredMaxLayoutWidth = fullNameLabel.frame.size.width
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func favoriteValueChanged()
    {
        
        if delegate != nil{
            
            delegate?.tweetCell?(self, didChangeValue: favoriteButton.selected)
            
        }
        
        favoriteButton.selected = true
        
    }
    func retweetValueChanged()
    {
        
        if delegate != nil{
            
            delegate?.tweetCell?(self, didChangeValue: retweetButton.selected)
            
        }
        
        retweetButton.selected = true
        
    }

    
    
}
