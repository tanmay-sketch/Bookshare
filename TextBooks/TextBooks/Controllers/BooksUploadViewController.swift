//
//  BooksUploadViewController.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 27/12/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage



class BooksUploadViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var txtGrades: UITextField?
    @IBOutlet var txtTitle: UITextField?
    @IBOutlet var txtSubject: UITextField?
    @IBOutlet var txtAuthor: UITextField?
    @IBOutlet var txtCondition: UITextField?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var conditionPicker: UIPickerView?
    @IBOutlet var gradesPicker: UIPickerView?
    @IBOutlet var toolbar: UIToolbar?
    
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    

    var imagePicker: UIImagePickerController!
    
    let bookconditions:[String] = ["Very Good", "Good", "Bad"]
    
    var uploadCompleted: ((_ isSuccess:Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionPicker?.dataSource = self
        conditionPicker?.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.delegate = self
//        imagePicker?.allowsEditing = true
        
        txtGrades?.inputView = gradesPicker
        txtGrades?.inputAccessoryView = toolbar
        txtTitle?.inputAccessoryView = toolbar
        txtAuthor?.inputAccessoryView = toolbar
        txtSubject?.inputAccessoryView = toolbar
        txtCondition?.inputView = conditionPicker
        txtCondition?.inputAccessoryView = toolbar

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0.0)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.scrollView.contentInset = .zero
            })
        }
    }
  
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func uploadImageTapped(_ sender:UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // DYNAMIC TEXT BUTTON
    
    fileprivate func showalert(with title: String, message:String, okAction: ((_ action:Bool) -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            okAction?(true)
        }))
        
        self.present(alert,animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        let title = txtTitle!.text;
        let subject = txtSubject!.text;
        let grade = txtGrades!.text;
        let author = txtAuthor!.text;
        let condition = txtCondition!.text;
    
        if title?.isEmpty ?? true {
            showalert(with: "Error", message: "Title not entered")
            return
        } else if subject?.isEmpty ?? true {
            showalert(with: "Error", message: "Subject not entered")
            return
        } else if grade?.isEmpty ?? true {
            showalert(with: "Error", message: "grade not entered")
            return
        } else if author?.isEmpty  ?? true {
            showalert(with: "Error", message: "Author not entered")
            return
        } else if condition?.isEmpty  ?? true {
            showalert(with: "Error", message: "Condition not entered")
            return
        } else if imageView?.image == nil {
            showalert(with: "Error", message:"Image not selected")
            return
        }
        
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("User is not logged in")
        }
        
        let name = Auth.auth().currentUser?.displayName ?? "Some Student"
        var userData = [String: Any]()
        userData = ["id": userID, "name": name]
        if let picture = Auth.auth().currentUser?.photoURL {
            userData["photo"] = picture.path
        }
        
        var doc = [String: Any]()
        doc["title"] = title
        doc["author"] = author
        doc["grade"] = grade
        doc["subject"] = subject
        doc["condition"] = condition
        doc["user"] = userData
        
        if let image = imageView?.image, let data = image.pngData() {
            
            let storageRef = storage.reference()
            let uniqueId = UUID().uuidString
            let booksRef = storageRef.child("\(uniqueId).png")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            booksRef.putData(data, metadata: nil) { [weak self] (metadata, error) in
                if let someError = error {
                    print("Some Error Occured \(someError)")
                } else if let _metadata = metadata {
                    print("Image Upload success \(_metadata.dictionaryRepresentation())")
                    doc["image"] = _metadata.path ?? "nil"
                    self?.db.collection("/textbooks/").addDocument(data: doc, completion: { error in
                        if let someError = error {
                            self?.showalert(with: "Error", message: someError.localizedDescription)
                        } else {
                            self?.showalert(with: "Success", message: "Book Uploaded Successfully", okAction: { _ in
                                self?.uploadCompleted?(true)
                                self?.navigationController?.popViewController(animated: true)
                            })
                        }
                    })
                }
                
            }
            
        }
        
        
    }
}

extension BooksUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("info \(info)")
        picker.dismiss(animated: true) {
            if let image = info[.originalImage] as? UIImage {
                self.imageView?.image = image
            }
        }
    }
    
}

extension BooksUploadViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == gradesPicker {
            return 7
        } else {
            return 3
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == gradesPicker {
        return "Grade \(row+6)"
        } else {
            return bookconditions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == gradesPicker {
        txtGrades?.text = "\(row+6)"
        } else {
            txtCondition?.text = bookconditions[row]
        }
    }
    
}


extension BooksUploadViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtTitle {
            txtSubject?.becomeFirstResponder()
        } else if textField == txtSubject {
            txtGrades?.becomeFirstResponder()
        } else if textField == txtGrades {
            txtAuthor?.becomeFirstResponder()
        } else if textField == txtAuthor{
            txtCondition?.becomeFirstResponder()
        } else {
            txtCondition?.resignFirstResponder()
        }
        return true
    }
    
}

    
