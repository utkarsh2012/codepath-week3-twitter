//
//  User.swift
//  Twitter
//
//  Created by Utkarsh Sengar on 4/14/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit

class User: NSObject {

    var name : String?
    var screenName: String?
    var profileUrl: URL?
    var tagLine: String?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
     
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlStringExists = profileUrlString {
            profileUrl = URL(string: profileUrlStringExists)
        }
        
        tagLine = dictionary["description"] as? String
    }
}
