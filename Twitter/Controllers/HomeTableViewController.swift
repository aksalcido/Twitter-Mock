//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Armando Salcido on 4/27/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [Tweet]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    
    @objc func loadTweets() {

        let myParams = ["count": 25]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: Url.HomeTimeline.rawValue, parameters: myParams, success:
            { (tweets: [NSDictionary]) in
                self.tweetArray.removeAll()
                
                for tweet in tweets {
                    // Access The User Dictionary from the JSON Tweet
                    let user = tweet["user"] as! NSDictionary
                    
                    // Create a Tweet Structure w/ Username, TweetContent and Profile Image
                    let tweet = Tweet(username: user["name"] as! String,
                                      tweetContent: tweet["text"] as! String,
                                      profileImage: URL(string: (user["profile_image_url_https"] as? String)!)!)
            
                    self.tweetArray.append(tweet)
                }
                
                // Ensure that the Tableview is updated with the new acquired data
                self.tableView.reloadData()
                // Ensure that the Refresh Control does not refresh forever
                self.myRefreshControl.endRefreshing()
                
        }, failure: { (Error) in
            print("Error in acquiring Tweets!")
        })
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: UserStatus.UserLoggedIn.rawValue)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
    
        // Assign the cell the Tweet Attributes
        cell.usernameLabel.text = tweetArray[indexPath.row].username
        cell.tweetContent.text = tweetArray[indexPath.row].tweetContent

        // Profile Image of User
        let data = try? Data(contentsOf: tweetArray[indexPath.row].profileImage)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
    
        return cell
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }



}
