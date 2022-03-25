//
//  DataModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct DataModel {
    let title: String?
    let dates: [String]?
    let dbID: String?
    let firstDate: String?
    let lastDate: String?

    init(title: String, dates: [String], dbID: String, firstDate: String, lastDate: String) {
        self.title = title
        self.dates = dates
        self.dbID = dbID
        self.firstDate = firstDate
        self.lastDate = lastDate
    }
}
