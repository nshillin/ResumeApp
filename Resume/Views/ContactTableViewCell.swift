//
//  ContactTableViewCell.swift
//  Resume
//
//  Created by Noah Shillington on 2019-07-08.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var infoTextView: UITextView!
    
    var title:String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var info:String? {
        didSet {
            infoTextView.text = info
        }
    }
    
    override func awakeFromNib() {
        infoTextView.textContainerInset = UIEdgeInsets.zero
        infoTextView.textContainer.lineFragmentPadding = 0
    }
}
