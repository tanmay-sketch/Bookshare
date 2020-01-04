//
//  BookDetailsViewController.swift
//  TextBooks
//
//  Created by Akshay on 19/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubject: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookGrade: UILabel!
    
    @IBOutlet weak var btnRequest: UIButton!

    
    private let db = Firestore.firestore()

    
    var book: Book!
    private let storage = Storage.storage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard self.book != nil else {
            fatalError("Book is nil")
        }
        
        if let image = book.image, !image.isEmpty {
            print("🎂 Image for \(book.title)")
            let reference = storage.reference(withPath: image)
            bookImage.sd_setImage(with: reference)
        } else {
            bookImage.image = nil
            print("🔴Image not given for \(book.title)")
        }
        bookTitle.text = book.title
        bookSubject.text = book.subject
        bookAuthor.text = book.author.first
        bookGrade.text = String(book.grade)
        
        if Auth.auth().currentUser?.uid != book.user.id {
            btnRequest.isHidden = false
        } else {
            btnRequest.isHidden = true
        }
        
    }
    
    @IBAction func btnRequestTapped(_ sender: UIButton) {
        let docId = "/textbooks/\(book.id)"
        db.document(docId).getDocument { (snapshot, error) in
            var newRequests = [[String:Any]]()
            guard let userID = Auth.auth().currentUser?.uid else {
                fatalError("User is not logged in")
            }
            
            let name = Auth.auth().currentUser?.displayName ?? "Some Student"
            var userData = [String: Any]()
            userData = ["id": userID, "name": name]
            if let picture = Auth.auth().currentUser?.photoURL {
                userData["photo"] = picture.path
            }
            if var requests = snapshot?.data()?["requests"] as? [[String:Any]] {
                
                requests.append(userData)
                newRequests = requests
            } else {
                newRequests = [userData]
            }
            
            self.db.document(docId).updateData(["requests":newRequests])
        }
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
