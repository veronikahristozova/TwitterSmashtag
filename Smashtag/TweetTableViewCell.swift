//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Veronika Hristozova on 10/5/16.
//  Copyright © 2016 Veronika Hristozova. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetProfilImageView: UIImageView!
    
    var tweet: Twitter.Tweet? { didSet { updateUI() } }
    
    private func updateUI() {
        
        tweetTextLabel?.attributedText = nil
        tweetCreatedLabel?.text = nil
        tweetProfilImageView?.image = nil
        tweetScreenNameLabel?.text = nil
        
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                DispatchQueue.global(qos: .userInitiated).async {
                    if let imageData = NSData(contentsOf: profileImageURL) {
                        DispatchQueue.main.async {
                            self.tweetProfilImageView?.image = UIImage(data: imageData as Data)
                        }
                    }
                }
            }
            
            let formatter = DateFormatter()
            if NSDate().timeIntervalSince(tweet.created) > 24*60*60 {
                formatter.dateStyle = DateFormatter.Style.short
            } else {
                formatter.timeStyle = DateFormatter.Style.short
            }
            tweetCreatedLabel?.text = formatter.string(from: tweet.created)
        }
        
    }
    
}
