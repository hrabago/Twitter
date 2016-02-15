//
//  User.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/12/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "KCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    
    
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var imageURL: NSURL?

    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"]   as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        
        if profileImageUrl != nil {
            imageURL = NSURL(string: profileImageUrl!)!
        } else {
            imageURL = nil
        }
    }
    
    func logout() {
        
        User.currentUser = nil
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    class var currentUser: User? {
        
        get {
        
            if _currentUser ==  nil {
        
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
                if data != nil {
                    do {
                        var dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch(let error) {
                    print(error)
                }
        
            }
        }
        return _currentUser
        }set(user){
            
            _currentUser = user
         
            if _currentUser != nil{
                
                //var data = NSJSONSerialization.dataWithJSONObject(user?.dictionary, options: nil, error: nil)
                do{
                    
                
                let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions.PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    NSUserDefaults.standardUserDefaults().synchronize()
                
                }catch (let error) {
                    
                    print(error)
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    
                }
                
            }
        }
    }

}
