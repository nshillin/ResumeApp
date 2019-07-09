//
//  Experience.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

struct Experience: Codable {
    var title:String
    var location:String
    var body:String

    var dates:String
    
    private var link:String
    var linkURL:URL? {
        return URL(string: link)
    }
    
}

