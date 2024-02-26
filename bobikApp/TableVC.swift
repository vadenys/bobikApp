//
//  TableVC.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class TableVC: UITableViewController, UIGestureRecognizerDelegate, cellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.dragDelegate = self

        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(colapseCell))
        gestureRecogniser.delegate = self
        tableView.addGestureRecognizer(gestureRecogniser)
        gestureRecogniser.cancelsTouchesInView = false
    }

    lazy var toDoList = {
        var toDoList = [toDoTask]()
        for i in 1...5 {
            let task = toDoTask()
            toDoList.append(task)
        }
        return toDoList
    }()

    var expandedCellIndexPath: IndexPath?
    let cellID = "inboxCell"

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        toDoList.remove(at: indexPath.row)
        if expandedCellIndexPath == indexPath {
            expandedCellIndexPath = nil
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard expandedCellIndexPath != indexPath else { return }
        if let indexPath = expandedCellIndexPath {
            expandedCellIndexPath = nil
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            expandedCellIndexPath = indexPath
            tableView.reloadRows(at: [expandedCellIndexPath!], with: .automatic)
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === tableView)
    }

    @objc func colapseCell(_ gesture: UITapGestureRecognizer) {
        guard expandedCellIndexPath != nil else { return }
        if let indexPath = expandedCellIndexPath {
            expandedCellIndexPath = nil
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        cell.delegate = self
        cellConfiguration(cell: cell, indexPath: indexPath)
        return cell
    }

    // MARK: - Cell collapse/expand configuration
    func cellConfiguration(cell: CustomCell, indexPath: IndexPath) {
        if expandedCellIndexPath == indexPath {
            cell.todoNotesLabel.isHidden = false
            cell.todoNameLabel.isUserInteractionEnabled = true
            cell.todoNameLabel.resignFirstResponder()
        } else {
            cell.todoNotesLabel.isHidden = true
        }
        if toDoList[indexPath.row].toDoChecked {
            cell.checkBoxImageView.image = UIImage(systemName: "checkmark.square")
        } else {
            cell.checkBoxImageView.image = UIImage(systemName: "square")
        }
    }

    // MARK: - Cell delegate
    func toggle(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: tableView)
        if let touchIndexPath = tableView.indexPathForRow(at: touchLocation) {
            toDoList[touchIndexPath.row].toDoChecked.toggle()
            tableView.reloadRows(at: [touchIndexPath], with: .automatic)
        }
    }
}

// MARK: - Row rearrangement
extension TableVC: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider()
        return [UIDragItem(itemProvider: itemProvider)]
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let men = toDoList[sourceIndexPath.row]
        toDoList.remove(at: sourceIndexPath.row)
        toDoList.insert(men, at: destinationIndexPath.row)
        if expandedCellIndexPath == sourceIndexPath {
            expandedCellIndexPath = destinationIndexPath
        }
    }
}
