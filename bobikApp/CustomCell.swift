//
//  CustomCell.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    func collapse() {
        nameLabel.isUserInteractionEnabled = false
        nameLabel.resignFirstResponder()
        bioLabel.isHidden = true
    }
}
