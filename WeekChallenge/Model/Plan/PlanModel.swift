//
//  PlanModel.swift
//  WeekChallenge
//
//  Created by 오승훈 on 2022/03/25.
//

import Foundation

struct PlanModel {
    let title: String?
    let dates: [String]?
    let dbID: String?
    let firstDate: String?
    let lastDate: String?
    let complete: [Int]?

    init(title: String, dates: [String], dbID: String, firstDate: String, lastDate: String, complete: [Int]) {
        self.title = title
        self.dates = dates
        self.dbID = dbID
        self.firstDate = firstDate
        self.lastDate = lastDate
        self.complete = complete
    }
}
