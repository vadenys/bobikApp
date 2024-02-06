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
    
    lazy var openedCellStatus: [Bool] = {
        return Array(repeating: false, count: people.count)
    }()
    
    var openedCellIndex: Int? = nil
    
    let cellID = "inboxCell"
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        //cell.nameLabel.text = people[indexPath.row].name
        if openedCellIndex == indexPath.row {
            cell.bioLabel.text = people[indexPath.row].bio
        } else {
            cell.bioLabel.text = "tap to expand -->"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if openedCellIndex == indexPath.row {
            let tappedCell = tableView.cellForRow(at: indexPath) as! CustomCell
            return
        } else if openedCellIndex == nil {
            guard let tappedCell = tableView.cellForRow(at: indexPath) as? CustomCell else {return}
            tappedCell.nameTextView.isUserInteractionEnabled = true
            tappedCell.nameTextView.resignFirstResponder()
            tappedCell.bioLabel.text = people[indexPath.row].bio
            tableView.beginUpdates()
            tableView.endUpdates()
            openedCellIndex = indexPath.row
            return
        } else if let openedCell = openedCellIndex {
            let indexPath = IndexPath(row: openedCell, section: (tableView.numberOfSections - 1))
            if let lastTappedCell = tableView.cellForRow(at: indexPath) as? CustomCell {
                lastTappedCell.nameTextView.isUserInteractionEnabled = false
                lastTappedCell.bioLabel.text = "tap to expand -->"
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            openedCellIndex = nil
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === tableView)
    }
    
    @objc func closeTheCell(_ gesture: UITapGestureRecognizer) {
        if let openedCell = openedCellIndex {
            let indexPath = IndexPath(row: openedCell, section: tableView.numberOfSections - 1)
            let cell = tableView.cellForRow(at: indexPath) as! CustomCell
            cell.nameTextView.isUserInteractionEnabled = false
            cell.nameTextView.resignFirstResponder()
            cell.bioLabel.text = "tap to expand -->"
            tableView.beginUpdates()
            tableView.endUpdates()
            openedCellIndex = nil
        }
    }
    
    
}
