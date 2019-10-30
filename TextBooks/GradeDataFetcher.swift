//
//  GradeDataFetcher.swift
//  TextBooks
//
//  Created by Tanmay Grandhisiri on 30/10/19.
//  Copyright © 2019 Tanmay Grandhisiri. All rights reserved.
//

import Foundation

struct GradeData: Codable {
    let Grade: [Grade]
}

struct Grade: Codable {
    let grade: Int
    let subjects: Array<Any>
}

class GradeDataFetcher {
    func getAllGrades() -> [Grade] {
        if let url = Bundle.main.url(forResource: "Grade", withExtension: "plist"){
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let booksData = try decoder.decode(GradeData.self, from: data)
            print (GradeData.Grade)
            return GradeData.Grade
        }
        catch {
            print(error.localizedDescription)
            }
    }
        return [Grade]()
}

}
