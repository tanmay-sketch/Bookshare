//
//  Book.swift
//  TextBooks
//
//  Created by Akshay on 03/12/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let id: String
    let photo: String?
    
    init(with dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let id = dict["id"] as? String else {
               fatalError("Book Title was not given")
        }
        self.name = name
        self.id = id
        self.photo = dict["photo"] as? String
    }
}


struct Book {
    
    let id: String
    
    let title: String
    let author: [String]
    let image: String?
    let grade: Int
    let subject: String
    let condition: String
    
    let user: User
    
    init(with id: String, dict: [String: Any]) {
        guard let title = dict["title"] as? String else {
            fatalError("Book Title was not given")
        }
        self.id = id
        
        guard let _user = dict["user"] as? [String:Any] else {
            fatalError("User data was not given")
        }
        
        self.user = User(with: _user)
        
        self.title = title
        image = dict["image"] as? String
        if let sub = dict["subject"] as? String {
            subject = sub
        } else {
            subject = "-"
        }
        
        if let _condition = dict["condition"] as? String {
            self.condition = _condition
        } else {
            self.condition = "-"
        }

        
        if let grade = dict["grade"] as? String {
            self.grade = Int(grade) ?? -1
        } else {
            self.grade = -1
        }
        if let authors = dict["author"] as? [String] {
            self.author = authors
        } else {
            self.author = ["None Given"]
        }
    }
    
}
