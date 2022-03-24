//
//  PlanViewModel.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/24.
//

import Foundation

struct PlanViewModel {
    func numberOfItem(planM: PlanModel) -> Int {
        return planM.dbTitles.count == 0 ? 1 : planM.dbTitles.count
    }
    
    func numberOfTitle(planM: PlanModel, index: Int) -> String {
        return planM.dbTitles.count == 0 ? "플랜을 생성해주세요" : planM.dbTitles[index]
    }
    
    func numberOfSubTitle(planM: PlanModel, index: Int) -> String {
        return planM.dbTitles.count == 0 ? "" : planM.dbTitles[index]
    }
    
    func numberOfPeriod(planM: PlanModel, index: Int) -> String {
        return planM.dbTitles.count == 0 ? "" : "\(planM.firstDates[index]) ~ \(planM.lastDates[index])"
    }
    
    func numberOfDate(planM: PlanModel, index: Int) ->  Array<Int>{
        return planM.dbDate.count == 0 ? [0,0,0,0,0] : planM.dbDate[index]
    }
    
    func selectOfCell() {
        
    }
}
