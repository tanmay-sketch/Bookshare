//
//  GradesTableViewController.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 19/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

struct ExpandableData {
    var opened : Bool
    var title : String
    var sectionData : [String]
    
    var associatedGrade : Grade
}
class GradesTableViewController: UITableViewController {
    
    var tableViewData = [ExpandableData]()
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Grades"

        var grades = [Grade]()
        
        db.collection("/books /").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("Doc: \(document.documentID) => \(document.data())")

                }
            }
        }

    }
    @IBAction func perforLogout(_ sender: UIBarButtonItem) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let controller = storyboard.instantiateViewController(identifier: "MainNavController")
         UIApplication.shared.delegate?.window??.rootViewController = controller
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let booksVC = segue.destination as? TextBooksViewController {
            if let index = self.tableView.indexPathForSelectedRow {
                let grade = tableViewData[index.section].associatedGrade
//                booksVC.grade = grade.grade
//
//                let subject = grade.subjects[index.row-1]
//                booksVC.subject = subject
            }
            
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.indentationLevel = 0
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.textLabel?.textColor = UIColor.darkGray
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.indentationLevel = 1
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            cell.textLabel?.textColor = UIColor.lightGray
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true && indexPath.row == 0 {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        else if indexPath.row == 0 {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            self.performSegue(withIdentifier: "showBooks", sender: nil)
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
