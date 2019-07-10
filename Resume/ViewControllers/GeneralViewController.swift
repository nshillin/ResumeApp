//
//  GeneralViewController.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit
import SafariServices

class GeneralViewController: UIViewController  {

    @IBOutlet weak var navBarView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    let defaultImageHeight:CGFloat = 100
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var contactTableViewTop: NSLayoutConstraint!
    let contactCell = "ContactTableViewCell"
    
    // Update navbar content and refresh contact table on profile update
    var profile:Profile? {
        didSet {
            if let profile = profile {
                nameLabel.text = profile.name
                jobTitleLabel.text = profile.jobTitle
                contactTableView.reloadData()
                downloadImage(from: profile.imageURL)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarView.accessibilityIdentifier = "GeneralNavBar"
        
        nameLabel.text = ""
        jobTitleLabel.text = ""

        profileImageHeight.constant = defaultImageHeight
        
        contactTableView.register(UINib(nibName: contactCell, bundle: nil), forCellReuseIdentifier: contactCell)
        contactTableViewTop.constant = navBarView.frame.maxY
        
        contactTableView.rowHeight = UITableView.automaticDimension
        contactTableView.estimatedRowHeight = 100
        
        resizeImageRadius()
    }
    
    
    func resizeImageRadius() {
        profileImageView.layer.cornerRadius = profileImageHeight.constant/2
    }
    
    @IBAction func goToAppStore(_ sender: UIButton) {
        open(url: profile?.appStoreURL)
    }
    
    @IBAction func goToLinkedIn(_ sender: UIButton) {
        open(url: profile?.linkedInURL)
    }
    
    @IBAction func goToGitHub(_ sender: UIButton) {
        open(url: profile?.gitHubURL)
    }
    
    func open(url:URL?) {
        if let url = url {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
    
    // Download profile image in background/update when loaded
    func downloadImage(from url: URL?) {
        if let url = url {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data)
                    }
                } catch {
                    print("Failed to download image")
                }
            }
        }
        
    }
}

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let profile = profile {
            return profile.contactMethods.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCell) as! ContactTableViewCell
        if let contactMethod = profile?.contactMethods[indexPath.row] {
            cell.title = contactMethod.title
            cell.info = contactMethod.info
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            profileImageHeight.constant = defaultImageHeight - yOffset
            resizeImageRadius()
        }
    }
}
