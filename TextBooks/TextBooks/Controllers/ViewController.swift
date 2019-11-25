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
    @IBAction func textField(_ sender: Any) {
    }
    
    @IBOutlet var toolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.inputAccessoryView = toolbar
        #if DEBUG
        textField.text = "9090909090"
        #endif
        
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    

    @IBAction func loginButtonTapped(_ sender: Any) {
   
        if textField.text?.count != 10 {
                 let alert = UIAlertController(title: "Error", message: "Please enter valid mobile number", preferredStyle: .alert)
                 let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                 alert.addAction(action)
                 self.present(alert, animated: true, completion: nil)
             }
        
        print(textField.text)
        

}
}
