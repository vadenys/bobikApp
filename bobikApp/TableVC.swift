//
//  TableVC.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class TableVC: UITableViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dragDelegate = self
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(closeTheCell))
        gestureRecogniser.delegate = self
        view.addGestureRecognizer(gestureRecogniser)
        gestureRecogniser.cancelsTouchesInView = false
    }

    lazy var people = {
        var peops = [Person]()
        for i in 1...5 {
            let man = Person(name: "Bob \(i)")
            peops.append(man)
        }
        return peops
    }()

    var openedCellIndex: Int?

    let cellID = "inboxCell"

       // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        cell.addGestureRecogniserCheckBox()
        if openedCellIndex == indexPath.row {
            cell.bioLabel.text = people[indexPath.row].bio
        } else {
            cell.bioLabel.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        people.remove(at: indexPath.row)
        if openedCellIndex == indexPath.row {
            openedCellIndex = nil
        }
        let rowIndex = [indexPath]
        tableView.deleteRows(at: rowIndex, with: .automatic)
    }

    @objc func closeTheCell(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: view)
        let touchIndexPath = tableView.indexPathForRow(at: touchLocation)

        // first to know if there are opened cells
        if let cellIndex = openedCellIndex {
            guard openedCellIndex != touchIndexPath?.row else { return }
            let indexPath = IndexPath(row: cellIndex, section: tableView.numberOfSections - 1)
            let cell = tableView.cellForRow(at: indexPath) as! CustomCell
            cell.collapse()
            tableView.beginUpdates()
            tableView.endUpdates()
            openedCellIndex = nil
        // no open cells and tapped on a cell
        } else if let indexPath = touchIndexPath {
            let touchCell = tableView.cellForRow(at: indexPath) as! CustomCell
            touchCell.nameLabel.isUserInteractionEnabled = true
            touchCell.nameLabel.resignFirstResponder()
            touchCell.bioLabel.isHidden = false
            touchCell.bioLabel.text = people[indexPath.row].bio
            tableView.beginUpdates()
            tableView.endUpdates()
            openedCellIndex = indexPath.row
        }
    }
}

// Row rearrangement
extension TableVC: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider()
        return [UIDragItem(itemProvider: itemProvider)]
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let men = people[sourceIndexPath.row]
        people.remove(at: sourceIndexPath.row)
        people.insert(men, at: destinationIndexPath.row)
        if openedCellIndex == sourceIndexPath.row {
            openedCellIndex = destinationIndexPath.row
        }
    }
}
