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
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
}
