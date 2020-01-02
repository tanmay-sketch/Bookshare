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

class CellClass: UITableViewCell {
    
}

class BooksUploadViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var txtGrades: UITextField?
    @IBOutlet var txtTitle: UITextField?
    @IBOutlet var txtSubject: UITextField?
    @IBOutlet var txtAuthor: UITextField?
    @IBOutlet var btnSelectCondition: UIButton!
    
    @IBOutlet var gradesPicker: UIPickerView?
    @IBOutlet var toolbar: UIToolbar?
    
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
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
        txtTitle?.inputAccessoryView = toolbar
        txtAuthor?.inputAccessoryView = toolbar
        txtSubject?.inputAccessoryView = toolbar
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onClickSelectCondition(_ sender: Any) {
        dataSource = ["Very Good","Good","Bad"]
        addTransparentView(frames: btnSelectCondition.frame)
        selectedButton = btnSelectCondition
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func uploadImageTapped(_ sender:UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // DYNAMIC TEXT BUTTON
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        //TODO: Validate textfields
        
        let booktitle = txtTitle?.text;
        let subjectdetail = txtSubject?.text;
        let authordetail = txtAuthor?.text;
        //picker details not validated
        
        if booktitle?.isEmpty ?? true {
            let alert = UIAlertController(title: "Book data is not entered", message: "Please enter all details", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert,animated: true)
            
        } else if subjectdetail?.isEmpty ?? true{
            let alert = UIAlertController(title: "Book data is not entered", message: "Please enter all details", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert,animated: true)
        }
         
        else if authordetail?.isEmpty ?? true{
            let alert = UIAlertController(title: "Book data is not entered", message: "Please enter all details", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert,animated: true)
        } else if imageView?.image == nil {
            let alert = UIAlertController(title: "Book data is not entered", message: "Please enter all details", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert,animated: true)
            
        }
        
        
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

extension BooksUploadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}

    
