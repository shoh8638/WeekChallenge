//
//  CompleteViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/23.
//

import Foundation

class CompleteViewModel {
    func numberOfItem(runM: RunModel) -> Int {
        return runM.titles.count == 0 ? 1 : runM.titles.count
    }
    
    func numberOfTitle(runM: RunModel, index: Int) -> String {
        return runM.titles.count == 0 ? "아무것도 없어요" : runM.titles[index]
    }
    
    func numberOfPeriod(runM: RunModel, index: Int) -> String {
        return runM.titles.count == 0 ? "" : "\(runM.firstPeriod[index]) ~ \(runM.lastPeriod[index])"
    }
}
