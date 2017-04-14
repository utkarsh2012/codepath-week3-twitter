//
//  Tweet.swift
//  Twitter
//
//  Created by Utkarsh Sengar on 4/14/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favouriteCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount  = (dictionary["retweet_count"] as? Int) ?? 0
        favouriteCount  = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampStringExists = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampStringExists)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dict in dictionaries {
            let tweet = Tweet(dictionary: dict)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
