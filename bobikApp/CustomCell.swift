//
//  CustomCell.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var bioLabel: UILabel!

    func collapse() {
        nameTextView.isUserInteractionEnabled = false
        nameTextView.resignFirstResponder()
        bioLabel.text = "tap to expand -->"
    }
}
