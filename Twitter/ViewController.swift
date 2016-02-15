//
//  ViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/10/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    @IBAction func onLogin(sender: AnyObject) {
        
        
        TwitterClient.sharedInstance.loginWithCompletion()
        {
            (user: User?, error: NSError?) in
            
            if user != nil
            {
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: nil)

                
            }
            else
            {
                
                //handle login error
            }
        }
        
        
    
    }


}

