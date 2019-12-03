//
//  BooksDataFetcher.swift
//  TextBooks
//
//  Created by Akshay on 28/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import Foundation

struct BooksData: Codable {
    let books:[Book]
}

struct Book: Codable {
    let title: String
    let author: [String]
    let image: String
    let grade: [Int]
    let subject: String
}

//class BooksDataFetcher {
//
//    func getAllBooks(with grade: Int, subject: String) -> [Book] {
//        if let url = Bundle.main.url(forResource: "Books", withExtension: "plist") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = PropertyListDecoder()
//                let booksData = try decoder.decode(BooksData.self, from: data)
//                
//                let filteredBooks = booksData.books.filter { book -> Bool in
//                    if book.grade == grade && book.subject.lowercased() == subject.lowercased() {
//                        return true
//                    } else {
//                        return false
//                    }
//                }
//                return filteredBooks
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return [Book]()
//    }
//    
//}
