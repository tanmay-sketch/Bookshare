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
    let name: String
    let author: String
    let image: String
    let `class`: String
}

class BooksDataFetcher {

    func getAllBooks() -> [Book] {
        if let url = Bundle.main.url(forResource: "Books", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                let booksData = try decoder.decode(BooksData.self, from: data)
                print(booksData.books)
                return booksData.books
            } catch {
                print(error.localizedDescription)
            }
        }
        return [Book]()
    }
    
}
