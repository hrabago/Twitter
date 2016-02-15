//
//  TwitterClient.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/10/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "QvI5iS2O37pkEwEIGbCMoPwxe"
let twitterConsumerSecret = "FN0DIPalPiuSncbsWsVh6FZ4xSLxnTkL0cQJe96hHHMdsIIPSZ"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        
        GET("1.1/statuses/home_timeline.json", parameters: params,
            
            success: { (
                operation: NSURLSessionDataTask,
                response: AnyObject?) -> Void in
                //print("home_timeline: \(response!)")
                
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                
                completion(tweets: tweets, error:nil)
                
            },
            failure: { (
                operation: NSURLSessionDataTask?,
                error: NSError!) -> Void in
                print("error getting current user1")
                completion(tweets: nil , error: error)

                
        })
        
    }
    
    func loginWithCompletion(completion: (user:User?,error: NSError?) -> ()){
        
        loginCompletion = completion
        
        
        //Fetch request token and redirect to authorization page
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            
            UIApplication.sharedApplication().openURL(authURL!)
            
            }){ (error: NSError!) -> Void in
                print("Failed to get to the request token")
                self.loginCompletion!(user: nil, error: error) 
        }
    }
    
    func openURL(url: NSURL)
    {
        fetchAccessTokenWithPath("oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                print("Got the access token!")
                
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json",
                    
                    parameters: nil,
                    
                    success: { (
                        operation: NSURLSessionDataTask!,
                        response: AnyObject?) -> Void in
                        //print("user: \(response!)")
                        var user = User(dictionary: response as! NSDictionary)
                        
                        User.currentUser = user
                        print("user: \(user.name)")
                        self.loginCompletion!(user: user, error: nil )
                        
                    },
                    failure: { (
                        operation: NSURLSessionDataTask?,
                        error: NSError!) -> Void in
                        print("error getting current user2")
                        self.loginCompletion!(user: nil, error: error)
                        
                })
                
            },
            failure: { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion!(user: nil, error: error)
        })
        

        
    }
    
}
