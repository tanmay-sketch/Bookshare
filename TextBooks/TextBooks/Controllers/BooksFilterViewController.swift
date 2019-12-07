//
//  BooksFilterViewController.swift
//  TextBooks
//
//  Created by Akshay on 07/12/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class BooksFilterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var grades = [Int]()
    
    var filterGrade : Int?
    
    var gradeSelected : ((_ grade:Int?) -> Void)?
    var previouslySelectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let filter = filterGrade, let index = grades.lastIndex(where: {filter == $0}) {
            let indexPath = IndexPath(item: index, section: 0)
            previouslySelectedIndexPath = indexPath
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let grade = grades[indexPath.row]
            gradeSelected?(grade)
        } else {
            gradeSelected?(nil)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}


extension BooksFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        let grade = grades[indexPath.row]
        cell.textLabel?.text = "Grade \(grade)"
        if grade == filterGrade {
            cell.isSelected = true
            cell.accessoryType = .checkmark
        } else {
            cell.isSelected = false
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if previouslySelectedIndexPath?.row == indexPath.row {
            previouslySelectedIndexPath = nil
            tableView.deselectRow(at: indexPath, animated: true)
            cell?.accessoryType = .none
        } else {
            previouslySelectedIndexPath = indexPath
            cell?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
