//
//  TextBooksViewController.swift
//  TextBooks
//
//  Created by Akshay on 17/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import UIKit

class TextBooksViewController: UIViewController {

    private var books = [Book]()
    
    var grade: Int?
    var subject: String?
    
    @IBOutlet var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _grade = grade, let _subject = subject else {
            fatalError("Grade and subject are not passed")
        }
        
        let fetcher = BooksDataFetcher()
        books = fetcher.getAllBooks(with: _grade, subject: _subject)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let cell = sender as! UICollectionViewCell        
        let indexPath = collectionView!.indexPath(for: cell)!
        
        let detailsController = segue.destination as! BookDetailsViewController
        detailsController.book = books[indexPath.item]
        
    }
    

}


extension TextBooksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! CollectionViewCell
        let book = books[indexPath.item]
        cell.configure(book: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell Selected", indexPath.item)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalWidth = collectionView.bounds.width-30;
        
        let eachCellWidth = totalWidth/2
        
        let size = CGSize(width: eachCellWidth, height: eachCellWidth)
        return size
    }
    
}
