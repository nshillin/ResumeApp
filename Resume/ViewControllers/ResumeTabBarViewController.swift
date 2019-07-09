//
//  ResumeTabBarViewController.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

class ResumeTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
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
        delegate = self
        
        createLoadingView()
        
        getProfile()
        
    }
    
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
        NetworkHandler().getProfile(success: didGetProfile, failure: errorGettingProfile)
    }
    
    func didGetProfile(_ profile:Profile) {
        DispatchQueue.main.async {
            self.profile = profile
        }
    }
    
    func errorGettingProfile(_ errorMessage:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error Downloading", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                self.getProfile()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
