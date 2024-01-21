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
        
        for i in 1...5 {
            let man = Person(name: "Bob \(i)")
            people.append(man)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    var people = [Person]()
    let cellID = "inboxCell"
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        cell.nameLabel.text = people[indexPath.row].name
        cell.bioLabel.text = "tap to expand -->"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else {return}
        cell.expandedCell.toggle()
        let tappedMan = people[indexPath.row]
        
        if cell.expandedCell {
            cell.bioLabel.text = tappedMan.bio
            tableView.beginUpdates()
            tableView.endUpdates()
        } else {
            cell.bioLabel.text = "tap to expand -->"
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
