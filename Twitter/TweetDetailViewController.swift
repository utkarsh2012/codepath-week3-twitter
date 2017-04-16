//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Utkarsh Sengar on 4/15/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var tweetView: TweetView!
    @IBOutlet weak var replyIconView: UIImageView!
    @IBOutlet weak var favoriteIconView: UIImageView!
    @IBOutlet weak var retweetIconView: UIImageView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.tweet = tweet
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyButton(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replyToTweetSegue" {
            if let navController = segue.destination as? UINavigationController {
                if let childVC = navController.topViewController as? NewTweetViewController {
                    childVC.tweet = tweet
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
