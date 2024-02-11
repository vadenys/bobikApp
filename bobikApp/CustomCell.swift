//
//  CustomCell.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class CustomCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var nameField: UITextView!
    @IBOutlet weak var bioField: UITextView!
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var phNameField: UILabel!
    @IBOutlet weak var phBioField: UILabel!

    func collapse() {
        nameField.isUserInteractionEnabled = false
        nameField.resignFirstResponder()
        bioField.text = ""
    }

    // TEXT VIEW DELEFATE
    func textViewDidChange(_ textView: UITextView) {
        phNameField.isHidden = !nameField.text.isEmpty
        phBioField.isHidden = !bioField.text.isEmpty
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        phNameField.isHidden = !nameField.text.isEmpty
        phBioField.isHidden = !bioField.text.isEmpty
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        phNameField.isHidden = !nameField.text.isEmpty
        phBioField.isHidden = !bioField.text.isEmpty
    }
}
