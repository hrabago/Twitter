//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/26/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    
    var tweet: Tweet?
    var backgroundImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fullNameLabel.text = tweet?.user?.name
        usernameLabel.text = "@\((tweet?.user?.screenname)!)"
        profileImageView.setImageWithURL((tweet?.user?.imageURL)!)
        
        numFollowersLabel.text = "\((tweet?.user?.userFollowersCount)!)"
        numFollowing.text = "\((tweet?.user?.userFollowingCount)!)"
        numTweetsLabel.text = "\((tweet?.user?.userTweetCount)!)"
        
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        
        let data = NSData(contentsOfURL: (tweet?.user?.profileBannerURL)!)
        backgroundImage = UIImage(data: data!)
        
        
        coverImageView.image = backgroundImage
        //navigationController?.navigationBar.setBackgroundImage(backgroundImage, forBarMetrics: UIBarMetrics.Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
