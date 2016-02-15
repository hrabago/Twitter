//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/13/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    
    let favoritePressedImage = UIImage(named: "like-action-on.png")! as UIImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //imageView.contentMode = .ScaleAspectFit
        
        // 4
        let image = UIImage(named: "TwitterLogo_white.png")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView
        navigationItem.titleView?.contentMode = UIViewContentMode.ScaleAspectFit
        navigationItem.titleView?.center.x = tableView.frame.size.width
        
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil , completion: { (tweets,error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
                    
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        
        
        User.currentUser?.logout()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tweets != nil{
            
            return (tweets?.count)!
            
        }else{
            
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets?[indexPath.row]
        
        
        return cell
    }
    
    
    @IBAction func retweetAction(sender: AnyObject) {
        
        
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        
        sender.setImage(favoritePressedImage, forState: UIControlState.Selected)

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
