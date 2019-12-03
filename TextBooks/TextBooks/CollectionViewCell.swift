//
//  CollectionViewCell.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 17/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit
import FirebaseStorage
import SDWebImage

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
 
    private let storage = Storage.storage()

    func configure(book: Book) {
        if let image = book.image, !image.isEmpty {
            print("🎂 Image for \(book.title)")
            let reference = storage.reference(withPath: image)
            bookImage.sd_setImage(with: reference)
        } else {
            bookImage.image = nil
            print("🔴Image not given for \(book.title)")
        }
        bookTitle.text = book.title
    }
    
}
