//
//  TableVC.swift
//  bobikApp
//
//  Created by Vasyl Denys on 1/21/24.
//

import UIKit

class TableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    lazy var people = {
        var peops = [Person]()
        for i in 1...20 {
            let man = Person(name: "Bob \(i)")
            peops.append(man)
        }
        return peops
    }()
    
    lazy var openedCellStatus: [Bool] = {
        return Array(repeating: false, count: people.count)
    }()
    
    let cellID = "inboxCell"
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        cell.nameLabel.text = people[indexPath.row].name
        if openedCellStatus[indexPath.row] == false {
            cell.bioLabel.text = "tap to expand -->"
        } else {
            cell.bioLabel.text = people[indexPath.row].bio
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard openedCellStatus[indexPath.row] == false else {return} // nothing happens if user taps on already opened cell
        // Checks if there is an opened cell and if - updates UI, updates data model
        if let lastTappeCellIdex = openedCellStatus.firstIndex(of: true) {
            openedCellStatus[lastTappeCellIdex] = false
            let indexPath = IndexPath(row: lastTappeCellIdex, section: 0)
            if let lastTappedCell = tableView.cellForRow(at: indexPath) as? CustomCell {
                lastTappedCell.bioLabel.text = "tap to expand -->"
            }
        }
        // Updates newly tapped cell
        guard let tappedCell = tableView.cellForRow(at: indexPath) as? CustomCell else {return}
        tappedCell.bioLabel.text = people[indexPath.row].bio
        tableView.beginUpdates()
        tableView.endUpdates()
        openedCellStatus[indexPath.row] = true
    }
}
