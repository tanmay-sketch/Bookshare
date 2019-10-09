//
//  ViewController.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 09/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.keyboardType = UIKeyboardType.numberPad
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

