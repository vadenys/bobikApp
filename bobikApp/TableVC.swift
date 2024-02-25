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
        tableView.dragDelegate = self

        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(colapseCell))
        gestureRecogniser.delegate = self
        tableView.addGestureRecognizer(gestureRecogniser)
        gestureRecogniser.cancelsTouchesInView = false
    }

    lazy var people = {
        var peops = [Person]()
        for i in 1...5 {
            let man = Person()
            peops.append(man)
        }
        return peops
    }()

    var expandedCellIndexPath: IndexPath?
    let cellID = "inboxCell"

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        people.remove(at: indexPath.row)
        if expandedCellIndexPath == indexPath {
            expandedCellIndexPath = nil
        }
        tableView.deleteRows(at: [indexPath], with: .none)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard expandedCellIndexPath != indexPath else { return }
        if let indexPath = expandedCellIndexPath {
            expandedCellIndexPath = nil
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            expandedCellIndexPath = indexPath
            tableView.reloadRows(at: [expandedCellIndexPath!], with: .none)
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === tableView)
    }

    @objc func colapseCell(_ gesture: UITapGestureRecognizer) {
        guard expandedCellIndexPath != nil else { return }
        if let indexPath = expandedCellIndexPath {
            expandedCellIndexPath = nil
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
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
            cell.bioLabel.isHidden = false
            cell.nameLabel.isUserInteractionEnabled = true
            cell.nameLabel.resignFirstResponder()
        } else {
            cell.bioLabel.isHidden = true
        }
        if people[indexPath.row].checked {
            cell.checkBoxImageView.image = UIImage(systemName: "checkmark.square")
        } else {
            cell.checkBoxImageView.image = UIImage(systemName: "square")
        }
    }

    // MARK: - Cell delegate
    func toggle(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: tableView)
        let touchIndexPath = tableView.indexPathForRow(at: touchLocation)
        if let indexPath = touchIndexPath {
            let touchCell = tableView.cellForRow(at: indexPath) as! CustomCell
            people[indexPath.row].checked.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
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
        let men = people[sourceIndexPath.row]
        people.remove(at: sourceIndexPath.row)
        people.insert(men, at: destinationIndexPath.row)
        if expandedCellIndexPath == sourceIndexPath {
            expandedCellIndexPath = destinationIndexPath
        }
    }
}
