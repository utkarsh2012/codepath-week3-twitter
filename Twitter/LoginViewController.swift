//
//  LoginViewController.swift
//  Twitter
//
//  Created by Utkarsh Sengar on 4/13/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitter  = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "J9Tw0Drg0LMIRvdRXwkNZLE73", consumerSecret: "06pfvNeb9DRK1BbusSadYbbjJgKkLiaTMAl7KjGd9dTSZGr8zz")
        twitter?.deauthorize()
        twitter?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (request_token) in
            print("Got a token!")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(request_token!.token ?? "")")!
            UIApplication.shared.open(url)
        }, failure: { (error) in
            print("error: \(error?.localizedDescription ?? "")")
        })
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
