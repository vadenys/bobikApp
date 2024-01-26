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
    
    var openedCellList: [Bool] = []
    lazy var people: [Person] = {
        var peops = [Person]()
        for i in 1...20 {
            let man = Person(name: "Bob \(i)")
            peops.append(man)
        }
        openedCellList = Array(repeating: false, count: peops.count)
        return peops
    }()
    let cellID = "inboxCell"

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        cell.nameLabel.text = people[indexPath.row].name
        if openedCellList[indexPath.row] == false {
            cell.bioLabel.text = "tap to expand -->"
        } else {
            cell.bioLabel.text = people[indexPath.row].bio
        }
        return cell
    }
    
    var tappeCell: UITableViewCell?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let lastCell = tappeCell as? CustomCell {
            lastCell.bioLabel.text = "tap to expand -->"
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else {return}
        openedCellList = Array(repeating: false, count: people.count)
        openedCellList[indexPath.row] = true
        let tappedMan = people[indexPath.row]
        cell.bioLabel.text = tappedMan.bio
        tableView.beginUpdates()
        tableView.endUpdates()
        tappeCell = cell
    }
}
