//
//  Tweet.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/12/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

var tweetUser: Tweet?


class Tweet: NSObject {

    
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var timeAgo: String?
    var id: NSNumber?
    
    init(dictionary: NSDictionary){
        super.init()
        
        user = User(dictionary:dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        createdAt = formatter.dateFromString(createdAtString!)
        
        timeAgo = calculateTimeStamp((createdAt?.timeIntervalSinceNow)!)
        

        
    }
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) {
            // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) < 60) {
            // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 < 24) {
            // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 < 365) {
            // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) {
            // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
            
        }
        return tweets
        
    }
    
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
        // print(dict)
        
        var tweet = Tweet(dictionary: dict)
        
        return tweet
    }
    
    
    
    
}
