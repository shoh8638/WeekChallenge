//
//  hviewmodel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import Foundation

struct hviewmodel {
    func numberOfItem(homeM: HomeModel) -> Int {
        return homeM.dbTitles.count == 0 ? 1 : homeM.dbTitles.count
    }
    
    func numberOfTitle(homeM: HomeModel, index: Int) -> String {
        return homeM.dbTitles.count == 0 ? "아무것도 없어요" : homeM.dbTitles[index]
    }
    
    func numberOfPeriod(homeM: HomeModel, index: Int) -> String {
        return homeM.dbTitles.count == 0 ? "" : "\(homeM.firstDates[index]) ~ \(homeM.lastDates[index])"
    }
}
