//
//  DetailViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/21/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var imageViewLabel: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var tweet: Tweet?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
            fullNameLabel.text = tweet!.user?.name
            usernameLabel.text = "@\((tweet!.user?.screenname)!)"
            tweetLabel.text = tweet!.text
        
            //timeLabel.text = calculateTimeStamp((tweet?.createdAt?.timeIntervalSinceNow)!)
        
            timeLabel.text = "· \((tweet?.timeAgo)!)"
            
            imageViewLabel.setImageWithURL((tweet!.user?.imageURL)!)
        
            navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
            //navigationItem.title = "Tweet"
        

        // Do any additional setup after loading the view.
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
