//
//  CustomCell.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

protocol CellDelegate: AnyObject {
    func toggleCheckBox(_ controller: CustomCell, gesture: UITapGestureRecognizer)
    func tapCalendarIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer)
    func tapTagsIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer)
    func tapChecklistIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer)
    func tapDeadlineIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer)
}

class CustomCell: UITableViewCell {

    @IBOutlet weak var todoNameLabel: UILabel!
    @IBOutlet weak var todoNotesLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!

    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var tagsIcon: UIImageView!
    @IBOutlet weak var checklistIcon: UIImageView!
    @IBOutlet weak var deadlineIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecogniserCheckBox()
        addGestureRecogniserCalendarIcon()
        addGestureRecogniserTagsIcon()
        addGestureRecogniserChecklistIcon()
        addGestureRecogniserDeadlineIcon()

        calendarIcon.isHidden = true
        tagsIcon.isHidden = true
        checklistIcon.isHidden = true
        deadlineIcon.isHidden = true

        todoNotesLabel.text = "Bob is American singer, songwriter, dancer, and philanthropist. Known as the 'King of Pop', he is regarded as one of the most significant cultural figures of the 20th century"
    }

    weak var delegate: CellDelegate?

    // Gesture - checkBox
    func addGestureRecogniserCheckBox() {
        let gestureRecogniserCheckBox = UITapGestureRecognizer(target: self, action: #selector(toggleCheckBox))
        gestureRecogniserCheckBox.delegate = self
        gestureRecogniserCheckBox.cancelsTouchesInView = true
        checkBoxImageView.addGestureRecognizer(gestureRecogniserCheckBox)
    }

    @objc func toggleCheckBox(_ gesture: UITapGestureRecognizer) {
        delegate?.toggleCheckBox(self, gesture: gesture)
    }

    // Gesture - calendarIcon
    func addGestureRecogniserCalendarIcon() {
        let gestureRecogniserCalendarIcon = UITapGestureRecognizer(target: self, action: #selector(tapCalendarIcon))
        gestureRecogniserCalendarIcon.delegate = self
        gestureRecogniserCalendarIcon.cancelsTouchesInView = true
        calendarIcon.addGestureRecognizer(gestureRecogniserCalendarIcon)
    }

    @objc func tapCalendarIcon(_ gesture: UITapGestureRecognizer) {
        delegate?.tapCalendarIcon(self, gesture: gesture)
    }

    // Gesture - tagsIcon
    func addGestureRecogniserTagsIcon() {
        let gestureRecogniserTagsIcon = UITapGestureRecognizer(target: self, action: #selector(tapTagsIcon))
        gestureRecogniserTagsIcon.delegate = self
        gestureRecogniserTagsIcon.cancelsTouchesInView = true
        tagsIcon.addGestureRecognizer(gestureRecogniserTagsIcon)
    }

    @objc func tapTagsIcon(_ gesture: UITapGestureRecognizer) {
        delegate?.tapTagsIcon(self, gesture: gesture)
    }

    // Gesture - checklistIcon
    func addGestureRecogniserChecklistIcon() {
        let gestureRecogniserChecklistIcon = UITapGestureRecognizer(target: self, action: #selector(tapChecklistIcon))
        gestureRecogniserChecklistIcon.delegate = self
        gestureRecogniserChecklistIcon.cancelsTouchesInView = true
        checklistIcon.addGestureRecognizer(gestureRecogniserChecklistIcon)
    }

    @objc func tapChecklistIcon(_ gesture: UITapGestureRecognizer) {
        delegate?.tapChecklistIcon(self, gesture: gesture)
    }

    // Gesture - calendarIcon
    func addGestureRecogniserDeadlineIcon() {
        let gestureRecogniserDeadlineIcon = UITapGestureRecognizer(target: self, action: #selector(tapDeadlineIcon))
        gestureRecogniserDeadlineIcon.delegate = self
        gestureRecogniserDeadlineIcon.cancelsTouchesInView = true
        deadlineIcon.addGestureRecognizer(gestureRecogniserDeadlineIcon)
    }

    @objc func tapDeadlineIcon(_ gesture: UITapGestureRecognizer) {
        delegate?.tapDeadlineIcon(self, gesture: gesture)
    }




}
