//
//  TwitterClient.swift
//  Twitter
//
//  Created by Utkarsh Sengar on 4/14/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "J9Tw0Drg0LMIRvdRXwkNZLE73", consumerSecret: "06pfvNeb9DRK1BbusSadYbbjJgKkLiaTMAl7KjGd9dTSZGr8zz")
    var loginSuccess:  (() -> ())?
    var loginFailure:  ((Error) -> ())?
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task, response) in
            let tweetsDict = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetsDict)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error?) in
            failure(error!)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask?, response: Any?) in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                success(user)
        },
            failure: { (task: URLSessionDataTask?, error: Error?) in
                failure((error)!)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (request_token) in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(request_token!.token ?? "")")!
            UIApplication.shared.open(url)
        }, failure: { (error) in
            print("error: \(error?.localizedDescription ?? "")")
            self.loginFailure?(error!)
        })
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (access_token) in
            
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error) in
                self.loginFailure?(error)
            })
        }, failure: { (error) in
            self.loginFailure?(error!)
        })
    }
}
