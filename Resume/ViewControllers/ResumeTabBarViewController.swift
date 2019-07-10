//
//  ResumeTabBarViewController.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

class ResumeTabBarViewController: UITabBarController {
    
    // Update profile in sub-view-controllers when profile gets initiailized/updated
    var profile:Profile? {
        didSet {
            loadingView.isHidden = true
            for vc in viewControllers ?? [] {
                if let vc = vc as? GeneralViewController {
                    vc.profile = profile
                } else if let navVC = vc as? UINavigationController,
                   let vc = navVC.viewControllers.first as? ExperienceViewController {
                    vc.profile = profile
                }
            }
        }
    }
    
    var loadingView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingView()
        getProfile()
    }
    
    // Block user input with a loading screen until content downloads
    func createLoadingView() {
        loadingView = UIView(frame: view.frame)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(loadingView)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
    }

    
    func getProfile() {
        NetworkHandler().getDefaultUserProfile(success: didGetProfile, failure: errorGettingProfile)
    }
    
    func didGetProfile(_ profile:Profile) {
        DispatchQueue.main.async {
            self.profile = profile
        }
    }
    
    // Prompt user to retry download with an alert
    func errorGettingProfile(_ networkError:NetworkError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error Downloading", message: networkError.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                self.getProfile()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
