//
//  Profile.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

struct Profile:Codable {
    
    var name:String
    var jobTitle:String
    var description:String
    
    private var image:String
    var imageURL:URL? {
        return URL(string: image)
    }
    
    private var appStore:String
    var appStoreURL:URL? {
        return URL(string: appStore)
    }
    
    private var linkedIn:String
    var linkedInURL:URL? {
        return URL(string: linkedIn)
    }
    
    private var gitHub:String
    var gitHubURL:URL? {
        return URL(string: gitHub)
    }
    
    var contactMethods:[ContactMethod]
    
    var experience:[Experience]
    var education:[Experience]
    var projects:[Experience]
}
