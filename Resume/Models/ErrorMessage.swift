//
//  ErrorMessage.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-09.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

enum NetworkError:Equatable {
    case invalidURL
    case invalidJSON
    case defaultError
    
    var message:String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidJSON:
            return "Error decoding resume"
        case .defaultError:
            return "A network error occurred"
        }
    }
}
