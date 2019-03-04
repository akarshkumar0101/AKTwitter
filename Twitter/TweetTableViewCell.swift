//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Akarsh Kumar on 2/23/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favorButton: UIButton!
    
    var tweetID: Int = -1
    
    var isFavorite: Bool = false {
        didSet{
            if(isFavorite){
                favorButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
            }
            else{
                favorButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            }
        }
    }
    var isRetweeted: Bool = false {
        didSet{
            if(isRetweeted){
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
                retweetButton.isEnabled = false
            }
            else{
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
                retweetButton.isEnabled = true;
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweetClicked(_ sender: UIButton) {
        TwitterAPICaller.client?.retweetTweet(tweetID: tweetID, success: {
            self.isRetweeted = true
        }, failure: { (error) in
            print("retweeting failed: \(error)")
        })
    }

    @IBAction func favoriteClicked(_ sender: UIButton) {
        let nextFavorite = !self.isFavorite;
        if(nextFavorite){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.isFavorite = true;
            }, failure: { (error) in
                print("favoriting failed: \(error)");
            })
        }
        else{
            TwitterAPICaller.client?.unFavoriteTweet(tweetID: tweetID, success: {
                self.isFavorite = false;
            }, failure: { (error) in
                print("unfavoriting failed: \(error)");
            })
        }
    }
}
