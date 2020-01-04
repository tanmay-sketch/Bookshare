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

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubject: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookGrade: UILabel!
    
    @IBOutlet weak var btnRequest: UIButton!

    var book: Book!
    private let storage = Storage.storage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
