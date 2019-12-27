//
//  UploadBooksViewController.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 27/12/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class UploadBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblDropDown.delegate = self
        tblDropDown.dataSource = self
        tblDropDownHC.constant = 0
        
    }
    
    // MARK: - UITableView delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "numberofsubject")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "numberofsubject")
        }
        cell?.textLabel?.text = "grade \(indexPath.row+1)"
          
          return cell!
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func selectSubjects(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5) {
            self.tblDropDownHC.constant = 44.0 * 15.0
            self.view.layoutIfNeeded()
        }
    }
}
