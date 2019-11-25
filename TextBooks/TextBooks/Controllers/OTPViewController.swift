//
//  OTPViewController.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 14/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    // OTP function, if conditions not working
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if ((textField.text?.count)! < 1) && (string.count > 0){
            if textField == txtFirst{
                txtSecond.becomeFirstResponder()
            }
            
            if textField == txtSecond{
                txtThird.becomeFirstResponder()
            }
            
            if textField == txtThird{
                txtFourth.becomeFirstResponder()
            }
            
            if textField == txtFourth{
                txtFourth.resignFirstResponder()
            }
            
            textField.text = string
            return false
        }
            
            //not working
        else if ((textField.text?.count)! >= 1) && (string.count == 0){
            if textField == txtSecond{
                txtFirst.becomeFirstResponder()
            }
            
            if textField == txtThird{
                txtThird.becomeFirstResponder()
            }
            
            if textField == txtFourth{
                txtThird.becomeFirstResponder()
            }
            
            if textField == txtFirst{
                txtFirst.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        }
        else if (textField.text?.count)! >= 1{
            textField.text = string
            return false
        }
        
        return true
    }
    
    // OTP design not working
    func addBottomBorderTo(textField:UITextField){
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: 2.0)
        textField.layer.addSublayer(layer)
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

extension OTPViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(textField.text as Any)
        return true
    }
}
