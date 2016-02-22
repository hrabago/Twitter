//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Héctor Rábago on 2/13/16.
//  Copyright © 2016 Héctor Rábago. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import MBProgressHUD


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating,TweetCellDelegate {
    
    var tweets: [Tweet]?
    var filteredTweets: [Tweet]?
    
    var favoriteStates = [Int:Bool]()
    var searchController: UISearchController!
    
    
    
    

    @IBOutlet weak var tableView: UITableView!
    let favoritePressedImage = UIImage(named: "like-action-on.png")! as UIImage

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)


        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //imageView.contentMode = .ScaleAspectFit
        
        // 4
        let image = UIImage(named: "TwitterLogo_white.png")
        imageView.image = image
        // 5
        //navigationItem.titleView = imageView
        navigationController?.navigationBar.topItem?.titleView = imageView
        navigationItem.titleView?.contentMode = UIViewContentMode.ScaleAspectFit

        navigationItem.titleView?.center.x = tableView.frame.size.width / 2
        
        
        
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil , completion: { (tweets,error) -> () in
            self.tweets = tweets
            self.filteredTweets = tweets
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
        
        if filteredTweets != nil{
            
            return (filteredTweets?.count)!
            
        }else{
            
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = filteredTweets?[indexPath.row]
        
        cell.delegate = self
        
        cell.favoriteButton.selected = favoriteStates[indexPath.row] ?? false
        
        //let backgroundView = UIView()
        //backgroundView.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
        //cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    
    func tweetCell(tweetCell: TweetCell, didChangeValue value: Bool) {
        
        let indexPath = tableView.indexPathForCell(tweetCell)
        
        print("tweets view controller got the event")
        
        favoriteStates[indexPath!.row] = value
        
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil , completion: { (tweets,error) -> () in
            self.tweets = tweets
            self.filteredTweets = tweets
            self.tableView.reloadData()
            
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)

            
            
        })
        
    }

    
    @IBAction func retweetAction(sender: AnyObject) {
        print("Retweet button clicked")
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        
        let cell: UITableViewCell =  self.tableView.cellForRowAtIndexPath(indexPath)!
        
        print("This is the index path of the cell: \(indexPath.row)")
        
        let tweet = tweets![indexPath.row]
        
        let tweetID = tweet.id
        
        TwitterClient.sharedInstance.retweetWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                print("Tweet was printed successfull.. incre tweet retweet count here")
                
                //self.tweets![indexPath.row].retweetCount = self.tweets![indexPath.row].retweetCount as! Int + 1
                
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
                
            }
            else {
                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
            }
        }
        
        
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        
        print("fav button pressed")
        //sender.setImage(favoritePressedImage, forState: UIControlState.Normal)

        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        
        let cell: UITableViewCell =  self.tableView.cellForRowAtIndexPath(indexPath)!
        
        let tweet = tweets![indexPath.row]
        
        let tweetID = tweet.id
        
        
        
        
        TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                print("Tweet was printed successfull.. incre tweet count here")
                
                self.tweets![indexPath.row] = tweet!
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
                

            }
            else {
                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
            }
        }

    }
    
    @IBAction func searchAction(sender: AnyObject) {
    
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self

        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense.  Should set probably only set
        // this to yes if using another controller to display the search results.
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        
        searchController.searchBar.placeholder = "Search User"
        //searchController.searchBar.sizeToFit()
        //tableView.tableHeaderView = searchController?.searchBar

        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.becomeFirstResponder()
        
        
        navigationItem.titleView = searchController.searchBar
        navigationItem.rightBarButtonItems?.removeFirst()
        navigationItem.leftBarButtonItems?.removeLast()
        
        
        
        
        
        
        
        // By default the navigation bar hides when presenting the
        // search interface.  Obviously we don't want this to happen if
        // our search bar is inside the navigation bar.
        searchController.hidesNavigationBarDuringPresentation = false
        
        
        
    }
    
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        /*
        self.filteredRestaurants.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.businesses as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        self.filteredRestaurants = array as! [Business]
        
        self.tableView.reloadData()
        */
        if let searchText = searchController.searchBar.text {
            filteredTweets = searchText.isEmpty ? tweets : tweets!.filter({(dataString: Tweet) -> Bool in
                return dataString.user?.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
            
            tableView.reloadData()
        }
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        detailViewController.tweet = tweet
        
        
        print("prepare for segue called")
    }
    

}
