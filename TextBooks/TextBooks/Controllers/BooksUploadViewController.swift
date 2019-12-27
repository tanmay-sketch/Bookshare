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
    
    @IBOutlet var gradesPicker: UIPickerView?
    @IBOutlet var toolbar: UIToolbar?
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
        
        txtGrades?.inputView = gradesPicker
        txtGrades?.inputAccessoryView = toolbar
  
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func uploadImageTapped(_ sender:UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        //TODO: Validate textfields
        
        let title = "Dummy title"
        let author = "Dummy Author"
        let grades = [8,9]
        let subject = "Dummy Subject"
        
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("User is not logged in")
        }
        
        var doc = [String: Any]()
        doc["title"] = title
        doc["author"] = author
        doc["grades"] = grades
        doc["subject"] = subject
        doc["user"] = userID
        
        if let image = imageView?.image, let data = image.pngData() {
            
            let storageRef = storage.reference()
            let booksRef = storageRef.child("book_\(userID).png")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            booksRef.putData(data, metadata: nil) { (metadata, error) in
                if let someError = error {
                    print("Some Error Occured \(someError)")
                } else if let _metadata = metadata {
                    print("Upload success \(_metadata.dictionaryRepresentation())")
                    doc["image"] = _metadata.path ?? "nil"
                    self.db.collection("/testing/").addDocument(data: doc, completion: { error in
                        if let someError = error {
                            print("Some Error Occured \(someError)")
                        } else {
                            print("Insertion success")
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
            if let image = info[.editedImage] as? UIImage {
                self.imageView?.image = image
            }
        }
    }
    
}

extension BooksUploadViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Grade \(row+6)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtGrades?.text = "\(row+6)"
    }
}
