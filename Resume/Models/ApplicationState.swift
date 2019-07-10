//
//  ApplicationState.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-09.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

enum ApplicationState {
    case production
    case testing
    
    var profileURL:URL? {
        switch self {
        case .production:
            return URL(string: "https://gist.githubusercontent.com/nshillin/3ee62caea9addc5de056eff2a4a48fce/raw/")
        case .testing:
            return Bundle.main.url(forResource: "Valid", withExtension: "json")
        }
    }
}
