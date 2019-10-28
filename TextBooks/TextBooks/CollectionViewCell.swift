//
//  CollectionViewCell.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 17/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
 
    func configure(book: Book) {
        bookImage.image = UIImage(named: book.image)
        bookTitle.text = book.name
    }
    
}
