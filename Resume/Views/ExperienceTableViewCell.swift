//
//  ExperienceTableViewCell.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
        
    var title:String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var dateText:String? {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    var body:String? {
        didSet {
            bodyLabel.text = body
        }
    }
    
    var location:String? {
        didSet {
            locationLabel.text = location
        }
    }
}
