//
//  NetworkHandler.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

struct NetworkHandler {
    
    func getDefaultUserProfile(success:@escaping (Profile)->(), failure:@escaping (NetworkError)->()) {
        let delegte = UIApplication.shared.delegate as? AppDelegate
        getProfile(profileURL: delegte?.applicationState.profileURL, success: success, failure: failure)
    }
    
    func getProfile(profileURL:URL?, success:@escaping (Profile)->(), failure:@escaping (NetworkError)->()) {
        let session = URLSession.shared
        
        if let profileURL = profileURL {
            let task = session.dataTask(with: profileURL) { (data, response, error) in
                if let _ = error {
                    failure(.defaultError)
                } else if let data = data {
                    do {
                        let profile = try JSONDecoder().decode(Profile.self, from: data)
                        success(profile)
                    } catch {
                        failure(.invalidJSON)
                    }
                }
            }
            
            task.resume()
        } else {
            failure(.invalidURL)
        }
    }
}
