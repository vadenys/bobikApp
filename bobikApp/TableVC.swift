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
        tableView.separatorStyle = .none
        tableView.dragDelegate = self
        
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(collapseCell))
        gestureRecogniser.delegate = self
        tableView.addGestureRecognizer(gestureRecogniser)
        gestureRecogniser.cancelsTouchesInView = false
    }

    lazy var toDoList = {
        var toDoList = [ToDoTask]()
        for i in 1...5 {
            let task = ToDoTask()
            toDoList.append(task)
        }
        return toDoList
    }()

    var expandedCellIndexPath: IndexPath? 

    let cellID = "inboxCell"

    @IBAction func addNewToDoTask() {
        let newTask = ToDoTask()
        let indexPath = IndexPath(row: toDoList.count, section: tableView.numberOfSections - 1)
        toDoList.append(newTask)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Cell collapse/expand gesture recognition
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === tableView)
    }

    @objc func collapseCell(_ gesture: UITapGestureRecognizer) {
        if let indexPath = expandedCellIndexPath {
            let touchLocation = gesture.location(in: tableView)
            if tableView.indexPathForRow(at: touchLocation) == nil {
                expandedCellIndexPath = nil
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }

    // MARK: - Cell collapse/expand configuration
    func configureCell(cell: CustomCell, indexPath: IndexPath) {
        if expandedCellIndexPath == indexPath {
            cell.todoNotesLabel.isHidden = false
            cell.todoNameLabel.isUserInteractionEnabled = true
            cell.todoNameLabel.resignFirstResponder()
            cell.detailsView.isHidden = false
        } else {
            cell.todoNotesLabel.isHidden = true
            cell.detailsView.isHidden = true
        }
        if toDoList[indexPath.row].toDoChecked {
            cell.checkBoxImageView.image = UIImage(systemName: "checkmark.square")
        } else {
            cell.checkBoxImageView.image = UIImage(systemName: "square")
        }
    }
}

// MARK: - Table view data source and delegate
extension TableVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomCell
        cell.delegate = self
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard expandedCellIndexPath == nil else { return }
        toDoList.remove(at: indexPath.row)
        if expandedCellIndexPath == indexPath {
            expandedCellIndexPath = nil
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard expandedCellIndexPath != indexPath else { return }
        if let cellIndexPath = expandedCellIndexPath {
            expandedCellIndexPath = nil
            tableView.reloadRows(at: [cellIndexPath], with: .none)
        } else {
            expandedCellIndexPath = indexPath
            tableView.reloadRows(at: [expandedCellIndexPath!], with: .none)
        }
    }
}

// MARK: - Row rearrangement
extension TableVC: UITableViewDragDelegate {
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        expandedCellIndexPath == nil
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard expandedCellIndexPath == nil else { return [] }
        let itemProvider = NSItemProvider()
        return [UIDragItem(itemProvider: itemProvider)]
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard expandedCellIndexPath == nil else { return }
        let task = toDoList[sourceIndexPath.row]
        toDoList.remove(at: sourceIndexPath.row)
        toDoList.insert(task, at: destinationIndexPath.row)
        if expandedCellIndexPath == sourceIndexPath {
            expandedCellIndexPath = destinationIndexPath
        }
    }
}

// MARK: - Cell delegate
extension TableVC: CellDelegate {

    func toggleCheckBox(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: tableView)
        if let touchIndexPath = tableView.indexPathForRow(at: touchLocation) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.toDoList[touchIndexPath.row].toDoChecked.toggle()
                self.tableView.reloadRows(at: [touchIndexPath], with: .none)
            }
        }
    }

    func tapCalendarIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        print("calendar")
    }

    func tapTagsIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        print("tagsIcon")
    }

    func tapChecklistIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        print("checklist")
    }

    func tapDeadlineIcon(_ controller: CustomCell, gesture: UITapGestureRecognizer) {
        print("deadline")
    }
}
