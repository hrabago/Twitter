//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/26/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var myProfileNameLabel: UILabel!
    @IBOutlet weak var myUsernameLabel: UILabel!
    
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var backgroundImage: UIImage!
    
    var tweets: [Tweet]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        
        myProfileNameLabel.text = User.currentUser?.name
        myUsernameLabel.text = "@\((User.currentUser?.screenname)!)"
        profileImageView.setImageWithURL((User.currentUser?.imageURL)!)
        
        //coverImageView.setImageWithURL((User.currentUser?.profileBannerURL)!)
        
        
       
        let data = NSData(contentsOfURL: (User.currentUser?.profileBannerURL)!)
        backgroundImage = UIImage(data: data!)
            
        
        coverImageView.image = backgroundImage
        navigationController?.navigationBar.setBackgroundImage(backgroundImage, forBarMetrics: UIBarMetrics.Default)
        
        
        // Do any additional setup after loading the view.
        
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        TwitterClient.sharedInstance.userTimelineWithParams(nil , completion: { (tweets,error) -> () in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
            
        })
        
        
        numFollowersLabel.text = "\((User.currentUser?.userFollowersCount)!)"
        numFollowing.text = "\((User.currentUser?.userFollowingCount)!)"
        numTweetsLabel.text = "\((User.currentUser?.userTweetCount)!)"
        print(User.currentUser?.userTweetCount)
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tweets != nil{
            
            return (tweets?.count)!
            
        }else{
            
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
      
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        detailViewController.tweet = tweet
        
        
        print("prepare for segue called")
        
    }
    */
    

}
