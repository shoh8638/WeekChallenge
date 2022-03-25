//
//  RunModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/25.
//

import Foundation

struct RunModel {
    let title: String?
    let firstDate: String?
    let lastDate: String?

    init(title: String, firstDate: String, lastDate: String) {
        self.title = title
        self.firstDate = firstDate
        self.lastDate = lastDate
    }
}
