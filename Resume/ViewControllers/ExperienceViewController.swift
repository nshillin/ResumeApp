//
//  ExperienceViewController.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit
import SafariServices

class ExperienceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum ExperienceGroups:String {
        case education
        case experience
        case projects
        
        var title:String {
            return self.rawValue.capitalized
        }
        
        func getExperiences(profile:Profile) -> [Experience] {
            switch self {
            case .education:
                return profile.education
            case .experience:
                return profile.experience
            case .projects:
                return profile.projects
            }
        }
    }
    
    let groups:[ExperienceGroups] = [.education,.experience,.projects]
    
    let experienceCell = "ExperienceTableViewCell"
    
    var profile:Profile? {
        didSet {
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: experienceCell, bundle: nil), forCellReuseIdentifier: experienceCell)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.accessibilityIdentifier = "ExperienceTable"
    }
    
    func open(url:URL?) {
        if let url = url {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
}

extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let profile = profile {
            let group = groups[section]
            return group.getExperiences(profile: profile).count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: experienceCell) as! ExperienceTableViewCell
        let group = groups[indexPath.section]
        if let profile = profile {
            let experience = group.getExperiences(profile: profile)[indexPath.row]
            cell.title = experience.title
            cell.dateText = experience.dates
            cell.body = experience.body
            cell.location = experience.location
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let group = groups[indexPath.section]
        if let profile = profile {
            let experience = group.getExperiences(profile: profile)[indexPath.row]
            open(url: experience.linkURL)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups[section].title
    }
    
}
