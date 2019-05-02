//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Armando Salcido on 4/27/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    var favorited:Bool = false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        
        if (favorited) {
            favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        
        else {
            favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not Succeed!: \(error)")
            })
        }
        
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not Succeed!: \(error)")
            })
        }
    }
        
    @IBAction func retweet(_ sender: Any) {
        
    }
        
    
    
}
