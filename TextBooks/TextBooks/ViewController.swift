//
//  ViewController.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 09/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet var toolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.inputAccessoryView = toolbar
        
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        print(textField.text)
        if textField.text?.count != 10 {
            let alert = UIAlertController(title: "Error", message: "Please enter valid mobile number", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
   





}
}
