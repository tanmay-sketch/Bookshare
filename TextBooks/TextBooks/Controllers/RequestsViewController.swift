//
//  RequestsViewController.swift
//  TextBooks
//
//  Created by Akshay on 16/01/20.
//  Copyright © 2020 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RequestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath)
        
        if let requestCell = cell as? RequestCell {
                
        }
        
        return cell
    }
}



class RequestCell: UITableViewCell {
    
    @IBOutlet var imgUser: UIImageView?
    @IBOutlet var lblTitle: UILabel?
    
    @IBAction func approveTapped(_ sender:UIButton) {
           
    }
    
    @IBAction func rejectTapped(_ sender:UIButton) {
        
    }
}
