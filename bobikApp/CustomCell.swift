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
    var notesLabel = UILabel()


    // CELL-FOR_ROW CONFIGURATION
    func cellForRowConfigure() {
        self.nameField.delegate = self
        self.bioField.delegate = self
        self.nameField.textContainerInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        let notesLabel = createNotesLabel()
        self.addSubview(notesLabel)
    }
    
    // OPEN-CELL INTERACTION CONFIGURATION
    func openCellConfigure() {
        self.nameField.isUserInteractionEnabled = true
        self.nameField.resignFirstResponder()
        self.bioField.isUserInteractionEnabled = true
        self.bioField.resignFirstResponder()
        self.bioField.isHidden = false
    }

    // COLLAPSE
    func collapse() {
        nameField.isUserInteractionEnabled = false
        nameField.resignFirstResponder()
        bioField.isHidden = true
    }

    // TEXT VIEW DELEFATE
    func textViewDidChange(_ textView: UITextView) {
        phNameField.isHidden = !nameField.text.isEmpty
        notesLabel.isHidden = !bioField.text.isEmpty
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        phNameField.isHidden = !nameField.text.isEmpty
        notesLabel.isHidden = !bioField.text.isEmpty
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        phNameField.isHidden = !nameField.text.isEmpty
        notesLabel.isHidden = !bioField.text.isEmpty
    }

    // NOTES LABEL CONFIGURATION
    func createNotesLabel() -> UILabel {
        let xPosition = phNameField.frame.origin.x
        let yPosition = bioField.frame.origin.y + 15
        notesLabel.frame = CGRect(x: xPosition, y: yPosition, width: phNameField.frame.width, height: phNameField.frame.height)
        notesLabel.numberOfLines = 0
        notesLabel.textColor = .placeholderText
        notesLabel.text = "Notes"
        return notesLabel
    }
}





//NSLayoutConstraint(item: subview,
//                   attribute: .leading,
//                   relatedBy: .equal,
//                   toItem: view,
//                   attribute: .leadingMargin,
//                   multiplier: 1.0,
//                   constant: 0.0).isActive = true
