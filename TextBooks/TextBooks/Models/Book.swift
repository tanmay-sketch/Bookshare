//
//  Book.swift
//  TextBooks
//
//  Created by Akshay on 03/12/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import Foundation

struct Book: Codable {
    let title: String
    let author: [String]
    let image: String?
    let grade: [Int]
    let subject: String
    
    init(with dict: [String: Any]) {
        guard let title = dict["title"] as? String else {
            fatalError("Book Title was not given")
        }
        self.title = title
        image = dict["image"] as? String
        if let sub = dict["subject"] as? String {
            subject = sub
        } else {
            subject = "-"
        }
        if let grades = dict["grade"] as? [Int] {
            self.grade = grades
        } else {
            self.grade = [-1]
        }
        if let authors = dict["author"] as? [String] {
            self.author = authors
        } else {
            self.author = ["None Given"]
        }
    }
    
}
