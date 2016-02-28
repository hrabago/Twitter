//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/27/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        
        fullNameLabel.text = User.currentUser?.name
        usernameLabel.text = "@\((User.currentUser?.screenname)!)"
        
        profileImageView.setImageWithURL((User.currentUser?.imageURL)!)
        

        tweetTextView.text = "What's Happening..."
        tweetTextView.textColor = UIColor.lightGrayColor()

        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        let maxLength = 140
        let currentString: NSString = tweetTextView.text!
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: text)
        
        countDownLabel.text = "\(140 - newString.length)"
        
        
        
        return newString.length < maxLength
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if tweetTextView.textColor == UIColor.lightGrayColor() {
            tweetTextView.text = nil
            tweetTextView.textColor = UIColor.blackColor()
        }
    }
    @IBAction func updateStatusAction(sender: AnyObject) {
        
        print("tweet button pressed")
        
        let tweetStatus = tweetTextView.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        print(tweetStatus)
        
        TwitterClient.sharedInstance.tweetWithCompletion(["status": tweetStatus]) { (tweet, error) -> () in
        
        self.view.endEditing(true)
            
            
        User.currentUser?.tweeted()
            print(tweetStatus)
        }

        
        
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
