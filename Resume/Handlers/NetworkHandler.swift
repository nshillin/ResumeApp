//
//  NetworkHandler.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

struct NetworkHandler {
    
    private let profileURL = URL(string: "https://gist.githubusercontent.com/nshillin/3ee62caea9addc5de056eff2a4a48fce/raw")!
    
    func getProfile(success:@escaping (Profile)->(), failure:@escaping (String)->()) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: profileURL) { (data, response, error) in
            if let error = error {
                failure(error.localizedDescription)
            } else if let data = data {
                do {
//                    print(try JSONSerialization.jsonObject(with: data, options: []))
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    success(profile)
                } catch {
                    failure("Failed to decode JSON")
                }
            }
        }
        
        task.resume()
    }
}
