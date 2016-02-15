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
    
    init(dictionary: NSDictionary){
        
        user = User(dictionary:dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        createdAt = formatter.dateFromString(createdAtString!)
        

        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
            
        }
        return tweets
        
    }
    
    
    
    
}
