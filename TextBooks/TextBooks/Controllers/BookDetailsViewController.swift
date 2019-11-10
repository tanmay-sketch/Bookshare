//
//  BookDetailsViewController.swift
//  TextBooks
//
//  Created by Akshay on 19/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubject: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookGrade: UILabel!

    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookImage.image = UIImage(named: book.image)
        bookTitle.text = book.name
        bookSubject.text = book.subject
        bookAuthor.text = book.author
        bookGrade.text = String(book.grade)
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
