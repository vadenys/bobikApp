//
//  CustomCell.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

protocol CellDelegate: AnyObject {
    func toggle(_ controller: CustomCell, gesture: UITapGestureRecognizer)
}

class CustomCell: UITableViewCell {

    @IBOutlet weak var todoNameLabel: UILabel!
    @IBOutlet weak var todoNotesLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecogniserCheckBox()
        todoNotesLabel.text = "Bob is American singer, songwriter, dancer, and philanthropist. Known as the 'King of Pop', he is regarded as one of the most significant cultural figures of the 20th century"
    }

    weak var delegate: CellDelegate?

    func addGestureRecogniserCheckBox() {
        let gestureRecogniserCheckBox = UITapGestureRecognizer(target: self, action: #selector(toggleCheckBox))
        gestureRecogniserCheckBox.delegate = self
        gestureRecogniserCheckBox.cancelsTouchesInView = true
        checkBoxImageView.addGestureRecognizer(gestureRecogniserCheckBox)
    }

    @objc func toggleCheckBox(_ gesture: UITapGestureRecognizer) {
        delegate?.toggle(self, gesture: gesture)
    }
}
