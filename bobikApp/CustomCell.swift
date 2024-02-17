//
//  CustomCell.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var helpView: UIView!


    func collapse() {
        nameTextView.isUserInteractionEnabled = false
        nameTextView.resignFirstResponder()
        noteTextView.isHidden = true
        
    }
}
