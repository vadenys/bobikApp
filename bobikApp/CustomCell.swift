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
    @IBOutlet weak var checkBoxView: UIImageView!

    var checked = false

    func collapse() {
        nameLabel.isUserInteractionEnabled = false
        nameLabel.resignFirstResponder()
        bioLabel.isHidden = true
    }

    func addGestureRecogniserCheckBox() {
        let gestureRecogniserCheckBox = UITapGestureRecognizer(target: self, action: #selector(toggleCheckBox))
        gestureRecogniserCheckBox.delegate = self
        gestureRecogniserCheckBox.cancelsTouchesInView = false
        checkBoxView.addGestureRecognizer(gestureRecogniserCheckBox)
    }

    @objc func toggleCheckBox(_ gesture: UITapGestureRecognizer) {
        checked.toggle()
        if checked {
            let imageChecked = UIImage(systemName: "checkmark.square")
            checkBoxView.image = imageChecked
        } else {
            let imageChecked = UIImage(systemName: "square")
            checkBoxView.image = imageChecked
        }
    }

}
